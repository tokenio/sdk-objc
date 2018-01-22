//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"
#import "PagedArray.h"


@class TKMemberSync;
@class TKAccount;
@class Transaction;

/**
 * Represents a funding account in the Token system.
 * 
 * <p>
 * The class provides synchronous API with `TKAccount` providing a asynchronous
 * version. `TKAccount` instance can be obtained by calling `async` method.
 * </p>
 */
@interface TKAccountSync : NSObject

/// Asynchronous version.
@property (nonatomic, readonly) TKAccount *async;

/// Owner member.
@property (nonatomic, readonly) TKMemberSync *member;

/// Id by which Token system identifies this account.
@property (nonatomic, readonly) NSString *id;

/// Human-readable name. For example, "Checking account with number ending -2718".
@property (nonatomic, readonly) NSString *name;

/// Id by which Token system identifies this account's bank.
@property (nonatomic, readonly) NSString *bankId;

/// Flag indicating whether the account needs re-linking.
@property (nonatomic, readonly) BOOL isLocked;

/// Flag indicating whether the account allows for payment initiation.
@property (nonatomic, readonly) BOOL supportsPayment;

/// Flag indicating whether the account allows for retrieval of information.
@property (nonatomic, readonly) BOOL supportsInformation;

/// Flag indicating whether the account requires external authorization for creating transfers.
@property (nonatomic, readonly) BOOL requiresExternalAuth;

+ (TKAccountSync *)account:(TKAccount *)delegate;

/**
 * Looks up account balance.
 *
 * @return a balance amount
 */
- (TKBalance *)getBalance;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @return a looked up transaction
 */
- (Transaction *)getTransaction:(NSString *)transactionId;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @return a list of looked up transactions
 */
- (PagedArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                               limit:(int)limit;

@end
