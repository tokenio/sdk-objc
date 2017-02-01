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

@implementation TKUnauthenticatedClient {
    GatewayService *gateway;
    TKRpc *rpc;
}

- (id)initWithGateway:(GatewayService *)gateway_ timeoutMs:(int)timeoutMs_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
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
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }];
    [rpc execute:call request:request];
}

- (void)getMemberId:(NSString *)username
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError {
    GetMemberIdRequest *request = [GetMemberIdRequest message];
    request.username = username;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToGetMemberIdWithRequest:request
                                   handler:^(GetMemberIdResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           onSuccess(response.memberId);
                                       } else {
                                           RpcLogError(error);
                                           onError(error);
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)createMember:(NSString *)memberId
                  crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
               onSuccess:(OnSuccessWithMember)onSuccess
                 onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.operationsArray = [NSMutableArray arrayWithArray:operations];

    TKSignature *signature = [crypto sign:request.update
                                 usingKey:Key_Level_Privileged
                                   reason:TKLocalizedString(
                                           @"Signature_Reason_CreateMember",
                                           @"Approve create a new Token member account")];
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
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }];
    [rpc execute:call request:request];
}

- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
    request.body.linkAccounts.bankId = bankId;
    request.body.linkAccounts.bankName = bankName;
    request.body.linkAccounts.accountLinkPayloadsArray = [NSMutableArray arrayWithArray:accountLinkPayloads];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToNotifyWithRequest:request
                           handler:^(NotifyResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyAddKey:(NSString *)username
             keyName:(NSString *)keyName
                 key:(Key *)key
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.username = username;
    request.body.linkAccountsAndAddKey.linkAccounts.bankId = bankId;
    request.body.linkAccountsAndAddKey.linkAccounts.bankName = bankName;
    request.body.linkAccountsAndAddKey.linkAccounts.accountLinkPayloadsArray
            = [NSMutableArray arrayWithArray:accountLinkPayloads];
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    [rpc execute:call request:request];
}

@end
