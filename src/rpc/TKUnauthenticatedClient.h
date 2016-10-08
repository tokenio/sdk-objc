//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GatewayService;
@class Member;
@class TKSecretKey;

/**
 * Similar to TKClient but is only used for a handful of requests that
 * don't require authentication. We use this client to create new member or
 * login an existing one and switch to the authenticated TKClient.
 */
@interface TKUnauthenticatedClient : NSObject

/**
 * @param gateway gRPC client
 * @return new unauthenticated client
 */
- (id)initWithGateway:(GatewayService *)gateway;

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
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)addFirstKey:(TKSecretKey *)key
          forMember:(NSString *)memberId
          onSuccess:(void(^)(Member*))onSuccess
            onError:(void(^)(NSError *))onError;

/**
 * Sends a notification to request linking of accounts
 *
 * @param alias alias to notify
 * @param bankId bank id to link
 * @param accountsLinkPayload payload retrieved from bank
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccounts:(NSString * )alias
                    bankId:(NSString *)bankId
       accountsLinkPayload:(NSString *) accountsLinkPayload
                 onSuccess:(void(^)())onSuccess
                   onError:(void(^)(NSError *))onError;
/**
 * Sends a notification to request adding of a key
 *
 * @param alias alias to notify
 * @param publicKey key in string form
 * @param tags optional list of tags for the key
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyAddKey:(NSString * )alias
                publicKey:(NSString *) publicKey
                tags:(NSMutableArray<NSString*> *)tags
                 onSuccess:(void(^)())onSuccess
                   onError:(void(^)(NSError *))onError;

/**
 * Sends a notification to request linking of accounts and adding of a key
 *
 * @param alias alias to notify
 * @param bankId bank id to link
 * @param accountsLinkPayload payload retrieved from bank
 * @param publicKey key in string form
 * @param tags optional list of tags for the key
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)notifyLinkAccountsAndAddKey:(NSString * )alias
              bankId:(NSString *)bankId
 accountsLinkPayload:(NSString *) accountsLinkPayload
           publicKey:(NSString *) publicKey
                tags:(NSMutableArray<NSString*> *)tags
           onSuccess:(void(^)())onSuccess
             onError:(void(^)(NSError *))onError;


@end
