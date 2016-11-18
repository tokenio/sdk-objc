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
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [self signData:jsonData usingKey:key];
}

+ (NSString *)sign:(Token *)token
            action:(TokenSignature_Action)action
          usingKey:(TKSecretKey *)key {
    NSData *payload = [self encodedPayloadFor:token with:action];
    return [self signData:payload usingKey:key];
}

+ (NSString *)signPayload:(TokenPayload *)tokenPayload
                   action:(TokenSignature_Action)action
                 usingKey:(TKSecretKey *)key {
    NSData *payload = [self encodedPayload:tokenPayload with:action];
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
    NSData *payload = [self encodedPayloadFor:token with:action];
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
    NSString *result = [TKUtil base64EncodeBytes:(const char *)signature length:sizeof(signature)];
    
    // TODO(alexey): Remove this, here to help track down prod issue.
    NSLog(@"payload=[%@]", data);
    NSLog(@"key.id=[%@]", key.id);
    NSLog(@"key.public=[%@]", key.publicKeyStr);
    NSLog(@"signature=[%@]", result);
    
    return result;
}

+ (bool)verifySignature:(NSString *)signature
               forData:(NSData *)data
        usingPublicKey:(NSData *)key {
    NSData *decodedSignature = [TKUtil base64DecodeString:signature];
    return ed25519_verify(decodedSignature.bytes, data.bytes, data.length, key.bytes) != 0;
}

+ (NSData *)encodedPayloadFor:(Token *)token
                         with:(TokenSignature_Action)action {
    return [self encodedPayload:token.payload with:action];
}

+ (NSData *)encodedPayload:(TokenPayload *)tokenPayload
                      with:(TokenSignature_Action)action {
    NSString *actionName = [TokenSignature_Action_EnumDescriptor() textFormatNameForValue:action];
    NSString *jsonToken = [TKJson serialize:tokenPayload];
    NSString *payload = [jsonToken stringByAppendingFormat:@".%@", [actionName lowercaseString]];
    
    // TODO(alexey): Remove this, here to help track down prod issue.
    NSLog(@"payload=[%@]", payload);
    
    return [payload dataUsingEncoding:NSASCIIStringEncoding];
}

@end
