//
// Created by Yuhan Niu on 10/17/18.
// Copyright (c) 2018 Token Inc. All rights reserved.
//

#import "Security.pbobjc.h"

/**
 * Represents the part of a token member that can be accessed through an access token.
 *
 * <p>
 * The class provides synchronous version of `TKRepresentable`.
 * </p>
 */
@protocol TKRepresentableSync

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @return list of accounts
 */
- (NSArray<TKAccountSync *> *)getAccounts;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 * @return list of accounts
 */
- (TKAccountSync *)getAccount:(NSString *)accountId;

/**
 * Looks up account balance with a specific key level.
 *
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @return account balance
 */
- (TKBalance *)getBalance:(NSString *)accountId
                  withKey:(Key_Level)keyLevel;

/**
 * Looks up account balances with a specific key level.
 *
 * @param accountIds account ids to get balance
 * @param keyLevel specifies the key to use
 * @return account balances
 */
- (NSDictionary<NSString *,TKBalance *> *)getBalances:(NSArray<NSString *> *)accountIds
                                              withKey:(Key_Level)keyLevel;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @return an address record
 */
- (AddressRecord *)getAddressWithId:(NSString *)addressId;

/**
 * Looks up member addresses.
 *
 * @return a list of addresses
 */
- (NSArray<AddressRecord *> *)getAddresses;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @param keyLevel specifies the key to use
 * @return a looked up transaction
 */
- (Transaction *)getTransaction:(NSString *)transactionId
                     forAccount:(NSString *)accountId
                        withKey:(Key_Level)keyLevel;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @return a list of looked up transactions
 */
- (PagedArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                               limit:(int)limit
                                          forAccount:(NSString *)accountId
                                             withKey:(Key_Level)keyLevel;

@end
