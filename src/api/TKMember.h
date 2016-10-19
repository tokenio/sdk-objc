//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"
#import "Subscriber.pbobjc.h"
#import "Security.pbobjc.h"


@class TKSecretKey;
@class Member;
@class TKClient;
@class TKMemberAsync;
@class Address;
@class AccessBody_Resource;


/**
 * Represents a Member in the Token system. Each member has an active secret
 * and public key pair that is used to perform authentication.
 *
 * <p>
 * The class provides synchronous API with `TKMemberAsync` providing a asynchronous
 * version. `TKMemberAsync` instance can be obtained by calling `async` method.
 * </p>
 */
@interface TKMember : NSObject

@property (readonly, retain) TKMemberAsync *async;
@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstUsername;
@property (readonly, retain) NSArray<NSString*> *usernames;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

/**
 * Creates new member that is implemented by delegating all the calls to the
 * asynchonous implementation `TKMemberAsync`.
 */
+ (TKMember *)member:(TKMemberAsync *)delegate;

/**
 * Sets the On-Behalf-Of authentication value to be used
 * with this client.  The value must correspond to an existing
 * Access Token ID issued for the client member.
 *
 * @param accessTokenId the access token id
 */
- (void)useAccessToken:(NSString *)accessTokenId;

/**
 * Clears the access token value used with this client.
 */
- (void)clearAccessToken;

/**
 * Approves a public key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 */
- (void)approveKey:(TKSecretKey *)key
             level:(Key_Level)level;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 */
- (void)removeKey:(NSString *)keyId;

/**
 * Adds a new username for the member.
 *
 * @param username username, e.g. 'john', must be unique
 */
- (void)addUsername:(NSString *)username;

/**
 * Removes an username for the member.
 *
 * @param username username, e.g. 'john'
 */
- (void)removeUsername:(NSString *)username;

/**
 * Subscribes a device to receive push notifications
 *
 * @param provider push notification provider (default @"Token")
 * @param target target to send push to (push token)
 * @param platform target platform for notification (e.g. Platform_Ios)
 */
- (Subscriber *)subscribeToNotifications:(NSString *)provider
                                  target:(NSString *)target
                                platform:(Platform)platform;

/**
 * Get all subscribers
 *
 */
- (NSArray<Subscriber *> *)getSubscribers;

/**
 * Get a subscriber by Id
 *
 * @param subscriberId id of subscriber to get
 */
- (Subscriber *)getSubscriber:(NSString *)subscriberId;


/**
 * Unsubscribes a device from push notifications
 *
 * @param subscriberId id of the subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString *)subscriberId;



/**
 * Links a funding bank account to Token and returns it to the caller.
 *
 * @param bankId bank id
 * @param payload account link authorization payload generated
 *                by the bank
 */
- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                          withPayload:(NSString *)payload;

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @return list of accounts
 */
- (NSArray<TKAccount *> *)getAccounts;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 * @return list of accounts
 */
- (TKAccount *)getAccount:(NSString *)accountId;

/**
 * Looks up account balance.
 *
 * @param accountId account id
 * @return account balance
 */
- (Money *)getBalance:(NSString *)accountId;

/**
 * Looks up an existing token transfer.
 *
 * @param transferId ID of the transfer record
 * @return transfer record
 */
