//
//  TKSecureEnclaveCryptoEngine.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKSecureEnclaveCryptoEngine.h"

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

- (NSArray<TKKeyInfo*> *)generateKeys {
    
}

#pragma mark- Private Methods

- (NSString*)keyLabelForKeyType:(TKKeyType)keyType {
    return [NSString stringWithFormat:@"%@_%@", _memberId, @(keyType)];
}

- (TKKeyInfo*)generateKeyPairOfType:(TKKeyType)type {
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(
                                                                    kCFAllocatorDefault,
                                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                    kSecAccessControlUserPresence | kSecAccessControlPrivateKeyUsage,
                                                                    &error
                                                                    );
    
    if (error != errSecSuccess) {
        NSLog(@"Error generating access controls: %@\n", error);
        return nil;
    }
    
    CFMutableDictionaryRef accessControlDict = newCFDict;;
    CFDictionaryAddValue(accessControlDict, kSecAttrAccessControl, sacObject);
    CFDictionaryAddValue(accessControlDict, kSecAttrIsPermanent, kCFBooleanTrue);
    
    // create dict which actually saves key into keychain
    CFMutableDictionaryRef generateKeyRef = newCFDict;
    CFDictionaryAddValue(generateKeyRef, kSecAttrTokenID, kSecAttrTokenIDSecureEnclave);
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeyType, kSecAttrKeyTypeECSECPrimeRandom);
    CFDictionaryAddValue(generateKeyRef, kSecAttrKeySizeInBits, (__bridge const void *)([NSNumber numberWithInt:256]));
    CFDictionaryAddValue(generateKeyRef, kSecPrivateKeyAttrs, accessControlDict);
    
    SecKeyRef privateKeyRef = SecKeyCreateRandomKey(generateKeyRef, &error);
    if (error != errSecSuccess) {
        NSLog(@"Error generating private key: %@\n", error);
        return nil;
    }
    
    CFDictionaryRef dictRef = SecKeyCopyAttributes(privateKeyRef);
    
    CFDataRef keyHash = CFDictionaryGetValue(dictRef, kSecAttrApplicationLabel);
    NSData* keyHashData = (__bridge NSData *)(keyHash);
    NSString* keyHashString = [TKUtil base64EncodeData:keyHashData];
    NSLog(@"Key Hash String %@", keyHashString);
    
    return keyHashString;
}

@end
