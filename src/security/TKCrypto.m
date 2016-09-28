//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Protobuf/GPBMessage.h"
#import "Token.pbobjc.h"

#import "ed25519.h"
#import "TKCrypto.h"
#import "TKSecretKey.h"
#import "TKJson.h"
#import "TKUtil.h"


@implementation TKCrypto

+(NSString *)sign:(GPBMessage *)message
         usingKey:(TKSecretKey *)key {
    NSString *json = [TKJson serialize:message];

    NSLog(@"PAYLOAD FOR SIGNATURE: %@", json);

    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [self signData:jsonData usingKey:key];
}

+ (NSString *)sign:(Token *)token
            action:(TokenSignature_Action)action
          usingKey:(TKSecretKey *)key {
    NSData *payload = [self payloadFor:token action:action];
    return [self signData:payload usingKey:key];
}

+(NSString *)signPayload:(NSString *)payload
                usingKey:(TKSecretKey *)key {
    return [self signData:[payload dataUsingEncoding:NSASCIIStringEncoding]
                 usingKey:key];
}

+(bool)verifySignature:(NSString *)signature
            forMessage:(GPBMessage *)message
        usingPublicKey:(NSData *)key {
    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [self verifySignature:signature forData:jsonData usingPublicKey:key];
}

+(bool)verifySignature:(NSString *)signature
              forToken:(Token *)token
                action:(TokenSignature_Action) action
        usingPublicKey:(NSData *)key {
    NSData *payload = [self payloadFor:token action:action];
    return [self verifySignature:signature forData:payload usingPublicKey:key];
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

+ (NSString *)signData:(NSData *)data
              usingKey:(TKSecretKey *)key {
    unsigned char signature[64];
    unsigned const char *sk = key.privateKey.bytes;
    unsigned const char *pk = key.publicKey.bytes;

    ed25519_sign(signature, data.bytes, data.length, pk, sk);
    return [TKUtil base64EncodeBytes:(const char *)signature length:sizeof(signature)];
}

+ (bool)verifySignature:(NSString *)signature
               forData:(NSData *)data
        usingPublicKey:(NSData *)key {
    NSData *decodedSignature = [TKUtil base64DecodeString:signature];
    return ed25519_verify(decodedSignature.bytes, data.bytes, data.length, key.bytes) != 0;
}

+ (NSData *)payloadFor:(Token *)token
                  action:(TokenSignature_Action)action {
    NSString *actionName = [TokenSignature_Action_EnumDescriptor() textFormatNameForValue:action];
    NSString *jsonToken = [TKJson serialize:token.payment];
    NSString *payload = [jsonToken stringByAppendingFormat:@".%@", [actionName lowercaseString]];
    return [payload dataUsingEncoding:NSASCIIStringEncoding];
}

@end
