//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIOAsync_h
#define TokenIOAsync_h

#import <objc/NSObject.h>

#import "TKTypedef.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;
@class TokenIO;


/**
 * Use this class to create to create a new member using `createMember`
 * method or login an existing member using `loginMember`.
 *
 * <p>
 * The class provides async API with `TokenIO` providing a synchronous version.
 * `TokenIO` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TokenIOAsync : NSObject

@property (readonly, retain) TokenIO *sync;

/**
 * Creates a new builder object that can be used to customize the `TokenIOAsync`
 * instance being built.
 */
+ (TokenIOBuilder *)builder;

/**
 * Creates a new instance that connects to the specified Token host and port.
 */
- (id)initWithHost:(NSString *)host port:(int)port;

/**
 * Creates a new Token member with a pair of auto generated keys and the
 * given username.
 *
 * @param username member username to use, must be unique
 * @return newly created member
 */
- (void)createMember:(NSString *)username
            onSucess:(OnSuccessWithTKMemberAsync)onSuccess
             onError:(OnError)onError;

/**
 * Checks if a given username already exists.
 *
 * @param username username to check
 */
- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError;

/**
 * Logs in an existing member to the system.
 *
 * @param memberId member id
 * @param key secret/public key pair to use
 * @return logged in member
 */
- (void)loginMember:(NSString *)memberId
          secretKey:(TKSecretKey *)key
           onSucess:(OnSuccessWithTKMemberAsync)onSuccess
            onError:(OnError)onError;

/**
 * Sends a notification to request linking of accounts
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountsLinkPayload payload retrieved from bank
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountsLinkPayload:(NSString *)accountsLinkPayload
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError;

/**
 * Sends a notification to request adding of a key
 *
 * @param username username to notify
 * @param publicKey key in string form
 * @param name optional name of key
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyAddKey:(NSString *)username
           publicKey:(NSString *)publicKey
                name:(NSString *)name
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountsLinkPayload payload retrieved from bank
 * @param publicKey key in string form
 * @param name name of key
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountsLinkPayload:(NSString *)accountsLinkPayload
                          publicKey:(NSString *)publicKey
                               name:(NSString *)name
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError;


@end

#endif
