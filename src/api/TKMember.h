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
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

/**
 * Creates new member that is implemented by delegating all the calls to the
 * asynchonous implementation `TKMemberAsync`.
 */
+ (TKMember *)member:(TKMemberAsync *)delegate;

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
 * Adds a new alias for the member.
 *
 * @param alias alias, e.g. 'john', must be unique
 */
- (void)addAlias:(NSString *)alias;

/**
 * Removes an alias for the member.
 *
 * @param alias alias, e.g. 'john'
 */
- (void)removeAlias:(NSString *)alias;

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
- (NSArray<Transfer *> *)getTransfersOffset:(int)offset
                                      limit:(int)limit;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (NSArray<Transfer *> *)getTransfersOffset:(int)offset
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
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @return transfer token returned by the server
 */
- (Token *)createTokenForAccount:(NSString *)accountId
                                  amount:(double)amount
                                currency:(NSString *)currency;

/**
 * Creates a new transfer token.
 *
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer alias
 * @param description transfer description, optional
 * @return transfer token returned by the server
 */
- (Token *)createTokenForAccount:(NSString *)accountId
                                  amount:(double)amount
                                currency:(NSString *)currency
                           redeemerAlias:(NSString *)redeemerAlias
                             description:(NSString *)description;

/**
 * Looks up a existing transfer token.
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
- (NSArray<Token *> *)getTransferTokensOffset:(int)offset limit:(int)limit;

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

@end
