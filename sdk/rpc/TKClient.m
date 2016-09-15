//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <ProtoRPC/ProtoRPC.h>
#import "TKClient.h"
#import "Member.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"


NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKClient {
    GatewayService *gateway;
    NSString *memberId;
    TKSecretKey *key;
}

- (id)initWithGateway:(GatewayService *)gateway_
             memberId:(NSString *)memberId_
            secretKey:(TKSecretKey *)key_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
        memberId = memberId_;
        key = key_;
    }

    return self;
}

- (void)getMember:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError {

    GetMemberRequest *request = [GetMemberRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToGetMemberWithRequest:request
            handler:^(GetMemberResponse *response, NSError *error) {
                if (response) {
                    RpcLogCompleted(request);
                    onSuccess(response.member);
                } else {
                    RpcLogError(error);
                    onError(error);
                }
            }
    ];

    [self startCall:call withRequest:request];
}

- (void)startCall:(GRPCProtoCall *)call withRequest:(GPBMessage *)request {
    NSString *signature = [TKCrypto sign:request usingKey:key];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = signature;

    [call start];
}

@end