//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "Member.pbobjc.h"
#import "TKBalance.h"

#import "TKClient.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKRpcErrorHandler.h"
#import "TKError.h"
#import "TKUnauthenticatedClient.h"
#import "PagedArray.h"
#import "TKLogManager.h"

@implementation TKClient {
    GatewayService *gateway;
    TKCrypto *crypto;
    TKRpc *rpc;
    NSString *memberId;
    NSString *onBehalfOfMemberId;
    TKRpcErrorHandler *errorHandler;
    TKUnauthenticatedClient *unauthenticatedClient;
    SecurityMetadata *securityMetadata;
}

- (id)initWithGateway:(GatewayService *)gateway_
               crypto:(TKCrypto *)crypto_
            timeoutMs:(int)timeoutMs_
         developerKey:(NSString *)developerKey_
         languageCode:(NSString *)languageCode_
             memberId:(NSString *)memberId_
         errorHandler:(TKRpcErrorHandler *)errorHandler_ {
    self = [super init];
    
    if (self) {
        gateway = gateway_;
        crypto = crypto_;
        memberId = memberId_;
        rpc = [[TKRpc alloc] initWithTimeoutMs:timeoutMs_
                                  developerKey:developerKey_
                                  languageCode:languageCode_];
        errorHandler = errorHandler_;
        
        unauthenticatedClient = [[TKUnauthenticatedClient alloc]
                                 initWithGateway:gateway
                                 timeoutMs:timeoutMs_
                                 developerKey:developerKey_
                                 languageCode:languageCode_
                                 errorHandler:errorHandler];
    }
    
    return self;
}

- (id)initWithRpc:(TKRpc *)rpc_
          gateway:(GatewayService *)gateway_
           Crypto:(TKCrypto *)crypto_
         memberId:(NSString *)memberId_
           client:(TKUnauthenticatedClient *) unauthenticatedClient_
     errorHandler:(TKRpcErrorHandler *)errorHandler_ {
    self = [super init];
    if (self) {
        gateway = gateway_;
        crypto = crypto_;
        memberId = memberId_;
        rpc = rpc_;
        errorHandler = errorHandler_;
        unauthenticatedClient = unauthenticatedClient_;
    }
    return self;
}

- (TKCrypto *)getCrypto {
    return crypto;
}
- (void)useAccessToken:(NSString *)accessTokenId {
    onBehalfOfMemberId = accessTokenId;
}

- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    [unauthenticatedClient getMember:memberId onSuccess:onSuccess onError:onError];
}

- (void)updateMember:(Member *)member
          operations:(NSArray<MemberOperation *> *)operations
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError{
    [self updateMember:member
            operations:operations
         metadataArray:[NSArray array]
             onSuccess:onSuccess
               onError:onError];
}

- (void)updateMember:(Member *)member
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    
    [unauthenticatedClient
     getMember:memberId
     onSuccess:^(Member *newMember) {
         UpdateMemberRequest *request = [UpdateMemberRequest message];
         request.update.memberId = self->memberId;
         request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
         //Update to the latest lastHash before update member
         request.update.prevHash = newMember.lastHash;
         request.metadataArray = [NSMutableArray arrayWithArray:metadataArray];
         
         TKSignature *signature = [self->crypto
                                   sign:request.update
                                   usingKey:Key_Level_Privileged
                                   reason:TKLocalizedString(@"Signature_Reason_UpdateMember",
                                                            @"Approve updating user account")
                                   onError:onError];
         if (!signature) {
             return;
         }
         
         request.updateSignature.memberId = self->memberId;
         request.updateSignature.keyId = signature.key.id_p;
         request.updateSignature.signature = signature.value;
         RpcLogStart(request);
         
         __block GRPCProtoCall *call = [self->gateway
                                        RPCToUpdateMemberWithRequest:request
                                        handler:^(UpdateMemberResponse *response, NSError *error) {
                                            if (response) {
                                                RpcLogCompletedWithMetaData(response, call);
                                                onSuccess(response.member);
                                            } else {
                                                [self->errorHandler handle:onError withError:error];
                                            }
                                        }
                                        ];
         
         [self _startCall:call
              withRequest:request
                  onError:onError];
     }
     onError:onError];
}

