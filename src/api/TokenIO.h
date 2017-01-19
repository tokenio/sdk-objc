//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKTypedef.h"
#import "Security.pbobjc.h"

@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TokenIOAsync;


/**
 * Use this class to create to create a new member using `createMember`
 * method or login an existing member using `loginMember`.
 *
 * <p>
 * The class provides async API with `TokenIO` providing a synchronous version.
 * `TokenIO` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TokenIO : NSObject

@property (readonly, retain) TokenIOAsync *async;

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
- (id)initWithDelegate:(TokenIOAsync *)delegate;

/**
 * Checks if a given username already exists.
 *
 * @param username username to check
 * @return true if username already exists, false otherwise
 */
- (BOOL)usernameExists:(NSString *)username;

/**
 * Creates a new Token member with a set of auto generated keys and the
 * given username.
 *
 * @param username member username to use, must be unique
 * @return newly created member
 */
- (TKMember *)createMember:(NSString *)username;

/**
 * Generates a set of keys and returns it to the caller. This is typically
 * used on a second device that needs to be provisioned for an existing
 * member. The keys are then send to an existing device for approval.
 *
 * @param memberId member id to generate the keys for
 * @return generated keys
 */
- (NSArray<Key *> *)generateKeys:(NSString *)memberId;

/**
 * Logs in an existing member to the system.
 *
 * @param memberId member id
 * @return logged in member
 */
- (TKMember *)loginMember:(NSString *)memberId;

/**
 * Sends a notification to request linking of accounts
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountLinkPayloads linking payloads retrieved from bank
 */
- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads;

/**
 * Sends a notification to request adding of a key
 *
 * @param username username to notify
 * @param key key in string form
 * @param keyName optional name of key
 */
- (void)notifyAddKey:(NSString *)username
             keyName:(NSString *)keyName
                 key:(Key *)key;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountLinkPayloads payloads retrieved from bank
 * @param key key in string form
 * @param keyName optional name of key
 */
- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
                            keyName:(NSString *)keyName
                                key:(Key *)key;

@end
