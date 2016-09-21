//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


@class Account;
@class TKMember;
@class TKClient;
@class Token;
@class Payment;


@interface TKAccountAsync : NSObject

@property (atomic, readonly) TKAccount *sync;
@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccountAsync *)account:(Account *)account
                         of:(TKMember *)member
                  useClient:(TKClient *)client;

- (void)createTokenWithAmount:(double)amount
                     currency:(NSString *)currency
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

- (void)createTokenWithAmount:(double)amount
                     currency:(NSString *)currency
                redeemerAlias:(NSString *)redeemerAlias
                  description:(NSString *)description
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

- (void)lookupToken:(NSString *)tokenId
           onSucess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

- (void)lookupTokensOffset:(int)offset
                     limit:(int)limit
                 onSuccess:(OnSuccessWithTokens)onSuccess
                   onError:(OnError)onError;

- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError;

- (void)declineToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError;

- (void)revokeToken:(Token *)token
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

- (void)redeemToken:(Token *)token
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError;

- (void)redeemToken:(Token *)token
             amount:(NSNumber *)amount
           currency:(NSString *)currency
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError;

- (void)lookupBalance:(OnSuccessWithMoney)onSuccess
              onError:(OnError)onError;

- (void)lookupTransaction:(NSString *)transactionId
                onSuccess:(OnSuccessWithTransaction)onSuccess
                  onError:(OnError)onError;

- (void)lookupTransactionsOffset:(int)offset
                           limit:(int)limit
                       onSuccess:(OnSuccessWithTransactions)onSuccess
                         onError:(OnError)onError;

@end