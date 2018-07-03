//
//  TKSecureEnclaveCryptoEngine.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

@import LocalAuthentication;

#import "TKSecureEnclaveCryptoEngine.h"
#import "TKSignature.h"
#import "TKLogManager.h"
#import "QHex.h"
#import "TKLocalizer.h"
#import "TKError.h"

// Header bytes (expected by OpenSSL) to be prepended to the raw public key data to
// get the key in X509 format:
// https://forums.developer.apple.com/thread/8030
static NSString* kKeyHeader = @"3059301306072a8648ce3d020106082a8648ce3d030107034200";

@implementation TKSecureEnclaveCryptoEngine {
    NSString* _memberId;
    BOOL _useDevicePasscodeOnly;
}

- (id)initWithMemberId:(NSString *)memberId
  authenticationOption:(BOOL)useDevicePasscodeOnly {
    self = [super init];
    if (self) {
        _memberId = memberId;
        _useDevicePasscodeOnly = useDevicePasscodeOnly;
    }
    return self;
}

- (Key *)generateKey:(Key_Level)level {
    return [self generateKeyPairWithLevel:level];
}

- (Key *)generateKey:(Key_Level)level withExpiration:(NSNumber *)expiresAtMs {
    // TODO(MOB-344) implement;
    return nil;
}

- (Key *)getKeyInfo:(Key_Level)level
             reason:(NSString *)reason
            onError:(OnError)onError {
    SecKeyRef privateKeyRef = [self privateKeyForLevel:level reason:reason];
    if (!privateKeyRef) {
        onError([NSError errorFromErrorCode:kTKErrorKeyNotFound details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
        return nil;
    }
    return [self keyInfoForPrivateKey:privateKeyRef level:level];
}

- (TKSignature*)signData:(NSData *)data
           usingKeyLevel:(Key_Level)keyLevel
                  reason:(NSString *)reason
                 onError:(OnError)onError {
    
    SecKeyRef privateKeyRef = [self privateKeyForLevel:keyLevel reason:reason];
    if (!privateKeyRef) {
        onError([NSError errorFromErrorCode:kTKErrorKeyNotFound details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
        return nil;
    }

    NSError *error;
    CFDataRef signRef = SecKeyCreateSignature(
            privateKeyRef,
            kSecKeyAlgorithmECDSASignatureMessageX962SHA256,
            (__bridge CFDataRef)data,
            (void *)&error);
    if (signRef == nil) {
        CFRelease(privateKeyRef);
        TKLogError(@"Error signing data: %@", error);
        if ([error.domain isEqual:@kLAErrorDomain] &&
            (error.code == kLAErrorUserCancel || error.code == kLAErrorSystemCancel )) {
            onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                        details:TKLocalizedString(@"User_Cancelled_Authentication", @"User cancelled authentication")
                              encapsulatedError:error]);
        }
        else {
            onError([NSError errorFromErrorCode:kTKErrorUserInvalid
                                        details:TKLocalizedString(@"User_Invalid_Authentication", @"Invalid user for authentication")
                              encapsulatedError:error]);
        }
        return nil;
    }
    NSData* signatureData = (__bridge NSData *)(signRef);

    NSString* signatureString = [TKUtil base64UrlEncodeData:signatureData];
    TKSignature* tkSignature =  [TKSignature
            signature:signatureString
            signedWith:[self keyInfoForPrivateKey:privateKeyRef level:keyLevel]];
    CFRelease(privateKeyRef);

    return tkSignature;
}

- (bool)verifySignature:(NSString *)signature forData:(NSData *)data usingKeyId:(NSString *)keyId {
    SecKeyRef keyRef = [self publicKeyForKeyId:keyId];
    CFErrorRef error = NULL;
    NSData* signatureData = [TKUtil base64UrlDecodeString:signature];
    Boolean success = SecKeyVerifySignature(
            keyRef,
            kSecKeyAlgorithmECDSASignatureMessageX962SHA256,
            (__bridge CFDataRef)data,
            (__bridge CFDataRef)(signatureData), &error);
    CFRelease(keyRef);
    
    return success == 1;
}

#pragma mark- Private Methods

#define newCFDict CFDictionaryCreateMutable( \
    kCFAllocatorDefault, \
    0, \
    &kCFTypeDictionaryKeyCallBacks, \
    &kCFTypeDictionaryValueCallBacks)


- (NSString*)keyLabelForKeyLevel:(Key_Level)level {
    return [NSString stringWithFormat:@"%@_%@", _memberId, @(level)];
}

- (Key*)generateKeyPairWithLevel:(Key_Level)level {
    
    [self deleteOldKeysForLevel:level];
    
    CFErrorRef error = NULL;
    SecAccessControlCreateFlags accessFlags = kSecAccessControlPrivateKeyUsage;
    if (level < Key_Level_Low) {
        if (_useDevicePasscodeOnly) {
            accessFlags |= kSecAccessControlDevicePasscode; // Will require Passcode
        }
        else {
            accessFlags |= kSecAccessControlUserPresence; // Will require FaceID/Touch ID/Passcode
        }
    }
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            accessFlags,
            &error);
    if (sacObject == nil) {
        TKLogError(@"Error generating access controls: %@\n", error);
        return nil;
    }
    
    CFMutableDictionaryRef accessControlDict = newCFDict;
    CFDictionaryAddValue(accessControlDict, kSecAttrAccessControl, sacObject);
    CFDictionaryAddValue(accessControlDict, kSecAttrIsPermanent, kCFBooleanTrue);
    CFDictionaryAddValue(accessControlDict, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    
    // create dict which actually saves key into keychain
    CFMutableDictionaryRef generateKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(generateKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeyType, kSecAttrKeyTypeECSECPrimeRandom);
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeySizeInBits, (__bridge const void *)(@256));
    CFDictionaryAddValue(generateKeyRef, kSecPrivateKeyAttrs, accessControlDict);
    
    CFRelease(sacObject);
    
    SecKeyRef privateKeyRef = SecKeyCreateRandomKey(generateKeyRef, &error);
    if (privateKeyRef == nil) {
        TKLogError(@"Error generating private key: %@\n", error);
        return nil;
    }
    
    Key* key = [self keyInfoForPrivateKey:privateKeyRef level:level];

    CFRelease(privateKeyRef);
    return key;
}