- (void)verifyAlias:(NSString *)verificationId
               code:(NSString *)code
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError {
    VerifyAliasRequest *request = [VerifyAliasRequest message];
    request.verificationId = verificationId;
    request.code = code;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToVerifyAliasWithRequest: request
                                   handler:^(VerifyAliasResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)deleteMember:(Member *)member
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    DeleteMemberRequest *request = [DeleteMemberRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToDeleteMemberWithRequest:request
                                   handler:^(DeleteMemberResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:Key_Level_Privileged
             onError:onError];
}

- (void)getAliases:(OnSuccessWithAliases)onSuccess
           onError:(OnError)onError {
    GetAliasesRequest *request = [GetAliasesRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetAliasesWithRequest:request
                                   handler:^(GetAliasesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.aliasesArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)resendAliasVerification:(NSString *)memberId
                          alias:(Alias *) alias
                      onSuccess:(OnSuccessWithString)onSuccess
                        onError:(OnError)onError {
    RetryVerificationRequest *request = [RetryVerificationRequest message];
    request.memberId = memberId;
    request.alias = alias;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToRetryVerificationWithRequest:request
                                   handler:^(RetryVerificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.verificationId);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)subscribeToNotifications:(NSString *)handler
             handlerInstructions:(NSMutableDictionary<NSString *,NSString *> *)handlerInstructions
                       onSuccess:(OnSuccessWithSubscriber)onSuccess
                         onError:(OnError)onError {
    SubscribeToNotificationsRequest *request = [SubscribeToNotificationsRequest message];
    request.handler = handler;
    request.handlerInstructions = handlerInstructions;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToSubscribeToNotificationsWithRequest:request
                                   handler:^(SubscribeToNotificationsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.subscriber);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getSubscribers:(OnSuccessWithSubscribers)onSuccess
               onError:(OnError)onError {
    GetSubscribersRequest *request = [GetSubscribersRequest message];
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetSubscribersWithRequest:request
                                   handler:^(GetSubscribersResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.subscribersArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)getSubscriber:(NSString *)subscriberId
            onSuccess:(OnSuccessWithSubscriber)onSuccess
              onError:(OnError)onError {
    GetSubscriberRequest *request = [GetSubscriberRequest message];
    request.subscriberId = subscriberId;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetSubscriberWithRequest:request
                                   handler:^(GetSubscriberResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.subscriber);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getNotifications:(NSString *)offset
                   limit:(int)limit
               onSuccess:(OnSuccessWithNotifications)onSuccess
                 onError:(OnError)onError {
    GetNotificationsRequest *request = [GetNotificationsRequest message];
    request.page.offset = offset;
    request.page.limit = limit;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetNotificationsWithRequest:request
                                   handler:^(GetNotificationsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           PagedArray<Notification *> *paged =
                                           [[PagedArray<Notification *> alloc]
                                            initWith: response.notificationsArray
                                            offset: response.offset];
                                           onSuccess(paged);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)getNotification:(NSString *)notificationId
              onSuccess:(OnSuccessWithNotification)onSuccess
                onError:(OnError)onError {
    GetNotificationRequest *request = [GetNotificationRequest message];
    request.notificationId = notificationId;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetNotificationWithRequest:request
                                   handler:^(GetNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.notification);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)updateNotificationStatus:(NSString *)notificationId
                          status:(Notification_Status)status
                       onSuccess:(OnSuccess)onSuccess
                         onError:(OnError)onError {
    UpdateNotificationStatusRequest *request = [UpdateNotificationStatusRequest message];
    request.notificationId = notificationId;
    request.status = status;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToUpdateNotificationStatusWithRequest:request
                                   handler:^(UpdateNotificationStatusResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)unsubscribeFromNotifications:(NSString *)subscriberId
                           onSuccess:(OnSuccess)onSuccess
                             onError:(OnError)onError {
    UnsubscribeFromNotificationsRequest *request = [UnsubscribeFromNotificationsRequest message];
    request.subscriberId = subscriberId;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToUnsubscribeFromNotificationsWithRequest:request
                                   handler:^(UnsubscribeFromNotificationsResponse *response,
                                             NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)linkAccounts:(BankAuthorization *)bankAuthorization
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {
    LinkAccountsRequest *request = [LinkAccountsRequest message];
    request.bankAuthorization = bankAuthorization;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToLinkAccountsWithRequest:request
                                   handler:^(LinkAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.accountsArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)linkAccounts:(NSString *)bankId
         accessToken:(NSString *)accessToken
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {
    LinkAccountsOauthRequest *request = [LinkAccountsOauthRequest message];
    request.authorization.bankId = bankId;
    request.authorization.accessToken = accessToken;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToLinkAccountsOauthWithRequest:request
                                   handler:^(LinkAccountsOauthResponse *response, NSError *error) {
                                       if (response) {
                                           if (response.status != AccountLinkingStatus_Success) {
                                               onError([NSError
                                                        errorFromAccountLinkingStatus:response.status
                                                        userInfo:@{@"BankId":bankId}]);
                                           }
                                           else {
                                               RpcLogCompletedWithMetaData(response, call);
                                               onSuccess(response.accountsArray);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds
             onSuccess:(OnSuccess)onSuccess
               onError:(OnError)onError {
    UnlinkAccountsRequest *request = [UnlinkAccountsRequest message];
    request.accountIdsArray = [NSMutableArray arrayWithArray: accountIds];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToUnlinkAccountsWithRequest:request
                                   handler:^(UnlinkAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getAccounts:(OnSuccessWithAccounts)onSuccess
            onError:(OnError)onError {
    GetAccountsRequest *request = [GetAccountsRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetAccountsWithRequest:request
                                   handler:^(GetAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.accountsArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithAccount)onSuccess
           onError:(OnError)onError {
    GetAccountRequest *request = [GetAccountRequest message];
    request.accountId = accountId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetAccountWithRequest:request
                                   handler:^(GetAccountResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.account);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getDefaultAccount:(NSString *)accountId
                onSuccess:(OnSuccessWithAccount)onSuccess
                  onError:(OnError)onError {
    GetDefaultAccountRequest *request = [GetDefaultAccountRequest message];
    request.memberId = memberId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetDefaultAccountWithRequest:request
                                   handler:^(GetDefaultAccountResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.account);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)setDefaultAccount:(NSString *)accountId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    SetDefaultAccountRequest *request = [SetDefaultAccountRequest message];
    request.memberId = memberId;
    request.accountId = accountId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSetDefaultAccountWithRequest:request
                                   handler:^(SetDefaultAccountResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)prepareToken:(TokenPayload *)payload
           onSuccess:(OnSuccessWithPrepareTokenResult)onSuccess
             onError:(OnError)onError {
    PrepareTokenRequest *request = [PrepareTokenRequest message];
    request.payload = payload;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToPrepareTokenWithRequest:request
                                   handler:^(PrepareTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess([PrepareTokenResult create:response.resolvedPayload
                                                                         policy:response.policy]);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)createToken:(TokenPayload *)payload
     tokenRequestId:(NSString *)tokenRequestId
         signatures:(NSArray<Signature *> *)signatures
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    CreateTokenRequest *request = [CreateTokenRequest message];
    request.payload = payload;
    if (tokenRequestId) {
        request.tokenRequestId = tokenRequestId;
    }
    if (signatures && signatures.count > 0) {
        request.signaturesArray = [NSMutableArray arrayWithArray:signatures];
    }
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateTokenWithRequest:request
                                   handler:^(CreateTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.token);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createTransferToken:(TokenPayload *)payload
             tokenRequestId:(NSString *)tokenRequestId
                  onSuccess:(OnSuccessWithToken)onSuccess
             onAuthRequired:(OnAuthRequired)onAuthRequired
                    onError:(OnError)onError {
    CreateTransferTokenRequest *request = [CreateTransferTokenRequest message];
    request.payload = payload;
    if (tokenRequestId && tokenRequestId.length > 0) {
        request.tokenRequestId = tokenRequestId;
    }
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateTransferTokenWithRequest:request
                                   handler:^(CreateTransferTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == TransferTokenStatus_Success) {
                                               onSuccess(response.token);
                                           } else if (response.status == TransferTokenStatus_FailureExternalAuthorizationRequired) {
                                               onAuthRequired(response.authorizationDetails);
                                           } else {
                                               onError([NSError
                                                        errorFromTransferTokenStatus:response.status]);
                                           }
                                       } else {
                                           RpcLogError(error);
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createAccessToken:(TokenPayload *)payload
           tokenRequestId:(NSString *)tokenRequestId
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError {
    CreateAccessTokenRequest *request = [CreateAccessTokenRequest message];
    request.payload = payload;
    if (tokenRequestId && tokenRequestId.length > 0) {
        request.tokenRequestId = tokenRequestId;
    }
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateAccessTokenWithRequest:request
                                   handler:^(CreateAccessTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.token);
                                       } else {
                                           RpcLogError(error);
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)replaceToken:(Token *)tokenToCancel
       tokenToCreate:(TokenPayload *)tokenToCreate
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    ReplaceTokenRequest *request = [self _createReplaceTokenRequest:tokenToCancel
                                                      tokenToCreate:tokenToCreate
                                                            onError:onError];
    if (!request) {
        return;
    }
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToReplaceTokenWithRequest: request
                                   handler:^(ReplaceTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.result);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getToken:(NSString *)tokenId
       onSuccess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError {
    GetTokenRequest *request = [GetTokenRequest message];
    request.tokenId = tokenId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTokenWithRequest:request
                                   handler:^(GetTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.token);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getActiveAccessToken:(NSString *)toMemberId
                   onSuccess:(OnSuccessWithToken)onSuccess
                     onError:(OnError)onError {
    GetActiveAccessTokenRequest *request = [GetActiveAccessTokenRequest message];
    request.toMemberId = toMemberId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetActiveAccessTokenWithRequest:request
                                   handler:^(GetActiveAccessTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.token);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getTokensOfType:(GetTokensRequest_Type)type
                 offset:(NSString *)offset
                  limit:(int)limit
              onSuccess:(OnSuccessWithTokens)onSuccess
                onError:(OnError)onError {
    GetTokensRequest *request = [GetTokensRequest message];
    request.type = type;
    request.page.offset = offset;
    request.page.limit = limit;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTokensWithRequest:request
                                   handler:^(GetTokensResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           PagedArray<Token *> *paged = [[PagedArray<Token *> alloc]
                                                                         initWith: response.tokensArray
                                                                         offset: response.offset];
                                           onSuccess(paged);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)endorseToken:(Token *)token
             withKey:(Key_Level)keyLevel
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    NSString *reason = (token.payload.access != nil && token.payload.access.resourcesArray_Count > 0)
    ? @"Signature_Reason_EndorseAccessToken"
    : @"Signature_Reason_EndorseTransferToken";
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:keyLevel
                                   reason:TKLocalizedString(reason, @"Approve endorsing token")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    EndorseTokenRequest *request = [EndorseTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.memberId = memberId;
    request.signature.keyId = signature.key.id_p;
    request.signature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToEndorseTokenWithRequest:request
                                   handler:^(EndorseTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.result);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)cancelToken:(Token *)token
          onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
            onError:(OnError)onError {
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Cancelled
                                 usingKey:Key_Level_Low
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_CancelToken",
                                                            @"Approve cancelling the token")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    CancelTokenRequest *request = [CancelTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.memberId = memberId;
    request.signature.keyId = signature.key.id_p;
    request.signature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCancelTokenWithRequest:request
                                   handler:^(CancelTokenResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.result);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)redeemToken:(TransferPayload *)payload
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError {
    TKSignature *signature = [crypto sign:payload
                                 usingKey:Key_Level_Low
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_redeemToken",
                                                            @"Approve creating a transfer")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    CreateTransferRequest *request = [CreateTransferRequest message];
    request.payload = payload;
    request.payloadSignature.memberId = memberId;
    request.payloadSignature.keyId = signature.key.id_p;
    request.payloadSignature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateTransferWithRequest:request
                                   handler:
                                   ^(CreateTransferResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.transfer.status == TransactionStatus_Pending ||
                                               response.transfer.status == TransactionStatus_Success ||
                                               response.transfer.status == TransactionStatus_Processing ) {
                                               onSuccess(response.transfer);
                                           } else {
                                               onError([NSError
                                                        errorFromTransactionStatus:response.transfer.status]);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createStandingOrder:(NSString *)tokenId
                  onSuccess:(OnSuccessWithStandingOrderSubmission)onSuccess
                    onError:(OnError)onError {
    CreateStandingOrderRequest *request = [CreateStandingOrderRequest message];
    request.tokenId = tokenId;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateStandingOrderWithRequest:request
                                   handler:^(CreateStandingOrderResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.submission);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getTransfer:(NSString *)transferId
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError {
    GetTransferRequest *request = [GetTransferRequest message];
    request.transferId = transferId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTransferWithRequest:request
                                   handler:
                                   ^(GetTransferResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.transfer);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                   tokenId:(NSString *)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError {
    GetTransfersRequest *request = [GetTransfersRequest message];
    request.page.offset = offset;
    request.page.limit = limit;
    request.filter.tokenId = tokenId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTransfersWithRequest:request
                                   handler:
                                   ^(GetTransfersResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           PagedArray<Transfer *> *paged = [[PagedArray<Transfer *> alloc]
                                                                            initWith: response.transfersArray
                                                                            offset: response.offset];
                                           onSuccess(paged);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getBalance:(NSString *)accountId
           withKey:(Key_Level)keyLevel
         onSuccess:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError {
    GetBalanceRequest *request = [GetBalanceRequest message];
    request.accountId = accountId;
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBalanceWithRequest:request
                                   handler:
                                   ^(GetBalanceResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == RequestStatus_SuccessfulRequest) {
                                               TKBalance *balance = [TKBalance alloc];
                                               balance.available = response.balance.available;
                                               balance.current = response.balance.current;
                                               onSuccess(balance);
                                           }
                                           else {
                                               onError([NSError
                                                        errorFromRequestStatus:response.status
                                                        userInfo:@{@"AccountId": response.balance.accountId}]);
                                           }
                                           
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getBalances:(NSArray<NSString *> *)accountIds
            withKey:(Key_Level)keyLevel
          onSuccess:(OnSuccessWithTKBalances)onSuccess
            onError:(OnError)onError {
    GetBalancesRequest *request = [GetBalancesRequest message];
    request.accountIdArray = [NSMutableArray arrayWithArray:accountIds];
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBalancesWithRequest:request
                                   handler:
                                   ^(GetBalancesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           NSMutableDictionary<NSString *,TKBalance *> *result = [NSMutableDictionary dictionary];
                                           
                                           for (GetBalanceResponse *balanceResponse in response.responseArray) {
                                               if (balanceResponse.status == RequestStatus_SuccessfulRequest) {
                                                   TKBalance *balance = [TKBalance alloc];
                                                   balance.available = balanceResponse.balance.available;
                                                   balance.current = balanceResponse.balance.current;
                                                   [result setValue:balance forKey:balanceResponse.balance.accountId];
                                               }
                                               else {
                                                   onError([NSError
                                                            errorFromRequestStatus:balanceResponse.status
                                                            userInfo:@{@"AccountId": balanceResponse.balance.accountId}]);
                                                   return;
                                               }
                                           }
                                           
                                           onSuccess(result);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
               withKey:(Key_Level)keyLevel
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    GetTransactionRequest *request = [GetTransactionRequest message];
    request.accountId = accountId;
    request.transactionId = transactionId;
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTransactionWithRequest:request
                                   handler:
                                   ^(GetTransactionResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == RequestStatus_SuccessfulRequest) {
                                               onSuccess(response.transaction);
                                           }
                                           else {
                                               onError([NSError
                                                        errorFromRequestStatus:response.status
                                                        userInfo:@{@"AccountId": accountId,
                                                                   @"TransactionId": transactionId}]);
                                           }
                                           
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
                      withKey:(Key_Level)keyLevel
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
    GetTransactionsRequest *request = [GetTransactionsRequest message];
    request.accountId = accountId;
    request.page.offset = offset;
    request.page.limit = limit;
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTransactionsWithRequest:request
                                   handler:
                                   ^(GetTransactionsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == RequestStatus_SuccessfulRequest) {
                                               PagedArray<Transaction *> *paged = [[PagedArray<Transaction *> alloc]
                                                                                   initWith: response.transactionsArray
                                                                                   offset: response.offset];
                                               onSuccess(paged);
                                           }
                                           else {
                                               onError([NSError
                                                        errorFromRequestStatus:response.status
                                                        userInfo:@{@"AccountId": accountId}]);
                                           }
                                           
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getStandingOrder:(NSString *)standingOrderId
              forAccount:(NSString *)accountId
                 withKey:(Key_Level)keyLevel
               onSuccess:(OnSuccessWithStandingOrder)onSuccess
                 onError:(OnError)onError {
    GetStandingOrderRequest *request = [GetStandingOrderRequest message];
    request.accountId = accountId;
    request.standingOrderId = standingOrderId;

    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetStandingOrderWithRequest:request
                                   handler:
                                   ^(GetStandingOrderResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == RequestStatus_SuccessfulRequest) {
                                               onSuccess(response.standingOrder);
                                           }
                                           else {
                                               onError([NSError
                                                        errorFromRequestStatus:response.status
                                                        userInfo:@{@"AccountId": accountId,
                                                                   @"StandingOrderId":standingOrderId}]);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getStandingOrdersOffset:(NSString *)offset
                          limit:(int)limit
                     forAccount:(NSString *)accountId
                        withKey:(Key_Level)keyLevel
                      onSuccess:(OnSuccessWithStandingOrders)onSuccess
                        onError:(OnError)onError {
    GetStandingOrdersRequest *request = [GetStandingOrdersRequest message];
    request.accountId = accountId;
    request.page.offset = offset;
    request.page.limit = limit;

    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetStandingOrdersWithRequest:request
                                   handler:
                                   ^(GetStandingOrdersResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status == RequestStatus_SuccessfulRequest) {
                                               PagedArray<StandingOrder *> *paged =
                                               [[PagedArray<StandingOrder *> alloc]
                                                initWith: response.standingOrdersArray
                                                offset: response.offset];
                                               onSuccess(paged);
                                           }
                                           else {
                                               onError([NSError
                                                        errorFromRequestStatus:response.status
                                                        userInfo:@{@"AccountId": accountId}]);
                                           }

                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
             onError:onError];
}

- (void)getStandingOrderSubmission:(NSString *)submissionId
                         onSuccess:(OnSuccessWithStandingOrderSubmission)onSuccess
                           onError:(OnError)onError {
    GetStandingOrderSubmissionRequest *request = [GetStandingOrderSubmissionRequest message];
    request.submissionId = submissionId;

    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetStandingOrderSubmissionWithRequest:request
                                   handler:
                                   ^(GetStandingOrderSubmissionResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.submission);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getStandingOrderSubmissionsOffset:(NSString *)offset
                                    limit:(int)limit
                                onSuccess:(OnSuccessWithStandingOrderSubmissions)onSuccess
                                  onError:(OnError)onError {
    GetStandingOrderSubmissionsRequest *request = [GetStandingOrderSubmissionsRequest message];
    request.page.offset = offset;
    request.page.limit = limit;

    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToGetStandingOrderSubmissionsWithRequest:request
                                   handler:
                                   ^(GetStandingOrderSubmissionsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           PagedArray<StandingOrderSubmission *> *paged =
                                           [[PagedArray<StandingOrderSubmission *> alloc]
                                            initWith: response.submissionsArray
                                            offset: response.offset];
                                           onSuccess(paged);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createBlob:(NSString *)ownerId
          withType:(NSString *)type
          withName:(NSString *)name
          withData:(NSData *)data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError {
    CreateBlobRequest *request = [CreateBlobRequest message];
    //Blob_Payload * payload = [Blob_Payload message];
    request.payload.ownerId = ownerId;
    request.payload.type = type;
    request.payload.name = name;
    request.payload.data_p = data;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateBlobWithRequest:request
                                   handler:
                                   ^(CreateBlobResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           Attachment *attachment = [Attachment message];
                                           attachment.blobId = response.blobId;
                                           attachment.name = name;
                                           attachment.type = type;
                                           onSuccess(attachment);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getBlob:(NSString *)blobId
      onSuccess:(OnSuccessWithBlob)onSuccess
        onError:(OnError)onError {
    GetBlobRequest *request = [GetBlobRequest message];
    request.blobId = blobId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBlobWithRequest:request
                                   handler:
                                   ^(GetBlobResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.blob);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getTokenBlob:(NSString *)tokenId
          withBlobId:(NSString *)blobId
           onSuccess:(OnSuccessWithBlob)onSuccess
             onError:(OnError)onError {
    GetTokenBlobRequest *request = [GetTokenBlobRequest message];
    request.tokenId = tokenId;
    request.blobId = blobId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTokenBlobWithRequest:request
                                   handler:
                                   ^(GetTokenBlobResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.blob);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)addAddress:(Address *)address
          withName:(NSString *)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError {
    TKSignature *signature = [crypto sign:address
                                 usingKey:Key_Level_Low
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_AddAddress",
                                                            @"Approve adding an address")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    AddAddressRequest *request = [AddAddressRequest message];
    request.name = name;
    request.address = address;
    request.addressSignature.memberId = memberId;
    request.addressSignature.keyId = signature.key.id_p;
    request.addressSignature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToAddAddressWithRequest:request
                                   handler:
                                   ^(AddAddressResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.address);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getAddressById:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError {
    GetAddressRequest *request = [GetAddressRequest message];
    request.addressId = addressId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetAddressWithRequest:request
                                   handler:
                                   ^(GetAddressResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.address);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError {
    GetAddressesRequest *request = [GetAddressesRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetAddressesWithRequest:request
                                   handler:
                                   ^(GetAddressesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.addressesArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)deleteAddressById:(NSString *)addressId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    DeleteAddressRequest *request = [DeleteAddressRequest message];
    request.addressId = addressId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToDeleteAddressWithRequest:request
                                   handler:
                                   ^(DeleteAddressResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)confirmFunds:(NSString *)accountId
              amount:(Money *)amount
           onSuccess:(OnSuccessWithBoolean)onSuccess
             onError:(OnError)onError {
    ConfirmFundsRequest *request = [ConfirmFundsRequest message];
    request.accountId = accountId;
    request.amount = amount;
    RpcLogStart(request);

    __block GRPCProtoCall *call = [gateway
                                   RPCToConfirmFundsWithRequest:request
                                   handler:
                                   ^(ConfirmFundsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.fundsAvailable);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getBankInfo:(NSString *) bankId
          onSuccess:(OnSuccessWithBankInfo)onSuccess
            onError:(OnError)onError {
    GetBankInfoRequest *request = [GetBankInfoRequest message];
    request.bankId = bankId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBankInfoWithRequest:request
                                   handler:
                                   ^(GetBankInfoResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.info);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createTestBankAccount:(Money *)balance
                    onSuccess:(OnSuccessWithOauthBankAuthorization)onSuccess
                      onError:(OnError)onError {
    CreateTestBankAccountRequest *request = [CreateTestBankAccountRequest message];
    request.balance = balance;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateTestBankAccountWithRequest:request
                                   handler:
                                   ^(CreateTestBankAccountResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.authorization);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getProfile:(NSString *)ownerId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError {
    GetProfileRequest *request = [GetProfileRequest message];
    request.memberId = ownerId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetProfileWithRequest:request
                                   handler:
                                   ^(GetProfileResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.profile);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)setProfile:(Profile *)profile
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError {
    SetProfileRequest *request = [SetProfileRequest message];
    request.profile = profile;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSetProfileWithRequest:request
                                   handler:
                                   ^(SetProfileResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.profile);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getProfilePicture:(NSString *)ownerId
                     size:(ProfilePictureSize)size
                onSuccess:(OnSuccessWithBlob)onSuccess
                  onError:(OnError)onError {
    GetProfilePictureRequest *request = [GetProfilePictureRequest message];
    request.memberId = ownerId;
    request.size = size;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetProfilePictureWithRequest:request
                                   handler:
                                   ^(GetProfilePictureResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.blob);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)setProfilePicture:(NSString *)ownerId
                 withType:(NSString *)type
                 withName:(NSString *)name
                 withData:(NSData *)data
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    SetProfilePictureRequest *request = [SetProfilePictureRequest message];
    request.payload.ownerId = ownerId;
    request.payload.type = type;
    request.payload.name = name;
    request.payload.data_p = data;
    request.payload.accessMode = Blob_AccessMode_Public;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSetProfilePictureWithRequest:request
                                   handler:
                                   ^(SetProfilePictureResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getPairedDevices:(OnSuccessWithPairedDevices)onSuccess
                 onError:(OnError)onError {
    GetPairedDevicesRequest *request = [GetPairedDevicesRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetPairedDevicesWithRequest:request
                                   handler:^(GetPairedDevicesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.devicesArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)triggerStepUpNotification:(NSString *)tokenId
                        onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                          onError:(OnError)onError {
    TriggerStepUpNotificationRequest *request = [TriggerStepUpNotificationRequest message];
    request.tokenStepUp.tokenId = tokenId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToTriggerStepUpNotificationWithRequest:request
                                   handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.status);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)triggerBalanceStepUpNotification:(NSArray<NSString *> *)accountIds
                               onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                 onError:(OnError)onError {
    TriggerStepUpNotificationRequest *request = [TriggerStepUpNotificationRequest message];
    request.balanceStepUp.accountIdArray = [NSMutableArray arrayWithArray:accountIds];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToTriggerStepUpNotificationWithRequest:request
                                   handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.status);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}


- (void)triggerTransactionStepUpNotification:(NSString *)transactionId
                                   accountID:(NSString *)accountId
                                   onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                     onError:(OnError)onError {
    TriggerStepUpNotificationRequest *request = [TriggerStepUpNotificationRequest message];
    request.transactionStepUp.accountId = accountId;
    request.transactionStepUp.transactionId = transactionId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToTriggerStepUpNotificationWithRequest:request
                                   handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.status);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)ApplySca:(NSArray<NSString *> *)accountIds
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError {
    ApplyScaRequest *request = [ApplyScaRequest message];
    request.accountIdArray = [NSMutableArray arrayWithArray:accountIds];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToApplyScaWithRequest:request
                                   handler:^(ApplyScaResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
            usingKey:Key_Level_Standard
             onError:onError];
}

- (void)signTokenRequestState:(NSString *)tokenRequestId
                      tokenId:(NSString *)tokenId
                        state:(NSString *)state
                    onSuccess:(OnSuccessWithSignature)onSuccess
                      onError:(OnError)onError {
    SignTokenRequestStateRequest *request = [SignTokenRequestStateRequest message];
    request.tokenRequestId = tokenRequestId;
    request.payload.tokenId = tokenId;
    request.payload.state = state;\
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSignTokenRequestStateWithRequest:request
                                   handler:^(SignTokenRequestStateResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.signature);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)storeTokenRequest:(TokenRequestPayload *)requestPayload
           requestOptions:(TokenRequestOptions *)requestOptions
                onSuccess:(OnSuccessWithString)onSuccess
                  onError:(OnError)onError {
    StoreTokenRequestRequest *request = [StoreTokenRequestRequest message];
    request.requestPayload = requestPayload;
    request.requestOptions = requestOptions;
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToStoreTokenRequestWithRequest:request
                                   handler:^(StoreTokenRequestResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.tokenRequest.id_p);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)updateTokenRequest:(NSString *)requestId
                   options:(TokenRequestOptions *)options
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    UpdateTokenRequestRequest *request = [UpdateTokenRequestRequest message];
    request.requestId = requestId;
    request.requestOptions = options;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToUpdateTokenRequestWithRequest:request
                                   handler:^(UpdateTokenRequestResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)setReceiptContact:(ReceiptContact *)receiptContact
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    SetReceiptContactRequest *request = [SetReceiptContactRequest message];
    request.contact = receiptContact;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSetReceiptContactWithRequest:request
                                   handler:^(SetReceiptContactResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getReceiptContact:(OnSuccessWithReceiptContact)onSuccess
                  onError:(OnError)onError {
    GetReceiptContactRequest *request = [GetReceiptContactRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetReceiptContactWithRequest:request
                                   handler:^(GetReceiptContactResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.contact);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)addTrustedBeneficiary:(TrustedBeneficiary_Payload *)payload
                    onSuccess:(OnSuccess)onSuccess
                      onError:(OnError)onError {
    TKSignature *signature = [crypto sign:payload
                                 usingKey:Key_Level_Standard
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_AddTrustedBeneficiary",
                                                            @"Approve adding an address")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    AddTrustedBeneficiaryRequest *request = [AddTrustedBeneficiaryRequest message];
    request.trustedBeneficiary.payload = payload;
    request.trustedBeneficiary.signature.memberId = memberId;
    request.trustedBeneficiary.signature.keyId = signature.key.id_p;
    request.trustedBeneficiary.signature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToAddTrustedBeneficiaryWithRequest:request
                                   handler:^(AddTrustedBeneficiaryResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)removeTrustedBeneficiary:(TrustedBeneficiary_Payload *)payload
                       onSuccess:(OnSuccess)onSuccess
                         onError:(OnError)onError {
    TKSignature *signature = [crypto sign:payload
                                 usingKey:Key_Level_Standard
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_RemoveTrustedBeneficiary",
                                                            @"Approve adding an address")
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    RemoveTrustedBeneficiaryRequest *request = [RemoveTrustedBeneficiaryRequest message];
    request.trustedBeneficiary.payload = payload;
    request.trustedBeneficiary.signature.memberId = memberId;
    request.trustedBeneficiary.signature.keyId = signature.key.id_p;
    request.trustedBeneficiary.signature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToRemoveTrustedBeneficiaryWithRequest:request
                                   handler:^(RemoveTrustedBeneficiaryResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getTrustedBeneficiaries:(OnSuccessWithTrustedBeneficiaries)onSuccess
                        onError:(OnError)onError {
    GetTrustedBeneficiariesRequest *request = [GetTrustedBeneficiariesRequest message];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTrustedBeneficiariesWithRequest:request
                                   handler:^(GetTrustedBeneficiariesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.trustedBeneficiariesArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

-(void)setAppCallbackUrl:(NSString *)appCallbackUrl onSuccess:(OnSuccess)onSuccess onError:(OnError)onError {
    SetAppCallbackUrlRequest *request = [SetAppCallbackUrlRequest message];
    request.appCallbackURL = appCallbackUrl;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToSetAppCallbackUrlWithRequest:request
                                   handler:^(SetAppCallbackUrlResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

-(void)resolveTransferDestinations:(NSString *)accountId
                         onSuccess:(OnSuccessWithTransferEndpoints)onSuccess
                           onError:(OnError)onError {
    ResolveTransferDestinationsRequest *request = [ResolveTransferDestinationsRequest message];
    request.accountId = accountId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToResolveTransferDestinationsWithRequest:request
                                   handler:^(ResolveTransferDestinationsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.destinationsArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

-(void)setSecurityMetadata:(SecurityMetadata *)metadata {
    securityMetadata = metadata;
}

#pragma mark private

- (ReplaceTokenRequest *)_createReplaceTokenRequest:(Token *)tokenToCancel
                                      tokenToCreate:(TokenPayload *)tokenToCreate
                                            onError:(OnError)onError {
    TKSignature *signature = [crypto sign:tokenToCancel
                                   action:TokenSignature_Action_Cancelled
                                 usingKey:Key_Level_Low
                                   reason:TKLocalizedString(
                                                            @"Signature_Reason_CancelToken",
                                                            @"Approve cancelling the token")
                                  onError:onError];
    if (!signature) {
        return nil;
    }
    
    ReplaceTokenRequest *request = [ReplaceTokenRequest message];
    request.cancelToken.tokenId = tokenToCancel.id_p;
    request.cancelToken.signature.memberId = memberId;
    request.cancelToken.signature.keyId = signature.key.id_p;
    request.cancelToken.signature.signature = signature.value;
    request.createToken.payload = tokenToCreate;
    return request;
}

- (void)_startCall:(GRPCProtoCall *)call
       withRequest:(GPBMessage *)request
           onError:(OnError)onError {
    [self _startCall:call
         withRequest:request
            usingKey:Key_Level_Low
             onError:onError];
}

- (void)_startCall:(GRPCProtoCall *)call
       withRequest:(GPBMessage *)request
          usingKey:(Key_Level)keyLevel
           onError:(OnError)onError {
    [rpc execute:call
         request:request
        memberId:memberId
          crypto:crypto
        usingKey:keyLevel
      onBehalfOf:onBehalfOfMemberId
securityMetadata:securityMetadata
         onError:onError];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[TKClient alloc] initWithRpc:rpc
                                 gateway:gateway
                                  Crypto:crypto
                                memberId:memberId
                                  client:unauthenticatedClient
                            errorHandler:errorHandler];
}

- (Signature *)signTokenPayload:(TokenPayload *)tokenPayload
                       keyLevel:(Key_Level)keyLevel
                        onError:(OnError)onError {
    NSString *reason = (tokenPayload.bodyOneOfCase == TokenPayload_Body_OneOfCase_Access)
    ? @"Signature_Reason_EndorseAccessToken"
    : @"Signature_Reason_EndorseTransferToken";
    TKSignature *signature = [crypto
                              signPayload:tokenPayload
                              action:TokenSignature_Action_Endorsed
                              usingKey:keyLevel
                              reason:TKLocalizedString(reason, @"Approve endorsing token")
                              onError:onError];
    if (signature) {
        Signature *result = [Signature message];
        result.memberId = memberId;
        result.keyId = signature.key.id_p;
        result.signature = signature.value;
        return result;
    }
    return nil;
}
@end
