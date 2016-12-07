//
// Created by Alexey Kalinichenko on 12/7/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "TKRpc.h"
#import "GPBMessage.h"
#import "Auth.pbobjc.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"
#import "TKSecretKey.h"

NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKRpc {
    int timeoutMs;
}

- (id)initWithTimeoutMs:(int)timeoutMs_ {
    self = [super init];

    if (self) {
        timeoutMs = timeoutMs_;
    }

    return self;
}

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request {
    [self dispatch:call request:request];
}

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
      secretKey:(TKSecretKey *)key {
    [self execute:call
          request:request
         memberId:memberId
        secretKey:key
       onBehalfOf:nil];
}

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
      secretKey:(TKSecretKey *)key
     onBehalfOf:(NSString *)onBehalfOfMemberId {
    unsigned long now = (unsigned long)([[NSDate date] timeIntervalSince1970] * 1000);

    GRpcAuthPayload *payload = [GRpcAuthPayload message];
    payload.request = [request data];
    payload.createdAtMs = now;
    NSString *signature = [TKCrypto sign:payload usingKey:key];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = signature;
    call.requestHeaders[@"token-created-at-ms"] = [NSString stringWithFormat: @"%lu", now];

    if (onBehalfOfMemberId) {
        call.requestHeaders[@"token-on-behalf-of"] = onBehalfOfMemberId;
    }

    [self dispatch:call request:request];
}

- (void)dispatch:(GRPCProtoCall *)call request:(GPBMessage *)request {
    dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, timeoutMs * NSEC_PER_MSEC),
            dispatch_get_main_queue(), ^{
                [call cancel];
            });
    [call start];
}

@end