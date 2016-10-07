//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ProtoRPC/ProtoRPC.h"
#import "Member.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"

#import "TKClient.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"


NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKClient {
    GatewayService *gateway;
    NSString *memberId;
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

- (void)addAlias:(NSString *)alias
              to:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addAlias.alias = alias;

    [self _updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)removeAlias:(NSString *)alias
               from:(Member *)member
          onSuccess:(OnSuccessWithMember)onSuccess
            onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.removeAlias.alias = alias;

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

- (void)linkAccounts:(NSString *)bankId
             payload:(NSString *)accountLinkPayload
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {
    LinkAccountsRequest *request = [LinkAccountsRequest message];
    request.bankId = bankId;
    request.accountsLinkPayload = accountLinkPayload;
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

- (void)createPaymentToken:(PaymentToken_Payload *)payload
                 onSuccess:(OnSuccessWithPaymentToken)onSuccess
                   onError:(OnError)onError {
    CreatePaymentTokenRequest *request = [CreatePaymentTokenRequest message];
    request.payload = payload;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToCreatePaymentTokenWithRequest:request
                                   handler:^(CreatePaymentTokenResponse *response, NSError *error) {
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

- (void)getPaymentToken:(NSString *)tokenId
              onSuccess:(OnSuccessWithPaymentToken)onSuccess
                onError:(OnError)onError {
    GetPaymentTokenRequest *request = [GetPaymentTokenRequest message];
    request.tokenId = tokenId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetPaymentTokenWithRequest:request
                           handler:^(GetPaymentTokenResponse *response, NSError *error) {
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

- (void)getPaymentTokens:(int)offset
               limit:(int)limit
           onSuccess:(OnSuccessWithPaymentTokens)onSuccess
             onError:(OnError)onError {
    GetPaymentTokensRequest *request = [GetPaymentTokensRequest message];
    request.offset = offset;
    request.limit = limit;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetPaymentTokensWithRequest:request
                           handler:^(GetPaymentTokensResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.tokensArray);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];

    [self _startCall:call withRequest:request];
}

- (void)endorsePaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)onSuccess
                    onError:(OnError)onError {
    EndorsePaymentTokenRequest *request = [EndorsePaymentTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Endorsed
                                        usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToEndorsePaymentTokenWithRequest:request
                           handler:^(EndorsePaymentTokenResponse *response, NSError *error) {
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

- (void)cancelPaymentToken:(PaymentToken *)token
                 onSuccess:(OnSuccessWithPaymentToken)onSuccess
                   onError:(OnError)onError {
    CancelPaymentTokenRequest *request = [CancelPaymentTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Cancelled
                                        usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToCancelPaymentTokenWithRequest:request
                           handler:^(CancelPaymentTokenResponse *response, NSError *error) {
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

- (void)redeemPaymentToken:(PaymentPayload *)payload
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError {
    RedeemPaymentTokenRequest *request = [RedeemPaymentTokenRequest message];
    request.payload = payload;
    request.payloadSignature.keyId = key.id;
    request.payloadSignature.signature = [TKCrypto sign:payload usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToRedeemPaymentTokenWithRequest:request
                           handler:
                           ^(RedeemPaymentTokenResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.payment);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];

    [self _startCall:call withRequest:request];
}

- (void)getPayment:(NSString *)paymentId
         onSuccess:(OnSuccessWithPayment)onSuccess
           onError:(OnError)onError {
    GetPaymentRequest *request = [GetPaymentRequest message];
    request.paymentId = paymentId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetPaymentWithRequest:request
                           handler:
                           ^(GetPaymentResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.payment);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];

    [self _startCall:call withRequest:request];
}

- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                  tokenId:(NSString *)tokenId
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError {
    GetPaymentsRequest *request = [GetPaymentsRequest message];
    request.offset = offset;
    request.limit = limit;
    request.tokenId = tokenId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetPaymentsWithRequest:request
                           handler:
                           ^(GetPaymentsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.paymentsArray);
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

- (void)getTransactionsOffset:(NSString *)accountId
                          offset:(int)offset
                           limit:(int)limit
                       onSuccess:(OnSuccessWithTransactions)onSuccess
                         onError:(OnError)onError {
    GetTransactionsRequest *request = [GetTransactionsRequest message];
    request.accountId = accountId;
    request.offset = offset;
    request.limit = limit;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
                           RPCToGetTransactionsWithRequest:request
                           handler:
                           ^(GetTransactionsResponse *response, NSError *error) {
                               if (response) {
                                   RpcLogCompleted(response);
                                   onSuccess(response.transactionsArray);
                               } else {
                                   RpcLogError(error);
                                   onError(error);
                               }
                           }];
    
    [self _startCall:call withRequest:request];
}

- (void)addAddressWithName:(NSString * )name
                  withData:(NSString *)data
                 onSuccess:(OnSuccessWithAddress)onSuccess
                   onError:(OnError)onError {
    AddAddressRequest *request = [AddAddressRequest message];
    request.name = name;
    request.data_p = data;
    request.dataSignature.keyId = key.id;
    request.dataSignature.signature = [TKCrypto signPayload:data usingKey:key];
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

- (void)_updateMember:(MemberUpdate *)update
            onSuccess:(OnSuccessWithMember)onSuccess
              onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update = update;
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
    NSString *signature = [TKCrypto sign:request usingKey:key];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = signature;

    [call start];
}

@end
