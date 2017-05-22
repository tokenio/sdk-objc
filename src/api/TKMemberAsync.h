//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccessTokenConfig.h"
#import "TKTypedef.h"
#import "Subscriber.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Security.pbobjc.h"


@class Member;
@class TKClient;
@class TKCrypto;
@class TransferEndpoint;

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
@property (readonly, retain) NSArray<Key*> *keys;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenIO` or `TokenIOAsync` to obtain an instance of this class.
 */
+ (TKMemberAsync *)member:(Member *)member
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
 * Approves a key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKey:(Key *)key
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Adds a set of keys owned by this member. The keys are added to the list
 * of valid keys for the member.
 *
 * @param keys to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKeys:(NSArray<Key *> *)keys
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
 * Removes a set of keys owned by this member.
 *
 * @param keyId key ID of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKeys:(NSArray<NSString *> *)keyIds
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
 * Adds a set of usernames for the member.
 *
 * @param usernames set of usernames
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addUsernames:(NSArray<NSString *> *)usernames
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
 * Removes a set of usernames for the member.
 *
 * @param usernames set of usernames
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeUsernames:(NSArray<NSString *> *)usernames
              onSuccess:(OnSuccess)onSuccess
                onError:(OnError)onError;

/**
 * Subscribes a device to receive push notifications
 *
 * @param handler handler that will send the notifications to this subscriber
 * @param handlerInstructions instructions on how to send the notification
 */
- (void)subscribeToNotifications:(NSString *)handler
             handlerInstructions:(NSMutableDictionary<NSString *, NSString *> *)handlerInstructions
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
 * Get all notifications
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (void)getNotificationsOffset:(NSString *)offset
                         limit:(int)limit
                     onSuccess:(OnSuccessWithNotifications)onSuccess
               onError:(OnError)onError;

/**
 * Get a notification by Id
 *
 * @param notificationId id of notification to get
 */
- (void)getNotification:(NSString *)notificationId
            onSuccess:(OnSuccessWithNotification)onSuccess
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
 * @param authorization bank authorization, generated by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(BankAuthorization *)bankAuthorization
           onSuccess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError;

/**
 * Unlinks bank accounts previously linked via linkAccounts call.
 *
 * @param accountIds account ids to unlink
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds
             onSuccess:(OnSuccess)onSuccess
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
 * Looks up account balance.
 *
 * @param accountId account id
 */
- (void)getBalance:(NSString *)accountId
         onSuccess:(OnSuccessWithMoney)onSuccess
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
- (void)addAddress:(Address *)address
          withName:(NSString *)name
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
 * Creates a new transfer token.
 *
 * @param redeemerUsername redeemer username
 * @param accountId the funding account id
 * @param amount transfer amount
 * @param currency currency code, e.g. "USD"
 * @param description transfer description, optional
 * @param destinations transfer destinations, optional
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransferToken:(NSString *)redeemerUsername
                 forAccount:(NSString *)accountId
                     amount:(double)amount
                   currency:(NSString *)currency
                description:(NSString *)description
                destinations:(NSArray<TransferEndpoint *> *)destinations
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
 * @param destinations transfer destinations, optional
 * @param to payee username, optional
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransferToken:(NSString *)redeemerUsername
                 forAccount:(NSString *)accountId
                     amount:(double)amount
                   currency:(NSString *)currency
                description:(NSString *)description
               destinations:(NSArray<TransferEndpoint *> *)destinations
                         to:(NSString *)to
                  onSuccess:(OnSuccessWithToken)onSuccess
                    onError:(OnError)onError;

/**
 * Creates a new access token for a list of resources.
 *
 * @param accessTokenConfig the access token configuration object
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 * @return the created access token
 */
- (void)createAccessToken:(AccessTokenConfig *)accessTokenConfig
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Cancels the existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (void)replaceAccessToken:(Token *)tokenToCancel
         accessTokenConfig:(AccessTokenConfig *)accessTokenConfig
                 onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                   onError:(OnError)onError;

/**
 * Cancels the existing access token, creates a replacement and endorses it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 * @return result of the replacement operation
 */
- (void)replaceAndEndorseAccessToken:(Token *)tokenToCancel
                   accessTokenConfig:(AccessTokenConfig *)accessTokenConfig
                           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
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
 * @param keyLevel key to use
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)endorseToken:(Token *)token
             withKey:(Key_Level)keyLevel
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
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
          onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
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
 * @param description transfer description
 * @param destination transfer destination
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createTransfer:(Token *)token
                amount:(NSNumber *)amount
              currency:(NSString *)currency
           description:(NSString *)description
           destination:(TransferEndpoint *)destination
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

/**
 * Returns a list of all token enabled banks.
 *
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBanks:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError;

/**
 * Returns linking information for the specified bank id.
 *
 * @param bankId the bank id
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBankInfo:(NSString *)bankId
          onSuccess:(OnSuccessWithBankInfo)onSuccess
            onError:(OnError)onError;

@end