- (void)deleteOldKeysForLevel:(Key_Level)level {
    CFMutableDictionaryRef queryKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(queryKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(queryKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    CFDictionarySetValue(queryKeyRef, kSecClass, kSecClassKey);
    SecItemDelete(queryKeyRef);
}

- (NSData*)publicKeyDataFromKeyRef:(SecKeyRef)publicKeyRef {
    CFMutableDictionaryRef queryRef = newCFDict;
    CFDictionarySetValue(queryRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(queryRef, kSecValueRef, publicKeyRef);
    CFDictionarySetValue(queryRef, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(queryRef, kSecReturnData, kCFBooleanTrue);
    CFTypeRef result;
    OSStatus status = SecItemAdd(queryRef, &result);
    if (status != errSecSuccess) {
        status = SecItemCopyMatching(queryRef, &result);
        if (status != errSecSuccess) {
            TKLogError(@"Error adding public key: %@\n", @(status));
            return nil;
        }
    }
    NSData* keyBitsData = (__bridge NSData *)(result);
    return keyBitsData;
}

- (Key*)keyInfoForPrivateKey:(SecKeyRef)keyRef level:(Key_Level)level {
    SecKeyRef publicKeyRef = SecKeyCopyPublicKey(keyRef);
    NSData* puclicKeyData = [self publicKeyDataFromKeyRef:publicKeyRef];
    
    CFRelease(publicKeyRef);
    if (!puclicKeyData) {
        return nil;
    }
    
    NSMutableData* keyWithHeaderData = [[QHex dataWithHexString:kKeyHeader] mutableCopy];
    [keyWithHeaderData appendData:puclicKeyData];
   
    Key *key = [Key message];
    key.level = level;
    key.algorithm = Key_Algorithm_EcdsaSha256;
    key.publicKey = [TKUtil base64UrlEncodeData:keyWithHeaderData];
    key.id_p = [TKUtil idForData:keyWithHeaderData];
    
    CFMutableDictionaryRef queryRef = newCFDict;
    CFDictionarySetValue(queryRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(queryRef, kSecValueRef, publicKeyRef);
    CFDictionarySetValue(queryRef, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFMutableDictionaryRef updateRef = newCFDict;
    CFDictionarySetValue(updateRef, kSecAttrLabel, (__bridge const void *)key.id_p);
    OSStatus status = SecItemUpdate(queryRef, updateRef);
    if (status != errSecSuccess) {
        TKLogError(@"Error attaching key id label to public key: %@\n", @(status));
        return nil;
    }
    
    return key;
}

- (SecKeyRef)privateKeyForLevel:(Key_Level)level reason:(NSString *)reason {
    CFMutableDictionaryRef getKeyRef = newCFDict;
    CFDictionarySetValue(getKeyRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(getKeyRef, kSecAttrKeyClass, kSecAttrKeyClassPrivate);
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(getKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionarySetValue(getKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    CFDictionarySetValue(getKeyRef, kSecReturnRef, kCFBooleanTrue);
    NSString *prompt = (reason != nil)
            ? reason
            : @"Authenticate to sign data";
    CFDictionarySetValue(getKeyRef, kSecUseOperationPrompt, (__bridge const void *)prompt);

    SecKeyRef keyRef;
    OSStatus status = SecItemCopyMatching(getKeyRef, (CFTypeRef *)&keyRef);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving private key: %@\n", @(status));
        return nil;
    }
    
    return (SecKeyRef)keyRef;
}

- (SecKeyRef)publicKeyForKeyId:(NSString*)keyId {
    CFMutableDictionaryRef getKeyRef = newCFDict;
    
    CFDictionarySetValue(getKeyRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(getKeyRef, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(getKeyRef, kSecAttrLabel, (__bridge const void *)(keyId));
    CFDictionarySetValue(getKeyRef, kSecReturnRef, kCFBooleanTrue);
    
    SecKeyRef keyRef;
    OSStatus status = SecItemCopyMatching(getKeyRef, (CFTypeRef *)&keyRef);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving public key for id %@ error: %@\n", keyId,  @(status));
        return nil;
    }
    
    return (SecKeyRef)keyRef;
}

@end
