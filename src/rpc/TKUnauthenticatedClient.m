//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "gateway/Gateway.pbrpc.h"

#import "TKUnauthenticatedClient.h"
#import "TKUtil.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"


@implementation TKUnauthenticatedClient {
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
    request.nonce = [TKUtil nonce];
    RpcLogStart(request);

    [gateway createMemberWithRequest:request handler:^(CreateMemberResponse *response, NSError *error) {
        if (response) {
            RpcLogCompleted(response);
            onSuccess(response.memberId);
        } else {
            RpcLogError(error);
            onError(error);
        }
    }];
}


- (void)addFirstKey:(TKSecretKey *)key
          forMember:(NSString *)memberId
          onSuccess:(void(^)(Member*))onSuccess
            onError:(void(^)(NSError *))onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.addKey.level = 0;
    request.update.addKey.publicKey = key.publicKeyStr;
    request.updateSignature.keyId = key.id;
    request.updateSignature.signature = [TKCrypto sign:request.update usingKey:key];
    RpcLogStart(request);

    [gateway updateMemberWithRequest:request
                             handler:^(UpdateMemberResponse *response, NSError *error) {
        if (response) {
            RpcLogCompleted(response);
            onSuccess(response.member);
        } else {
            RpcLogError(error);
            onError(error);
        }
    }];
}

- (void)notifyLinkAccounts:(NSString *)alias
                    bankId:(NSString *)bankId
       accountsLinkPayload:(NSString *)accountsLinkPayload
                 onSuccess:(void (^)())onSuccess
                   onError:(void (^)(NSError *))onError {
    NotifyLinkAccountsRequest *request = [NotifyLinkAccountsRequest message];
    request.alias = alias;
    request.bankId = bankId;
    request.accountsLinkPayload = accountsLinkPayload;
    RpcLogStart(request);
    
    [gateway notifyLinkAccountsWithRequest:request
                                   handler:^(NotifyLinkAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           onSuccess();
                                       } else {
                                           RpcLogError(error);
                                           onError(error);
                                       }
                                   }];
}

- (void)notifyAddKey:(NSString * )alias
           publicKey:(NSString *) publicKey
                tags:(NSMutableArray<NSString*> *)tags
           onSuccess:(void(^)())onSuccess
             onError:(void(^)(NSError *))onError {
    NotifyAddKeyRequest *request = [NotifyAddKeyRequest message];
    request.alias = alias;
    request.publicKey = publicKey;
    request.tagsArray = tags;
    RpcLogStart(request);
    
    [gateway notifyAddKeyWithRequest:request
                             handler:^(NotifyAddKeyResponse *response, NSError *error) {
                                 if (response) {
                                     RpcLogCompleted(response);
                                     onSuccess();
                                 } else {
                                     RpcLogError(error);
                                     onError(error);
                                 }
                             }];
}

- (void)notifyLinkAccountsAndAddKey:(NSString * )alias
                             bankId:(NSString *)bankId
                accountsLinkPayload:(NSString *) accountsLinkPayload
                          publicKey:(NSString *) publicKey
                               tags:(NSMutableArray<NSString*> *)tags
                          onSuccess:(void(^)())onSuccess
                            onError:(void(^)(NSError *))onError {
    NotifyLinkAccountsAndAddKeyRequest *request = [NotifyLinkAccountsAndAddKeyRequest message];
    request.alias = alias;
    request.bankId = bankId;
    request.accountsLinkPayload = accountsLinkPayload;
    request.publicKey = publicKey;
    request.tagsArray = tags;
    RpcLogStart(request);
    
    [gateway notifyLinkAccountsAndAddKeyWithRequest:request
                                            handler:^(NotifyLinkAccountsAndAddKeyResponse *response, NSError *error) {
                                                if (response) {
                                                    RpcLogCompleted(response);
                                                    onSuccess();
                                                } else {
                                                    RpcLogError(error);
                                                    onError(error);
                                                }
                                            }];
}

@end
