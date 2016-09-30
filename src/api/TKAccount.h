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
@class TKAccountAsync;


@interface TKAccount : NSObject

@property (atomic, readonly) TKAccountAsync *async;
@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccount *)account:(TKAccountAsync *)delegate;

- (Money *)lookupBalance;

- (Transaction *)lookupTransaction:(NSString *)transactionId;

- (NSArray<Payment *> *)lookupTransactionsOffset:(int)offset
                                           limit:(int)limit;

@end
