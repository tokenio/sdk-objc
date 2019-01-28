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
#import "TKUtil.h"

// Header bytes (expected by OpenSSL) to be prepended to the raw public key data to
// get the key in X509 format:
// https://forums.developer.apple.com/thread/8030
static NSString *kKeyHeader = @"3059301306072a8648ce3d020106082a8648ce3d030107034200";

@implementation TKSecureEnclaveCryptoEngine {
    NSString *_memberId;
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
    return [self generateKey:level withExpiration:nil];
}

- (Key *)generateKey:(Key_Level)level withExpiration:(NSNumber *)expiresAtMs {
    if (@available(macOS 10.12, iOS 10, *)) {
        [self deleteKeysForLevel:level];
        
        SecKeyRef privateKeyRef = [self createPrivatePairWith:level expiration:expiresAtMs];
        if (privateKeyRef == nil) {
            TKLogError(@"Error generating private key");
            return nil;
        }
        
        NSData *publicKeyData = [self savePublicKeyWith:privateKeyRef expiration:expiresAtMs];
        if (publicKeyData == nil) {
            TKLogError(@"Error saving public key");
            return nil;
        }
        Key* key = [self publicKeyInfo:publicKeyData level:level expiration:expiresAtMs];
        CFRelease(privateKeyRef);
        
        return key;
    } else {
        TKLogError(@"Secure enclave is not supported");
        return nil;
    }
}

