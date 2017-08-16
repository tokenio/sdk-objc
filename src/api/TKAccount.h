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

@property (atomic, readonly) TKMemberSync *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;
@property (atomic, readonly) NSString *bankId;

+ (TKAccount *)account:(Account *)account
                    of:(TKMemberSync *)member
             useClient:(TKClient *)client;

/**
 * Looks up account balance.
 *
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBalance:(OnSuccessWithMoney)onSuccess
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
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

@end
