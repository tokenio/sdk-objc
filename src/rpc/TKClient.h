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


/**
 * An authenticated RPC client that is used to talk to Token gateway. The
 * class is a thin wrapper on top of gRPC generated client. Makes the API
 * easier to use.
 */
@interface TKClient : NSObject

/**
 * @param gateway gateway gRPC client
 * @param crypto crypto module to use
 * @param timeoutMs gRPC timeout in ms
 * @return newly created client
 */
- (id)initWithGateway:(GatewayService *)gateway
               crypto:(TKCrypto *)crypto
            timeoutMs:(int)timeoutMs
             memberId:(NSString *)memberId;

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
 * Looks up member information for the current user. The user is defined by
 * the key used for authentication.
 *
 * @return member information
 */
- (void)getMember:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError;

/**
 * Adds an      for a given user.
 *
 * @param member member to add the username to
 * @param username new unique username to add
 * @return member information
 */
- (void)addUsername:(NSString *)username
              to:(Member *)member
       onSuccess:(OnSuccessWithMember)onSuccess
         onError:(OnError)onError;


/**
 * Removes an username for a given user.
 *
 * @param member member to remove the username to
 * @param username username to remove
 * @return member information
 */
- (void)removeUsername:(NSString *)username
               from:(Member *)member
          onSuccess:(OnSuccessWithMember)onSuccess
            onError:(OnError)onError;

/**
 * Adds a public key to the list of approved keys for the specified member.
 *
 * @param key key to add
 * @param member member to add the key to
 * @param level key level
 */
- (void)addKey:(NSString *)newPublicKey
            to:(Member *)member
         level:(NSUInteger)level
     onSuccess:(OnSuccessWithMember)onSuccess
       onError:(OnError)onError;

/**
 * Removes a public key from the list of approved keys for the specified member.
 *
 * @param key key to remove
 * @param member member to remove the key for
 */
- (void)removeKey:(NSString *)keyId
             from:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError;

/**
 * Subscribes a device to receive push notifications
 *
 * @param target target to send push to (push token)
 * @param platform target platform for notification (e.g. Platform_Ios)
 */
- (void)subscribeToNotifications:(NSString *)target
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
 * Get all notifications
 *
 */
- (void)getNotifications:(OnSuccessWithNotifications)onSuccess
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
 * Links a funding bank account to Token.
 *
 * @param bankId bank id
 * @param accountLinkPayloads account link authorization payload generated
 *                           by the bank
 */
- (void)linkAccounts:(NSString *)bankId
        withPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
           onSuccess:(OnSuccessWithAccounts)onSuccess
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
 * Creates a new transfer token.
 *
 * @param payload transfer token payload
 */
- (void)createToken:(TokenPayload *)payload
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
 * Cancels the existing token, creates a replacement and endorses it.
 * Supported only for access tokens.
 *
 * @param tokenToCancel old token to replace
 * @param tokenToCreate new token to create
 * @param keyId key id used to sign the token
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
 * Looks up token owned by the member.
 *
 * @param type token type
 * @param offset offset to start at
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
 * @param transfer transfer parameters, such as amount, currency, etc
 */
- (void)createTransfer:(TransferPayload *)payload
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
 * @param offset offset to start at
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
 * @return account balance
 */
- (void)getBalance:(NSString *)accountId
         onSuccess:(OnSuccessWithMoney)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token transfer.
 *
 * @param accountId ID of the account
 * @param transactionId ID of the transaction
 * @return transaction record
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
 * @param accountId ID of the account
 * @return transaction record
 */
- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:accountId
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

/**
 * Creates a new member address
 *
 * @param data the address
 * @param name the name of the address
 * @return an address record created
 */
- (void)addAddress:(Address *)address
          withName:(NSString *)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an address by id
 *
 * @param addressId the address id
 * @return an address record
 */
- (void)getAddressById:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError;

/**
 * Looks up member addresses
 *
 * @return a list of addresses
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
 * Returns a list of all token enabled banks.
 *
 * @return a list of banks
 */
- (void)getBanks:(OnSuccessWithBanks)onSuccess
             onError:(OnError)onError;

/**
 * Returns linking information for the specified bank id.
 *
 * @param bankId the bank id
 * @return bank linking information
 */
- (void)getBankInfo:(NSString *) bankId
          onSuccess:(OnSuccessWithBankInfo)onSuccess
            onError:(OnError)onError;

@end
