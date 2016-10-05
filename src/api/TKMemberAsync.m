//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>
#import "Money.pbobjc.h"
#import "Member.pbobjc.h"
#import "Security.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Payment.pbobjc.h"

#import "TKAccount.h"
#import "TKMember.h"
#import "TKMemberAsync.h"
#import "TKSecretKey.h"
#import "TKClient.h"
#import "TKAccountAsync.h"
#import "TKUtil.h"


@implementation TKMemberAsync {
    TKClient *client;
    Member *member;
}

+ (TKMemberAsync *)member:(Member *)member
                secretKey:(TKSecretKey *)key
                useClient:(TKClient *)client {
    return [[TKMemberAsync alloc] initWithMember:member secretKey:key useClient:client];
}

- (id)initWithMember:(Member *)member_
           secretKey:(TKSecretKey *)key
           useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        _key = key;
        member = member_;
        client = client_;
    }

    return self;
}

- (TKMember *)sync {
    return [TKMember member:self];
}

- (NSString *)id {
    return member.id_p;
}

- (NSString *)firstAlias {
    return member.aliasesArray[0];
}

- (NSArray<NSString *> *)publicKeys {
    NSMutableArray<NSString *> *result = [NSMutableArray array];
    for (Key *key in member.keysArray) {
        [result addObject:key.publicKey];
    }
    return result;
}

- (NSArray<NSString *> *)aliases {
    return [member.aliasesArray copy];
}

- (void)approveKey:(TKSecretKey *)key
          onSucess:(OnSuccess)onSuccess
           onError:(OnError)onError {
    [self approvePublicKey:key.publicKeyStr
                  onSucess:onSuccess
                   onError:onError];
}

- (void)approvePublicKey:(NSString *)publicKey
                onSucess:(OnSuccess)onSuccess
                 onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;
    
    [client addKey:publicKey
                to:member
             level:0
         onSuccess:
                 ^(Member *m) {
                     [retainedMember clear];
                     [retainedMember mergeFrom:m];
                     onSuccess();
                 }
           onError:onError];
}

- (void)removeKey:(NSString *)keyId
         onSucess:(OnSuccess)onSuccess
          onError:(OnError)onError {
    [client removeKey:keyId
                 from:member
            onSuccess:
                    ^(Member *m) {
                        [member clear];
                        [member mergeFrom:m];
                        onSuccess();
                    }
              onError:onError];
}

- (void)addAlias:(NSString *)alias
        onSucess:(OnSuccess)onSuccess
         onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    [client addAlias:alias
                  to:member
           onSuccess:
                   ^(Member *m) {
                       [retainedMember clear];
                       [retainedMember mergeFrom:m];
                       onSuccess();
                   }
             onError:onError];
}

- (void)removeAlias:(NSString *)alias
           onSucess:(OnSuccess)onSuccess
            onError:(OnError)onError {
    [client removeAlias:alias
                   from:member
              onSuccess:
                      ^(Member *m) {
                          [member clear];
                          [member mergeFrom:m];
                          onSuccess();
                      }
                onError:onError];
}

- (void)linkAccounts:(NSString *)bankId
         withPayload:(NSString *)payload
            onSucess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError {
    [client linkAccounts:bankId
                 payload:payload
               onSuccess:
                       ^(NSArray<Account *> *accounts) {
                           onSuccess([self _mapAccounts:accounts]);
                       }
                 onError:onError];
}

- (void)lookupAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
               onError:(OnError)onError {
    [client lookupAccounts:
                    ^(NSArray<Account *> *accounts) {
                        onSuccess([self _mapAccounts:accounts]);
                    }
                   onError:onError];
}

- (void)lookupPayment:(NSString *)paymentId
            onSuccess:(OnSuccessWithPayment)onSuccess
              onError:(OnError)onError {
    [client lookupPayment:paymentId
                onSuccess:onSuccess
                  onError:onError];
}

- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError {
    [self lookupPaymentsOffset:offset
                         limit:limit
                       tokenId:nil
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                     tokenId:(NSString *)tokenId
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError {
    [client lookupPaymentsOffset:offset
                           limit:limit
                         tokenId:tokenId
                       onSuccess:onSuccess
                         onError:onError];
}

- (void)createAddressName:(NSString *)name
                 withData:(NSString *)data
                onSuccess:(OnSuccessWithAddress)onSuccess
                  onError:(OnError)onError {
    [client createAddressName:name
                     withData:data
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)lookupAddressWithId:(NSString *)addressId
                  onSuccess:(OnSuccessWithAddress)onSuccess
                    onError:(OnError)onError {
    [client getAddressById:addressId
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)lookupAddresses:(OnSuccessWithAddresses)onSuccess
                onError:(OnError)onError {
    [client getAddresses:onSuccess
                 onError:onError];
}

- (void)deleteAddressWithId:(NSString *)addressId
                   onSucess:(OnSuccess)onSuccess
                    onError:(OnError)onError {
    [client deleteAddressById:addressId
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)setPreferences:(NSString *)preferences
              onSucess:(OnSuccess)onSuccess
               onError:(OnError)onError {
    [client setPreferences:preferences
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)lookupPreferences:(OnSuccessWithPreferences)onSuccess
                  onError:(OnError)onError {
    [client getPreferences:onSuccess
                   onError:onError];
}

- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                            onSucess:(OnSuccessWithPaymentToken)onSuccess
                             onError:(OnError)onError {
    [self createPaymentTokenForAccount:accountId
                                amount:amount
                              currency:currency
                         redeemerAlias:nil
                           description:nil
                              onSucess:onSuccess
                               onError:onError];
}

- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                       redeemerAlias:(NSString *)redeemerAlias
                         description:(NSString *)description
                            onSucess:(OnSuccessWithPaymentToken)onSuccess
                             onError:(OnError)onError {
    
    TokenMember *payer = [TokenMember message];
    payer.id_p = self.id;
    
    PaymentToken_Payload *payload = [PaymentToken_Payload message];
    payload.version = @"1.0";
    payload.nonce = [TKUtil nonce];
    payload.payer = payer;
    payload.amount = [NSString stringWithFormat:@"%g", amount];
    payload.currency = currency;
    payload.transfer.from.accountId = accountId;

    if (redeemerAlias) {
        payload.redeemer.alias = redeemerAlias;
    }

    if (description) {
        payload.description_p = description;
    }

    [client createPaymentToken:payload
                     onSuccess:^(PaymentToken *token) { onSuccess(token); }
                       onError:onError];
}

- (void)lookupPaymentToken:(NSString *)tokenId
                  onSucess:(OnSuccessWithPaymentToken)onSuccess
                   onError:(OnError)onError {
    [client lookupPaymentToken:tokenId
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)lookupPaymentTokensOffset:(int)offset
                            limit:(int)limit
                        onSuccess:(OnSuccessWithPaymentTokens)onSuccess
                          onError:(OnError)onError {
    [client lookupPaymentTokens:offset
                          limit:limit
                      onSuccess:onSuccess
                        onError:onError];
}

- (void)endorsePaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)onSuccess
                    onError:(OnError)onError {
    [client endorsePaymentToken:token
                      onSuccess:onSuccess
                        onError:onError];

}

- (void)cancelPaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)onSuccess
                    onError:(OnError)onError {
    [client cancelPaymentToken:token
                      onSuccess:onSuccess
                        onError:onError];
}

- (void)redeemPaymentToken:(PaymentToken *)token
                 onSuccess:(OnSuccessWithPayment)onSuccess
                   onError:(OnError)onError {
    [self redeemPaymentToken:token
                      amount:nil
                    currency:nil
                   onSuccess:onSuccess
                     onError:onError];
}

- (void)redeemPaymentToken:(PaymentToken *)token
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

    [client redeemPaymentToken:payload
                     onSuccess:onSuccess
                       onError:onError];
}

#pragma mark private

- (NSArray<TKAccountAsync *> *)_mapAccounts:(NSArray<Account *> *)accounts {
    NSMutableArray<TKAccountAsync *> *result = [NSMutableArray array];
    for (Account *a in accounts) {
        TKAccountAsync *tkAccount = [TKAccountAsync account:a of:self.sync useClient:client];
        [result addObject:tkAccount];
    }
    return result;
}

@end
