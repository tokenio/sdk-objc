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
@property (readonly, retain) NSString *firstUsername;
@property (readonly, retain) NSArray<NSString*> *usernames;
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
 * Sets the On-Behalf-Of authentication value to be used
 * with this client. The value must correspond to an existing
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
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKey:(TKSecretKey *)key
             level:(Key_Level)level
         onSuccess:(OnSuccess)onSuccess
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
                   level:(Key_Level)level
               onSuccess:(OnSuccess)onSuccess
                 onError:(OnError)onError;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKey:(NSString *)keyId
        onSuccess:(OnSuccess)onSuccess
          onError:(OnError)onError;

/**
 * Adds a new username for the member.
 *
 * @param username username, e.g. 'john', must be unique
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addUsername:(NSString *)username
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Removes an username for the member.
 *
 * @param username username, e.g. 'john'
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeUsername:(NSString *)username
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;


/**
 * Subscribes a device to receive push notifications
 *
 * @param provider push notification provider (default @"Token")
 * @param target target to send push to (push token)
 * @param platform target platform for notification (e.g. Platform_Ios)
 */
- (void)subscribeToNotifications:(NSString *)provider
                          target:(NSString *)target
                        platform:(Platform)platform
                       onSuccess:(OnSuccessWithSubscriber)onSuccess
                         onError:(OnError)onError;

/**
 * Get all subscribers 
 *
 */
- (void)getSubscribers:(OnSuccessWithSubscribers)onSuccess
               onError:(OnError)onError;

/**
 * Get a subscriber by Id
 *
 * @param subscriberId id of subscriber to get
 */
- (void)getSubscriber:(NSString *)subscriberId
            onSuccess:(OnSuccessWithSubscriber)onSuccess
              onError:(OnError)onError;

/**
 * Unsubscribes a device from push notifications
 *
 * @param subscriberId if of subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString *)subscriberId
                           onSuccess:(OnSuccess)onSuccess
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
         withPayload:(NSString *)payload
           onSuccess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError;

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 */
- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccountAsync)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing token transfer.
 *
 * @param transferId ID of the transfer record
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getTransfer:(NSString *)transferId
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                   tokenId:(NSString *)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError;

/**
 * Creates a new member address.
 *
 * @param name the name of the address
 * @param address the address json
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAddressWithName:(NSString *)name
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
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)deleteAddressWithId:(NSString *)addressId
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError;

/**
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer token username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransferToken:(NSString *)redeemerUsername
                 forAccount:(NSString *)accountId
                     amount:(double)amount
                   currency:(NSString *)currency
                  onSuccess:(OnSuccessWithToken)onSuccess
                    onError:(OnError)onError;

/**
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param description transfer description, optional
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransferToken:(NSString *)redeemerUsername
                    forAccount:(NSString *)accountId
                        amount:(double)amount
                      currency:(NSString *)currency
                   description:(NSString *)description
                    onSuccess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

/**
 * Creates a new access token for a list of resources.
 *
 * @param toUsername the redeemer username
 * @param resources a list of resources to grant access to
 * @return the created access token
 */
- (void)createAccessToken:(NSString *)toUsername
             forResources:(NSArray<AccessBody_Resource *> *)resources
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new access for an address.
 *
 * @param toUsername the redeemer username
 * @param addressId address id
 * @return the created access token
 */
- (void)createAccessToken:(NSString *)toUsername
               forAddress:(NSString *)addressId
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new access for an account.
 *
 * @param toUsername the redeemer username
 * @param accountId account id
 * @return the created access token
 */
- (void)createAccessToken:(NSString *)toUsername
               forAccount:(NSString *)accountId
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new access for a transaction.
 *
 * @param toUsername the redeemer username
 * @param accountId account id
 * @return the created access token
 */
- (void)createAccessToken:(NSString *)toUsername
   forAccountTransactions:(NSString *)accountId
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up a existing transfer token.
 *
 * @param tokenId token id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getToken:(NSString *)tokenId
       onSuccess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError;

/**
 * Looks up transfer tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getTransferTokensOffset:(NSString *)offset
                          limit:(int)limit
                      onSuccess:(OnSuccessWithTokens)onSuccess
                        onError:(OnError)onError;

/**
 * Looks up access tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAccessTokensOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTokens)onSuccess
                      onError:(OnError)onError;

/**
 * Endorses the transfer token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to endorse
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError;

/**
 * Cancels the transfer token by signing it. The signature is persisted
 * along with the token.
 *
 * @param token token to cancel
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)cancelToken:(Token *)token
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransfer:(Token *)token
             onSuccess:(OnSuccessWithTransfer)onSuccess
               onError:(OnError)onError;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param amount transfer amount
 * @param currency transfer currency code, e.g. "EUR"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransfer:(Token *)token
                amount:(NSNumber *)amount
              currency:(NSString *)currency
             onSuccess:(OnSuccessWithTransfer)onSuccess
               onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param transactionId ID of the transaction
 * @param accountId account id
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError;

/**
 * Looks up existing transactions. This is a full list of transactions with token transfers
 * being a subset.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param accountId account id
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

@end
