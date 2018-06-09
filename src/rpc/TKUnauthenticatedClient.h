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
 * @param onSuccess invoked on success with a list of banks
 */
- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
       onSuccess:(OnSuccessWithBanks)onSuccess
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
 * Sends a notification to request linking of accounts
 *
 * @param alias alias to notify
 * @param authorization bank authorization, generated by the bank
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization
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
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param alias alias to notify
 * @param authorization bank authorization, generated by the bank
 * @param key key in string form
 * @param keyName optional key name
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError;

#pragma mark - Member Recovery

/**
 * Begins member account recovery process by contacting alias. The verification message will be sent if the alias is valid.
 *
 * @param alias alias to recover
 * @param onSuccess invoked if successful with verification Id
 * @param onError invoked if failed
 */
- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError;

/**
 * Gets member recovery Operation by the verification code. Update member with this operation to get the recovered member.
 *
 * @param verificationId verificationId from begin member recovery response
 * @param code code from verification message
 * @param key the new privileged key
 * @param onSuccess invoked if successful with member recovery operation
 * @param onError invoked if failed
 */
- (void)getMemberRecoveryOperation:(NSString *)verificationId
                              code:(NSString *)code
                     privilegedKey:(Key *)key
                         onSuccess:(OnSuccessWithMemberRecoveryOperation)onSuccess
                           onError:(OnError)onError;

/**
 * Recovers the alias with the recovered member.
 *
 * @param verificationId verificationId from begin member recovery response
 * @param code code from verification message
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)recoverAlias:(NSString *)verificationId
                code:(NSString *)code
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError;
@end
