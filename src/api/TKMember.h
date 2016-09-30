//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


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
- (void)approveKey:(TKSecretKey *)key;

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
 * Links a funding bank account to Token and returns it to the caller.
 *
 * @param bankId bank id
 * @param payload account link authorization payload generated
 *                by the bank
 */
- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                          withPayload:(NSData *)payload;

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @return list of accounts
 */
- (NSArray<TKAccount *> *)lookupAccounts;

/**
 * Looks up an existing token payment.
 *
 * @param paymentId ID of the payment record
 * @return payment record
 */
- (Payment *)lookupPayment:(NSString *)paymentId;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit
                                     tokenId:(NSString *)tokenId;

/**
 * Creates a new member address.
 *
 * @param name the name of the address
 * @param address the address json
 * @return the address record created
 */
- (Address *)createAddressName:(NSString *)name
                      withData:(NSString *)data;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @return an address record
 */
- (Address *)lookupAddressWithId:(NSString *)addressId;

/**
 * Looks up member addresses.
 *
 * @return a list of addresses
 */
- (NSArray<Address *> *)lookupAddresses;

/**
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 */
- (void)deleteAddressWithId:(NSString *)addressId;

/**
 * Sets member preferences.
 *
 * @param preferences member json preferences
 */
- (void)setPreferences:(NSString *)preferences;

/**
 * Looks up member preferences.
 *
 * @return member preferences
 */
- (NSString *)lookupPreferences;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @return payment token returned by the server
 */
- (Token *)createTokenForAccount:(NSString *)accountId
                          amount:(double)amount
                        currency:(NSString *)currency;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer alias
 * @param description payment description, optional
 * @return payment token returned by the server
 */
- (Token *)createTokenForAccount:(NSString *)accountId
                          amount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description;

/**
 * Looks up a existing token.
 *
 * @param tokenId token id
 * @return payment token returned by the server
 */
- (Token *)lookupToken:(NSString *)tokenId;

/**
 * Looks up tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return payment tokens owned by the member
 */
- (NSArray<Token *> *)lookupTokensOffset:(int)i limit:(int)limit;

/**
 * Endorses the token by signing it. The signature is persisted along
 * with the token.
 *
 * @param token token to endorse
 * @return endorsed token
 */
- (Token *)endorseToken:(Token *)token;

/**
 * Declines the token by signing it. The signature is persisted along
 * with the token.
 *
 * @param token token to decline
 * @return declined token
 */
- (Token *)declineToken:(Token *)token;

/**
 * Revokes the token by signing it. The signature is persisted along
 * with the token. Only applicable to endorsed tokens.
 *
 * @param token token to endorse
 * @return endorsed token
 */
- (Token *)revokeToken:(Token *)token;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @return payment record
 */
- (Payment *)redeemToken:(Token *)token;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @param amount payment amount
 * @param currency payment currency code, e.g. "EUR"
 * @return payment record
 */
- (Payment *)redeemToken:(Token *)token
                  amount:(NSNumber *)amount
                currency:(NSString *)currency;

@end
