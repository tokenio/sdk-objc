//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "Member.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"

#import "TKClient.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKRpcErrorHandler.h"
#import "TKError.h"

@implementation TKClient {
    GatewayService *gateway;
    TKCrypto *crypto;
    TKRpc *rpc;
    NSString *memberId;
    NSString *onBehalfOfMemberId;
    TKRpcErrorHandler *errorHandler;
}

- (id)initWithGateway:(GatewayService *)gateway_
               crypto:(TKCrypto *)crypto_
            timeoutMs:(int)timeoutMs_
             memberId:(NSString *)memberId_
         errorHandler:(TKRpcErrorHandler *)errorHandler_ {
    self = [super init];
    
    if (self) {
        gateway = gateway_;
        crypto = crypto_;
        memberId = memberId_;
        rpc = [[TKRpc alloc] initWithTimeoutMs:timeoutMs_];
        errorHandler = errorHandler_;
    }
    
    return self;
}

- (void)useAccessToken:(NSString *)accessTokenId {
    onBehalfOfMemberId = accessTokenId;
}

- (void)clearAccessToken {
    onBehalfOfMemberId = nil;
}

- (void)getMember:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    GetMemberRequest *request = [GetMemberRequest message];
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
    
    [self _startCall:call withRequest:request];
}

- (void)updateMember:(Member *)member
          operations:(NSArray<MemberOperation *> *)operations
            onSuccess:(OnSuccessWithMember)onSuccess
              onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
    request.update.prevHash = member.lastHash;

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

    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
}

- (void)createTransferToken:(TokenPayload *)payload
          onSuccess:(OnSuccessWithToken)onSuccess
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
                                   } else {
                                       onError([NSError
                                                errorFromTransferTokenStatus:response.status]);
                                   }
                               } else {
                                   RpcLogError(error);
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call withRequest:request];
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

    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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

    NSString *reason = (tokenToCancel.payload.access != nil)
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
}

- (void)endorseToken:(Token *)token
             withKey:(Key_Level)keyLevel
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    NSString *reason = (token.payload.access != nil)
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
}

- (void)createTransfer:(TransferPayload *)payload
             onSuccess:(OnSuccessWithTransfer)onSuccess
               onError:(OnError)onError {
    TKSignature *signature = [crypto sign:payload
                                 usingKey:Key_Level_Low
                                   reason:TKLocalizedString(
                                           @"Signature_Reason_CreateTransfer",
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
                                   onSuccess(response.transfer);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
}

- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                   tokenId:(NSString *)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError {
    GetTransfersRequest *request = [GetTransfersRequest message];
    request.page.offset = offset;
    request.page.limit = limit;
    request.tokenId = tokenId;
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
    
    [self _startCall:call withRequest:request];
}

- (void)getBalance:(NSString *)accountId
         onSuccess:(OnSuccessWithMoney)onSuccess
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
                                   onSuccess(response.current);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
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
                                   onSuccess(response.transaction);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
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
                                   PagedArray<Transaction *> *paged = [[PagedArray<Transaction *> alloc]
                                                                 initWith: response.transactionsArray
                                                                   offset: response.offset];
                                   onSuccess(paged);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)createBlob:(NSString *)ownerId
          withType:(NSString *)type
          withName:(NSString *)name
          withData:(NSData *)data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError {
    CreateBlobRequest *request = [CreateBlobRequest message];
    Blob_Payload * payload = [Blob_Payload message];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
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
    
    [self _startCall:call withRequest:request];
}

- (void)getBanks:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    GetBanksRequest *request = [GetBanksRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetBanksWithRequest:request
                           handler:
                           ^(GetBanksResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.banksArray);
                               } else {
                                   [errorHandler handle:onError withError:error];
                               }
                           }];

    [self _startCall:call withRequest:request];
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

    [self _startCall:call withRequest:request];
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

- (void)_startCall:(GRPCProtoCall *)call withRequest:(GPBMessage *)request {
    [rpc execute:call
         request:request
        memberId:memberId
          crypto:crypto
      onBehalfOf:onBehalfOfMemberId];
}

@end
