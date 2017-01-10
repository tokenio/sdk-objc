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

- (NSArray<TKKeyInfo*> *)generateKeys {
    TKKeyInfo *privileged = [engine generateKey:Key_Level_Privileged];
    TKKeyInfo *standard = [engine generateKey:Key_Level_Standard];
    TKKeyInfo *low = [engine generateKey:Key_Level_Low];
    return @[privileged, standard, low];
}

- (TKSignature *)sign:(GPBMessage *)message
             usingKey:(TKKeyType)keyType {
    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [engine signData:jsonData usingKeyLevel:[self keyLevelForType:keyType]];
}

- (TKSignature *)sign:(Token *)token
               action:(TokenSignature_Action)action
             usingKey:(TKKeyType)keyType {
    NSData *payload = [self encodedPayloadFor:token with:action];
    return [engine signData:payload usingKeyLevel:[self keyLevelForType:keyType]];
}

- (TKSignature *)signPayload:(TokenPayload *)tokenPayload
                      action:(TokenSignature_Action)action
                    usingKey:(TKKeyType)keyType {
    NSData *payload = [self encodedPayload:tokenPayload with:action];
    return [engine signData:payload usingKeyLevel:[self keyLevelForType:keyType]];
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

- (Key_Level)keyLevelForType:(TKKeyType)type {
    switch (type) {
        case kKeyKeyManagement:
            return Key_Level_Privileged;
        case kKeySigningHighPrivilege:
            // TODO: This needs to be Key_Level_Standard. Need to change server first
            // PR-383.
            return Key_Level_Privileged;
        case kKeySigning:
            // TODO: This needs to be Key_Level_Low. Need to change server first
            // PR-383.
            return Key_Level_Privileged;
        case kKeyAuth:
            return Key_Level_Low;
        default:
            [NSException
                    raise:NSInvalidArgumentException
                   format:@"Invalid key type: %d", type];
    }
}

@end
