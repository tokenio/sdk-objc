//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKTypedef.h"
#import "Alias.pbobjc.h"
#import "Security.pbobjc.h"

@class GatewayService;
@class TokenIOBuilder;
@class TKMemberSync;
@class TokenIO;
@class DeviceInfo;
@class TokenPayload;
@class DeviceMetadata;

/**
 * Use this class to create a new member with `createMember`
 * method or use an existing member with `getMember`.
 *
 * <p>
 * The class provides async API with `TokenIOSync` providing a synchronous version.
 * `TokenIO` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TokenIOSync : NSObject

/// Asynchronous API.
@property (readonly, retain) TokenIO *async;

/**
 * Creates a new builder object that can be used to customize the `TokenIO`
 * instance being built.
 */
+ (TokenIOBuilder *)builder;

/**
 * Creates a new builder object with host, port, and useSsl set for the sandbox testing environment.
 */
+ (TokenIOBuilder *)sandboxBuilder;

/**
 * Creates a new instance that connects to the specified Token host and port.
 * The instance is backed by the async implementation that it delegates all
 * the calls to.
 */
- (id)initWithDelegate:(TokenIO *)delegate;

/**
 * Checks if a given alias already exists.
 *
 * @param alias alias to check
 * @return true if alias already exists, false otherwise
 */
- (BOOL)aliasExists:(Alias *)alias;

/**
 * Looks up member id for a given alias.
 *
 * @param alias alias to check
 * @return member id if alias exists, nil otherwise
 */
- (NSString *)getMemberId:(Alias *)alias;

/**
 * Looks up token member for a given alias.
 * Set alias Alias_Type_Unknown if the alias type is unknown
 *
 * @param alias alias to check
 * @return token member if alias exists, nil otherwise
 */
- (TokenMember *)getTokenMember:(Alias *)alias;

/**
 * Creates a new Token member with a set of auto generated keys and the
 * given alias.
 *
 * @param alias member alias to use, must be unique
 * @return newly created member
 */
- (TKMemberSync *)createMember:(Alias *)alias;

/**
 * Provisions a new device for an existing user. The call generates a set
 * of keys that are returned back. The keys need to be approved by an
 * existing device/keys.
 *
 * @param alias member id to provision the device for
 * @return device information
 */
- (DeviceInfo *)provisionDevice:(Alias *)alias;

/**
 * Logs in an existing member to the system.
 *
 * @param memberId member id
 * @return logged in member
 */
- (TKMemberSync *)getMember:(NSString *)memberId;

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
 * @return a list of banks
 */
- (NSArray<Bank *> *)getBanks:(NSArray<NSString *> *)bankIds
                       search:(NSString *)search
                      country:(NSString *)country
                         page:(int)page
                      perPage:(int)perPage
                         sort:(NSString *)sort
                     provider:(NSString *)provider;

/**
 * Sends a notification to request payment. The from alias in tokenpayload will be notified.
 *
 * @param token payload of a token to be sent
 */
- (void)notifyPaymentRequest:(TokenPayload *)token;

/**
 * Sends a notification to request adding keys
 *
 * @param alias alias to notify
 * @param keys list of new keys to add
 * @param deviceMetadata device metadata of the keys. It will be shown in the pop up.
 */
- (void)notifyAddKey:(Alias *)alias
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata;

/**
 * Notifies subscribed devices that a token should be created and endorsed.
 *
 * @param tokenRequestId the token request ID to send
 * @param keys list of new keys to add
 * @param deviceMetadata device metadata of the keys; it will be shown in in the pop-up
 * @param contact receipt contact to send
 */
- (NotifyResult *)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                                         keys:(NSArray<Key *> *)keys
                               deviceMetadata:(DeviceMetadata *)deviceMetadata
                                      contact:(ReceiptContact *)contact;

/**
 * Invalidate a notification.
 *
 * @param notificationId notification id to invalidate
 * @return notify status
 */
- (NotifyStatus)invalidateNotification:(NSString *)notificationId
                             onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                               onError:(OnError)onError;

/**
 * Get the token request result based on a token's tokenRequestId.
 *
 * @param tokenRequestId token request id
 * @return token request result
 */
- (TokenRequestResult *)getTokenRequestResult:(NSString *)tokenRequestId;

#pragma mark - Member Recovery

/**
 * Begins member account recovery process by contacting alias. The verification message will
 * be sent if the alias is valid. All the member recovery methods shall be called by the same
 * TokenIOSync instance.
 *
 * @param alias alias to recover
 * @return verificationId for the recovery process
 */
- (NSString* )beginMemberRecovery:(Alias *)alias;

/**
 * Verifies member recovery code after beginMemberRecovery is successful. All the member recovery
 * methods shall be called by the same TokenIOSync instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 */
- (void)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code;

/**
 * Completes member recovery process after verifyMemberRecoveryCode is successful. Uploads member's
 * public keys from this device to Token directory. All the member recovery methods shall be called
 * by the same TokenIO instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 */
- (TKMemberSync *)completeMemberRecovery:(Alias *)alias
                                memberId:(NSString *)memberId
                          verificationId:(NSString *)verificationId
                                    code:(NSString *)code;

@end
