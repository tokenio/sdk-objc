//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


@class Account;
@class TKMemberSync;
@class TKClient;
@class Token;

/**
 * Represents a funding account in the Token system.
 * 
 * <p>
 * The class provides async API
 * </p>
 */
@interface TKAccount : NSObject

/**
 * Owner member.
 */
@property (atomic, readonly) TKMemberSync *member;

/**
 * Id by which Token system identifies this account.
 */
@property (atomic, readonly) NSString *id;

/**
 * Human readable name, such as "Checking account with number ending -2718"
 */
@property (atomic, readonly) NSString *name;

/**
 * Id by which Token system identifies this account's bank
 */
@property (atomic, readonly) NSString *bankId;

/**
 * Does account require re-linking?
 */
@property (atomic, readonly) BOOL isLocked;

+ (TKAccount *)account:(Account *)account
                    of:(TKMemberSync *)member
             useClient:(TKClient *)client;

/**
 * Looks up account balance.
 *
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBalance:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransaction:(NSString *)transactionId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

@end
