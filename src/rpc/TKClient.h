//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "gateway/Gateway.pbrpc.h"

#import "TKTypedef.h"
#import "TKCrypto.h"


@class Member;
@class GatewayService;
@class Token;
@class TokenPayload;
@class Transfer;
@class TransferPayload;
@class TKCrypto;
@class TKRpcErrorHandler;
@class Alias;


/**
 * An authenticated RPC client that is used to talk to Token gateway. The
 * class is a thin wrapper on top of gRPC generated client. Makes the API
 * easier to use.
 */
@interface TKClient : NSObject <NSCopying>

/**
 * @param gateway gateway gRPC client
 * @param crypto crypto module to use
 * @param timeoutMs gRPC timeout in ms
 * @param developerKey Token developer key
 * @param languageCode the SDK language code
 * @param errorHandler error handler to handle RPC errors
 * @return newly created client
 */
- (id)initWithGateway:(GatewayService *)gateway
               crypto:(TKCrypto *)crypto
            timeoutMs:(int)timeoutMs
         developerKey:(NSString *)developerKey
         languageCode:(NSString *)languageCode
             memberId:(NSString *)memberId
         errorHandler:(TKRpcErrorHandler *)errorHandler;

/**
 * Returns the cypto module
 */
- (TKCrypto *)getCrypto;

/**
 * Sets the On-Behalf-Of authentication value to be used
 * with this client. The value must correspond to an existing
 * Access Token ID issued for the client member.
 *
 * @param accessTokenId the access token id
 */
- (void)useAccessToken:(NSString *)accessTokenId;

/**
 * Looks up member information for the current user. The user is defined by
 * the key used for authentication.
 *
 * @param memberId member id
 */
- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError;

/**
 * Updates a Token member by adding/removing keys/aliases. The operations
 * are batched together and sent to the server.
 *
 * @param member member to update
 * @param operations set of operations that will mutate the member account
 * @param onSuccess invoked on success with member information
 */
- (void)updateMember:(Member *)member
          operations:(NSArray<MemberOperation *> *)operations
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError;

/**
 * Updates a Token member by adding/removing keys/aliases. The operations
 * are batched together and sent to the server.
 *
 * @param member member to update
 * @param operations set of operations that will mutate the member account
 * @param metadataArray set of metadataArray; only use in addAlias operation now
 * @param onSuccess invoked on success with member information
 */
- (void)updateMember:(Member *)member
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError;

/**
 * Delete the member.
 */
- (void)deleteMember:(Member *)member
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError;

/**
 * Get aliases array. It shall be called after create member and login
 *
 * @param onSuccess invoked on success with aliases array
 */
- (void)getAliases:(OnSuccessWithAliases)onSuccess
           onError:(OnError)onError;

/**
 * Resend alias verification message (email, text, etc.).
 *
 * @param memberId resend verification message for this memberId
 * @param alias resend verification message for this alias
 * @param onSuccess invoked on success with verification ID
 */
- (void)resendAliasVerification:(NSString *)memberId
                          alias:(Alias *) alias
                      onSuccess:(OnSuccessWithString)onSuccess
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
- (void)getNotifications:(NSString *)offset
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
 * @param subscriberId id of subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString *)subscriberId
                           onSuccess:(OnSuccess)onSuccess
                             onError:(OnError)onError;


/**
 * Links some funding bank accounts to Token.
 *
 * @param bankAuthorization bank authorization, generated by the bank
 */
- (void)linkAccounts:(BankAuthorization *)bankAuthorization
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Links some funding bank accounts to Token by access token.
 *
 * @param bankId bankId to link
 * @param accessToken bank access token, generated by the bank
 */
- (void)linkAccounts:(NSString *)bankId
         accessToken:(NSString *)accessToken
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Unlinks token accounts.
 *
 * @param accountIds account ids to unlink
 */
- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds
             onSuccess:(OnSuccess)onSuccess
               onError:(OnError)onError;

/**
 * Looks up linked member accounts.
 */
- (void)getAccounts:(OnSuccessWithAccounts)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a linked member account.
 */
- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithAccount)onSuccess
           onError:(OnError)onError;

/**
 * Looks up the member's default bank account.
 */
- (void)getDefaultAccount:(NSString *)defaultAccount
                onSuccess:(OnSuccessWithAccount)onSuccess
                  onError:(OnError)onError;

/**
 * Sets the member's default bank account.
 *
 * @param accountId the account to set as default
 * @param onSuccess invoked if the default set to the specified value
 */
- (void)setDefaultAccount:(NSString *)accountId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new transfer token.
 *
 * @param payload transfer token payload
 */
- (void)createTransferToken:(TokenPayload *)payload
                  onSuccess:(OnSuccessWithToken)onSuccess
             onAuthRequired:(OnAuthRequired)onAuthRequired
                    onError:(OnError)onError;

/**
 * Creates a new access token.
 *
 * @param payload access token payload
 */
- (void)createAccessToken:(TokenPayload *)payload
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

/**
 * Cancels the existing token and creates a replacement for it.
 * Supported only for access tokens.
 *
 * @param tokenToCancel old token to replace
 * @param tokenToCreate new token to create
 */
- (void)replaceToken:(Token *)tokenToCancel
       tokenToCreate:(TokenPayload *)tokenToCreate
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError;

/**
 * Cancels the existing token, creates a replacement, and endorses it.
 * Supported only for access tokens.
 *
 * @param tokenToCancel old token to replace
 * @param tokenToCreate new token to create
 */
- (void)replaceAndEndorseToken:(Token *)tokenToCancel
                 tokenToCreate:(TokenPayload *)tokenToCreate
                     onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                       onError:(OnError)onError;

