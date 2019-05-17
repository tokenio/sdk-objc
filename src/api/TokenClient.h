//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIO_h
#define TokenIO_h

#import <objc/NSObject.h>

#import "Alias.pbobjc.h"

#import "TKBrowser.h"
#import "TKTypedef.h"
#import "TokenCluster.h"
#import "TKCrypto.h"

@class DeviceMetadata;
@class GatewayService;
@class Key;
@class TKMember;
@class TokenClientBuilder;
@class TokenPayload;

@protocol TKCryptoEngineFactory;

/**
 * Use this class to create a new member with `createMember`
 * method or use an existing member with `getMember`.
 *
 * <p>
 * The class provides async API 
 * </p>
 */
@interface TokenClient : NSObject

/**
 * Creates a new builder object that can be used to customize the `TokenClient`
 * instance being built.
 */
+ (TokenClientBuilder *)builder;

/**
 * Creates a new builder object with host, port, and useSsl set for the sandbox testing environment.
 */
+ (TokenClientBuilder *)sandboxBuilder;

/**
 * Creates a new instance that connects to the specified TokenCluster and port.
 *
 * @param tokenCluster TokenCluster to connect to
 * @param port gRPC port to connect to
 * @param timeout timeout value in ms
 * @param developerKey developer ID
 * @param languageCode the SDK language code
 * @param cryptoEngineFactory crypto module to use
 * @param useSsl use SSL if true
 * @param browserFactory use customized authorization browser if set
 * @param certsPath use custom certs; otherwise, use the default root certs
 * @param globalRpcErrorCallback global RPC error callback to invoke on error
 */
- (id)initWithTokenCluster:(TokenCluster *)tokenCluster
                      port:(int)port
                 timeoutMs:(int)timeout
              developerKey:(NSString *)developerKey
              languageCode:(NSString *)languageCode
                    crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory
            browserFactory:(TKBrowserFactory)browserFactory
                    useSsl:(BOOL)useSsl
                 certsPath:(NSString *)certsPath
    globalRpcErrorCallback:(OnError)globalRpcErrorCallback;

/**
 * Creates a new Token member with a pair of auto generated keys and the
 * given alias.
 *
 * @param alias member alias to use, must be unique
 */
- (void)createMember:(Alias *)alias
            onSuccess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError;

/**
 * Creates a new Token member with a pair of auto generated keys and the
 * given alias.
 *
 * @param alias member alias to use, must be unique
 * @param recoveryAgent member id of the primary recovery agent.
 */
- (void)createMember:(Alias *)alias
       recoveryAgent:(NSString *)recoveryAgent
           onSuccess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError;
/**
 * Provisions a new device for an existing user. The call generates a set
 * of keys that are returned back. The keys need to be approved by an
 * existing device/keys.
 *
 * @param alias member id to provision the device for
 */
- (void)provisionDevice:(Alias *)alias
              onSuccess:(OnSuccessWithDeviceInfo)onSuccess
                onError:(OnError)onError;

/**
 * Checks if a given alias already exists.
 *
 * @param alias alias to check
 */
- (void)aliasExists:(Alias *)alias
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError;

/**
 * Looks up member id for a given alias.
 *
 * @param alias alias to check
 */
- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError;

/**
 * Looks up token member for a given unknown alias.
 * Set alias Alias_Type_Unknown if the alias type is unknown
 *
 * @param alias alias to check
 * @param onSuccess invoked if successful; return token member if alias already exists, nil otherwise
 */
- (void)getTokenMember:(Alias *)alias
             onSuccess:(OnSuccessWithTokenMember)onSuccess
               onError:(OnError)onError;

/**
 * Gets a TKMember using already-stored keys.
 * ("Logs in" an existing member to the system.)
 *
 * @param memberId member id
 */
- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithTKMember)onSuccess
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
 * Returns a list of token enabled countries for banks.
 *
 * @param provider If specified, return banks whose 'provider' matches the provider
 * (case-insensitive)
 */
- (void)getBanksCountries:(NSString *)provider
                onSuccess:(OnSuccessWithStrings)onSuccess
                  onError:(OnError)onError;

/**
 * Sends a notification to request payment. The from alias in tokenpayload will be notified.
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
 * @param keys list of new keys to add
 * @param deviceMetadata device metadata of the keys; it will be shown in in the pop-up
 * @param contact receipt contact to send
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                               keys:(NSArray<Key *> *)keys
                     deviceMetadata:(DeviceMetadata *)deviceMetadata
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
 * @param crypto the new crypto
 * @param onSuccess invoked if successful with member
 * @param onError invoked if failed
 */
- (void)completeRecovery:(NSString *)memberId
      recoveryOperations:(NSArray<MemberRecoveryOperation *> *)recoveryOperations
           privilegedKey:(Key *)privilegedKey
                  crypto:(TKCrypto *)crypto
               onSuccess:(OnSuccessWithTKMember)onSuccess
                 onError:(OnError)onError;

/**
 * Completes account recovery if the default recovery rule was set.
 *
 * @param memberId the member id
 * @param verificationId the verification id
 * @param code the code
 * @param crypto the new crypto
 * @param onSuccess invoked if successful with member
 * @param onError invoked if failed
 */
- (void)completeRecoveryWithDefaultRule:(NSString *)memberId
                         verificationId:(NSString *)verificationId
                                   code:(NSString *)code
                                 crypto:(TKCrypto *)crypto
                              onSuccess:(OnSuccessWithTKMember)onSuccess
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

/**
 * Creates TKCrypto with member id.
 *
 * @param memberId the member id
 * @return TKCrypto
 */
- (TKCrypto *)createCrypto:(NSString *)memberId;
@end

#endif
