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

@implementation TKClient {
    GatewayService *gateway;
    TKCrypto *crypto;
    TKRpc *rpc;
    NSString *memberId;
    NSString *onBehalfOfMemberId;
    TKRpcErrorHandler *errorHandler;
    TKUnauthenticatedClient *unauthenticatedClient;
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

- (TKCrypto *)getCrypto {
    return crypto;
}
- (void)useAccessToken:(NSString *)accessTokenId {
    onBehalfOfMemberId = accessTokenId;
}

- (void)clearAccessToken {
    onBehalfOfMemberId = nil;
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
    
    [unauthenticatedClient getMember:memberId
                           onSuccess:^(Member *newMember) {
                               UpdateMemberRequest *request = [UpdateMemberRequest message];
                               request.update.memberId = memberId;
                               request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
                               //Update to the latest lastHash before update member
                               request.update.prevHash = newMember.lastHash;
                               request.metadataArray = [NSMutableArray arrayWithArray:metadataArray];
                               
                               TKSignature *signature = [crypto sign:request.update
                                                            usingKey:Key_Level_Privileged
                                                              reason:TKLocalizedString(
                                                                                       @"Signature_Reason_UpdateMember",
                                                                                       @"Approve updating user account")
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
                                                      }
                                                      ];
                               
                               [self _startCall:call
                                    withRequest:request
                                        onError:onError];
                           }
                             onError:onError];
    
    
}

