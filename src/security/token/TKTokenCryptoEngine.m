//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ed25519.h"
#import "TKTokenSecretKey.h"
#import "TKTokenCryptoEngine.h"
#import "TKTokenCryptoStorage.h"
#import "TKSignature.h"


@implementation TKTokenCryptoEngine {
    id<TKTokenCryptoStorage> storage;
}

- (id)initWithStorage:(id<TKTokenCryptoStorage>)storage_ {
    self = [super init];

    if (self) {
        storage = storage_;
    }

    return self;
}

- (Key *)generateKey:(Key_Level)level {
    TKTokenSecretKey *key = [self createNewKey_:level];
    [storage addKey:key];
    return key.keyInfo;
}

- (TKSignature *)signData:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel {
    TKTokenSecretKey *key = [storage lookupKeyByLevel:keyLevel];
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
    NSData *publicKey = [storage lookupKeyById:keyId].publicKey;
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
