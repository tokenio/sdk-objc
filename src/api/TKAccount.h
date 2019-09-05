//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"
#import "TokenProto.h"

@class TKClient;
@class TKMember;

/**
 * Represents a funding account in the Token system.
 * 
 * <p>
 * The class provides async API
 * </p>
 */
@interface TKAccount : NSObject

/// Owner member.
@property (nonatomic, readonly) TKMember *member;

/// Id by which Token system identifies this account.
@property (nonatomic, readonly) NSString *id;

/// Human-readable name. For example, could be "Checking account with number ending -2718".
@property (nonatomic, readonly) NSString *name;

/// Id by which Token system identifies this account's bank.
@property (nonatomic, readonly) NSString *bankId;

/// Flag indicating whether the account needs re-linking.
@property (nonatomic, readonly) BOOL isLocked;

/// Flag indicating whether the account can send payments.
@property (nonatomic, readonly) BOOL supportsSendPayment;

/// Flag indicating whether the account can receive payments.
@property(nonatomic, readwrite) BOOL supportsReceivePayment;

/// Flag indicating whether the account allows for retrieval of information.
@property (nonatomic, readonly) BOOL supportsInformation;

/// Flag indicating whether the account requires external authorization for creating transfers.
@property (nonatomic, readonly) BOOL requiresExternalAuth;

/// Account details
@property (nonatomic, readonly) AccountDetails *accountDetails;

/// Account features
@property (nonatomic, readonly) AccountFeatures *accountFeatures;

+ (TKAccount *)account:(Account *)account
                    of:(TKMember *)member
             useClient:(TKClient *)client;

/**
 * Looks up account balance.
 *
 * @param keyLevel key level
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBalance:(Key_Level)keyLevel
         onSuccess:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @param keyLevel key level
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransaction:(NSString *)transactionId
               withKey:(Key_Level)keyLevel
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @param keyLevel key level
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                      withKey:(Key_Level)keyLevel
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

/**
 * Looks up an existing standing order and return the response.
 *
 * @param standingOrderId standing order ID
 * @param keyLevel key level
 * @param onSuccess invoked on success with the standing order
 * @param onError invoked on error
 */
- (void)getStandingOrder:(NSString *)standingOrderId
                 withKey:(Key_Level)keyLevel
               onSuccess:(OnSuccessWithStandingOrder)onSuccess
                 onError:(OnError)onError;

/**
 * Looks up standing orders and return response.
 *
 * @param offset offset
 * @param limit limit
 * @param keyLevel key level
 * @param onSuccess invoked on success with standing orders
 * @param onError invoked on error
 */
- (void)getStandingOrdersOffset:(NSString *)offset
                          limit:(int)limit
                        withKey:(Key_Level)keyLevel
                      onSuccess:(OnSuccessWithStandingOrders)onSuccess
                        onError:(OnError)onError;

@end
