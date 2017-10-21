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

/**
 * Use this class to create to create a new member using `createMember`
 * method or login an existing member using `loginMember`.
 *
 * <p>
 * The class provides async API with `TokenIOSync` providing a synchronous version.
 * `TokenIO` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TokenIOSync : NSObject

@property (readonly, retain) TokenIO *async;

/**
 * Creates a new builder object that can be used to customize the `TokenIO`
 * instance being built.
 */
+ (TokenIOBuilder *)builder;

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
- (TKMemberSync *)loginMember:(NSString *)memberId;

/**
 * Sends a notification to request payment. The from alias in tokenpayload will be notified.
 *
 * @param token payload of a token to be sent
 */
- (void)notifyPaymentRequest:(TokenPayload *)token;

/**
 * Sends a notification to request linking of accounts
 *
 * @param alias alias to notify
 * @param authorization bank authorization, generated by the bank
 */
- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization;

/**
 * Sends a notification to request adding of a key
 *
 * @param alias alias to notify
 * @param key key in string form
 * @param keyName optional name of key
 */
- (void)notifyAddKey:(Alias *)alias
             keyName:(NSString *)keyName
                 key:(Key *)key;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param alias alias to notify
 * @param authorization bank authorization, generated by the bank
 * @param key key in string form
 * @param keyName optional name of key
 */
- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key;

#pragma mark - Recovery

/**
 * Begins recovery process for an alias. The verification message will be sent if the alias is valid.
 *
 * @param aliasValue alias value to recover
 */
- (void)beginRecovery:(NSString *)aliasValue;

/**
 * Verifies recovery code after beginRecovery is successful.
 *
 * @param code code from verification message
 * @return Boolean if the code is correct
 */
- (BOOL)verifyRecoveryCode:(NSString *)code;

/**
 * Completes recovery process after verifyRecoveryCode is successful.
 *
 * @return recovered member
 */
- (TKMemberSync *)completeRecovery;

@end
