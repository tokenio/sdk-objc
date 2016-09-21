//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <ProtoRPC/ProtoRPC.h>
#import <TokenSdk/Member.pbobjc.h>
#import <TokenSdk/gateway/Gateway.pbrpc.h>

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

- (void)addKey:(TKSecretKey *)newKey
            to:(Member *)member
         level:(NSUInteger)level
     onSuccess:(OnSuccessWithMember)onSuccess
       onError:(OnError)onError {
    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addKey.level = level;
    update.addKey.publicKey = newKey.publicKeyStr;

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
             payload:(NSData *)accountLinkPayload
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {
    LinkAccountRequest *request = [LinkAccountRequest message];
    request.bankId = bankId;
    request.accountLinkPayload = accountLinkPayload;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLinkAccountWithRequest:request
                                 handler:^(LinkAccountResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         onSuccess(response.accountsArray);
                                     } else {
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }
    ];

    [self _startCall:call withRequest:request];
}

- (void)lookupAccounts:(OnSuccessWithAccounts)onSuccess
               onError:(OnError)onError {
    LookupAccountsRequest *request = [LookupAccountsRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupAccountsWithRequest:request
                                   handler:^(LookupAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           onSuccess(response.accountsArray);
                                       } else {
                                           RpcLogError(error);
                                           onError(error);
                                       }
                                   }
    ];

    [self _startCall:call withRequest:request];
}

- (void)createPaymentToken:(PaymentToken *)paymentToken
                 onSuccess:(OnSuccessWithToken)onSuccess
                   onError:(OnError)onError {
    CreatePaymentTokenRequest *request = [CreatePaymentTokenRequest message];
    request.token = paymentToken;
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

- (void)lookupToken:(NSString *)tokenId
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    LookupTokenRequest *request = [LookupTokenRequest message];
    request.tokenId = tokenId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupTokenWithRequest:request
                                handler:^(LookupTokenResponse *response, NSError *error) {
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

- (void)lookupTokens:(int)offset
               limit:(int)limit
           onSuccess:(OnSuccessWithTokens)onSuccess
             onError:(OnError)onError {
    LookupTokensRequest *request = [LookupTokensRequest message];
    request.offset = offset;
    request.limit = limit;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupTokensWithRequest:request
                                handler:^(LookupTokensResponse *response, NSError *error) {
                                    if (response) {
                                        RpcLogCompleted(response);
                                        onSuccess(response.tokensArray);
                                    } else {
                                        RpcLogError(error);
                                        onError(error);
                                    }
                                }
    ];

    [self _startCall:call withRequest:request];
}

- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError {
    EndorseTokenRequest *request = [EndorseTokenRequest message];
    request.tokenId = token.id_p;
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
                                         onSuccess(response.token);
                                     } else {
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }
    ];

    [self _startCall:call withRequest:request];
}

- (void)declineToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError {
    DeclineTokenRequest *request = [DeclineTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Declined
                                        usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToDeclineTokenWithRequest:request
                                 handler:^(DeclineTokenResponse *response, NSError *error) {
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

- (void)revokeToken:(Token *)token
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    RevokeTokenRequest *request = [RevokeTokenRequest message];
    request.tokenId = token.id_p;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:token
                                          action:TokenSignature_Action_Revoked
                                        usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToRevokeTokenWithRequest:request
                                 handler:^(RevokeTokenResponse *response, NSError *error) {
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

- (void)redeemToken:(PaymentPayload *)payload
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError {
    RedeemPaymentTokenRequest *request = [RedeemPaymentTokenRequest message];
    request.payload = payload;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:payload usingKey:key];
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

- (void)lookupPayment:(NSString *)paymentId
            onSuccess:(OnSuccessWithPayment)onSuccess
              onError:(OnError)onError {
    LookupPaymentRequest *request = [LookupPaymentRequest message];
    request.paymentId = paymentId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupPaymentWithRequest:request
                                       handler:
                                               ^(LookupPaymentResponse *response, NSError *error) {
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

- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                     tokenId:(NSString *)tokenId
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError {
    LookupPaymentsRequest *request = [LookupPaymentsRequest message];
    request.offset = offset;
    request.limit = limit;
    request.tokenId = tokenId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupPaymentsWithRequest:request
                                       handler:
                                               ^(LookupPaymentsResponse *response, NSError *error) {
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

- (void)lookupBalance:(NSString *)accountId
            onSuccess:(OnSuccessWithMoney)onSuccess
              onError:(OnError)onError {
    LookupBalanceRequest *request = [LookupBalanceRequest message];
    request.accountId = accountId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupBalanceWithRequest:request
                                  handler:
                                          ^(LookupBalanceResponse *response, NSError *error) {
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

- (void)lookupTransaction:(NSString *)transactionId
               forAccount:(NSString *)accountId
                onSuccess:(OnSuccessWithTransaction)onSuccess
                  onError:(OnError)onError {
    LookupTransactionRequest *request = [LookupTransactionRequest message];
    request.accountId = accountId;
    request.transactionId = transactionId;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupTransactionWithRequest:request
                                  handler:
                                          ^(LookupTransactionResponse *response, NSError *error) {
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

- (void)lookupTransactionsOffset:(NSString *)accountId
                          offset:(int)offset
                           limit:(int)limit
                       onSuccess:(OnSuccessWithTransactions)onSuccess
                         onError:(OnError)onError {
    LookupTransactionsRequest *request = [LookupTransactionsRequest message];
    request.accountId = accountId;
    request.offset = offset;
    request.limit = limit;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupTransactionsWithRequest:request
                                       handler:
                                               ^(LookupTransactionsResponse *response, NSError *error) {
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

- (void)createAddressName:(NSString * )name
                 withData:(NSString *)data
                onSuccess:(OnSuccessWithAddress)onSuccess
                  onError:(OnError)onError {
    CreateAddressRequest *request = [CreateAddressRequest message];
    request.name = name;
    request.data_p = data;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto signPayload:data usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToCreateAddressWithRequest:request
                                  handler:
                                          ^(CreateAddressResponse *response, NSError *error) {
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

- (void)setPreferences:(NSString *)preferences
             onSuccess:(OnSuccess)onSuccess
               onError:(OnError)onError {
    SetPreferenceRequest *request = [SetPreferenceRequest message];
    request.preference = preferences;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToSetPreferenceWithRequest:request
                                  handler:
                                          ^(SetPreferenceResponse *response, NSError *error) {
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

- (void)getPreferences:(OnSuccessWithPreferences)onSuccess
               onError:(OnError)onError {
    GetPreferenceRequest *request = [GetPreferenceRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToGetPreferenceWithRequest:request
                                  handler:
                                          ^(GetPreferenceResponse *response, NSError *error) {
                                              if (response) {
                                                  RpcLogCompleted(response);
                                                  onSuccess(response.preference);
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
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:request.update usingKey:key];
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