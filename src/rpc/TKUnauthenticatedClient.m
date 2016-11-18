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
    request.updateSignature.memberId = memberId;
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

- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    UsernameExistsRequest *request = [UsernameExistsRequest message];
    request.username = username;
    RpcLogStart(request);
    
    [gateway usernameExistsWithRequest:request
                            handler:^(UsernameExistsResponse *response, NSError *error) {
        if (response) {
            RpcLogCompleted(response);
            onSuccess(response.exists);
        } else {
            RpcLogError(error);
            onError(error);
        }
    }];
}

- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<NSString*> *)accountLinkPayloads
                 onSuccess:(void (^)())onSuccess
                   onError:(void (^)(NSError *))onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
    request.body.linkAccounts.bankId = bankId;
    request.body.linkAccounts.bankName = bankName;
    request.body.linkAccounts.accountLinkPayloadsArray = [NSMutableArray arrayWithArray:accountLinkPayloads];
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

- (void)notifyAddKey:(NSString *)username
           publicKey:(NSString *)publicKey
                name:(NSString*)name
           onSuccess:(void(^)())onSuccess
             onError:(void(^)(NSError *))onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
    request.body.addKey.publicKey = publicKey;
    request.body.addKey.name = name;
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

- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<NSString*> *)accountLinkPayloads
                          publicKey:(NSString *)publicKey
                               name:(NSString *)name
                          onSuccess:(void(^)())onSuccess
                            onError:(void(^)(NSError *))onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
    request.body.linkAccountsAndAddKey.linkAccounts.bankId = bankId;
    request.body.linkAccountsAndAddKey.linkAccounts.bankName = bankName;
    request.body.linkAccountsAndAddKey.linkAccounts.accountLinkPayloadsArray = [NSMutableArray arrayWithArray:accountLinkPayloads];
    request.body.linkAccountsAndAddKey.addKey.publicKey = publicKey;
    request.body.linkAccountsAndAddKey.addKey.name = name;
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
