//
// Created by Alexey Kalinichenko on 12/7/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "TKRpc.h"
#import "GPBMessage.h"
#import "Auth.pbobjc.h"
#import "TKCrypto.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKLogManager.h"
#import "TKJson.h"

NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKRpc {
    int timeoutMs;
    NSString *developerKey;
    NSString *languageCode;
}

- (id)initWithTimeoutMs:(int)timeoutMs_
           developerKey:(NSString *)developerKey_
           languageCode:(NSString *)languageCode_ {
    self = [super init];

    if (self) {
        timeoutMs = timeoutMs_;
        developerKey = [developerKey_ copy];
        languageCode = [languageCode_ copy];
    }

    return self;
}

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request {
    [self _setSdkHeaders:call];
    [self dispatch:call request:request];
}

- (void)execute:(GRPCProtoCall *)call
        request:(GPBMessage *)request
       memberId:(NSString *)memberId
         crypto:(TKCrypto *)crypto
       usingKey:(Key_Level)keyLevel
     onBehalfOf:(NSString *)onBehalfOfMemberId
        onError:(OnError)onError { 
    unsigned long long now = (unsigned long long)([[NSDate date] timeIntervalSince1970] * 1000);

    GrpcAuthPayload *payload = [GrpcAuthPayload message];
    payload.request = [request data];
    payload.createdAtMs = now;
    TKSignature *signature = [crypto
            sign:payload
        usingKey:keyLevel
          reason:TKLocalizedString(
                  @"Signature_Reason_Authentication",
                  @"Approve authentication")
         onError:onError];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = signature.key.id_p;
    call.requestHeaders[@"token-signature"] = signature.value;
    call.requestHeaders[@"token-created-at-ms"] = [NSString stringWithFormat:@"%llu", now];
    
    [self _setSdkHeaders:call];

    if (onBehalfOfMemberId) {
        call.requestHeaders[@"token-on-behalf-of"] = onBehalfOfMemberId;
    }

    // Keep it in comment in case we need it in the future.
    // TKLogVerbose(@"Auth key-id: %@", signature.key.id_p);
    // TKLogVerbose(@"Auth signature: %@", signature.value);
    // TKLogVerbose(@"Auth payload: %@", [TKJson serialize:request]);
    // TKLogVerbose(@"Auth created-at: %llu", now);

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

- (void)_setSdkHeaders:(GRPCProtoCall *)call {
    NSString * version = [TKUtil tokenSdkVersion];
    call.requestHeaders[@"token-sdk"] = @"objc";
    call.requestHeaders[@"token-sdk-version"] = version;
    call.requestHeaders[@"token-dev-key"] = developerKey;
    call.requestHeaders[@"language"] = languageCode;
}

@end
