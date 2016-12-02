//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "Member.pbobjc.h"
#import "gateway/Auth.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"

#import "TKClient.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"
#import "PagedArray.h"


NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKClient {
    GatewayService *gateway;
    NSString *memberId;
    NSString *onBehalfOfMemberId;
    TKSecretKey *key;
}

- (id)initWithGateway:(GatewayService *)gateway_
             memberId:(NSString *)memberId_
            secretKey:(TKSecretKey *)key_ {
    self = [super init];
    
    if (self) {
        gateway = gateway_;
        memberId = memberId_;
        key = key_;
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }
                           ];
    
    [self _startCall:call withRequest:request];
}

- (void)addUsername:(NSString *)username
              to:(Member *)member
       onSuccess:(OnSuccessWithMember)onSuccess
         onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addUsername.username = username;
    
    [self _updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)removeUsername:(NSString *)username
               from:(Member *)member
          onSuccess:(OnSuccessWithMember)onSuccess
            onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.removeUsername.username = username;
    
    [self _updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)addKey:(NSString *)newPublicKey
            to:(Member *)member
         level:(NSUInteger)level
     onSuccess:(OnSuccessWithMember)onSuccess
       onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addKey.level = (int) level;
    update.addKey.publicKey = newPublicKey;
    
    [self _updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)removeKey:(NSString *)keyId
             from:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.removeKey.keyId = keyId;
    
    [self _updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)subscribeToNotifications:(NSString *)target
                        platform:(Platform)platform
                       onSuccess:(OnSuccessWithSubscriber)onSuccess
                         onError:(OnError)onError {
    SubscribeToNotificationsRequest *request = [SubscribeToNotificationsRequest message];
    request.target = target;
    request.platform = platform;
    GRPCProtoCall *call = [gateway
                           RPCToSubscribeToNotificationsWithRequest:request
                           handler:^(SubscribeToNotificationsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.subscriber);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}


- (void)linkAccounts:(NSString *)bankId
        withPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {
    LinkAccountsRequest *request = [LinkAccountsRequest message];
    request.bankId = bankId;
    request.accountLinkPayloadsArray = [NSMutableArray arrayWithArray: accountLinkPayloads];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToLinkAccountsWithRequest:request
                           handler:^(LinkAccountsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.accountsArray);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)createToken:(TokenPayload *)payload
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    CreateTokenRequest *request = [CreateTokenRequest message];
    request.payload = payload;
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateTokenWithRequest:request
                           handler:^(CreateTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.token);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)replaceToken:(Token *)tokenToCancel
       tokenToCreate:(TokenPayload *)tokenToCreate
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    ReplaceTokenRequest *request = [self createReplaceTokenRequest:tokenToCancel tokenToCreate:tokenToCreate];
    
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToReplaceTokenWithRequest: request
                           handler:^(ReplaceTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];

    
}

- (void)replaceAndEndorseToken:(Token *)tokenToCancel
                 tokenToCreate:(TokenPayload *)tokenToCreate
                     onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                       onError:(OnError)onError {
    ReplaceTokenRequest *request = [self createReplaceTokenRequest:tokenToCancel tokenToCreate:tokenToCreate];
    request.createToken.payloadSignature.memberId = memberId;
    request.createToken.payloadSignature.keyId = key.id;
    request.createToken.payloadSignature.signature = [TKCrypto signPayload:tokenToCreate
                                                                    action:TokenSignature_Action_Endorsed
                                                                  usingKey:key];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToReplaceTokenWithRequest: request
                           handler:^(ReplaceTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }
                           ];
    
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    EndorseTokenRequest *request = [EndorseTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.memberId = memberId;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Endorsed
                                        usingKey:key];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToEndorseTokenWithRequest:request
                           handler:^(EndorseTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)cancelToken:(Token *)token
          onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
            onError:(OnError)onError {
    CancelTokenRequest *request = [CancelTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.memberId = memberId;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Cancelled
                                        usingKey:key];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCancelTokenWithRequest:request
                           handler:^(CancelTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.result);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)createTransfer:(TransferPayload *)payload
             onSuccess:(OnSuccessWithTransfer)onSuccess
               onError:(OnError)onError {
    CreateTransferRequest *request = [CreateTransferRequest message];
    request.payload = payload;
    request.payloadSignature.memberId = memberId;
    request.payloadSignature.keyId = key.id;
    request.payloadSignature.signature = [TKCrypto sign:payload usingKey:key];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToCreateTransferWithRequest:request
                           handler:
                           ^(CreateTransferResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.transfer);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)addAddress:(Address *)address
          withName:(NSString *)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError {
    AddAddressRequest *request = [AddAddressRequest message];
    request.name = name;
    request.address = address;
    request.addressSignature.memberId = memberId;
    request.addressSignature.keyId = key.id;
    request.addressSignature.signature = [TKCrypto sign:address usingKey:key];
    RpcLogStart(request);
    
    GRPCProtoCall *call = [gateway
                           RPCToAddAddressWithRequest:request
                           handler:
                           ^(AddAddressResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.address);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
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
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

#pragma mark private
- (ReplaceTokenRequest *)createReplaceTokenRequest:(Token *)tokenToCancel
                                     tokenToCreate:(TokenPayload *)tokenToCreate {
    ReplaceTokenRequest *request = [ReplaceTokenRequest message];
    request.cancelToken.tokenId = tokenToCancel.id_p;
    request.cancelToken.signature.memberId = memberId;
    request.cancelToken.signature.keyId = key.id;
    request.cancelToken.signature.signature = [TKCrypto sign:tokenToCancel
                                                      action:TokenSignature_Action_Cancelled
                                                    usingKey:key];
    request.createToken.payload = tokenToCreate;
    return request;
}

- (void)_updateMember:(MemberUpdate *)update
            onSuccess:(OnSuccessWithMember)onSuccess
              onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update = update;
    request.updateSignature.memberId = memberId;
    request.updateSignature.keyId = key.id;
    request.updateSignature.signature = [TKCrypto sign:request.update usingKey:key];
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
                           }
                           ];
    
    [self _startCall:call withRequest:request];
}

- (void)_startCall:(GRPCProtoCall *)call withRequest:(GPBMessage *)request {
    unsigned long now = (unsigned long)([[NSDate date] timeIntervalSince1970] * 1000);
    
    GRpcAuthPayload *payload = [GRpcAuthPayload message];
    payload.request = [request data];
    payload.createdAtMs = now;
    NSString *signature = [TKCrypto sign:payload usingKey:key];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = signature;
    call.requestHeaders[@"token-created-at-ms"] = [NSString stringWithFormat: @"%lu", now];
    
    if (onBehalfOfMemberId) {
        call.requestHeaders[@"token-on-behalf-of"] = onBehalfOfMemberId;
    }
    
    [call start];
}

@end
