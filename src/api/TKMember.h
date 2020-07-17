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
#import "BulkTransferTokenBuilder.h"
#import "StandingOrderTokenBuilder.h"
#import "TKBrowser.h"
#import "TKRepresentable.h"
#import "TKTypedef.h"
#import "TokenCluster.h"
#import "TransferTokenBuilder.h"

NS_ASSUME_NONNULL_BEGIN
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
@property (readonly, retain) NSString * id;

/// Convenience access to aliases[0].
@property (readonly, retain) Alias * _Nullable firstAlias ;

/// Member's aliases: emails, etc. In UI, user normally refers to member by alias.
@property (readonly, retain) NSArray<Alias *> * _Nullable aliases;


/// Customized authorization browser creation block.
@property (readonly, retain) TKBrowserFactory _Nullable browserFactory;

/// Current token cluster
@property (readonly, retain) TokenCluster * tokenCluster;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenClient` to obtain an instance of this class.
 */
+ (TKMember *)member:(Member *)member
        tokenCluster:(TokenCluster *)tokenCluster
           useClient:(TKClient *)client
   useBrowserFactory:(TKBrowserFactory)browserFactory
             aliases:(NSMutableArray<Alias *> *) aliases;


- (TKClient *)getClient;

/**
 * Creates a representable that acts as another member using an access token.
 *
 * @param accessTokenId the access token id
 */
- (id<TKRepresentable>)forAccessToken:(NSString *)accessTokenId;

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
 * Verifies a given alias.
 *
 * @param verificationId the verification id
 * @param code the code
 */
- (void)verifyAlias:(NSString *)verificationId
               code:(NSString *)code
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
- (void)getNotificationsOffset:(NSString * _Nullable)offset
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
 * Updates the status of a notification.
 *
 * @param notificationId the notification id to update
 * @param status the status to update
 */
- (void)updateNotificationStatus:(NSString *)notificationId
                          status:(Notification_Status)status
                       onSuccess:(OnSuccess)onSuccess
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
 * Initiates the account linking process. The authorization browser will present and the accounts
 * selected by user will be linked.
 *
 * @param bankId bank Id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)initiateAccountLinking:(NSString *)bankId
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
- (void)linkAccounts:(NSString *)bankId
         accessToken:(NSString *)accessToken
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
                   tokenId:(NSString * _Nullable)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up an existing Token standing order submission.
 *
 * @param submissionId submission ID
 * @param onSuccess invoked on success with the standing order submission
 * @param onError invoked on error
 */
- (void)getStandingOrderSubmission:(NSString *)submissionId
                         onSuccess:(OnSuccessWithStandingOrderSubmission)onSuccess
                           onError:(OnError)onError;

/**
 * Looks up a list of existing standing order submissions.
 *
 * @param offset offset
 * @param limit limit
 * @param onSuccess invoked on success with standing order submissions
 * @param onError invoked on error
 */
- (void)getStandingOrderSubmissionsOffset:(NSString * _Nullable)offset
                                    limit:(int)limit
                                onSuccess:(OnSuccessWithStandingOrderSubmissions)onSuccess
                                  onError:(OnError)onError;

/**
 * Looks up an existing bulk transfer.
 *
 * @param bulkTransferId bulk transfer ID
 * @param onSuccess invoked on success with a bulk transfer record
 * @param onError invoked on error
*/
-(void)getBulkTransfer:(NSString *)bulkTransferId
             onSuccess:(OnSuccessWithBulkTransfer)onSuccess
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
- (TransferTokenBuilder *)createTransferTokenBuilder:(NSDecimalNumber *)amount
                                                     currency:(NSString *)currency;

/**
 * Creates a new transfer token builder from token request.
 *
 * @param tokenRequest token request
 * @return the transfer token builder
 */
- (TransferTokenBuilder *)createTransferTokenBuilderWithTokenRequest:(TokenRequest *)tokenRequest;

/**
 * Creates a new transfer token builder from token payload.
 *
 * @param tokenPayload token payload
 * @return the transfer token builder
 */
- (TransferTokenBuilder *)createTransferTokenBuilderWithTokenPayload:(TokenPayload *)tokenPayload;

/**
 * Creates a new transfer token builder.
 *
 * @param amount lifetime amount of the token
 * @param currency currency code, e.g. "USD"
 * @return the transfer token builder
 */
- (TransferTokenBuilder *)createTransferToken:(NSDecimalNumber *)amount currency:(NSString *)currency
__deprecated_msg("Use createTransferTokenBuilder instead");

/**
 * Creates a new transfer token builder from token request.
 *
 * @param tokenRequest token request
 * @return the transfer token builder
 */
- (TransferTokenBuilder *)createTransferToken:(TokenRequest *)tokenRequest
__deprecated_msg("Use createTransferTokenBuilderWithTokenRequest instead");

/**
 * Creates a new standing order token builder. Defines a standing order
 * for a fixed time span.
 *
 * @param amount individual transfer amount
 * @param currency currency code, e.g. "USD"
 * @param frequency ISO 20022 code for the frequency of the standing order:
 *                  DAIL, WEEK, TOWK, MNTH, TOMN, QUTR, SEMI, YEAR
 * @param startDate start date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
 * @param endDate end date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
 * @return standing order token builder
 */
- (StandingOrderTokenBuilder *)createStandingOrderTokenBuilder:(NSDecimalNumber *)amount
                                                      currency:(NSString *)currency
                                                     frequency:(NSString *)frequency
                                                     startDate:(NSString *)startDate
                                                       endDate:(NSString * _Nullable)endDate;

/**
 * Creates a new indefinite standing order token builder.
 *
 * @param amount individual transfer amount
 * @param currency currency code, e.g. "USD"
 * @param frequency ISO 20022 code for the frequency of the standing order:
 *                  DAIL, WEEK, TOWK, MNTH, TOMN, QUTR, SEMI, YEAR
 * @param startDate start date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
 * @return standing order token builder
 */
- (StandingOrderTokenBuilder *)createStandingOrderTokenBuilder:(NSDecimalNumber *)amount
                                                      currency:(NSString *)currency
                                                     frequency:(NSString *)frequency
                                                     startDate:(NSString *)startDate;

/**
 * Creates a new standing order token builder from a token request.
 *
 * @param tokenRequest token request
 * @return standing order token builder
 */
- (StandingOrderTokenBuilder *)createStandingOrderTokenBuilderWithTokenRequest:(TokenRequest *)tokenRequest;

/**
 * Creates a new bulk transfer token builder.
 *
 * @param transfers list of transfers
 * @param totalAmount total amount irrespective of currency. Used for redundancy check.
 * @param source source account for all transfer
 * @return bulk transfer token builder
 */
- (BulkTransferTokenBuilder *) createBulkTransferTokenBuilder:(NSArray<BulkTransferBody_Transfer *> *)transfers
                                                 totalAmount:(NSDecimalNumber *) totalAmount
                                                      source:(TransferEndpoint *)source;

/**
 * Creates a new bulk transfer token builder from a token request.
 *
 * @param tokenRequest token request
 * @return bulk transfer token builder
*/
- (BulkTransferTokenBuilder *) createBulkTransferTokenBuilder:(TokenRequest *)tokenRequest;

/**
 * Prepares a transfer token, returning the resolved token payload and policy.
 *
 * @param builder transfer token builder
 */
- (void)prepareTransferToken:(TransferTokenBuilder *)builder
                   onSuccess:(OnSuccessWithPrepareTokenResult)onSuccess
                     onError:(OnError)onError;

/**
 * Prepares a standing order token, returning the resolved token payload
 * and policy.
 *
 * @param builder standing order token builder
 */
- (void)prepareStandingOrderToken:(StandingOrderTokenBuilder *)builder
                        onSuccess:(OnSuccessWithPrepareTokenResult)onSuccess
                          onError:(OnError)onError;

/**
 * Prepares a bulk transfer token, returning the resolved token payload
 * and policy.
 *
 * @param builder bulk transfer token builder
 */
- (void)prepareBulkTransferToken:(BulkTransferTokenBuilder *)builder
                       onSuccess:(OnSuccessWithPrepareTokenResult)onSuccess
                         onError:(OnError)onError;

/**
 * Signs a token payload.
 *
 * @param tokenPayload token payload
 * @param keyLevel key level
 * @return token payload signature
 */
- (Signature * _Nullable)signTokenPayload:(TokenPayload *)tokenPayload
                       keyLevel:(Key_Level)keyLevel
                        onError:(OnError)onError;

/**
 * Creates a token directly from a resolved token payload and list of token signatures.
 *
 * @param tokenPayload token payload
 * @param tokenRequestId the token request id
 * @param signatures list of signatures
 */
- (void)createToken:(TokenPayload *)tokenPayload
     tokenRequestId:(NSString * _Nullable)tokenRequestId
         signatures:(NSArray<Signature *> *)signatures
          onSuccess:(OnSuccessWithToken)onSuccess
            onError:(OnError)onError;

/**
 * Creates a token directly from a resolved token payload and list of token signatures.
 *
 * @param tokenPayload token payload
 * @param tokenRequestId the token request id
 * @param keyLevel the key level
 */
- (void)createToken:(TokenPayload *)tokenPayload
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
- (void)createAccessToken:(AccessTokenBuilder *)accessTokenBuilder
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Cancels the existing access token and creates a replacement for it.
 *
 * @param tokenToCancel old token to cancel
 * @param accessTokenBuilder access token configuration to create a new token from
 */
- (void)replaceAccessToken:(Token *)tokenToCancel
        accessTokenBuilder:(AccessTokenBuilder *)accessTokenBuilder
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
 * Looks up a existing access token where the calling member is the grantor and the given
 * member is the grantee.
 *
 * @param toMemberId grantee of the active access token
 */
- (void)getActiveAccessToken:(NSString *)toMemberId
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
             amount:(NSDecimalNumber * _Nullable)amount
           currency:(NSString * _Nullable)currency
        description:(NSString * _Nullable)description
        destination:(TransferEndpoint * _Nullable)destination
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
- (void)redeemToken:(Token *)token
             amount:(NSDecimalNumber * _Nullable)amount
           currency:(NSString * _Nullable)currency
        description:(NSString * _Nullable)description
transferDestination:(TransferDestination * _Nullable)transferDestination
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError;

/**
 * Redeems a standing order token.
 *
 * @param tokenId ID of token to redeem
 */
- (void)redeemStandingOrderToken:(NSString *)tokenId
                       onSuccess:(OnSuccessWithStandingOrderSubmission)onSuccess
                         onError:(OnError)onError;

/**
 * Redeems a bulk transfer token.
 *
 * @param tokenId ID of token to redeem
 */
- (void)redeemBulkTransferToken:(NSString *)tokenId
                      onSuccess:(OnSuccessWithBulkTransfer)onSuccess
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
          withData:(NSData *)data
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
                    onSuccess:(OnSuccessWithOauthBankAuthorization)onSuccess
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

/**
 * Sign with a Token signature a token request state payload.
 *
 * @param tokenRequestId token request id
 * @param tokenId token id
 * @param state state
 */
- (void)signTokenRequestState:(NSString *)tokenRequestId
                      tokenId:(NSString *)tokenId
                        state:(NSString *)state
                    onSuccess:(OnSuccessWithSignature)onSuccess
                      onError:(OnError)onError;

/**
 * Stores a token request.
 *
 * @param requestPayload token request payload
 * @param requestOptions token request options
 */
- (void)storeTokenRequest:(TokenRequestPayload *)requestPayload
           requestOptions:(TokenRequestOptions *)requestOptions
                onSuccess:(OnSuccessWithString)onSuccess
                  onError:(OnError)onError;

/**
 * Updates an existing token request.
 *
 * @param requestId token request ID
 * @param options new token request options
 */
- (void)updateTokenRequest:(NSString *)requestId
                   options:(TokenRequestOptions *)options
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError;

/**
 * Replaces the member's receipt contact.
 *
 * @param receiptContact receipt contact to set
 */
- (void)setReceiptContact:(ReceiptContact *)receiptContact
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
- (void)addTrustedBeneficiary:(NSString *)memberId
                    onSuccess:(OnSuccess)onSuccess
                      onError:(OnError)onError;

/**
 * Removes a trusted beneficiary.
 */
- (void)removeTrustedBeneficiary:(NSString *)memberId
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
-(void)setSecurityMetadata:(SecurityMetadata *)securityMetadata;

/**
 * Sets the app callback url of a member.
 *
 * @param appCallbackUrl the app callback url
 */
-(void)setAppCallbackUrl:(NSString *)appCallbackUrl onSuccess:(OnSuccess)onSuccess onError:(OnError)onError;

/**
 * Resolves transfer destinations for the given account ID.
 *
 * @param accountId account ID
 */
-(void)resolveTransferDestinations:(NSString *)accountId
                         onSuccess:(OnSuccessWithTransferEndpoints)onSuccess
                           onError:(OnError)onError;
@end
NS_ASSUME_NONNULL_END
