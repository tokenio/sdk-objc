//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ed25519.h"
#import "TKTokenSecretKey.h"
#import "TKTokenCryptoEngine.h"
#import "TKKeyStore.h"
#import "TKSignature.h"


@implementation TKTokenCryptoEngine {
    id<TKKeyStore> keyStore;
    NSString *memberId;
}

- (id)initForMember:(NSString *)memberId_ useKeyStore:(id <TKKeyStore>)store_ {
    self = [super init];

    if (self) {
        keyStore = store_;
        memberId = memberId_;
    }

    return self;
}

- (Key *)generateKey:(Key_Level)level {
    TKTokenSecretKey *key = [self createNewKey_:level];
    [keyStore addKey:key forMember:memberId];
    return key.keyInfo;
}

- (TKSignature *)signData:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel {
    TKTokenSecretKey *key = [keyStore lookupKeyByLevel:keyLevel forMember:memberId];
    unsigned char signature[64];
    unsigned const char *sk = key.privateKey.bytes;
    unsigned const char *pk = key.publicKey.bytes;

    ed25519_sign(signature, data.bytes, data.length, pk, sk);
    return [TKSignature
            signature:[TKUtil base64EncodeBytes:(const char *)signature length:sizeof(signature)]
           signedWith:key.keyInfo];
}

- (bool)verifySignature:(NSString *)signature
                forData:(NSData *)data
             usingKeyId:(NSString *)keyId {
    NSData *publicKey = [keyStore lookupKeyById:keyId forMember:memberId].publicKey;
    NSData *decodedSignature = [TKUtil base64DecodeString:signature];
    return ed25519_verify(decodedSignature.bytes, data.bytes, data.length, publicKey.bytes) != 0;
}

#pragma mark private

- (TKTokenSecretKey *)createNewKey_:(Key_Level)keyLevel {
    unsigned char seed[32];
    if (ed25519_create_seed(seed)) {
        [NSException
                raise:NSInternalInconsistencyException
               format:@"Can't initialize random number generator"];
    }

    unsigned char public_key[32], private_key[64];
    ed25519_create_keypair(public_key, private_key, seed);

    NSData *publicKey = [NSData dataWithBytes:public_key length:sizeof(public_key)];
    NSData *privateKey = [NSData dataWithBytes:private_key length:sizeof(private_key)];

    return [TKTokenSecretKey keyWithLevel:keyLevel privateKey:privateKey publicKey:publicKey];
}

@end