- (void)deleteMember:(Member *)member
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    DeleteMemberRequest *request = [DeleteMemberRequest message];
    
    GRPCProtoCall *call = [gateway
                           RPCToDeleteMemberWithRequest:request
                           handler:^(DeleteMemberResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetAliasesWithRequest:request
                           handler:^(GetAliasesResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.aliasesArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToRetryVerificationWithRequest:request
                           handler:^(RetryVerificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.verificationId);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    GRPCProtoCall *call = [gateway
                           RPCToSubscribeToNotificationsWithRequest:request
                           handler:^(SubscribeToNotificationsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.subscriber);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)getSubscribers:(OnSuccessWithSubscribers)onSuccess
               onError:(OnError)onError {
    GetSubscribersRequest *request = [GetSubscribersRequest message];
    GRPCProtoCall *call = [gateway
                           RPCToGetSubscribersWithRequest:request
                           handler:^(GetSubscribersResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.subscribersArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    GRPCProtoCall *call = [gateway
                           RPCToGetSubscriberWithRequest:request
                           handler:^(GetSubscriberResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.subscriber);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    GRPCProtoCall *call = [gateway
                           RPCToGetNotificationsWithRequest:request
                           handler:^(GetNotificationsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   PagedArray<Notification *> *paged = [[PagedArray<Notification *> alloc]
                                                                 initWith: response.notificationsArray
                                                                 offset: response.offset];
                                   onSuccess(paged);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    GRPCProtoCall *call = [gateway
                           RPCToGetNotificationWithRequest:request
                           handler:^(GetNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.notification);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    GRPCProtoCall *call = [gateway
                           RPCToUnsubscribeFromNotificationsWithRequest:request
                           handler:^(UnsubscribeFromNotificationsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToLinkAccountsWithRequest:request
                           handler:^(LinkAccountsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.accountsArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToLinkAccountsOauthWithRequest:request
                           handler:^(LinkAccountsOauthResponse *response, NSError *error) {
                               if (response) {
                                   if (response.status != AccountLinkingStatus_Success) {
                                       onError([NSError
                                                errorFromAccountLinkingStatus:response.status
                                                userInfo:@{@"BankId":bankId}]);
                                   }
                                   else {
                                       RpcLogCompleted(response);
                                       onSuccess(response.accountsArray);
                                   }
                               } else {
                                   [errorHandler handle:onError withError:error];
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

    GRPCProtoCall *call = [gateway
                           RPCToUnlinkAccountsWithRequest:request
                           handler:^(UnlinkAccountsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetAccountsWithRequest:request
                           handler:^(GetAccountsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.accountsArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetAccountWithRequest:request
                           handler:^(GetAccountResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.account);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetDefaultAccountWithRequest:request
                           handler:^(GetDefaultAccountResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.account);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToSetDefaultAccountWithRequest:request
                           handler:^(SetDefaultAccountResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else { 
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createTransferToken:(TokenPayload *)payload
                  onSuccess:(OnSuccessWithToken)onSuccess
             onAuthRequired:(OnAuthRequired)onAuthRequired
                    onError:(OnError)onError {
    CreateTransferTokenRequest *request = [CreateTransferTokenRequest message];
    request.payload = payload;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateTransferTokenWithRequest:request
                           handler:^(CreateTransferTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
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
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createAccessToken:(TokenPayload *)payload
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    CreateAccessTokenRequest *request = [CreateAccessTokenRequest message];
    request.payload = payload;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToCreateAccessTokenWithRequest:request
                                handler:^(CreateAccessTokenResponse *response, NSError *error) {
                                    if (response) {
                                        RpcLogCompleted(response);
                                        onSuccess(response.token);
                                    } else {
                                        RpcLogError(error);
                                        [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToReplaceTokenWithRequest: request
                           handler:^(ReplaceTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)replaceAndEndorseToken:(Token *)tokenToCancel
                 tokenToCreate:(TokenPayload *)tokenToCreate
                     onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                       onError:(OnError)onError {
    ReplaceTokenRequest *request = [self _createReplaceTokenRequest:tokenToCancel
                                                      tokenToCreate:tokenToCreate
                                                            onError:onError];
    if (!request) {
        return;
    }

    NSString *reason = (tokenToCancel.payload.access != nil && tokenToCancel.payload.access.resourcesArray_Count > 0)
            ? @"Signature_Reason_EndorseAccessToken"
            : @"Signature_Reason_EndorseTransferToken";
    TKSignature *signature = [crypto signPayload:tokenToCreate
                                          action:TokenSignature_Action_Endorsed
                                        usingKey:Key_Level_Standard
                                          reason:TKLocalizedString(
                                                  reason,
                                                  @"Approve endorsing token")
                                         onError:onError];
    if (!signature) {
        return;
    }

    request.createToken.payloadSignature.memberId = memberId;
    request.createToken.payloadSignature.keyId = signature.key.id_p;
    request.createToken.payloadSignature.signature = signature.value;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToReplaceTokenWithRequest: request
                           handler:^(ReplaceTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTokenWithRequest:request
                           handler:^(GetTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.token);
                               } else {
                                   [errorHandler handle:onError withError:error];
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

    GRPCProtoCall *call = [gateway
                           RPCToGetActiveAccessTokenWithRequest:request
                           handler:^(GetActiveAccessTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.token);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTokensWithRequest:request
                           handler:^(GetTokensResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   PagedArray<Token *> *paged = [[PagedArray<Token *> alloc]
                                                                 initWith: response.tokensArray
                                                                   offset: response.offset];
                                   onSuccess(paged);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToEndorseTokenWithRequest:request
                           handler:^(EndorseTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToCancelTokenWithRequest:request
                           handler:^(CancelTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateTransferWithRequest:request
                           handler:
                           ^(CreateTransferResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   if (response.transfer.status == TransactionStatus_Pending ||
                                       response.transfer.status == TransactionStatus_Success ||
                                       response.transfer.status == TransactionStatus_Processing ) {
                                       onSuccess(response.transfer);
                                   } else {
                                       onError([NSError
                                                errorFromTransactionStatus:response.transfer.status]);
                                   }
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTransferWithRequest:request
                           handler:
                           ^(GetTransferResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.transfer);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTransfersWithRequest:request
                           handler:
                           ^(GetTransfersResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   PagedArray<Transfer *> *paged = [[PagedArray<Transfer *> alloc]
                                                                 initWith: response.transfersArray
                                                                   offset: response.offset];
                                   onSuccess(paged);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetBalanceWithRequest:request
                           handler:
                           ^(GetBalanceResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
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
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetBalancesWithRequest:request
                           handler:
                           ^(GetBalancesResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
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
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTransactionWithRequest:request
                           handler:
                           ^(GetTransactionResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   if (response.status == RequestStatus_SuccessfulRequest) {
                                       onSuccess(response.transaction);
                                   }
                                   else {
                                       onError([NSError
                                                errorFromRequestStatus:response.status
                                                userInfo:@{@"AccountId": accountId,
                                                           @"TransactionId": response.transaction.id_p}]);
                                   }
                                   
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTransactionsWithRequest:request
                           handler:
                           ^(GetTransactionsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
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
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
            usingKey:keyLevel
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
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateBlobWithRequest:request
                           handler:
                           ^(CreateBlobResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   Attachment *attachment = [Attachment message];
                                   attachment.blobId = response.blobId;
                                   attachment.name = name;
                                   attachment.type = type;
                                   onSuccess(attachment);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetBlobWithRequest:request
                           handler:
                           ^(GetBlobResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.blob);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetTokenBlobWithRequest:request
                           handler:
                           ^(GetTokenBlobResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.blob);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToAddAddressWithRequest:request
                           handler:
                           ^(AddAddressResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.address);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetAddressWithRequest:request
                           handler:
                           ^(GetAddressResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.address);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetAddressesWithRequest:request
                           handler:
                           ^(GetAddressesResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.addressesArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToDeleteAddressWithRequest:request
                           handler:
                           ^(DeleteAddressResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
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

    GRPCProtoCall *call = [gateway
                           RPCToGetBankInfoWithRequest:request
                           handler:
                           ^(GetBankInfoResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.info);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];

    [self _startCall:call
         withRequest:request
             onError:onError];
}

- (void)createTestBankAccount:(Money *)balance
                    onSuccess:(OnSuccessWithBankAuthorization)onSuccess
                      onError:(OnError)onError {
    CreateTestBankAccountRequest *request = [CreateTestBankAccountRequest message];
    request.balance = balance;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateTestBankAccountWithRequest:request
                           handler:
                           ^(CreateTestBankAccountResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.bankAuthorization);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetProfileWithRequest:request
                           handler:
                           ^(GetProfileResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.profile);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToSetProfileWithRequest:request
                           handler:
                           ^(SetProfileResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.profile);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToGetProfilePictureWithRequest:request
                           handler:
                           ^(GetProfilePictureResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.blob);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToSetProfilePictureWithRequest:request
                           handler:
                           ^(SetProfilePictureResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
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

    GRPCProtoCall *call = [gateway
                           RPCToGetPairedDevicesWithRequest:request
                           handler:^(GetPairedDevicesResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.devicesArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToTriggerStepUpNotificationWithRequest:request
                           handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.status);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToTriggerStepUpNotificationWithRequest:request
                           handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.status);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToTriggerStepUpNotificationWithRequest:request
                           handler:^(TriggerStepUpNotificationResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.status);
                               } else {
                                   [errorHandler handle:onError withError:error];
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
    
    GRPCProtoCall *call = [gateway
                           RPCToApplyScaWithRequest:request
                           handler:^(ApplyScaResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess();
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call
         withRequest:request
            usingKey:Key_Level_Standard
             onError:onError];
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
         onError:onError];
}

@end
