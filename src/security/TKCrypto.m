//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Protobuf/GPBMessage.h"
#import "Token.pbobjc.h"
#import "TKCryptoEngine.h"
#import "TKJson.h"
#import "TKKeyInfo.h"
#import "TKSignature.h"


@implementation TKCrypto {
    id<TKCryptoEngine> engine;
}

- (id)initWithEngine:(id<TKCryptoEngine>)engine_ {
    self = [super init];

    if (self) {
        engine = engine_;
    }

    return self;
}

- (TKKeyInfo *)generateKey:(Key_Level)level {
    return [engine generateKey:level];
}

- (TKSignature *)sign:(GPBMessage *)message
             usingKey:(Key_Level)keyLevel {
    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [engine signData:jsonData usingKeyLevel:keyLevel];
}

- (TKSignature*)signData:(NSData *)data usingKey:(Key_Level)keyLevel {
    return [engine signData:data usingKeyLevel:keyLevel];
}

- (TKSignature *)sign:(Token *)token
               action:(TokenSignature_Action)action
             usingKey:(Key_Level)keyLevel {
    NSData *payload = [self encodedPayloadFor:token with:action];
    return [engine signData:payload usingKeyLevel:keyLevel];
}

- (TKSignature *)signPayload:(TokenPayload *)tokenPayload
                      action:(TokenSignature_Action)action
                    usingKey:(Key_Level)keyLevel {
    NSData *payload = [self encodedPayload:tokenPayload with:action];
    return [engine signData:payload usingKeyLevel:keyLevel];
}

- (bool)verifySignature:(NSString *)signature
             forMessage:(GPBMessage *)message
             usingKeyId:(NSString *)keyId {
    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [engine verifySignature:signature
                           forData:jsonData
                        usingKeyId:keyId];
}

- (bool)verifySignature:(NSString *)signature
               forToken:(Token *)token
                 action:(TokenSignature_Action) action
             usingKeyId:(NSString *)keyId {
    NSData *payload = [self encodedPayloadFor:token with:action];
    return [engine verifySignature:signature
                           forData:payload
                        usingKeyId:keyId];
}

- (bool)verifySignature:(NSString *)signature forData:(NSData *)data usingKeyId:(NSString *)keyId {
    return [engine verifySignature:signature
                           forData:data
                        usingKeyId:keyId];
}

#pragma mark private

- (NSData *)encodedPayloadFor:(Token *)token
                         with:(TokenSignature_Action)action {
    return [self encodedPayload:token.payload with:action];
}

- (NSData *)encodedPayload:(TokenPayload *)tokenPayload
                      with:(TokenSignature_Action)action {
    NSString * actionName = [TokenSignature_Action_EnumDescriptor() textFormatNameForValue:action];
    NSString * jsonToken = [TKJson serialize:tokenPayload];
    NSString * payload = [jsonToken stringByAppendingFormat:@".%@", [actionName lowercaseString]];

    return [payload dataUsingEncoding:NSASCIIStringEncoding];
}

@end
