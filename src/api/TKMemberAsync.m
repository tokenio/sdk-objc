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
             level:(Key_Level)level
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError {
    [self approvePublicKey:key.publicKeyStr
                     level:level
                  onSuccess:onSuccess
                   onError:onError];
}

- (void)approvePublicKey:(NSString *)publicKey
                   level:(Key_Level)level
               onSuccess:(OnSuccess)onSuccess
                 onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;
    
    [client addKey:publicKey
                to:member
             level:level
         onSuccess:
                 ^(Member *m) {
                     [retainedMember clear];
                     [retainedMember mergeFrom:m];
                     onSuccess();
                 }
           onError:onError];
}

- (void)removeKey:(NSString *)keyId
        onSuccess:(OnSuccess)onSuccess
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
       onSuccess:(OnSuccess)onSuccess
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
          onSuccess:(OnSuccess)onSuccess
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

- (void)subscribeToNotifications:(NSString *)provider
        target:(NSString *)target
               platform:(Platform)platform
              onSuccess:(OnSuccess)onSuccess
                onError:(OnError)onError {
    [client subscribeToNotifications:provider
                              target:target
                            platform:platform
                           onSuccess:onSuccess
                             onError:onError];
}

- (void)unsubscribeFromNotifications:(NSString *)subscriberId
              onSuccess:(OnSuccess)onSuccess
                onError:(OnError)onError {
    [client unsubscribeFromNotifications:subscriberId
                    onSuccess:onSuccess
                      onError:onError];
}


- (void)linkAccounts:(NSString *)bankId
         withPayload:(NSString *)payload
           onSuccess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError {
    [client linkAccounts:bankId
                 payload:payload
               onSuccess:
                       ^(NSArray<Account *> *accounts) {
                           onSuccess([self _mapAccounts:accounts]);
                       }
                 onError:onError];
}

- (void)getAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
            onError:(OnError)onError {
    [client getAccounts:
                    ^(NSArray<Account *> *accounts) {
                        onSuccess([self _mapAccounts:accounts]);
                    }
                   onError:onError];
}

- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccountAsync)onSuccess
           onError:(OnError)onError {
    [client getAccount:accountId
                    onSuccess:^(Account * account) {
                        onSuccess([self _mapAccount:account]);
                    }
               onError:onError];
}

- (void)getPayment:(NSString *)paymentId
         onSuccess:(OnSuccessWithPayment)onSuccess
           onError:(OnError)onError {
    [client getPayment:paymentId
             onSuccess:onSuccess
               onError:onError];
}

- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError {
    [self getPaymentsOffset:offset
                      limit:limit
                    tokenId:nil
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                  tokenId:(NSString *)tokenId
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError {
    [client getPaymentsOffset:offset
                        limit:limit
                      tokenId:tokenId
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)addAddressWithName:(NSString *)name
                  withData:(NSString *)data
                 onSuccess:(OnSuccessWithAddress)onSuccess
                   onError:(OnError)onError {
    [client addAddressWithName:name
                      withData:data
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)getAddressWithId:(NSString *)addressId
               onSuccess:(OnSuccessWithAddress)onSuccess
                 onError:(OnError)onError {
    [client getAddressById:addressId
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError {
    [client getAddresses:onSuccess
                 onError:onError];
}

- (void)deleteAddressWithId:(NSString *)addressId
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError {
    [client deleteAddressById:addressId
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                           onSuccess:(OnSuccessWithPaymentToken)onSuccess
                             onError:(OnError)onError {
    [self createPaymentTokenForAccount:accountId
                                amount:amount
                              currency:currency
                         redeemerAlias:nil
                           description:nil
                             onSuccess:onSuccess
                               onError:onError];
}

- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                       redeemerAlias:(NSString *)redeemerAlias
                         description:(NSString *)description
                           onSuccess:(OnSuccessWithPaymentToken)onSuccess
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

- (void)getPaymentToken:(NSString *)tokenId
              onSuccess:(OnSuccessWithPaymentToken)onSuccess
                onError:(OnError)onError {
    [client getPaymentToken:tokenId
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)getPaymentTokensOffset:(int)offset
                         limit:(int)limit
                     onSuccess:(OnSuccessWithPaymentTokens)onSuccess
                       onError:(OnError)onError {
    [client getPaymentTokens:offset
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

- (TKAccountAsync *)_mapAccount:(Account *)account {
    return [TKAccountAsync account:account of:self.sync useClient:client];
}

@end
