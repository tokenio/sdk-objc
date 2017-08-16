//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "gateway/Gateway.pbrpc.h"

#import "TKUnauthenticatedClient.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKRpcErrorHandler.h"
#import "TKHasher.h"

@implementation TKUnauthenticatedClient {
    GatewayService *gateway;
    TKRpc *rpc;
    TKRpcErrorHandler *errorHandler;
}

- (id)initWithGateway:(GatewayService *)gateway_
            timeoutMs:(int)timeoutMs_
         errorHandler:(TKRpcErrorHandler *) errorHandler_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
        errorHandler = errorHandler_;
        rpc = [[TKRpc alloc] initWithTimeoutMs:timeoutMs_];
    }

    return self;
}

- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
               onError:(void(^)(NSError *))onError {
    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = [TKUtil nonce];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToCreateMemberWithRequest:request
                                 handler:^(CreateMemberResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         onSuccess(response.memberId);
                                     } else {
                                         [errorHandler handle:onError withError:error];
                                     }
                                 }];
    [rpc execute:call request:request];
}

- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError {
    ResolveAliasRequest *request = [ResolveAliasRequest message];
    request.alias = alias;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToResolveAliasWithRequest:request
                                   handler:^(ResolveAliasResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           if (response.hasMember) {
                                               onSuccess(response.member.id_p);
                                           }
                                           else{
                                               onSuccess(nil);
                                           }
                                       } else {
                                           [errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    GetMemberRequest *request = [GetMemberRequest message];
    request.memberId = memberId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToGetMemberWithRequest:request
                              handler:^(GetMemberResponse *response, NSError *error) {
                                  if (response) {
                                      RpcLogCompleted(response);
                                      onSuccess(response.member);
                                  } else {
                                      [errorHandler handle:onError withError:error];
                                  }
                              }
    ];

    [rpc execute:call request:request];
}

- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    [self createMember:memberId
                crypto:crypto
            operations:operations
             metadataArray:[NSArray array]
             onSuccess:onSuccess
               onError:onError];
}

- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
           metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
    request.metadataArray = [NSMutableArray arrayWithArray:metadataArray];

    TKSignature *signature = [crypto sign:request.update
                                 usingKey:Key_Level_Privileged
                                   reason:TKLocalizedString(
                                           @"Signature_Reason_CreateMember",
                                           @"Approve create a new Token member account")
                                  onError:onError];
    if (!signature) {
        return;
    }

    request.updateSignature.memberId = memberId;
    request.updateSignature.keyId = signature.key.id_p;
    request.updateSignature.signature = signature.value;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToUpdateMemberWithRequest:request
                                 handler:^(UpdateMemberResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         onSuccess(response.member);
                                     } else {
                                         [errorHandler handle:onError withError:error];
                                     }
                                 }];
    [rpc execute:call request:request];
}

- (void)notifyPaymentRequest:(Alias *)alias
                       token:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    RequestTransferRequest *request = [RequestTransferRequest message];
    request.alias = alias;
    request.tokenPayload = token;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToRequestTransferWithRequest:request
                           handler:^(RequestTransferResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.body.linkAccounts.bankAuthorization = authorization;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToNotifyWithRequest:request
                           handler:^(NotifyResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyAddKey:(Alias *)alias
             keyName:(NSString *)keyName
                 key:(Key *)key
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.body.addKey.name = keyName;
    request.body.addKey.key = key;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToNotifyWithRequest:request
                           handler:^(NotifyResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.body.linkAccountsAndAddKey.linkAccounts.bankAuthorization = authorization;
    request.body.linkAccountsAndAddKey.addKey.name = keyName;
    request.body.linkAccountsAndAddKey.addKey.key = key;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToNotifyWithRequest:request
                           handler:^(NotifyResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

@end
