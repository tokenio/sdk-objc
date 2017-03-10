//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccessTokenConfig.h"
#import "TKTypedef.h"
#import "Subscriber.pbobjc.h"
#import "Security.pbobjc.h"
#import "Token.pbobjc.h"
#import "Notification.pbobjc.h"
#import "PagedArray.h"


@class Member;
@class TKClient;
@class TKMemberAsync;
@class Address;
@class AddressRecord;
@class AccessBody_Resource;
@class Destination;


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
@property (readonly, retain) NSArray<Key*> *keys;

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
 * Approves a key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 */
- (void)approveKey:(Key *)key;

/**
 * Approves a set of keys owned by this member. The keys are added to the list
 * of valid keys for the member.
 *
 * @param keys to add to the approved list
 */
- (void)approveKeys:(NSArray<Key *> *)keys;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 */
- (void)removeKey:(NSString *)keyId;

/**
 * Removes a set of keys owned by this member.
 *
 * @param keyIds key IDs of the keys to remove
 */
- (void)removeKeys:(NSArray<NSString *> *)keyIds;

/**
 * Adds a new username for the member.
 *
 * @param username username, e.g. 'john', must be unique
 */
- (void)addUsername:(NSString *)username;

/**
 * Adds a new set of usernames for the member.
 *
 * @param usernames set of usernames
 */
- (void)addUsernames:(NSArray<NSString *> *)usernames;

/**
 * Removes an username for the member.
 *
 * @param username username, e.g. 'john'
 */
- (void)removeUsername:(NSString *)username;

/**
 * Removes a of usernames for the member.
 *
 * @param usernames set of usernames
 */
- (void)removeUsernames:(NSArray<NSString *> *)usernames;

/**
 * Subscribes a device to receive push notifications
 *
 * @param target target to send push to (push token)
 * @param platform target platform for notification (e.g. Platform_Ios)
 */
- (Subscriber *)subscribeToNotifications:(NSString *)target
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
 * Get all notifications
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (PagedArray<Notification *> *)getNotificationsOffset:(NSString *)offset
                                                 limit:(int)limit;

/**
 * Get a notification by Id
 *
 * @param notificationId id of notification to get
 */
- (Notification *)getNotification:(NSString *)notificationId;


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
 * @param payloads account link authorization payload generated
 *                by the bank
 */
- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                         withPayloads:(NSArray<SealedMessage*> *)payloads;

/**
 * Unlinks bank accounts previously linked via linkAccounts call.
 *
 * @param accountIds account ids to unlink
 */
- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds;

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
- (PagedArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                         limit:(int)limit;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (PagedArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                         limit:(int)limit
                                       tokenId:(NSString *)tokenId;

/**
 * Creates a new member address.
 *
 * @param address the address
 * @param name the name of the address
 * @return the address record created
 */
- (AddressRecord *)addAddress:(Address *)address
                     withName:(NSString *)name;

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
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer token username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer username
 * @param description transfer description, optional
 * @param destinations transfer destinations, optional
 * @return transfer token returned by the server
 */
- (Token *)createTransferToken:(NSString *)redeemerUsername
                    forAccount:(NSString *)accountId
                        amount:(double)amount
                      currency:(NSString *)currency
                   description:(NSString *)description
                  destinations:(NSArray<Destination *> *)destinations;

/**
 * Creates a new access token for a list of resources.
 *
 * @param accessTokenConfig the access token configuration object
 * @return the created access token
 */
- (Token *)createAccessToken:(AccessTokenConfig *)accessTokenConfig;

/**
 * Cancels the existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (TokenOperationResult *)replaceAccessToken:(Token *)tokenToCancel
                           accessTokenConfig:(AccessTokenConfig *)accessTokenConfig;

/**
 * Cancels the existing access token, creates a replacement and endorses it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (TokenOperationResult *)replaceAndEndorseAccessToken:(Token *)tokenToCancel
                                     accessTokenConfig:(AccessTokenConfig *)accessTokenConfig;

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
- (PagedArray<Token *> *)getTransferTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Looks up access tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return access tokens owned by the member
 */
- (PagedArray<Token *> *)getAccessTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Endorses the transfer token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to endorse
 * @param keyLevel key to use
 * @return result of the endorse operation
 */
- (TokenOperationResult *)endorseToken:(Token *)token withKey:(Key_Level)keyLevel;

/**
 * Cancels the transfer token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to cancel
 * @return result of the cancelled operation
 */
- (TokenOperationResult *)cancelToken:(Token *)token;

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
 * @param description transfer description
 * @return transfer record
 */
- (Transfer *)createTransfer:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency
                 description:(NSString *)description;

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
- (PagedArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                               limit:(int)limit
                                          forAccount:(NSString *)accountId;

/**
 * Returns a list of all token enabled banks.
 *
 * @return a list of banks
 */
- (NSArray<Bank *> *)getBanks;

/**
 * Returns linking information for the specified bank id.
 *
 * @param bankId the bank id
 * @return bank linking information
 */
- (BankInfo *)getBankInfo:(NSString *)bankId;

@end
