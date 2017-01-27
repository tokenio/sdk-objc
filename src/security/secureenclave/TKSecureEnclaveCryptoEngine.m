//
//  TKSecureEnclaveCryptoEngine.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKSecureEnclaveCryptoEngine.h"
#import "TKSignature.h"
#import "TKLogManager.h"
#import "QHex.h"

// Header bytes (expected by OpenSSL) to be prepended to the raw public key data to
// get the key in X509 format:
// https://forums.developer.apple.com/thread/8030
static NSString* kKeyHeader = @"3059301306072a8648ce3d020106082a8648ce3d030107034200";

@implementation TKSecureEnclaveCryptoEngine {
    NSString* _memberId;
}

- (id)initWithMemberId:(NSString *)memberId {
    self = [super init];
    if (self) {
        _memberId = memberId;
    }
    return self;
}

- (Key *)generateKey:(Key_Level)level {
    return [self generateKeyPairWithLevel:level];
}

- (TKSignature*)signData:(NSData *)data usingKeyLevel:(Key_Level)keyLevel {
    SecKeyRef privateKeyRef = [self privateKeyForLevel:keyLevel];
    CFErrorRef error = NULL;
    if (!privateKeyRef) {
        return nil;
    }

    CFDataRef signRef = SecKeyCreateSignature(
            privateKeyRef,
            kSecKeyAlgorithmECDSASignatureMessageX962SHA256,
            (__bridge CFDataRef)data,
            &error);
    if (signRef == nil) {
        CFRelease(privateKeyRef);
        TKLogError(@"Error signing data: %@", error);
        return nil;
    }
    NSData* signatureData = (__bridge NSData *)(signRef);

    NSString* signatureString = [TKUtil base64EncodeData:signatureData];
    TKSignature* tkSignature =  [TKSignature
            signature:signatureString
            signedWith:[self keyInfoForPrivateKey:privateKeyRef level:keyLevel]];
    CFRelease(privateKeyRef);

    return tkSignature;
}

- (bool)verifySignature:(NSString *)signature forData:(NSData *)data usingKeyId:(NSString *)keyId {
    SecKeyRef keyRef = [self publicKeyForKeyId:keyId];
    CFErrorRef error = NULL;
    NSData* signatureData = [TKUtil base64DecodeString:signature];
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
        accessFlags |= kSecAccessControlUserPresence; // Will require Touch ID/Passcode
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
        CFRelease(privateKeyRef);
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
    key.publicKey = [TKUtil base64EncodeData:keyWithHeaderData];
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

- (SecKeyRef)privateKeyForLevel:(Key_Level)level {

    CFMutableDictionaryRef getKeyRef = newCFDict;
    CFDictionarySetValue(getKeyRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(getKeyRef, kSecAttrKeyClass, kSecAttrKeyClassPrivate);
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(getKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionarySetValue(getKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeyLevel:level]));
    CFDictionarySetValue(getKeyRef, kSecReturnRef, kCFBooleanTrue);
    CFDictionarySetValue(getKeyRef, kSecUseOperationPrompt, @"Authenticate to sign data");
    
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
