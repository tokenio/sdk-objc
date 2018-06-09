//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIO_h
#define TokenIO_h

#import "Alias.pbobjc.h"
#import <objc/NSObject.h>
#import "TKTypedef.h"
#import "TKBrowser.h"
#import "TokenCluster.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMemberSync;
@class TokenIOSync;
@protocol TKCryptoEngineFactory;
@class TokenPayload;
@class Key;
@class DeviceMetadata;

/**
 * Use this class to create a new member with `createMember`
 * method or use an existing member with `getMember`.
 *
 * <p>
 * The class provides async API 
 * </p>
 */
@interface TokenIO : NSObject

/**
 * Creates a new builder object that can be used to customize the `TokenIOAsync`
 * instance being built.
 */
+ (TokenIOBuilder *)builder;

/**
 * Creates a new builder object with host, port, and useSsl set for the sandbox testing environment.
 */
+ (TokenIOBuilder *)sandboxBuilder;

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
 * @param onSuccess invoked on success with a list of banks
 */
- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
       onSuccess:(OnSuccessWithBanks)onSuccess
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
 * @param keyName name of key
 * @param key the key
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
 * Begins member account recovery process by contacting alias. The verification message will
 * be sent if the alias is valid. All the member recovery methods shall be called by the same
 * TokenIO instance.
 *
 * @param alias alias to recover
 * @param onSuccess invoked if successful with verification Id
 * @param onError invoked if failed
 */

- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError;

/**
 * Verifies member recovery code after beginMemberRecovery is successful. All the member recovery
 * methods shall be called by the same TokenIO instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code
                   onSuccess:(OnSuccessWithBoolean)onSuccess
                     onError:(OnError)onError;

/**
 * Completes member recovery process after verifyMemberRecoveryCode is successful. Uploads member's
 * public keys from this device to Token directory. All the member recovery methods shall be called
 * by the same TokenIO instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 * @param onSuccess invoked if successful with TkMember
 * @param onError invoked if failed
 */
- (void)completeMemberRecovery:(Alias *)alias
                      memberId:(NSString *)memberId
                verificationId:(NSString *)verificationId
                          code:(NSString *)code
                     onSuccess:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError;

@end

#endif
