//
// Created by Alexey Kalinichenko on 12/7/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPBMessage;
@class TKCrypto;


@interface TKRpc : NSObject

/**
 * @param timeoutMs gRPC timeout in ms
 * @return newly created client
 */
- (id)initWithTimeoutMs:(int)timeoutMs;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
        crypto:(TKCrypto *)crypto
     onBehalfOf:(NSString *)onBehalfOfMemberId;

@end