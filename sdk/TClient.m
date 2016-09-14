//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <ProtoRPC/ProtoRPC.h>
#import "TClient.h"
#import "Member.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"
#import "TSecretKey.h"
#import "TCrypto.h"


@implementation TClient {
    GatewayService *gateway;
    TSecretKey *key;
}

- (id)initWithGateway:(GatewayService *)gateway_ secretKey:(TSecretKey *)key_ {
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
    call.requestHeaders[@"token-signature"] = [TCrypto sign:request usingKey:key];

    [call start];
}

@end