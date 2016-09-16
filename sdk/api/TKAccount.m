//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <protos/Transfer.pbobjc.h>
#import "TKAccount.h"
#import "TKMember.h"
#import "Account.pbobjc.h"
#import "TKClient.h"
#import "Token.pbobjc.h"
#import "TKRpcSyncCall.h"
#import "TKUtil.h"


@implementation TKAccount {
    Account *account;
    TKClient *client;
}

+ (TKAccount *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client {
    return [[TKAccount alloc] initWithAccount:account of:member useClient:client];
}

- (id)initWithAccount:(Account *)account_ of:(TKMember *)member useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        account = account_;
        client = client_;
        _member = member;
    }

    return self;
}

- (NSString *)id {
    return account.id_p;
}

- (NSString *)name {
    return account.name;
}

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency {
    return [self createTokenWithAmount:amount
                              currency:currency
                         redeemerAlias:nil description:nil];
}

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncCreateTokenWithAmount:amount
                                currency:currency
                           redeemerAlias:redeemerAlias
                             description:description
                                onSucess:call.onSuccess
                                 onError:call.onError];
    }];
}

- (void)asyncCreateTokenWithAmount:(double)amount
                          currency:(NSString *)currency
                          onSucess:(OnSuccessWithToken)onSuccess
                           onError:(OnError)onError {
    [self asyncCreateTokenWithAmount:amount
                            currency:currency
                       redeemerAlias:nil
                         description:nil
                            onSucess:onSuccess
                             onError:onError];
}

- (void)asyncCreateTokenWithAmount:(double)amount
                             currency:(NSString *)currency
                        redeemerAlias:(NSString *)redeemerAlias
                          description:(NSString *)description
                             onSucess:(OnSuccessWithToken)onSuccess
                              onError:(OnError)onError {

    TokenMember *payer = [TokenMember message];
    payer.id_p = self.member.id;

    PaymentToken *paymentToken = [PaymentToken message];
    paymentToken.scheme = @"Pay/1.0";  // FIXME: Should be s/-/\//
    paymentToken.nonce = [TKUtil nonce];
    paymentToken.payer = payer;
    paymentToken.amount = amount;
    paymentToken.currency = currency;
    paymentToken.transfer.from.accountId = self.id;

    if (redeemerAlias) {
        paymentToken.redeemer.alias = redeemerAlias;
    }

    if (description) {
        paymentToken.description_p = description;
    }

    [client createPaymentToken:paymentToken
                        onSuccess:^(Token *token) { onSuccess(token); }
                          onError:onError];
}

- (Token *)lookupToken:(NSString *)tokenId {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncLookupToken:tokenId
                      onSucess:call.onSuccess
                       onError:call.onError];
    }];
}

- (void)asyncLookupToken:(NSString *)tokenId
        onSucess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError {
    [client lookupToken:tokenId
              onSuccess:onSuccess
                onError:onError];
}

- (NSArray<Token *> *)lookupTokensOffset:(int)offset
                                   limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncLookupTokensOffset:offset
                                limit:limit
                            onSuccess:call.onSuccess
                              onError:call.onError];
    }];
}

- (void)asyncLookupTokensOffset:(int)offset
                          limit:(int)limit
                      onSuccess:(OnSuccessWithTokens)onSuccess
                        onError:(OnError)onError {
    [client lookupTokens:offset
                   limit:limit
               onSuccess:onSuccess
                 onError:onError];
}

- (Token *)endorseToken:(Token *)token {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncEndorseToken:token
                onSuccess:call.onSuccess
                onError:call.onError];
    }];
}

- (void)asyncEndorseToken:(Token *)token
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError {
    [client endorseToken:token
               onSuccess:onSuccess
                 onError:onError];

}

- (Token *)declineToken:(Token *)token {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncDeclineToken:token
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (void)asyncDeclineToken:(Token *)token
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError {
    [client declineToken:token
               onSuccess:onSuccess
                 onError:onError];

}

- (Token *)revokeToken:(Token *)token {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncRevokeToken:token
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (void)asyncRevokeToken:(Token *)token
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError {
    [client revokeToken:token
               onSuccess:onSuccess
                 onError:onError];

}

@end