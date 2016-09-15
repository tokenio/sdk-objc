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


@implementation TKClient {
    GatewayService *gateway;
    TKSecretKey *key;
}

- (id)initWithGateway:(GatewayService *)gateway_ secretKey:(TKSecretKey *)key_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
        key = key_;
    }

    return self;
}

- (void)getMember:(NSString *)memberId
        onSuccess:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError {

    GetMemberRequest *request = [GetMemberRequest message];
    GRPCProtoCall *call = [gateway
            RPCToGetMemberWithRequest:request
            handler:^(GetMemberResponse *response, NSError *error) {
                if (response) {
                    onSuccess(response.member);
                } else {
                    onError(error);
                }
            }
    ];

    call.requestHeaders[@"token-realm"] = @"Token";
    call.requestHeaders[@"token-scheme"] = @"Token-Ed25519-SHA512";
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = [TKCrypto sign:request usingKey:key];

    [call start];
}

@end