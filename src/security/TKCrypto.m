//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Protobuf/GPBMessage.h"
#import "Token.pbobjc.h"
#import "TKCryptoEngine.h"
#import "TKJson.h"
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

- (NSArray<Key *> *)generateKeys {
    return @[
             [self generateKey:Key_Level_Privileged],
             [self generateKey:Key_Level_Standard],
             [self generateKey:Key_Level_Low]
             ];
}

- (Key *)generateKey:(Key_Level)level {
    return [engine generateKey:level];
}

- (Key *)generateKey:(Key_Level)level
      withExpiration:(long long)expiresAtMs {
    return [engine generateKey:level
                withExpiration:expiresAtMs];
}


- (NSArray<Key *> *)getKeyInfos:(NSString *)reason
                        onError:(OnError)onError {
    NSArray *levels = @[[NSNumber numberWithInt:Key_Level_Privileged],
                        [NSNumber numberWithInt:Key_Level_Standard],
                        [NSNumber numberWithInt:Key_Level_Low]];
    NSMutableArray<Key *> *result = [NSMutableArray arrayWithCapacity:3];
    
    for (NSNumber* level in levels) {
        Key_Level keylevel = level.intValue;
        Key *key = [self getKeyInfo:keylevel
                             reason:reason
                            onError:onError];
        if (!key) {
            return nil;
        }
        [result addObject:key];
    }
    
    return [NSArray arrayWithArray:result];
}

- (Key *)getKeyInfo:(Key_Level)level
             reason:(NSString *)reason
            onError:(OnError)onError {
    Key *key = [engine getKeyInfo:level
                           reason:reason
                          onError:onError];
    if (!key) {
        return nil;
    }
    return key;
}

- (TKSignature *)sign:(GPBMessage *)message
             usingKey:(Key_Level)keyLevel
               reason:(NSString *)reason
              onError:(OnError)onError {
    NSString *json = [TKJson serialize:message];
    NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
    return [engine signData:jsonData usingKeyLevel:keyLevel reason:reason onError:onError];
}

- (TKSignature *)sign:(Token *)token
               action:(TokenSignature_Action)action
             usingKey:(Key_Level)keyLevel
               reason:(NSString *)reason
              onError:(OnError)onError {
    NSData *payload = [self encodedPayloadFor:token with:action];
    return [engine signData:payload usingKeyLevel:keyLevel reason:reason onError:onError];
}

- (TKSignature *)signPayload:(TokenPayload *)tokenPayload
                      action:(TokenSignature_Action)action
                    usingKey:(Key_Level)keyLevel
                      reason:(NSString *)reason
                     onError:(OnError)onError {
    NSData *payload = [self encodedPayload:tokenPayload with:action];
    return [engine signData:payload usingKeyLevel:keyLevel reason:reason onError:onError];
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

    return [payload dataUsingEncoding:NSUTF8StringEncoding];
}

@end
