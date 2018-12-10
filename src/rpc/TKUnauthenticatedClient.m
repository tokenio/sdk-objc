//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "gateway/Gateway.pbrpc.h"

#import "TKUnauthenticatedClient.h"

#import "TKError.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKRpcErrorHandler.h"
#import "TKHasher.h"
#import "TKUtil.h"
#import "NotifyResult.h"
#import "TokenRequestResult.h"

@implementation TKUnauthenticatedClient {
    GatewayService *gateway;
    TKRpc *rpc;
    TKRpcErrorHandler *errorHandler;
}

- (id)initWithGateway:(GatewayService *)gateway_
            timeoutMs:(int)timeoutMs_
         developerKey:(NSString *)developerKey_
         languageCode:(NSString *)languageCode_
         errorHandler:(TKRpcErrorHandler *) errorHandler_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
        errorHandler = errorHandler_;
        rpc = [[TKRpc alloc] initWithTimeoutMs:timeoutMs_
                                  developerKey:developerKey_
                                  languageCode:languageCode_];
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
                                         [self->errorHandler handle:onError withError:error];
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
                                           else {
                                               onSuccess(nil);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getTokenMember:(Alias *)alias
          onSuccess:(OnSuccessWithTokenMember)onSuccess
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
                                       onSuccess(response.member);
                                   }
                                   else {
                                       onSuccess(nil);
                                   }
                               } else {
                                   [self->errorHandler handle:onError withError:error];
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
                                      [self->errorHandler handle:onError withError:error];
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
    
    [self updateMember:memberId
                crypto:crypto
              prevHash:nil
            operations:operations
         metadataArray:metadataArray
                reason:TKLocalizedString(
                         @"Signature_Reason_CreateMember",
                         @"Approve create a new Token member account")
             onSuccess:onSuccess
               onError:onError];
}

- (void)updateMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
            prevHash:(NSString *)prevHash
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
              reason:(NSString *)reason
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
    if (prevHash) {
        request.update.prevHash = prevHash;
    }
    request.metadataArray = [NSMutableArray arrayWithArray:metadataArray];
    
    TKSignature *signature = [crypto sign:request.update
                                 usingKey:Key_Level_Privileged
                                   reason:reason
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
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
       onSuccess:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    GetBanksRequest *request = [GetBanksRequest message];
    request.idsArray = [NSMutableArray arrayWithArray:bankIds];
    request.search = search;
    request.country = country;
    request.page = page;
    request.perPage = perPage;
    request.sort = sort;
    request.provider = provider;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToGetBanksWithRequest:request
                           handler:
                           ^(GetBanksResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.banksArray);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    
    [rpc execute:call request:request];
}

- (void)notifyPaymentRequest:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    RequestTransferRequest *request = [RequestTransferRequest message];
    request.tokenPayload = token;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToRequestTransferWithRequest:request
                           handler:^(RequestTransferResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)notifyAddKey:(Alias *)alias
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.body.addKey.keysArray = [NSMutableArray arrayWithArray:keys];
    request.body.addKey.deviceMetadata = deviceMetadata;
    
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToNotifyWithRequest:request
                           handler:^(NotifyResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

-(void)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                            addkey:(AddKey *)addKey
                           contact:(ReceiptContact *)contact
                         onSuccess:(OnSuccessWithNotifyResult)onSuccess
                           onError:(OnError)onError {
    TriggerCreateAndEndorseTokenNotificationRequest *request = [TriggerCreateAndEndorseTokenNotificationRequest message];
    request.tokenRequestId = tokenRequestId;
    request.addKey = addKey;
    request.contact = contact;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToTriggerCreateAndEndorseTokenNotificationWithRequest:request
                           handler:^(TriggerCreateAndEndorseTokenNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess([NotifyResult createWithNotifyStatus:response.status
                                                                   notificationId:response.notificationId]);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)invalidateNotification:(NSString *)notificationId
                     onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                       onError:(OnError)onError {
    InvalidateNotificationRequest *request = [InvalidateNotificationRequest message];
    request.notificationId = notificationId;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToInvalidateNotificationWithRequest:request
                           handler:^(InvalidateNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.status);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)getTokenRequestResult:(NSString *)tokenRequestId
                    onSuccess:(OnSuccessWithTokenRequestResult)onSuccess
                      onError:(OnError)onError {
    GetTokenRequestResultRequest *request = [GetTokenRequestResultRequest message];
    request.tokenRequestId = tokenRequestId;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTokenRequestResultWithRequest:request
                           handler:^(GetTokenRequestResultResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess([TokenRequestResult createWithTokenId:response.tokenId
                                                                         signature:response.signature]);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

#pragma mark - Member Recovery

- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError {
    BeginRecoveryRequest *request = [BeginRecoveryRequest message];
    request.alias = alias;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToBeginRecoveryWithRequest: request
                           handler:^(BeginRecoveryResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.verificationId);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)getMemberRecoveryOperation:(NSString *)verificationId
                              code:(NSString *)code
                     privilegedKey:(Key *)key
                         onSuccess:(OnSuccessWithMemberRecoveryOperation)onSuccess
                           onError:(OnError)onError {
    CompleteRecoveryRequest *request = [CompleteRecoveryRequest message];
    request.verificationId = verificationId;
    request.code = code;
    request.key = key;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCompleteRecoveryWithRequest: request
                           handler:^(CompleteRecoveryResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   if (response.status != VerificationStatus_Success) {
                                       onError([NSError
                                                errorFromVerificationStatus:response.status
                                                userInfo:nil]);
                                       return;
                                   }
                                   onSuccess(response.recoveryEntry);
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}

- (void)recoverAlias:(NSString *)verificationId
                code:(NSString *)code
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    VerifyAliasRequest *request = [VerifyAliasRequest message];
    request.verificationId = verificationId;
    request.code = code;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToVerifyAliasWithRequest: request
                           handler:^(VerifyAliasResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [self->errorHandler handle:onError withError:error];
                               }
                           }];
    [rpc execute:call request:request];
}
@end
