//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ed25519.h"

#import "TKCrypto.h"
#import "TKSecretKey.h"
#import "GPBMessage.h"
#import "TKJson.h"
#import "TKUtil.h"


@implementation TKCrypto

+(NSString *)sign:(GPBMessage *)message usingKey:(TKSecretKey *)key {
    unsigned char signature[64];
    unsigned const char *sk = key.privateKey.bytes;
    unsigned const char *pk = key.publicKey.bytes;

    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];

    ed25519_sign(signature, jsonData.bytes, jsonData.length, pk, sk);

    return [TKUtil base64EncodeBytes:(const char *)signature length:sizeof(signature)];
}

+(bool)verifySignature:(NSString *)signature forMessage:(GPBMessage *)message usingPublicKey:(NSData *)key {
    NSData *decodedSignature = [TKUtil base64DecodeString:signature];

    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];

    return ed25519_verify(decodedSignature.bytes, jsonData.bytes, jsonData.length, key.bytes) != 0;
}

+(TKSecretKey *)generateKey {
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

    return [TKSecretKey withPrivateKey:privateKey publicKey:publicKey];
}

@end
