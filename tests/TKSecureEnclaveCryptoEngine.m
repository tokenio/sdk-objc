//
//  TKSecureEnclaveCryptoEngine.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKSecureEnclaveCryptoEngine.h"
#import "TKKeyInfo.h"
#import "TKJson.h"
#import "TKSignature.h"
#include <CommonCrypto/CommonDigest.h>

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

- (TKKeyInfo*)generateKey:(Key_Level)level {
    return [self generateKeyPairWithLevel:level];
}

- (TKSignature*)signData:(NSData *)data usingKeyLevel:(Key_Level)keyLevel {
    SecKeyRef privateKeyRef = [self privateKeyForLevel:keyLevel];
    CFErrorRef error = NULL;

    CFDataRef signRef = SecKeyCreateSignature(privateKeyRef, kSecKeyAlgorithmECDSASignatureMessageX962SHA256, (__bridge CFDataRef)data, &error);
    if (error != errSecSuccess) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Error signing data: %@\n", error];
    }
    NSData* signatureData = (__bridge NSData *)(signRef);

    NSString* signatureString = [TKUtil base64EncodeData:signatureData];
    TKSignature* tkSignature =  [TKSignature signature:signatureString signedWith:[self keyInfoForPrivateKey:privateKeyRef level:keyLevel]];
    CFRelease(privateKeyRef);

    return tkSignature;
}

- (bool)verifySignature:(NSString *)signature forData:(NSData *)data usingKeyId:(NSString *)keyId {
    SecKeyRef keyRef = [self publicKeyForKeyId:keyId];
    if (keyRef == NULL) {
        return false;
    }
    CFErrorRef error = NULL;
    NSData* signatureData = [TKUtil base64DecodeString:signature];
    Boolean success = SecKeyVerifySignature(keyRef, kSecKeyAlgorithmECDSASignatureMessageX962SHA256, (__bridge CFDataRef)data, (__bridge CFDataRef)(signatureData), &error);
    CFRelease(keyRef);
    
    return success == 1;
}

#pragma mark- Private Methods

#define newCFDict CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks)


- (NSString*)keyLabelForKeylevel:(Key_Level)level {
    return [NSString stringWithFormat:@"%@_%@", _memberId, @(level)];
}

- (TKKeyInfo*)generateKeyPairWithLevel:(Key_Level)level {
    
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
                                                                    &error
                                                                    );
    
    if (error != errSecSuccess) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Error generating access controls: %@\n", error];
    }
    
    CFMutableDictionaryRef accessControlDict = newCFDict;
    CFDictionaryAddValue(accessControlDict, kSecAttrAccessControl, sacObject);
    CFDictionaryAddValue(accessControlDict, kSecAttrIsPermanent, kCFBooleanTrue);
    CFDictionaryAddValue(accessControlDict, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeylevel:level]));
    
    // create dict which actually saves key into keychain
    CFMutableDictionaryRef generateKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(generateKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeyType, kSecAttrKeyTypeECSECPrimeRandom);
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeySizeInBits, (__bridge const void *)([NSNumber numberWithInt:256]));
    CFDictionaryAddValue(generateKeyRef, kSecPrivateKeyAttrs, accessControlDict);
    
    CFRelease(sacObject);
    
    SecKeyRef privateKeyRef = SecKeyCreateRandomKey(generateKeyRef, &error);
    if (error != errSecSuccess) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Error generating private key: %@\n", error];
    }
    
    TKKeyInfo* keyInfo = [self keyInfoForPrivateKey:privateKeyRef level:level];

    CFRelease(privateKeyRef);
    return keyInfo;
}

- (void)deleteOldKeysForLevel:(Key_Level)level {
    CFMutableDictionaryRef queryKeyRef = newCFDict;
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(queryKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionaryAddValue(queryKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeylevel:level]));
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
    OSStatus status = SecItemAdd(queryRef, (CFTypeRef *)&result);
    if (status != errSecSuccess) {
        status = SecItemCopyMatching(queryRef, (CFTypeRef *)&result);
        if (status != errSecSuccess) {
            [NSException
             raise:NSInvalidArgumentException
             format:@"Error adding public key: %@\n", @(status)];
        }
    }
    NSData* keyBitsData = (__bridge NSData *)(result);
    return keyBitsData;
}

- (TKKeyInfo*)keyInfoForPrivateKey:(SecKeyRef)keyRef level:(Key_Level)level {
    SecKeyRef publicKeyRef = SecKeyCopyPublicKey(keyRef);
    NSData* puclicKeyData = [self publicKeyDataFromKeyRef:publicKeyRef];
    
    CFDictionaryRef dictRef = SecKeyCopyAttributes(keyRef);
    CFDataRef keyHash = CFDictionaryGetValue(dictRef, kSecAttrApplicationLabel);
    NSLog(@"kSecAttrApplicationLabel %@", keyHash);
    NSLog(@"puclicKeyData %@", puclicKeyData);
    NSData* keyHashData = (__bridge NSData *)(keyHash);
    NSString* keyHashString = [TKUtil base64EncodeData:keyHashData];
    
    CFRelease(publicKeyRef);
   
    return  [TKKeyInfo keyInfoWithId:keyHashString level:level algorithm:Key_Algorithm_Sha256WithEcdsa publicKey:puclicKeyData];
}

- (SecKeyRef)privateKeyForLevel:(Key_Level)level {

    CFMutableDictionaryRef getKeyRef = newCFDict;
    CFDictionarySetValue(getKeyRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(getKeyRef, kSecAttrKeyClass, kSecAttrKeyClassPrivate);
#if !(TARGET_IPHONE_SIMULATOR)
    CFDictionaryAddValue(getKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
#endif
    CFDictionarySetValue(getKeyRef, kSecAttrLabel, (__bridge const void *)([self keyLabelForKeylevel:level]));
    CFDictionarySetValue(getKeyRef, kSecReturnRef, kCFBooleanTrue);
    CFDictionarySetValue(getKeyRef, kSecUseOperationPrompt, @"Authenticate to sign data");
    
    SecKeyRef keyRef;
    OSStatus status = SecItemCopyMatching(getKeyRef, (CFTypeRef *)&keyRef);
    if (status != errSecSuccess) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Error retrieving private key: %@\n", @(status)];
    }
    
    return (SecKeyRef)keyRef;
}

- (SecKeyRef)publicKeyForKeyId:(NSString*)keyId {
    NSData* appLabel = [TKUtil base64DecodeString:keyId];
    CFMutableDictionaryRef getKeyRef = newCFDict;
    
    CFDictionarySetValue(getKeyRef, kSecClass, kSecClassKey);
    CFDictionarySetValue(getKeyRef, kSecAttrKeyClass, kSecAttrKeyClassPublic);
    CFDictionarySetValue(getKeyRef, kSecAttrApplicationLabel, (__bridge const void *)(appLabel));
    CFDictionarySetValue(getKeyRef, kSecReturnRef, kCFBooleanTrue);
    
    SecKeyRef keyRef;
    OSStatus status = SecItemCopyMatching(getKeyRef, (CFTypeRef *)&keyRef);
    if (status != errSecSuccess) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Error retrieving public key for id %@ error: %@\n", keyId,  @(status)];
    }
    
    return (SecKeyRef)keyRef;
}
@end
