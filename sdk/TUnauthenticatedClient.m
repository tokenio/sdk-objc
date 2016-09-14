//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TUnauthenticatedClient.h"
#import "TUtil.h"

#import "gateway/Gateway.pbrpc.h"
#import "TSecretKey.h"
#import "TCrypto.h"


@implementation TUnauthenticatedClient {
    GatewayService *gateway;
}

- (id)initWithGateway:(GatewayService *)gateway_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
    }

    return self;
}

- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
               onError:(void(^)(NSError *))onError {

    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = [TUtil nonce];

    [gateway createMemberWithRequest:request handler:^(CreateMemberResponse *response, NSError *error) {
        if (response) {
            onSuccess(response.memberId);
        } else {
            onError(error);
        }
    }];
}

- (void)addFirstKey:(TSecretKey *)key
          forMember:(NSString *)memberId
          onSuccess:(void(^)(Member*))onSuccess
            onError:(void(^)(NSError *))onError {

    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.addKey.level = 0;
    request.update.addKey.publicKey = key.publicKey;
    request.signature.keyId = key.id;
    request.signature.signature = [TCrypto sign:request.update usingKey:key];

    [gateway updateMemberWithRequest:request handler:^(UpdateMemberResponse *response, NSError *error) {
        if (response) {
            onSuccess(response.member);
        } else {
            onError(error);
        }
    }];
}

@end