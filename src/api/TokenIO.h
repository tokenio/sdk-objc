//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKTypedef.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;
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
 * Checks if a given alias already exists.
 *
 * @param alias alias to check
 * @return true if alias already exists, false otherwise
 */
- (BOOL)aliasExists:(NSString *)alias;

/**
 * Creates a new Token member with a pair of auto generated keys and the
 * given alias.
 *
 * @param alias member alias to use, must be unique
 * @return newly created member
 */
- (TKMember *)createMember:(NSString *)alias;

/**
 * Logs in an existing member to the system.
 *
 * @param memberId member id
 * @param key secret/public key pair to use
 * @return logged in member
 */
- (TKMember *)loginMember:(NSString *)memberId secretKey:(TKSecretKey *)secretKey;

/**
 * Sends a notification to request linking of accounts
 *
 * @param alias alias to notify
 * @param bankId bank id to link
 * @param accountsLinkPayload payload retrieved from bank
 */
- (void)notifyLinkAccounts:(NSString * )alias
                    bankId:(NSString *)bankId
       accountsLinkPayload:(NSString *) accountsLinkPayload;

/**
 * Sends a notification to request adding of a key
 *
 * @param alias alias to notify
 * @param publicKey key in string form
 * @param name optional name of key
 */
- (void)notifyAddKey:(NSString * )alias
           publicKey:(NSString *)publicKey
                name:(NSString *)name;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param alias alias to notify
 * @param bankId bank id to link
 * @param accountsLinkPayload payload retrieved from bank
 * @param publicKey key in string form
 * @param name optional name of key
 */
- (void)notifyLinkAccountsAndAddKey:(NSString * )alias
                             bankId:(NSString *)bankId
                accountsLinkPayload:(NSString *) accountsLinkPayload
                          publicKey:(NSString *)publicKey
                               name:(NSString *)name;




@end
