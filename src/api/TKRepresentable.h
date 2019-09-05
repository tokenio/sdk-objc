//
// Created by Yuhan Niu on 10/16/18.
// Copyright (c) 2018 Token Inc. All rights reserved.
//

#import "TKTypedef.h"
#import "Security.pbobjc.h"

/**
 * Represents the part of a token member that can be accessed through an access token.
 * 
 * <p>
 * The class provides async API
 * </p>
 */
@protocol TKRepresentable

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAccounts:(OnSuccessWithTKAccounts)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccount)onSuccess
           onError:(OnError)onError;

/**
 * Looks up account balance with a specific key level.
 *
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getBalance:(NSString *)accountId
           withKey:(Key_Level)keyLevel
         onSuccess:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError;

/**
 * Looks up account balances with a specific key level.
 *
 * @param accountIds account ids to get balance
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success with account balances
 * @param onError callback invoked on error
 */
- (void)getBalances:(NSArray<NSString *> *)accountIds
            withKey:(Key_Level)keyLevel
          onSuccess:(OnSuccessWithTKBalances)onSuccess
            onError:(OnError)onError;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAddressWithId:(NSString *)addressId
               onSuccess:(OnSuccessWithAddress)onSuccess
                 onError:(OnError)onError;

/**
 * Looks up member addresses.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
               withKey:(Key_Level)keyLevel
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
                      withKey:(Key_Level)keyLevel
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

/**
 * Looks up an existing standing order and return the response.
 *
 * @param accountId account ID
 * @param standingOrderId standing order ID
 * @param keyLevel key level
 * @param onSuccess invoked on success with the standing order
 * @param onError invoked on error
 */
- (void)getStandingOrder:(NSString *)standingOrderId
              forAccount:(NSString *)accountId
                 withKey:(Key_Level)keyLevel
               onSuccess:(OnSuccessWithStandingOrder)onSuccess
                 onError:(OnError)onError;

/**
 * Looks up standing orders and return response.
 *
 * @param accountId account ID
 * @param offset offset
 * @param limit limit
 * @param keyLevel key level
 * @param onSuccess invoked on success with standing orders
 * @param onError invoked on error
 */
- (void)getStandingOrdersOffset:(NSString *)offset
                          limit:(int)limit
                     forAccount:(NSString *)accountId
                        withKey:(Key_Level)keyLevel
                      onSuccess:(OnSuccessWithStandingOrders)onSuccess
                        onError:(OnError)onError;
@end
