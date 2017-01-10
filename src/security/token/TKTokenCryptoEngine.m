//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ed25519.h"
#import "TKTokenSecretKey.h"
#import "TKUtil.h"
#import "TKTokenCryptoEngine.h"
#import "TKKeyInfo.h"
#import "TKTokenCryptoStorage.h"


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

- (NSArray<TKKeyInfo*> *)generateKeys {
    TKTokenSecretKey *privileged = [self generateKey:Key_Level_Privileged];
    // TODO: This needs to be Key_Level_Standard. Need to change server first
    // PR-383.
    TKTokenSecretKey *standard = [self generateKey:Key_Level_Privileged];
    TKTokenSecretKey *low = [self generateKey:Key_Level_Low];

    [storage addKey:privileged ofType:kKeyKeyManagement];
    [storage addKey:privileged ofType:kKeySigningHighPrivelege];
    [storage addKey:standard ofType:kKeySigning];
    [storage addKey:low ofType:kKeyAuth];

    return @[
            privileged.keyInfo,
            standard.keyInfo,
            low.keyInfo
    ];
}

- (NSString *)signData:(NSData *)data
            usingKeyId:(NSString *)keyId {
    TKTokenSecretKey *key = [storage lookupKeyById:keyId];
    unsigned char signature[64];
    unsigned const char *sk = key.privateKey.bytes;
    unsigned const char *pk = key.publicKey.bytes;

    ed25519_sign(signature, data.bytes, data.length, pk, sk);
    return [TKUtil base64EncodeBytes:(const char *)signature length:sizeof(signature)];
}

- (bool)verifySignature:(NSString *)signature
                forData:(NSData *)data
             usingKeyId:(NSString *)keyId {
    NSData *publicKey = [storage lookupKeyById:keyId].publicKey;
    NSData *decodedSignature = [TKUtil base64DecodeString:signature];
    return ed25519_verify(decodedSignature.bytes, data.bytes, data.length, publicKey.bytes) != 0;
}

- (TKKeyInfo *)lookupKeyByType:(TKKeyType)type {
    TKTokenSecretKey *key = [storage lookupKeyByType:type];
    return [TKKeyInfo keyInfoWithId:key.id level:key.level publicKey:key.publicKey];
}

#pragma mark private

- (TKTokenSecretKey *)generateKey:(Key_Level)keyLevel {
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
