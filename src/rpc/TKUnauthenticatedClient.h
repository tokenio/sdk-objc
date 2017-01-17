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

/**
 * Similar to TKClient but is only used for a handful of requests that
 * don't require authentication. We use this client to create new member or
 * login an existing one and switch to the authenticated TKClient.
 */
@interface TKUnauthenticatedClient : NSObject

/**
 * @param gateway gRPC client
 * @param timeoutMs gRPC timeout in ms
 * @return new unauthenticated client
 */
- (id)initWithGateway:(GatewayService *)gateway
            timeoutMs:(int)timeoutMs;

/**
 * Creates new member ID. After the method returns the ID is reserved on
 * the server.
 *
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
               onError:(void(^)(NSError *))onError;


/**
 * Adds first key to be linked with the specified member id.
 *
 * @param memberId member id
 * @param crypto crypto module used to generate keys
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)createKeys:(NSString *)memberId
            crypto:(TKCrypto *)crypto
         onSuccess:(void (^)(Member *))onSuccess
           onError:(void(^)(NSError *))onError;

/**
 * Checks if a given username already exists.
 *
 * @param username username to check
 * @return true if username already exists, false otherwise
 */
- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError;

/**
 * Sends a notification to request linking of accounts
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountLinkPayloads payload retrieved from bank
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError;

/**
 * Sends a notification to request adding of a key
 *
 * @param username username to notify
 * @param keyName optional key name
 * @param publicKey key in string form
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyAddKey:(NSString *)username
             keyName:(NSString *)keyName
                 key:(Key *)key
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param username username to notify
 * @param bankId bank id to link
 * @param bankName bank name to link
 * @param accountLinkPayloads payloads retrieved from bank
 * @param key key in string form
 * @param keyName optional key name
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError;

@end
