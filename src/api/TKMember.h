//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Address.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Blob.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Security.pbobjc.h"
#import "Subscriber.pbobjc.h"

#import "AccessTokenBuilder.h"
#import "TKBrowser.h"
#import "TKRepresentable.h"
#import "TKTypedef.h"
#import "TokenCluster.h"
#import "TransferTokenBuilder.h"

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
@interface TKMember : NSObject <TKRepresentable>

/// Member ID.
@property (readonly, retain) NSString * _Nonnull id;

/// Convenience access to aliases[0].
@property (readonly, retain) Alias * _Nonnull firstAlias ;

/// Member's aliases: emails, etc. In UI, user normally refers to member by alias.
@property (readonly, retain) NSArray<Alias *> * _Nonnull aliases;


/// Customized authorization browser creation block.
@property (readonly, retain) TKBrowserFactory _Nonnull browserFactory;

/// Current token cluster
@property (readonly, retain) TokenCluster * _Nonnull tokenCluster;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenClient` to obtain an instance of this class.
 */
+ (TKMember * _Nonnull)member:(Member * _Nonnull)member
        tokenCluster:(TokenCluster * _Nonnull)tokenCluster
           useClient:(TKClient * _Nonnull)client
   useBrowserFactory:(TKBrowserFactory _Nonnull)browserFactory
             aliases:(NSMutableArray<Alias *> * _Nonnull) aliases;


- (TKClient * _Nonnull)getClient;

/**
 * Creates a representable that acts as another member using an access token.
 *
 * @param accessTokenId the access token id
 */
- (id<TKRepresentable> _Nonnull)forAccessToken:(NSString * _Nonnull)accessTokenId;

/**
 * Gets public keys Array for the member.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getKeys:(OnSuccessWithKeys)onSuccess
        onError:(OnError)onError;

/**
 * Approves a key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKey:(Key * _Nonnull)key
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
- (void)approveKeys:(NSArray<Key *> * _Nonnull)keys
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKey:(NSString * _Nonnull)keyId
        onSuccess:(OnSuccess)onSuccess
          onError:(OnError)onError;

/**
 * Removes a set of keys owned by this member.
 *
 * @param keyIds key IDs of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKeys:(NSArray<NSString *> * _Nonnull)keyIds
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Removes all public keys that do not have a corresponding private key stored on
 * the current device from tke member.
 *
 */
- (void)removeNonStoredKeys:(OnSuccess)onSuccess
                    onError:(OnError)onError;

/**
 * Resend alias verification message (email, text, etc.).
 *
 * @param alias resend verification message for this alias
 * @param onSuccess invoked on success with verification ID
 */
- (void)resendAliasVerification:(Alias * _Nonnull)alias
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
- (void)addAlias:(Alias * _Nonnull)alias
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Adds a set of aliases for the member.
 *
 * @param aliases set of aliases
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAliases:(NSArray<Alias *> * _Nonnull)aliases
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Removes an alias for the member.
 *
 * @param alias alias, e.g. 'john'
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAlias:(Alias * _Nonnull)alias
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;

/**
 * Removes a set of aliases for the member.
 *
 * @param aliases set of aliases
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAliases:(NSArray<Alias *> * _Nonnull)aliases
            onSuccess:(OnSuccess)onSuccess
              onError:(OnError)onError;

/**
 * Verifies a given alias.
 *
 * @param verificationId the verification id
 * @param code the code
 */
- (void)verifyAlias:(NSString * _Nonnull)verificationId
               code:(NSString * _Nonnull)code
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;

/**
 * Delete the member.
 */
- (void)deleteMember:(OnSuccess)onSuccess
             onError:(OnError)onError;

/**
 * Subscribes a device to receive push notifications
 *
 * @param handler handler that will send the notifications to this subscriber
 * @param handlerInstructions instructions on how to send the notification
 */
- (void)subscribeToNotifications:(NSString * _Nonnull)handler
             handlerInstructions:(NSMutableDictionary<NSString *, NSString *> * _Nonnull)handlerInstructions
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
- (void)getSubscriber:(NSString * _Nonnull)subscriberId
            onSuccess:(OnSuccessWithSubscriber)onSuccess
              onError:(OnError)onError;

/**
 * Get all notifications
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 */
- (void)getNotificationsOffset:(NSString * _Nullable)offset
                         limit:(int)limit
                     onSuccess:(OnSuccessWithNotifications)onSuccess
                       onError:(OnError)onError;

/**
 * Get a notification by Id
 *
 * @param notificationId id of notification to get
 */
- (void)getNotification:(NSString * _Nonnull)notificationId
              onSuccess:(OnSuccessWithNotification)onSuccess
                onError:(OnError)onError;


/**
 * Unsubscribes a device from push notifications
 *
 * @param subscriberId if of subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString * _Nonnull)subscriberId
                           onSuccess:(OnSuccess)onSuccess
                             onError:(OnError)onError;

/**
 * Initiates the account linking process. The authorization browser will present and the accounts
 * selected by user will be linked.
 *
 * @param bankId bank Id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)initiateAccountLinking:(NSString * _Nonnull)bankId
                     onSuccess:(OnSuccessWithTKAccounts)onSuccess
                       onError:(OnError)onError;

/**
 * Links a set of funding bank accounts to Token and returns it to the caller.
 *
 * @param bankId bank ID to link
 * @param accessToken bank access token, generated by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(NSString * _Nonnull)bankId
         accessToken:(NSString * _Nonnull)accessToken
           onSuccess:(OnSuccessWithTKAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Links a set of funding bank accounts to Token and returns it to the caller.
 *
 * @param bankAuthorization bank authorization, generated by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(BankAuthorization * _Nonnull)bankAuthorization
           onSuccess:(OnSuccessWithTKAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Unlinks bank accounts previously linked via linkAccounts call.
 *
 * @param accountIds account ids to unlink
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)unlinkAccounts:(NSArray<NSString *> * _Nonnull)accountIds
             onSuccess:(OnSuccess)onSuccess
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
- (void)setDefaultAccount:(NSString * _Nonnull)accountId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up an existing token transfer.
 *
 * @param transferId ID of the transfer record
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getTransfer:(NSString * _Nonnull)transferId
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
- (void)getTransfersOffset:(NSString * _Nullable)offset
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
- (void)getTransfersOffset:(NSString * _Nullable)offset
                     limit:(int)limit
                   tokenId:(NSString * _Nonnull)tokenId
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
- (void)addAddress:(Address * _Nonnull)address
          withName:(NSString * _Nonnull)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError;

/**
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)deleteAddressWithId:(NSString * _Nonnull)addressId
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError;

/**
 * Creates a new transfer token builder.
 *
 * @param amount lifetime amount of the token
 * @param currency currency code, e.g. "USD"
 * @return the transfer token builder
 */
- (TransferTokenBuilder * _Nonnull)createTransferTokenBuilder:(NSDecimalNumber * _Nonnull)amount
                                                     currency:(NSString * _Nonnull)currency;

/**
 * Creates a new transfer token builder from token request.
 *
 * @param tokenRequest token request
 * @return the transfer token builder
 */
- (TransferTokenBuilder * _Nonnull)createTransferTokenBuilderWithTokenRequest:(TokenRequest * _Nonnull)tokenRequest;

/**
 * Creates a new transfer token builder from token payload.
 *
 * @param tokenPayload token payload
 * @return the transfer token builder
 */
- (TransferTokenBuilder * _Nonnull)createTransferTokenBuilderWithTokenPayload:(TokenPayload * _Nonnull)tokenPayload;

/**
 * Creates a new transfer token builder.
 *
 * @param amount lifetime amount of the token
 * @param currency currency code, e.g. "USD"
 * @return the transfer token builder
 */
- (TransferTokenBuilder * _Nonnull)createTransferToken:(NSDecimalNumber * _Nonnull)amount currency:(NSString * _Nonnull)currency
__deprecated_msg("Use createTransferTokenBuilder instead");

/**
 * Creates a new transfer token builder from token request.
 *
 * @param tokenRequest token request
 * @return the transfer token builder
 */
- (TransferTokenBuilder * _Nonnull)createTransferToken:(TokenRequest * _Nonnull)tokenRequest
__deprecated_msg("Use createTransferTokenBuilderWithTokenRequest instead");

/**
 * Prepares a transfer token, returning the resolved token payload and policy.
 *
 * @param builder transfer token builder
 */
- (void)prepareTransferToken:(TransferTokenBuilder * _Nonnull)builder
                   onSuccess:(OnSuccessWithPrepareTokenResult)onSuccess
                     onError:(OnError)onError;

/**
 * Signs a token payload.
 *
 * @param tokenPayload token payload
 * @param keyLevel key level
 * @return token payload signature
 */
- (Signature * _Nullable)signTokenPayload:(TokenPayload * _Nonnull)tokenPayload
                       keyLevel:(Key_Level)keyLevel
                        onError:(OnError)onError;

/**
 * Creates a token directly from a resolved token payload and list of token signatures.
 *
 * @param tokenPayload token payload
 * @param tokenRequestId the token request id
 * @param signatures list of signatures
 */
- (void)createToken:(TokenPayload * _Nonnull)tokenPayload
     tokenRequestId:(NSString * _Nullable)tokenRequestId
         signatures:(NSArray<Signature *> * _Nonnull)signatures
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Creates a token directly from a resolved token payload and list of token signatures.
 *
 * @param tokenPayload token payload
 * @param tokenRequestId the token request id
 * @param keyLevel the key level
 */
- (void)createToken:(TokenPayload * _Nonnull)tokenPayload
     tokenRequestId:(NSString * _Nullable)tokenRequestId
           keyLevel:(Key_Level)keyLevel
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Creates a new access token for a list of resources.
 *
 * @param accessTokenBuilder the access token configuration object
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createAccessToken:(AccessTokenBuilder * _Nonnull)accessTokenBuilder
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Cancels the existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenBuilder access token configuration to create a new token from
 */
- (void)replaceAccessToken:(Token * _Nonnull)tokenToCancel
        accessTokenBuilder:(AccessTokenBuilder * _Nonnull)accessTokenBuilder
                 onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up a existing transfer token.
 *
 * @param tokenId token id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getToken:(NSString * _Nonnull)tokenId
       onSuccess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError;

/**
 * Looks up a existing access token where the calling member is the grantor and the given
 * member is the grantee.
 *
 * @param toMemberId grantee of the active access token
 */
- (void)getActiveAccessToken:(NSString * _Nonnull)toMemberId
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
- (void)getTransferTokensOffset:(NSString * _Nullable)offset
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
- (void)getAccessTokensOffset:(NSString * _Nullable)offset
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
- (void)endorseToken:(Token * _Nonnull)token
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
- (void)cancelToken:(Token * _Nonnull)token
          onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
            onError:(OnError)onError;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemToken:(Token * _Nonnull)token
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
- (void)redeemToken:(Token * _Nonnull)token
             amount:(NSDecimalNumber * _Nonnull)amount
           currency:(NSString * _Nonnull)currency
        description:(NSString * _Nonnull)description
        destination:(TransferEndpoint * _Nonnull)destination
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError
__deprecated_msg("Use redeemToken:amount:currency:description:transferDestination:onSuccess:onError: instead");;

/**
 * Redeems a transfer token.
 *
 * @param token transfer token to redeem
 * @param amount transfer amount
 * @param currency transfer currency code, e.g. "EUR"
 * @param description transfer description
 * @param transferDestination transfer destination
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemToken:(Token * _Nonnull)token
             amount:(NSDecimalNumber * _Nonnull)amount
           currency:(NSString * _Nonnull)currency
        description:(NSString * _Nonnull)description
transferDestination:(TransferDestination * _Nonnull)destination
          onSuccess:(OnSuccessWithTransfer)onSuccess
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
- (void)createBlob:(NSString * _Nonnull)ownerId
          withType:(NSString * _Nonnull)type
          withName:(NSString * _Nonnull)name
          withData:(NSData * _Nonnull)data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError;

/**
 * Gets a blob.
 *
 * @param blobId id of the blob
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBlob:(NSString * _Nonnull)blobId
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
- (void)getTokenBlob:(NSString * _Nonnull)tokenId
          withBlobId:(NSString * _Nonnull)blobId
           onSuccess:(OnSuccessWithBlob)onSuccess
             onError:(OnError)onError;

/**
 * Returns linking information for the specified bank id.
 *
 * @param bankId the bank id
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getBankInfo:(NSString * _Nonnull)bankId
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
- (void)createTestBankAccount:(Money * _Nonnull)balance
                    onSuccess:(OnSuccessWithOauthBankAuthorization)onSuccess
                      onError:(OnError)onError;

/**
 * Returns profile for the given member id.
 *
 * @param ownerId of the member to lookup the profile for
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)getProfile:(NSString * _Nonnull) ownerId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError;


/**
 * Updates caller profile.
 *
 * @param profile to set
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)setProfile:(Profile * _Nonnull)profile
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
- (void)getProfilePicture:(NSString * _Nonnull)ownerId
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
- (void)setProfilePicture:(NSString * _Nonnull)ownerId
                 withType:(NSString * _Nonnull)type
                 withName:(NSString * _Nonnull)name
                 withData:(NSData * _Nonnull)data
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
- (void)triggerStepUpNotification:(NSString * _Nonnull)tokenId
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
- (void)triggerBalanceStepUpNotification:(NSArray<NSString *> * _Nonnull)accountIds
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
- (void)triggerTransactionStepUpNotification:(NSString * _Nonnull)transactionId
                                   accountID:(NSString * _Nonnull)accountId
                                   onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                     onError:(OnError)onError;

/**
 * To grant access to balances or transactions, a device will need to apply SCA with standard key.
 *
 * @param accountIds account ids for applying SCA
 */
- (void)ApplySca:(NSArray<NSString *> * _Nonnull)accountIds
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Sign with a Token signature a token request state payload.
 *
 * @param tokenRequestId token request id
 * @param tokenId token id
 * @param state state
 */
- (void)signTokenRequestState:(NSString * _Nonnull)tokenRequestId
                      tokenId:(NSString * _Nonnull)tokenId
                        state:(NSString * _Nonnull)state
                    onSuccess:(OnSuccessWithSignature)onSuccess
                      onError:(OnError)onError;

/**
 * Stores a token request.
 *
 * @param requestPayload token request payload
 * @param requestOptions token request options
 */
- (void)storeTokenRequest:(TokenRequestPayload * _Nonnull)requestPayload
           requestOptions:(TokenRequestOptions * _Nonnull)requestOptions
                onSuccess:(OnSuccessWithString)onSuccess
                  onError:(OnError)onError;

/**
 * Updates an existing token request.
 *
 * @param requestId token request ID
 * @param options new token request options
 */
- (void)updateTokenRequest:(NSString * _Nonnull)requestId
                   options:(TokenRequestOptions * _Nonnull)options
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError;

/**
 * Replaces the member's receipt contact.
 *
 * @param receiptContact receipt contact to set
 */
- (void)setReceiptContact:(ReceiptContact * _Nonnull)receiptContact
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Gets the member's receipt contact.
 */
- (void)getReceiptContact:(OnSuccessWithReceiptContact)onSuccess
                  onError:(OnError)onError;

/**
 * Marks a member as a trusted beneficiary.
 */
- (void)addTrustedBeneficiary:(NSString * _Nonnull)memberId
                    onSuccess:(OnSuccess)onSuccess
                      onError:(OnError)onError;

/**
 * Removes a trusted beneficiary.
 */
- (void)removeTrustedBeneficiary:(NSString * _Nonnull)memberId
                       onSuccess:(OnSuccess)onSuccess
                         onError:(OnError)onError;

/**
 * Gets a list of all the user's trusted beneficiaries.
 */
- (void)getTrustedBeneficiaries:(OnSuccessWithTrustedBeneficiaries)onSuccess
                        onError:(OnError)onError;

/**
 * Sets the security metadata to be sent with each request.
 *
 * @param securityMetadata the security metadata
 */
-(void)setSecurityMetadata:(SecurityMetadata * _Nonnull)securityMetadata;

/**
 * Sets the app callback url of a member.
 *
 * @param appCallbackUrl the app callback url
 */
-(void)setAppCallbackUrl:(NSString * _Nonnull)appCallbackUrl onSuccess:(OnSuccess)onSuccess onError:(OnError)onError;

/**
 * Resolves transfer destinations for the given account ID.
 *
 * @param accountId account ID
 */
-(void)resolveTransferDestinations:(NSString * _Nonnull)accountId
                         onSuccess:(OnSuccessWithTransferEndpoints)onSuccess
                           onError:(OnError)onError;
@end
