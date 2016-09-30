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
    __strong typeof(member) retainedMember = member;
    
    [client addKey:key
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
         withPayload:(NSData *)payload
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

- (void)getAddressById:(NSString *)addressId
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

- (void)deleteAddressById:(NSString *)addressId
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

- (void)getPreferences:(OnSuccessWithPreferences)onSuccess
               onError:(OnError)onError {
    [client getPreferences:onSuccess
                   onError:onError];
}

- (void)createTokenForAccount:(NSString *)accountId
                       amount:(double)amount
                     currency:(NSString *)currency
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError {
    [self createTokenForAccount:accountId
                         amount:amount
                       currency:currency
                  redeemerAlias:nil
                    description:nil
                       onSucess:onSuccess
                        onError:onError];
}

- (void)createTokenForAccount:(NSString *)accountId
                       amount:(double)amount
                     currency:(NSString *)currency
                redeemerAlias:(NSString *)redeemerAlias
                  description:(NSString *)description
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError {

    TokenMember *payer = [TokenMember message];
    payer.id_p = self.id;

    PaymentToken *paymentToken = [PaymentToken message];
    paymentToken.scheme = @"Pay/1.0";
    paymentToken.nonce = [TKUtil nonce];
    paymentToken.payer = payer;
    paymentToken.amount = [NSString stringWithFormat:@"%g", amount];
    paymentToken.currency = currency;
    paymentToken.transfer.from.accountId = accountId;

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
