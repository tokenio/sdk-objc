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
