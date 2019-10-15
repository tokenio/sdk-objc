//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"
#import "TKCryptoEngineFactory.h"

@class GatewayService;
@class Member;
@class TKCrypto;
@class TKRpcErrorHandler;

/**
 * Similar to TKClient but is only used for a handful of requests that
 * don't require authentication. We use this client to create new member or
 * login an existing one and switch to the authenticated TKClient.
 */
@interface TKUnauthenticatedClient : NSObject

/**
 * @param gateway gRPC client
 * @param timeoutMs gRPC timeout in ms
 * @param developerKey Token developer key
 * @param languageCode the SDK language code
 * @param errorHandler error handler to handle RPC errors
 * @return new unauthenticated client
 */
- (id)initWithGateway:(GatewayService *)gateway
            timeoutMs:(int)timeoutMs
         developerKey:(NSString *)developerKey
         languageCode:(NSString *)languageCode
         errorHandler:(TKRpcErrorHandler *)errorHandler;

/**
 * Creates new member ID. After the method returns the ID is reserved on
 * the server.
 *
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
               onError:(OnError)onError;

/**
 * Looks up member id for a given alias.
 *
 * @param alias alias to check
 * @param onSuccess invoked if successful; return member id if alias already exists, nil otherwise
 */
- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError;

/**
 * Looks up token member for a given alias.
 * Set alias Alias_Type_Unknown if the alias type is unknown
 *
 * @param alias alias to check
 * @param onSuccess invoked if successful; return token member if alias already exists, nil otherwise
 */
- (void)getTokenMember:(Alias *)alias
             onSuccess:(OnSuccessWithTokenMember)onSuccess
               onError:(OnError)onError;

/**
 * Creates a new Token member.
 *
 * @param memberId member id
 * @param crypto crypto engine to use
 * @param operations a set of operations that setup member keys and/or aliases
 * @param onSuccess invoked if successful; return member information
 */
- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError;

/**
 * Creates a new Token member.
 *
 * @param memberId member id
 * @param crypto crypto engine to use
 * @param operations a set of operations that setup member keys and/or aliases
 * @param metadataArray set of metadataArray; only use in addAlias operation now
 * @param onSuccess invoked if successful; return member information
 */
- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
           metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError;

/**
 * Updates a Token member.
 *
 * @param memberId member id
 * @param crypto crypto engine to use
 * @param prevHash prevHash for update member request
 * @param operations a set of operations that setup member keys and/or aliases
 * @param metadataArray set of metadataArray; only use in addAlias operation now
 * @param reason the reason to update member
 * @param onSuccess invoked if successful; return member information
 */
- (void)updateMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
            prevHash:(NSString *)prevHash
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
              reason:(NSString *)reason
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError;

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
 * Returns a list of token enabled banks.
 *
 * @param bankIds If specified, return banks whose 'id' matches any one of the given ids
 * (case-insensitive). Can be at most 1000.
 * @param search If specified, return banks whose 'name' or 'identifier' contains the given
 * search string (case-insensitive)
 * @param country If specified, return banks whose 'country' matches the given ISO 3166-1 alpha-2
 * country code (case-insensitive)
 * @param page Result page to retrieve. Default to 1 if not specified.
 * @param perPage Maximum number of records per page. Can be at most 200. Default to 200
 * if not specified.
 * @param sort The key to sort the results. Could be one of: name, provider and country. Defaults
 * to name if not specified.
 * @param provider If specified, return banks whose 'provider' matches the provider
 * (case-insensitive)
 * @param bankFeatures If specified, return banks who meet the bank features requirement
 * @param onSuccess invoked on success with a list of banks
 */
- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
    bankFeatures:(BankFilter_BankFeatures *)bankFeatures
       onSuccess:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError;

/**
 * Returns a list of token enabled countries for banks.
 *
 * @param provider If specified, return banks whose 'provider' matches the provider
 * (case-insensitive)
 */
- (void)getBanksCountries:(NSString *)provider
                onSuccess:(OnSuccessWithStrings)onSuccess
                  onError:(OnError)onError;

