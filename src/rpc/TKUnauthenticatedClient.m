//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "gateway/Gateway.pbrpc.h"

#import "TKUnauthenticatedClient.h"
#import "TKUtil.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKKeyInfo.h"
#import "TKSignature.h"


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

- (void)createKeys:(NSString *)memberId
            crypto:(TKCrypto *)crypto
         onSuccess:(void (^)(Member *))onSuccess
           onError:(void(^)(NSError *))onError {
    NSArray<NSNumber *> *keys = @[
            @(Key_Level_Privileged),
            @(Key_Level_Standard),
            @(Key_Level_Low)];
    [self createKeysForMember_:memberId
                          keys:keys
                      keyIndex:0
                      lastHash:nil
                        crypto:crypto
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    UsernameExistsRequest *request = [UsernameExistsRequest message];
    request.username = username;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToUsernameExistsWithRequest:request
                                   handler:^(UsernameExistsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           onSuccess(response.exists);
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
    request.body.linkAccountsAndAddKey.linkAccounts.accountLinkPayloadsArray = [NSMutableArray arrayWithArray:accountLinkPayloads];
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

#pragma mark private

- (void)createKeysForMember_:(NSString *)memberId
                        keys:(NSArray<NSNumber *> *)keys
                    keyIndex:(NSUInteger)keyIndex
                    lastHash:(NSString *)lastHash
                      crypto:(TKCrypto *)crypto
                   onSuccess:(void (^)(Member *))onSuccess
                     onError:(void(^)(NSError *))onError {
    TKKeyInfo *key = [crypto generateKey:(Key_Level) [[keys objectAtIndex:keyIndex] intValue]];

    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.addKey.level = key.level;
    request.update.addKey.publicKey = key.publicKeyStr;
    request.update.addKey.algorithm = key.algorithm;

    if (lastHash) {
        request.update.prevHash = lastHash;
    }

    TKSignature *signature = [crypto sign:request.update usingKey:Key_Level_Privileged];
    request.updateSignature.memberId = memberId;
    request.updateSignature.keyId = signature.key.id;
    request.updateSignature.signature = signature.value;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToUpdateMemberWithRequest:request
                                 handler:^(UpdateMemberResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         if (keyIndex == keys.count - 1) {
                                             onSuccess(response.member);
                                         } else {
                                             [self createKeysForMember_:memberId
                                                                   keys:keys
                                                               keyIndex:keyIndex + 1
                                                               lastHash:response.member.lastHash
                                                                 crypto:crypto
                                                              onSuccess:onSuccess
                                                                onError:onError];
                                         }
                                     } else {
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }];
    [rpc execute:call request:request];
}

@end
