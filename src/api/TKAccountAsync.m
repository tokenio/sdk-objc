//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <TokenSdk/Account.pbobjc.h>
#import <TokenSdk/Money.pbobjc.h>
#import <TokenSdk/Payment.pbobjc.h>
#import <TokenSdk/Token.pbobjc.h>
#import <TokenSdk/Transfer.pbobjc.h>

#import "TKMember.h"
#import "TKClient.h"
#import "TKUtil.h"
#import "TKAccountAsync.h"
#import "TKAccount.h"


@implementation TKAccountAsync {
    Account *account;
    TKClient *client;
}

+ (TKAccountAsync *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client {
    return [[TKAccountAsync alloc] initWithAccount:account of:member useClient:client];
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

- (TKAccount *)sync {
    return [TKAccount account:self];
}

- (NSString *)id {
    return account.id_p;
}

- (NSString *)name {
    return account.name;
}

- (void)createTokenWithAmount:(double)amount
                     currency:(NSString *)currency
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError {
    [self createTokenWithAmount:amount
                       currency:currency
                  redeemerAlias:nil
                    description:nil
                       onSucess:onSuccess
                        onError:onError];
}

- (void)createTokenWithAmount:(double)amount
                     currency:(NSString *)currency
                redeemerAlias:(NSString *)redeemerAlias
                  description:(NSString *)description
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError {

    TokenMember *payer = [TokenMember message];
    payer.id_p = self.member.id;

    PaymentToken *paymentToken = [PaymentToken message];
    paymentToken.scheme = @"Pay/1.0";
    paymentToken.nonce = [TKUtil nonce];
    paymentToken.payer = payer;
    paymentToken.amount = [NSString stringWithFormat:@"%g", amount];
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

- (void)lookupToken:(NSString *)tokenId
           onSucess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    [client lookupToken:tokenId
              onSuccess:onSuccess
                onError:onError];
}

- (void)lookupTokensOffset:(int)offset
                     limit:(int)limit
                 onSuccess:(OnSuccessWithTokens)onSuccess
                   onError:(OnError)onError {
    [client lookupTokens:offset
                   limit:limit
               onSuccess:onSuccess
                 onError:onError];
}

- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError {
    [client endorseToken:token
               onSuccess:onSuccess
                 onError:onError];

}

- (void)declineToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError {
    [client declineToken:token
               onSuccess:onSuccess
                 onError:onError];
}

- (void)revokeToken:(Token *)token
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError {
    [client revokeToken:token
               onSuccess:onSuccess
                 onError:onError];
}

- (void)redeemToken:(Token *)token
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError {
    [self redeemToken:token
               amount:nil
             currency:nil
            onSuccess:onSuccess
              onError:onError];
}

- (void)redeemToken:(Token *)token
             amount:(NSNumber *)amount
           currency:(NSString *)currency
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError {
    PaymentPayload *payload = [PaymentPayload message];
    payload.tokenId = token.id_p;
    payload.nonce = [TKUtil nonce];

    if (amount) {
        payload.amount.value = [amount stringValue];
    }
    if (currency) {
        payload.amount.currency = currency;
    }

    [client redeemToken:payload
              onSuccess:onSuccess
                onError:onError];
}

- (void)lookupBalance:(OnSuccessWithMoney)onSuccess
              onError:(OnError)onError {
    [client lookupBalance:account.id_p
                onSuccess:onSuccess
                  onError:onError];
}

- (void)lookupTransaction:(NSString *)transactionId
                onSuccess:(OnSuccessWithTransaction)onSuccess
                  onError:(OnError)onError {
    [client lookupTransaction:transactionId
                   forAccount:account.id_p
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)lookupTransactionsOffset:(int)offset
                           limit:(int)limit
                       onSuccess:(OnSuccessWithTransactions)onSuccess
                         onError:(OnError)onError {
    return [client lookupTransactionsOffset:account.id_p
                                     offset:offset
                                      limit:limit
                                  onSuccess:onSuccess
                                    onError:onError];
}

@end