/**
 * Sends a notification to request payment.  The from alias in tokenpayload will be notified.
 *
 * @param token payload of a token to be sent
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyPaymentRequest:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError;

/**
 * Sends a notification to request adding keys
 *
 * @param alias alias to notify
 * @param keys list of new keys to add
 * @param deviceMetadata device metadata of the keys. It will be shown in the pop up.
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyAddKey:(Alias *)alias
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError;

/**
 * Notifies subscribed devices that a token should be created and endorsed.
 *
 * @param tokenRequestId the token request ID to send
 * @param addKey the add key payload to be sent
 * @param contact receipt contact to send
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                               addkey:(AddKey *)addKey
                            contact:(ReceiptContact *)contact
                          onSuccess:(OnSuccessWithNotifyResult)onSuccess
                            onError:(OnError)onError;

/**
 * Invalidate a notification.
 *
 * @param notificationId notification id to invalidate
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)invalidateNotification:(NSString *)notificationId
                     onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                       onError:(OnError)onError;

/**
 * Get the token request result based on a token's tokenRequestId.
 *
 * @param tokenRequestId token request id
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)getTokenRequestResult:(NSString *)tokenRequestId
                    onSuccess:(OnSuccessWithTokenRequestResult)onSuccess
                      onError:(OnError)onError;

#pragma mark - Member Recovery

/**
 * Begins account recovery.
 *
 * @param alias the alias used to recover
 * @param onSuccess invoked if successful with verification Id
 * @param onError invoked if failed
 */
- (void)beginRecovery:(Alias *)alias
            onSuccess:(OnSuccessWithString)onSuccess
              onError:(OnError)onError;

/**
 * Create a recovery authorization for some agent to sign.
 *
 * @param memberId Id of member we claim to be.
 * @param privilegedKey new privileged key we want to use.
 * @param onSuccess invoked if successful with authorization structure for agent to sign
 * @param onError invoked if failed
 */
- (void)createRecoveryAuthorization:(NSString *)memberId
                                key:(Key *)privilegedKey
                          onSuccess:(OnSuccessWithMemberRecoveryOperationAuthorization)onSuccess
                            onError:(OnError)onError;

/**
 * Completes account recovery.
 *
 * @param memberId the member id
 * @param recoveryOperations the member recovery operations
 * @param privilegedKey the privileged public key in the member recovery operations
 * @param cryptoEngine the new crypto engine
 * @param onSuccess invoked if successful with member
 * @param onError invoked if failed
 */
- (void)completeRecovery:(NSString *)memberId
      recoveryOperations:(NSArray<MemberRecoveryOperation *> *)recoveryOperations
           privilegedKey:(Key *)privilegedKey
                  crypto:(TKCrypto *)crypto
               onSuccess:(OnSuccessWithMember)onSuccess
                 onError:(OnError)onError;

/**
 * Completes account recovery if the default recovery rule was set.
 *
 * @param memberId the member id
 * @param verificationId the verification id
 * @param code the code
 * @param cryptoEngine the new crypto engine
 * @param onSuccess invoked if successful with member
 * @param onError invoked if failed
 */
- (void)completeRecoveryWithDefaultRule:(NSString *)memberId
                         verificationId:(NSString *)verificationId
                                   code:(NSString *)code
                                 crypto:(TKCrypto *)crypto
                              onSuccess:(OnSuccessWithMember)onSuccess
                                onError:(OnError)onError;

/**
 * Gets recovery authorization from Token.
 *
 * @param verificationId the verification id
 * @param code the code
 * @param privilegedKey the privileged key
 * @param onSuccess invoked if successful with the recovery entry
 * @param onError invoked if failed
 */
- (void)getRecoveryAuthorization:(NSString *)verificationId
                            code:(NSString *)code
                   privilegedKey:(Key *)privilegedKey
                       onSuccess:(OnSuccessWithMemberRecoveryOperation)onSuccess
                         onError:(OnError)onError;
@end