/**
 * Looks up an existing token.
 *
 * @param tokenId token id
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
 * Looks up token owned by the member.
 *
 * @param type token type
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 */
- (void)getTokensOfType:(GetTokensRequest_Type)type
                 offset:(NSString *)offset
                  limit:(int)limit
              onSuccess:(OnSuccessWithTokens)onSuccess
                onError:(OnError)onError;

/**
 * Endorses a transfer token.
 *
 * @param token token to endorse
 * @param keyLevel specifies the key to use
 */
- (void)endorseToken:(Token *)token
             withKey:(Key_Level)keyLevel
           onSuccess:(OnSuccessWithTokenOperationResult)success
             onError:(OnError)error;

/**
 * Cancels a transfer token.
 *
 * @param token token to endorse
 */
- (void)cancelToken:(Token *)token
          onSuccess:(OnSuccessWithTokenOperationResult)success
            onError:(OnError)error;

/**
 * Redeems a transfer token.
 *
 * @param payload transfer payload
 */
- (void)redeemToken:(TransferPayload *)payload
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a token transfer by id.
 *
 * @param transferId transfer id
 */
- (void)getTransfer:(NSString *)transferId
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError;

/**
 * Looks up existing token transfers.
 *
 * @param offset offset to start at (NULL for none)
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                   tokenId:(NSString *)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up account balance.
 *
 * @param accountId account id
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success with account balance
 */
- (void)getBalance:(NSString *)accountId
           withKey:(Key_Level)keyLevel
         onSuccess:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError;

/**
 * Looks up account balances.
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
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param accountId ID of the account
 * @param transactionId ID of the transaction
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success with transaction record
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
 * @param accountId ID of the account
 * @param keyLevel specifies the key to use
 * @param onSuccess invoked on success with transaction record
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:accountId
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
 * @param onSuccess invoked on success with attachment
 */
- (void)createBlob:(NSString *)ownerId
          withType:(NSString *)type
          withName:(NSString *)name
          withData:(NSData * )data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError;

/**
 * Downloads a blob from the server.
 *
 * @param blobId id of the blob
 * @param onSuccess invoked on success with Blob
 */
- (void)getBlob:(NSString *)blobId
      onSuccess:(OnSuccessWithBlob)onSuccess
        onError:(OnError)onError;

/**
 * Downloads a blob from the server, attached to the given token.
 *
 * @param tokenId id of the token
 * @param blobId id of the blob
 * @param onSuccess invoked on success with Blob
 */
- (void)getTokenBlob:(NSString *)tokenId
          withBlobId:(NSString *)blobId
           onSuccess:(OnSuccessWithBlob)onSuccess
             onError:(OnError)onError;

/**
 * Creates a new member address
 *
 * @param address the address
 * @param name the name of the address
 * @param onSuccess invoked on success with an address record created
 */
- (void)addAddress:(Address *)address
          withName:(NSString *)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an address by id
 *
 * @param addressId the address id
 * @param onSuccess invoked on success with an address record
 */
- (void)getAddressById:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError;

/**
 * Looks up member addresses
 *
 * @param onSuccess invoked on success with a list of addresses
 */
- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

/**
 * Deletes a member address by its id
 *
 * @param addressId the id of the address
 */
- (void)deleteAddressById:(NSString *)addressId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

/**
 * Returns linking information for the specified bank id.
 *
 * @param bankId the bank id
 * @param onSuccess invoked on success with bank linking information
 */
- (void)getBankInfo:(NSString *) bankId
          onSuccess:(OnSuccessWithBankInfo)onSuccess
            onError:(OnError)onError;

/**
 * Creates a test fake bank account and returns a BankAuthorization to link.
 * Only works in test environments; doesn't work in production.
 */
- (void)createTestBankAccount:(Money *)balance
                    onSuccess:(OnSuccessWithOauthBankAuthorization)onSuccess
                      onError:(OnError)onError;

/**
 * Returns profile of a given member id
 *
 * @param ownerId member id
 * @param onSuccess invoked on success with profile in the server
 */
- (void)getProfile:(NSString *)ownerId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError;

/**
 * Set profile for the current user
 *
 * @param profile profile of current user
 * @param onSuccess invoked on success with profile in the server
 */
- (void)setProfile:(Profile *)profile
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError;

/**
 * Returns profile picture of a given member id and size
 *
 * @param ownerId onwer member id
 * @param size image size
 * @param onSuccess invoked on success with profile picture in the server
 */
- (void)getProfilePicture:(NSString *)ownerId
                     size:(ProfilePictureSize)size
                onSuccess:(OnSuccessWithBlob)onSuccess
                  onError:(OnError)onError;
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
 * @param tokenPayload transfer token payload
 * @param options map of options
 */
- (void)storeTokenRequest:(TokenPayload *)tokenPayload
                  options:(NSDictionary<NSString*, NSString*> *)options
                onSuccess:(OnSuccessWithString)onSuccess
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
- (void)addTrustedBeneficiary:(TrustedBeneficiary_Payload *)payload
                    onSuccess:(OnSuccess)onSuccess
                      onError:(OnError)onError;

/**
 * Removes a trusted beneficiary.
 */
-(void)removeTrustedBeneficiary:(TrustedBeneficiary_Payload *)payload
                      onSuccess:(OnSuccess)onSuccess
                        onError:(OnError)onError;

/**
 * Gets a list of all of the user's trusted beneficiaries.
 */
-(void)getTrustedBeneficiaries:(OnSuccessWithTrustedBeneficiaries)onSuccess
                       onError:(OnError)onError;

@end
