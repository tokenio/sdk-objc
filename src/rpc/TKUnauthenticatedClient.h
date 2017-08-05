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
 * @param errorHandler error handler to handle RPC errors
 * @return new unauthenticated client
 */
- (id)initWithGateway:(GatewayService *)gateway
            timeoutMs:(int)timeoutMs
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
 * Looks up member id for a given username.
 *
 * @param username username to check
 */
- (void)getMemberId:(NSString *)username
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError;

/**
 * Creates a new Token member.
 *
 * @param memberId member id
 * @param crypto crypto engine to use
 * @param operations a set of operations that setup member keys and/or usernames
 */
- (void)createMember:(NSString *)memberId
                  crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
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
 * Sends a notification to request payment
 *
 * @param username username to notify
 * @param token payload of a token to be sent
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyPaymentRequest:(NSString *)username
                       token:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError;

/**
 * Sends a notification to request linking of accounts
 *
 * @param username username to notify
 * @param authorization bank authorization, generated by the bank
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccounts:(NSString *)username
             authorization:(BankAuthorization *)authorization
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError;

/**
 * Sends a notification to request adding of a key
 *
 * @param username username to notify
 * @param keyName optional key name
 * @param key key in string form
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
 * @param authorization bank authorization, generated by the bank
 * @param key key in string form
 * @param keyName optional key name
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError;

@end
