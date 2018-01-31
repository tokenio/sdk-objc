//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccessTokenConfig.h"
#import "TransferTokenBuilder.h"
#import "TKTypedef.h"
#import "Alias.pbobjc.h"
#import "Subscriber.pbobjc.h"
#import "Security.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Blob.pbobjc.h"
#import "Token.pbobjc.h"
#import "Notification.pbobjc.h"
#import "PagedArray.h"
#import "Member.pbobjc.h"


@class Member;
@class TKClient;
@class TKMember;
@class Address;
@class AddressRecord;
@class AccessBody_Resource;
@class TransferEndpoint;


/**
 * Represents a Member in the Token system. Each member has an active secret
 * and public key pair that is used to perform authentication.
 *
 * <p>
 * The class provides synchronous API with `TKMember` providing a asynchronous
 * version. `TKMember` instance can be obtained by calling `async` method.
 * </p>
 */
@interface TKMemberSync : NSObject

/// Asynchronous API to member.
@property (readonly, retain) TKMember *async;

/// Member ID.
@property (readonly, retain) NSString *id;

/// Convenience access to aliases[0].
@property (readonly, retain) Alias *firstAlias;

/// Member's aliases: emails, etc. In UI, user normally refers to member by alias.
@property (readonly, retain) NSArray<Alias *> *aliases;

/// Crypto keys.
@property (readonly, retain) NSArray<Key *> *keys;

/**
 * Creates new member that is implemented by delegating all the calls to the
 * asynchonous implementation `TKMember`.
 */
+ (TKMemberSync *)member:(TKMember *)delegate;

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
 * Resend alias verification message (email, text, etc.).
 *
 * @param alias resend verification message for this alias
 * @return verification ID
 */
- (NSString *)resendAliasVerification:(Alias *)alias;

/**
 * Get all subscribers.
 *
 */
- (NSArray<Alias *> *)getAliases;

/**
 * Adds a new alias for the member.
 *
 * @param alias alias, e.g. Alias_Type_Email, 'john@example.com',
 *  must be unique
 */
- (void)addAlias:(Alias *)alias;

/**
 * Adds a new set of aliases for the member.
 *
 * @param aliases set of aliases
 */
- (void)addAliases:(NSArray<Alias *> *)aliases;

/**
 * Removes an alias from the member.
 *
 * @param alias alias, e.g. Alias_Type_Email, 'john@example.com'
 */
- (void)removeAlias:(Alias *)alias;

/**
 * Removes a set of aliases from the member.
 *
 * @param aliases set of aliases
 */
- (void)removeAliases:(NSArray<Alias *> *)aliases;

/**
 * Subscribes a device to receive push notifications.
 *
 * @param handler handler that will send the notifications to this subscriber
 * @param handlerInstructions instructions on how to send the notification
 */
- (Subscriber *)subscribeToNotifications:(NSString *)handler
                     handlerInstructions:(NSMutableDictionary<NSString *, NSString *> *)handlerInstructions;

/**
 * Get all subscribers.
 *
 */
- (NSArray<Subscriber *> *)getSubscribers;

/**
 * Get a subscriber by Id.
 *
 * @param subscriberId id of subscriber to get
 */
- (Subscriber *)getSubscriber:(NSString *)subscriberId;


/**
 * Get all notifications.
 
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 */
- (PagedArray<Notification *> *)getNotificationsOffset:(NSString *)offset
                                                 limit:(int)limit;

/**
 * Get a notification by Id.
 *
 * @param notificationId id of notification to get
 */
- (Notification *)getNotification:(NSString *)notificationId;


/**
 * Unsubscribes a device from push notifications.
 *
 * @param subscriberId id of the subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString *)subscriberId;


/**
 * Links a bank. The authorization browser will present and the accounts selected by user
 * will be linked.
 *
 * @param bankId bank Id
 */
- (NSArray<TKAccountSync *> *)linkBank:(NSString *)bankId;

/**
 * Links a set of funding bank accounts to Token and returns it to the caller.
 *
 * @param bankAuthorization bank authorization, generated by the bank
 */
- (NSArray<TKAccountSync *> *)linkAccounts:(BankAuthorization *)bankAuthorization;

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
- (NSArray<TKAccountSync *> *)getAccounts;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 * @return list of accounts
 */
- (TKAccountSync *)getAccount:(NSString *)accountId;

/**
 * Looks up a member's default bank account.
 *
 * @return account default account
 */
- (TKAccountSync *)getDefaultAccount;

/**
 * Sets the member's default bank account.
 *
 * @param accountId account id to set as default
 */
