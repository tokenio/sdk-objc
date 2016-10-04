//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


@class TKSecretKey;
@class Member;
@class TKClient;


/**
 * Represents a Member in the Token system. Each member has an active secret
 * and public key pair that is used to perform authentication.
 * 
 * <p>
 * The class provides async API with `TKMember` providing a synchronous version.
 * `TKMember` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TKMemberAsync : NSObject

@property (readonly, retain) TKMember *sync;
@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenIO` or `TokenIOAsync` to obtain an instance of this class.
 */
+ (TKMemberAsync *)member:(Member *)member
                secretKey:(TKSecretKey *)key
                useClient:(TKClient *)client;

/**
 * Approves a public key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKey:(TKSecretKey *)key
          onSucess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Approves a public key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approvePublicKey:(NSString *)publicKey
                onSucess:(OnSuccess)onSuccess
                 onError:(OnError)onError;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKey:(NSString *)keyId
         onSucess:(OnSuccess)onSuccess
          onError:(OnError)onError;

/**
 * Adds a new alias for the member.
 *
 * @param alias alias, e.g. 'john', must be unique
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAlias:(NSString *)alias
        onSucess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Removes an alias for the member.
 *
 * @param alias alias, e.g. 'john'
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAlias:(NSString *)alias
           onSucess:(OnSuccess)onSuccess
            onError:(OnError)onError;

/**
 * Links a funding bank account to Token and returns it to the caller.
 *
 * @param bankId bank id
 * @param payload account link authorization payload generated
 *                by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(NSString *)bankId
         withPayload:(NSData *)payload
            onSucess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError;

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
               onError:(OnError)onError;

/**
 * Looks up an existing token payment.
 *
 * @param paymentId ID of the payment record
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupPayment:(NSString *)paymentId
            onSuccess:(OnSuccessWithPayment)onSuccess
              onError:(OnError)onError;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                     tokenId:(NSString *)tokenId
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError;

/**
 * Creates a new member address.
 *
 * @param name the name of the address
 * @param address the address json
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createAddressName:(NSString *)name
                 withData:(NSString *)data
                onSuccess:(OnSuccessWithAddress)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupAddressWithId:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError;

/**
 * Looks up member addresses.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

/**
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)deleteAddressWithId:(NSString *)addressId
                 onSucess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Sets member preferences.
 *
 * @param preferences member json preferences
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)setPreferences:(NSString *)preferences
              onSucess:(OnSuccess)onSuccess
               onError:(OnError)onError;

/**
 * Looks up member preferences.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupPreferences:(OnSuccessWithPreferences)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTokenForAccount:(NSString *)accountId
                       amount:(double)amount
                     currency:(NSString *)currency
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer alias
 * @param description payment description, optional
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTokenForAccount:(NSString *)accountId
                       amount:(double)amount
                     currency:(NSString *)currency
                redeemerAlias:(NSString *)redeemerAlias
                  description:(NSString *)description
                     onSucess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

/**
 * Looks up a existing token.
 *
 * @param tokenId token id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupToken:(NSString *)tokenId
           onSucess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Looks up tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)lookupTokensOffset:(int)offset
                     limit:(int)limit
                 onSuccess:(OnSuccessWithTokens)onSuccess
                   onError:(OnError)onError;

/**
 * Endorses the token by signing it. The signature is persisted along
 * with the token.
 *
 * @param token token to endorse
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError;

/**
 * Declines the token by signing it. The signature is persisted along
 * with the token.
 *
 * @param token token to decline
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)declineToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError;

/**
 * Revokes the token by signing it. The signature is persisted along
 * with the token. Only applicable to endorsed tokens.
 *
 * @param token token to endorse
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)revokeToken:(Token *)token
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemToken:(Token *)token
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @param amount payment amount
 * @param currency payment currency code, e.g. "EUR"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemToken:(Token *)token
             amount:(NSNumber *)amount
           currency:(NSString *)currency
          onSuccess:(OnSuccessWithPayment)onSuccess
            onError:(OnError)onError;

@end