- (Key *)getKeyInfo:(Key_Level)level
             reason:(NSString *)reason
            onError:(OnError)onError {
    if (@available(macOS 10.12, iOS 10, *)) {
        SecKeyRef privateKeyRef = [self getPrivateKeyRefWith:level reason:reason];
        if (!privateKeyRef) {
            onError([NSError
                     errorFromErrorCode:kTKErrorKeyNotFound
                     details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
            return nil;
        }
        return [self getPublicKeyInfoWith:privateKeyRef level:level];
    } else {
        TKLogError(@"Secure enclave is not supported");
        return nil;
    }
}

- (TKSignature *)signData:(NSData *)data
           usingKeyLevel:(Key_Level)keyLevel
                  reason:(NSString *)reason
                 onError:(OnError)onError {
    if (@available(macOS 10.12, iOS 10, *)) {
        SecKeyRef privateKeyRef = [self getPrivateKeyRefWith:keyLevel reason:reason];
        if (!privateKeyRef) {
            onError([NSError
                     errorFromErrorCode:kTKErrorKeyNotFound
                     details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
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
                                     signedWith:[self getPublicKeyInfoWith:privateKeyRef level:keyLevel]];
        CFRelease(privateKeyRef);
        
        return tkSignature;
    } else {
        onError([NSError
                 errorFromErrorCode:kTKErrorSecureEnclaveIsNotSupported
                 details:@"Secure Enclave is not supported in the current OS"]);
        return nil;
    }
}

- (bool)verifySignature:(NSString *)signature forData:(NSData *)data usingKeyId:(NSString *)keyId {
    if (@available(macOS 10.12, iOS 10, *)) {
        SecKeyRef keyRef = [self getPublicKeyRefWithKeyId:keyId];

        CFErrorRef error = NULL;
        NSData* signatureData = [TKUtil base64UrlDecodeString:signature];
        Boolean success = SecKeyVerifySignature(
                                                keyRef,
                                                kSecKeyAlgorithmECDSASignatureMessageX962SHA256,
                                                (__bridge CFDataRef)data,
                                                (__bridge CFDataRef)(signatureData), &error);
        CFRelease(keyRef);
        
        return success == 1;
    } else {
        return false;
    }
}

#pragma mark- Private Methods

#define newCFDict CFDictionaryCreateMutable( \
    kCFAllocatorDefault, \
    0, \
    &kCFTypeDictionaryKeyCallBacks, \
    &kCFTypeDictionaryValueCallBacks)

/**
 * Generates a key pair and save the private key. The public key will not be saved by default.
 * @param level key level
 * @param expiresAtMs expiration time
 * @return private key reference
 */
- (SecKeyRef)createPrivatePairWith:(Key_Level)level expiration:(NSNumber *)expiresAtMs {
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
    
    CFMutableDictionaryRef privateKeyAttributes = newCFDict;
    CFDictionaryAddValue(privateKeyAttributes, kSecAttrAccessControl, sacObject);
    CFDictionaryAddValue(privateKeyAttributes, kSecAttrIsPermanent, kCFBooleanTrue);
    CFDictionaryAddValue(privateKeyAttributes, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    // Ues application tag attribute to save the expiration time.
    if (expiresAtMs != nil) {
        NSString * expiration= [NSString stringWithFormat:@"%@",expiresAtMs];
        CFDictionaryAddValue(privateKeyAttributes, kSecAttrApplicationTag, (__bridge const void *)expiration);
    }
    
    // Creates dict which actually saves key into keychain
    CFMutableDictionaryRef generateKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(generateKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeyType, kSecAttrKeyTypeECSECPrimeRandom);
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeySizeInBits, (__bridge const void *)(@256));
    CFDictionaryAddValue(generateKeyRef, kSecPrivateKeyAttrs, privateKeyAttributes);
    
    
    CFRelease(sacObject);
    
    return SecKeyCreateRandomKey(generateKeyRef, &error);
}

/**
 * Saves the public key.
 * @param privateKeyRef corresponding private key reference
 * @param expiresAtMs expiration time
 * @return public key data
 */
- (NSData *)savePublicKeyWith:(SecKeyRef)privateKeyRef expiration:(NSNumber *)expiresAtMs {
    SecKeyRef publicKeyRef = SecKeyCopyPublicKey(privateKeyRef);
    
    // Saves the public keys.
    CFMutableDictionaryRef queryRef = newCFDict;
    CFDictionarySetValue(queryRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(queryRef, kSecValueRef, publicKeyRef);
    CFDictionarySetValue(queryRef, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(queryRef, kSecReturnData, kCFBooleanTrue);
    CFTypeRef result;
    OSStatus status = SecItemAdd(queryRef, &result);
    if (status != errSecSuccess) {
        TKLogError(@"Error adding public key: %@\n", @(status));
        return nil;
    }
    NSData *publicKeyData = (__bridge NSData *)(result);
    
    CFRelease(publicKeyRef);
    if (!publicKeyData) {
        return nil;
    }
    
    // Updates the public label with key id with future searches.
    NSString *keyId = [self publicKeyId:publicKeyData];
    CFDictionarySetValue(queryRef, kSecReturnData, kCFBooleanFalse);
    CFMutableDictionaryRef updateRef = newCFDict;
    CFDictionarySetValue(updateRef, kSecAttrLabel, (__bridge const void *)keyId);
    if (expiresAtMs != nil) {
        NSString * expiration= [NSString stringWithFormat:@"%@",expiresAtMs];
        CFDictionaryAddValue(updateRef, kSecAttrApplicationTag, (__bridge const void *)expiration);
    }
    status = SecItemUpdate(queryRef, updateRef);
    if (status != errSecSuccess) {
        TKLogError(@"Error attaching key id label to public key: %@\n", @(status));
        return nil;
    }
    return publicKeyData;
}

/**
 * Gets the private key reference.
 * @param level key level
 * @param reason reason
 * @return private key reference
 */
- (SecKeyRef)getPrivateKeyRefWith:(Key_Level)level reason:(NSString *)reason{
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
    
    return keyRef;
}

/**
 * Gets the public key reference by id. Throws key expiration exception if the key is expired.
 * @param keyId key id
 * @return public key reference
 */
- (SecKeyRef)getPublicKeyRefWithKeyId:(NSString *)keyId {
    // Checks expiration time.
    CFMutableDictionaryRef publicKeyQuery = newCFDict;
    CFDictionarySetValue(publicKeyQuery, kSecClass, kSecClassKey);
    CFDictionarySetValue(publicKeyQuery, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(publicKeyQuery, kSecAttrLabel, (__bridge const void *)(keyId));
    CFDictionarySetValue(publicKeyQuery, kSecReturnAttributes, kCFBooleanTrue);
    
    CFDictionarySetValue(publicKeyQuery, kSecReturnRef, kCFBooleanTrue);
    CFDictionaryRef attributes;
    OSStatus status = SecItemCopyMatching(publicKeyQuery, (CFTypeRef *)&attributes);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving public key for id %@ error: %@\n", keyId,  @(status));
        return nil;
    }
    
    NSNumber *expiredAtMs = [self expirationTimeAtMs:attributes];
    if (expiredAtMs && expiredAtMs.longLongValue < (long long) ([[NSDate date] timeIntervalSince1970] * 1000)) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Key with id: %@ has expired", keyId];
    }
    
    // Retrieves the public key reference.
    SecKeyRef keyRef;
    CFDictionarySetValue(publicKeyQuery, kSecReturnRef, kCFBooleanTrue);
    CFDictionarySetValue(publicKeyQuery, kSecReturnAttributes, kCFBooleanFalse);
    status = SecItemCopyMatching(publicKeyQuery, (CFTypeRef *)&keyRef);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving public key for id %@ error: %@\n", keyId,  @(status));
        return nil;
    }
    
    return keyRef;
}

/**
 * Gets the public key info.
 * @param privateKeyRef corresponding private key reference
 * @param level key level
 * @return public key info
 */
- (Key *)getPublicKeyInfoWith:(SecKeyRef)privateKeyRef level:(Key_Level)level{
    SecKeyRef publicKeyRef = SecKeyCopyPublicKey(privateKeyRef);
    
    // Gets the public keys data.
    CFMutableDictionaryRef publicKeyQuery = newCFDict;
    CFDictionarySetValue(publicKeyQuery, kSecClass, kSecClassKey);
    CFDictionarySetValue(publicKeyQuery, kSecValueRef, publicKeyRef);
    CFDictionarySetValue(publicKeyQuery, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(publicKeyQuery, kSecReturnData, kCFBooleanTrue);
    CFTypeRef result;
    OSStatus status = SecItemCopyMatching(publicKeyQuery, &result);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving public key: %@\n", @(status));
        return nil;
    }
    NSData *publicKeyData = (__bridge NSData *)(result);
    
    CFRelease(publicKeyRef);
    
    // Gets the exipration time.
    CFDictionarySetValue(publicKeyQuery, kSecReturnData, kCFBooleanFalse);
    CFDictionarySetValue(publicKeyQuery, kSecReturnAttributes, kCFBooleanTrue);
    CFDictionaryRef attributes;
    status = SecItemCopyMatching(publicKeyQuery, (CFTypeRef *)&attributes);
    if (status != errSecSuccess) {
        TKLogError(@"Error retrieving public key: %@\n", @(status));
        return nil;
    }
    NSNumber *expiredAtMs = [self expirationTimeAtMs:attributes];
    
    return [self publicKeyInfo:publicKeyData level:level expiration:expiredAtMs];
}

/**
 * Deletes all the keys for a specific level.
 * @param level key level
 */
- (void)deleteKeysForLevel:(Key_Level)level {
    CFMutableDictionaryRef queryKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(queryKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(queryKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    CFDictionarySetValue(queryKeyRef, kSecClass, kSecClassKey);
    SecItemDelete(queryKeyRef);
}


/**
 * Generates public key info.
 * @param publicKeyData public key data
 * @param level key level
 * @param expiresAtMs expiration time
 * @return public key info
 */
- (Key *)publicKeyInfo:(NSData *)publicKeyData level:(Key_Level)level expiration:(NSNumber *)expiresAtMs{
    if (publicKeyData == nil) {
        return nil;
    }
    NSMutableData* keyWithHeaderData = [[QHex dataWithHexString:kKeyHeader] mutableCopy];
    [keyWithHeaderData appendData:publicKeyData];
    
    Key *key = [Key message];
    key.level = level;
    key.algorithm = Key_Algorithm_EcdsaSha256;
    key.publicKey = [TKUtil base64UrlEncodeData:keyWithHeaderData];
    key.id_p = [TKUtil idForData:keyWithHeaderData];
    if (expiresAtMs != nil) {
        key.expiresAtMs = [expiresAtMs integerValue];
    }
    return key;
}

/**
 * Generates public key id.
 * @param puclicKeyData public key data
 * @return public key id
 */
- (NSString *)publicKeyId:(NSData *)puclicKeyData {
    if (puclicKeyData == nil) {
        return nil;
    }
    NSMutableData* keyWithHeaderData = [[QHex dataWithHexString:kKeyHeader] mutableCopy];
    [keyWithHeaderData appendData:puclicKeyData];
    return [TKUtil idForData:keyWithHeaderData];
}

/**
 * Gets expiration time from a attribute dictionary.
 *
 * @param dictionary attribute dictionary
 * @return expiration time
 */
- (NSNumber *)expirationTimeAtMs:(CFDictionaryRef)attributes {
    NSString *expiration = CFDictionaryGetValue(attributes, kSecAttrApplicationTag);
    if (!expiration || [expiration length] == 0) {
        return nil;
    }
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:expiration];
}

// Generates kSecAttrLabel value for search
- (NSString*)keyLabelForKeyLevel:(Key_Level)level {
    return [NSString stringWithFormat:@"%@_%@", _memberId, @(level)];
}
@end