- (Transfer *)getTransfer:(NSString *)transferId;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (NSArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                      limit:(int)limit;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (NSArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                      limit:(int)limit
                                    tokenId:(NSString *)tokenId;

/**
 * Creates a new member address.
 *
 * @param name the name of the address
 * @param address the address json
 * @return the address record created
 */
- (Address *)addAddressWithName:(NSString *)name
                       withData:(NSString *)data;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @return an address record
 */
- (Address *)getAddressWithId:(NSString *)addressId;

/**
 * Looks up member addresses.
 *
 * @return a list of addresses
 */
- (NSArray<Address *> *)getAddresses;

/**
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 */
- (void)deleteAddressWithId:(NSString *)addressId;

/**
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer token username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @return transfer token returned by the server
 */
- (Token *)createTransferToken:(NSString *)redeemerUsername
                    forAccount:(NSString *)accountId
                        amount:(double)amount
                      currency:(NSString *)currency;

/**
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer token username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer username
 * @param description transfer description, optional
 * @return transfer token returned by the server
 */
- (Token *)createTransferToken:(NSString *)redeemerUsername
                    forAccount:(NSString *)accountId
                        amount:(double)amount
                      currency:(NSString *)currency
                   description:(NSString *)description;

/**
 * Creates a new access token for a list of resources.
 *
 * @param toUsername the redeemer username
 * @param resources a list of resources to grant access to
 * @return the created access token
 */
- (Token *)createAccessToken:(NSString *)toUsername
                forResources:(NSArray<AccessBody_Resource *> *)resources;

/**
 * Creates a new access token for any addresses.
 *
 * @param toUsername the redeemer username
 * @return the created access token
 */
- (Token *)createAddressAccessToken:(NSString *)toUsername;

/**
 * Creates a new access token for a given address.
 *
 * @param toUsername the redeemer username
 * @param addressId address id
 * @return the created access token
 */
- (Token *)createAddressAccessToken:(NSString *)toUsername
                       restrictedTo:(NSString *)addressId;

/**
 * Creates a new access token for any account.
 *
 * @param toUsername the redeemer username
 * @return the created access token
 */
- (Token *)createAccountAccessToken:(NSString *)toUsername;

/**
 * Creates a new access token for a given account.
 *
 * @param toUsername the redeemer username
 * @param accountId account id
 * @return the created access token
 */
- (Token *)createAccountAccessToken:(NSString *)toUsername
                       restrictedTo:(NSString *)accountId;

/**
 * Creates a new access tokrn for transactions in any account.
 *
 * @param toUsername the redeemer username
 * @return the created access token
 */
- (Token *)createTransactionsAccessToken:(NSString *)toUsername;


/**
 * Creates a new access token for transactions in a given account.
 *
 * @param toUsername the redeemer username
 * @param accountId account id
 * @return the created access token
 */
- (Token *)createTransactionsAccessToken:(NSString *)toUsername
                            restrictedTo:(NSString *)accountId;

/**
 * Creates a new access token for balance of any account.
 *
 * @param toUsername the redeemer username
 * @return the created access token
 */
- (Token *)createBalanceAccessToken:(NSString *)toUsername;

/**
 * Creates a new access token for account balance.
 *
 * @param toUsername the redeemer username
 * @param accountId account id
 * @return the created access token
 */
- (Token *)createBalanceAccessToken:(NSString *)toUsername
                       restrictedTo:(NSString *)accountId;

/**
 * Looks up a existing token.
 *
 * @param tokenId token id
 * @return transfer token returned by the server
 */
- (Token *)getToken:(NSString *)tokenId;

/**
 * Looks up transfer tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return transfer tokens owned by the member
 */
- (NSArray<Token *> *)getTransferTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Looks up access tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return access tokens owned by the member
 */
- (NSArray<Token *> *)getAccessTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Endorses the transfer token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to endorse
 * @return endorsed token
 */
- (Token *)endorseToken:(Token *)token;

/**
 * Cancels the transfer token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to cancel
 * @return cancelled token
 */
- (Token *)cancelToken:(Token *)token;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @return transfer record
 */
- (Transfer *)createTransfer:(Token *)token;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param amount transfer amount
 * @param currency transfer currency code, e.g. "EUR"
 * @return transfer record
 */
- (Transfer *)createTransfer:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @return a looked up transaction
 */
- (Transaction *)getTransaction:(NSString *)transactionId
                     forAccount:(NSString *)accountId;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param accountId account id
 * @return a list of looked up transactions
 */
- (NSArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                            limit:(int)limit
                                       forAccount:(NSString *)accountId;

@end
