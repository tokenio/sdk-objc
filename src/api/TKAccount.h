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


/**
 * Represents a funding account in the Token system.
 * 
 * <p>
 * The class provides synchronous API with `TKAccountAsync` providing a asynchronous
 * version. `TKAccountAsync` instance can be obtained by calling `async` method.
 * </p>
 */
@interface TKAccount : NSObject

@property (atomic, readonly) TKAccountAsync *async;
@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccount *)account:(TKAccountAsync *)delegate;

/**
 * Looks up account balance.
 *
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (Money *)getBalance;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token payment.
 *
 * @param transactionId ID of the transaction
 * @return a looked up transaction
 */
- (Transaction *)getTransaction:(NSString *)transactionId;

/**
 * Looks up existing transactions. This is a full list of transactions with token payments
 * being a subset.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return a list of looked up transactions
 */
- (NSArray<Payment *> *)getTransactionsOffset:(int)offset
                                        limit:(int)limit;

@end
