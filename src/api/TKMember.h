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
#import "Blob.pbobjc.h"
#import "Address.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "TransferTokenBuilder.h"
#import "TKBrowser.h"

@class Member;
@class TKClient;
@class TKCrypto;
@class TransferEndpoint;

/**
 * Represents a Member in the Token system. Each member has an active secret
 * and public key pair that is used to perform authentication.
 * 
 * <p>
 * The class provides async API
 * </p>
 */
@interface TKMember : NSObject

/// Member ID.
@property (readonly, retain) NSString *id;

/// Convenience access to aliases[0].
@property (readonly, retain) Alias *firstAlias;

/// Member's aliases: emails, etc. In UI, user normally refers to member by alias.
@property (readonly, retain) NSArray<Alias *> *aliases;

/// Crypto keys.
@property (readonly, retain) NSArray<Key *> *keys;

/// Customized authorization browser creation block.
@property (readonly, retain) TKBrowserFactory browserFactory;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenIO` or `TokenIOSync` to obtain an instance of this class.
 */
+ (TKMember *)member:(Member *)member
           useClient:(TKClient *)client
   useBrowserFactory:(TKBrowserFactory)browserFactory
             aliases:(NSMutableArray<Alias *> *) aliases_;


- (TKClient *)getClient;

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
 * @param keyIds key IDs of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKeys:(NSArray<NSString *> *)keyIds
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Resend alias verification message (email, text, etc.).
 *
 * @param alias resend verification message for this alias
 * @param onSuccess invoked on success with verification ID
 */
- (void)resendAliasVerification:(Alias *)alias
                      onSuccess:(OnSuccessWithString)onSuccess
                        onError:(OnError)onError;

/**
 * Gets aliases Array for the member.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAliases:(OnSuccessWithAliases)onSuccess
           onError:(OnError)onError;

/**
 * Adds a new alias for the member.
 *
 * @param alias alias, e.g. 'john', must be unique
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAlias:(Alias *)alias
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Adds a set of aliases for the member.
 *
 * @param aliases set of aliases
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAliases:(NSArray<Alias *> *)aliases
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Removes an alias for the member.
 *
 * @param alias alias, e.g. 'john'
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAlias:(Alias *)alias
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;

/**
 * Removes a set of aliases for the member.
 *
 * @param aliases set of aliases
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAliases:(NSArray<Alias *> *)aliases
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
 * @param offset offset to start at (NULL for none)
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
 * Links a bank. The authorization browser will present and the accounts selected by user
 * will be linked.
 *
 * @param bankId bank Id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkBank:(NSString *)bankId
       onSuccess:(OnSuccessWithTKAccounts)onSuccess
         onError:(OnError)onError;

/**
 * Links a set of funding bank accounts to Token and returns it to the caller.
 *
 * @param bankAuthorization bank authorization, generated by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(BankAuthorization *)bankAuthorization
           onSuccess:(OnSuccessWithTKAccounts)onSuccess
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
- (void)getAccounts:(OnSuccessWithTKAccounts)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 */
- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccount)onSuccess
           onError:(OnError)onError;


/**
 * Looks up a member's default account
 *
 */
- (void)getDefaultAccount:(OnSuccessWithTKAccount)onSuccess
                  onError:(OnError)onError;

/**
 * Updates member's default account
 *
 * @param accountId id of account to set to default
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)setDefaultAccount:(NSString *)accountId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up account balance with a specific key level.
 *
 * @param accountId account id
 * @param keyLevel specifies the key to use
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
 */
- (void)getBalances:(NSArray<NSString *> *)accountIds
            withKey:(Key_Level)keyLevel
          onSuccess:(OnSuccessWithTKBalances)onSuccess
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
 * @param offset offset to start at (NULL for none)
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
 * @param offset offset to start at (NULL for none)
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
 * Creates a new transfer token builder.
 *
 * @param amount lifetime amount of the token
 * @param currency currency code, e.g. "USD"
 * @return the transfer token builder
 */
- (TransferTokenBuilder *)createTransferToken:(double)amount
                                     currency:(NSString *)currency;

/**
 * Creates a new access token for a list of resources.
 *
 * @param accessTokenConfig the access token configuration object
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createAccessToken:(AccessTokenConfig *)accessTokenConfig
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Cancels the existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
 */
- (void)replaceAccessToken:(Token *)tokenToCancel
         accessTokenConfig:(AccessTokenConfig *)accessTokenConfig
                 onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                   onError:(OnError)onError;

/**
 * Cancels the existing access token, creates a replacement, and endorses it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenConfig access token configuration to create a new token from
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
 * @param offset offset to start at (NULL for none)
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
 * @param offset offset to start at (NULL for none)
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
 * along with the token. If the member doesn't have a sufficiently
 * high-privilege key, this gets status TokenOperationResult_Status_MoreSignaturesNeeded
 * and the system pushes a notification to the member prompting them to use a
 * higher-privilege key.
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
- (void)redeemToken:(Token *)token
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
- (void)redeemToken:(Token *)token
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
 * Uploads a blob to the server.
 *
 * @param ownerId owner of the blob
 * @param type MIME type of the file
 * @param name name of the file
 * @param data binary data
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)createBlob:(NSString *)ownerId
          withType:(NSString *)type
          withName:(NSString *)name
          withData:(NSData * )data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError;

/**
 * Gets a blob.
 *
 * @param blobId id of the blob
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBlob:(NSString *)blobId
      onSuccess:(OnSuccessWithBlob)onSuccess
        onError:(OnError)onError;

/**
 * Gets a blob attached to a token.
 *
 * @param tokenId id of the token
 * @param blobId id of the blob
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getTokenBlob:(NSString *)tokenId
          withBlobId:(NSString *)blobId
           onSuccess:(OnSuccessWithBlob)onSuccess
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

/**
 * Creates a fake test bank account, returns BankAuthorization for linking.
 * Only works in test environments, not in production.
 *
 * @param balance starting balance
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)createTestBankAccount:(Money *)balance
                    onSuccess:(OnSuccessWithBankAuthorization)onSuccess
                      onError:(OnError)onError;

/**
 * Returns profile for the given member id.
 *
 * @param ownerId of the member to lookup the profile for
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getProfile:(NSString *) ownerId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError;


/**
 * Updates caller profile.
 *
 * @param profile to set
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)setProfile:(Profile *)profile
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError;

/**
 * Returns profile picture of a given member id and size
 *
 * @param ownerId onwer member id
 * @param size image size
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getProfilePicture:(NSString *)ownerId
                     size:(ProfilePictureSize) size
                onSuccess:(OnSuccessWithBlob)onSuccess
                  onError:(OnError)onError;
/**
 * Set profile picture for the current user
 *
 * @param ownerId owner of the picture
 * @param type MIME type of the file
 * @param name name of the file
 * @param data binary data
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)setProfilePicture:(NSString *)ownerId
                 withType:(NSString *)type
                 withName:(NSString *)name
                 withData:(NSData *)data
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Returns a list of paired devices for the current user
 *
 * @param onSuccess invoked on success with a list of paired devices
 */
- (void)getPairedDevices:(OnSuccessWithPairedDevices)onSuccess
                 onError:(OnError)onError;

/**
 * If more signatures is needed after endorsing a token, calls this method to notify
 * the user to endorse the token. We expect this to happen if user tried to endorse with a
 * low privilege key on another device.
 *
 * @param tokenId id of the token to endorse
 * @param onSuccess invoked on success with notify status
 */
- (void)triggerStepUpNotification:(NSString *)tokenId
                        onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                          onError:(OnError)onError;
    
/**
 * If more signatures is needed after getting balance, calls this method to notify
 * the user to renew the access. We expect this to happen if user tried to get balance with a
 * low privilege key on another device.
 *
 * @param accountIds ids of the accounts to get balances
 * @param onSuccess invoked on success with notify status
 */
- (void)triggerBalanceStepUpNotification:(NSArray<NSString *> *)accountIds
                               onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                 onError:(OnError)onError;
    
/**
 * If more signatures is needed after getting transaction, calls this method to notify
 * the user to renew the access. We expect this to happen if user tried to get transaction with a
 * low privilege key on another device.
 *
 * @param transactionId id of the transaction to get transaction
 * @param accountId the account id of transaction to get transaction
 * @param onSuccess invoked on success with notify status
 */
- (void)triggerTransactionStepUpNotification:(NSString *)transactionId
                                   accountID:(NSString *)accountId
                                   onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                     onError:(OnError)onError;

/**
 * To grant access to balances or transactions, a device will need to apply SCA with standard key.
 *
 * @param accountIds account ids for applying SCA
 */
- (void)ApplySca:(NSArray<NSString *> *)accountIds
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;
@end
