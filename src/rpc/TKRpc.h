//
// Created by Alexey Kalinichenko on 12/7/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"
#import "TKCrypto.h"
@class GPBMessage;
@class TKCrypto;


@interface TKRpc : NSObject

/**
 * @param timeoutMs gRPC timeout in ms
 * @return newly created client
 */
- (id)initWithTimeoutMs:(int)timeoutMs
           developerKey:(NSString *)developerKey
           languageCode:(NSString *)languageCode;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
        crypto:(TKCrypto *)crypto
       usingKey:(Key_Level)keyLevel
     onBehalfOf:(NSString *)onBehalfOfMemberId
        onError:(OnError)onError;

@end