- (void)setDefaultAccount:(NSString *)accountId;

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
- (NSArray<TKBalance *> *)getBalances:(NSArray<NSString *> *)accountIds
                              withKey:(Key_Level)keyLevel;

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
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 */
- (PagedArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                         limit:(int)limit;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at (NULL for none)
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
 * Creates a new transfer token builder.
 *
 * @param amount lifetime amount of the token
 * @param currency currency code, e.g. "USD"
 * @return transfer token builder, can be executed to create a token
 */
- (TransferTokenBuilder *)createTransferToken:(double)amount
                                     currency:(NSString *)currency;

/** Creates a new access token for a list of resources.
 *
 * @param accessTokenConfig the access token configuration object
 * @return the created access token
 */
- (Token *)createAccessToken:(AccessTokenConfig *)accessTokenConfig;

/**
 * Cancels an existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (TokenOperationResult *)replaceAccessToken:(Token *)tokenToCancel
                           accessTokenConfig:(AccessTokenConfig *)accessTokenConfig;

/**
 * Cancels an existing access token, creates a replacement, and endorses it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (TokenOperationResult *)replaceAndEndorseAccessToken:(Token *)tokenToCancel
                                     accessTokenConfig:(AccessTokenConfig *)accessTokenConfig;

/**
 * Looks up an existing token.
 *
 * @param tokenId token id
 * @return transfer token returned by the server
 */
- (Token *)getToken:(NSString *)tokenId;

/**
 * Looks up transfer tokens owned by the member.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @return transfer tokens owned by the member
 */
- (PagedArray<Token *> *)getTransferTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Looks up access tokens owned by the member.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @return access tokens owned by the member
 */
- (PagedArray<Token *> *)getAccessTokensOffset:(NSString *)offset limit:(int)limit;

/**
 * Endorses the transfer token by signing it. The signature is persisted 
 * along with the token. If the member doesn't have a sufficiently
 * high-privilege key, this gets status TokenOperationResult_Status_MoreSignaturesNeeded
 * and the system pushes a notification to the member prompting them to use a
 * higher-privilege key.
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
- (Transfer *)redeemToken:(Token *)token;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param amount transfer amount
 * @param currency transfer currency code, e.g. "EUR"
 * @param description transfer description
 * @return transfer record
 */
- (Transfer *)redeemToken:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency
                 description:(NSString *)description;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param amount transfer amount
 * @param currency transfer currency code, e.g. "EUR"
 * @param description transfer description
 * @param destination transfer destination
 * @return transfer record
 */
- (Transfer *)redeemToken:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency
                 description:(NSString *)description
                 destination:(TransferEndpoint *)destination;

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

/**
 * Uploads a blob to the server.
 *
 * @param ownerId owner of the blob
 * @param type MIME type of the file
 * @param name name of the file
 * @param data binary data
 * @return attachment
 */
- (Attachment *)createBlob:(NSString *)ownerId
                  withType:(NSString *)type
                  withName:(NSString *)name
                  withData:(NSData * )data;

/**
 * Gets a blob.
 *
 * @param blobId Id of the blob.
 * @return Blob
 */
- (Blob *)getBlob:(NSString *)blobId;

/**
 * Gets a blob attached to a token.
 *
 * @param tokenId id of the token
 * @param blobId Id of the blob
 * @return Blob
 */
- (Blob *)getTokenBlob:(NSString *)tokenId
            withBlobId:(NSString *)blobId;

/**
 * Returns a list of token-enabled banks the member can link.
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

/**
 * Creates a fake test bank account; returns BankAuthorization for linking.
 * Only works in test environments, not in production.
 *
 * @param balance starting balance
 * @return bank authorization
 */
- (BankAuthorization *)createTestBankAccount:(Money *)balance;

/**
 * Returns profile for the given member id.
 *
 * @param ownerId member id of the member to lookup the profile for
 * @return profile
 */
- (Profile *)getProfile:(NSString *)ownerId;


/**
 * Updates caller profile.
 *
 * @param profile to set
 * @return updated profile
 */
- (Profile *)setProfile:(Profile *)profile;


/**
 * Returns profile picture of a given member id and size
 *
 * @param ownerId owner member id
 * @param size image size
 * @return profile picture Blob
 */
- (Blob *)getProfilePicture:(NSString *)ownerId
                     size:(ProfilePictureSize) size;
/**
 * Set profile picture for the current user
 *
 * @param ownerId owner of the picture
 * @param type MIME type of the file
 * @param name name of the file
 * @param data binary data
 */
- (void)setProfilePicture:(NSString *)ownerId
                 withType:(NSString *)type
                 withName:(NSString *)name
                 withData:(NSData *)data;

/**
 * Returns a list of paired devices for the current user
 *
 * @return list of paired devices
 */
- (NSArray<Device *> *)getPairedDevices;

/**
 * If more signatures is needed after endorsing a token, calls this method to notify
 * the user to endorse the token. We expect this to happen if user tried to endorse with a
 * low privilege key on another device.
 *
 * @param tokenId id of the token to endorse
 * @return notify status
 */
- (NotifyStatus)triggerStepUpNotification:(NSString *)tokenId;

/**
 * If more signatures is needed after getting balance, calls this method to notify
 * the user to renew the access. We expect this to happen if user tried to get balance with a
 * low privilege key on another device.
 *
 * @param accountId id of the account to get balance
 * @return notify status
 */
- (NotifyStatus)triggerBalanceStepUpNotification:(NSString *)accountId;
    
/**
 * If more signatures is needed after getting transaction, calls this method to notify
 * the user to renew the access. We expect this to happen if user tried to get transaction with a
 * low privilege key on another device.
 *
 * @param transactionId id of the transaction to get transaction
 * @param accountId the account id of transaction to get transaction
 * @return notify status
 */
- (NotifyStatus)triggerTransactionStepUpNotification:(NSString *)transactionId
                                           accountID:(NSString *)accountId;
    
@end
