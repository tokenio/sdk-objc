//
// Created by Alexey Kalinichenko on 12/7/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKSecretKey;
@class GPBMessage;


@interface TKRpc : NSObject


/**
 * @param timeoutMs gRPC timeout in ms
 * @param memberId member id
 * @param key secret key to use for authentication
 * @return newly created client
 */
- (id)initWithTimeoutMs:(int)timeoutMs;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
      secretKey:(TKSecretKey *)key;

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
      secretKey:(TKSecretKey *)key
     onBehalfOf:(NSString *)onBehalfOfMemberId;

@end