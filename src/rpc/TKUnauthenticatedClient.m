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
#import "TKTypedef.h"


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

- (void)aliasExists:(NSString *)alias
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    AliasExistsRequest *request = [AliasExistsRequest message];
    request.alias = alias;
    RpcLogStart(request);
    
    [gateway aliasExistsWithRequest:request
                            handler:^(AliasExistsResponse *response, NSError *error) {
        if (response) {
            RpcLogCompleted(response);
            onSuccess(response.exists);
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
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.notification.linkAccounts.bankId = bankId;
    request.notification.linkAccounts.accountsLinkPayload = accountsLinkPayload;
    RpcLogStart(request);
    
    [gateway notifyWithRequest:request
                                   handler:^(NotifyResponse *response, NSError *error) {
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
                name:(NSString*)name
           onSuccess:(void(^)())onSuccess
             onError:(void(^)(NSError *))onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.notification.addKey.publicKey = publicKey;
    request.notification.addKey.name = name;
    RpcLogStart(request);
    
    [gateway notifyWithRequest:request
                             handler:^(NotifyResponse *response, NSError *error) {
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
                               name:(NSString *)name
                          onSuccess:(void(^)())onSuccess
                            onError:(void(^)(NSError *))onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.notification.linkAccountsAndAddKey.linkAccounts.bankId = bankId;
    request.notification.linkAccountsAndAddKey.linkAccounts.accountsLinkPayload = accountsLinkPayload;
    request.notification.linkAccountsAndAddKey.addKey.publicKey = publicKey;
    request.notification.linkAccountsAndAddKey.addKey.name = name;
    RpcLogStart(request);
    
    [gateway notifyWithRequest:request
                                            handler:^(NotifyResponse *response, NSError *error) {
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
