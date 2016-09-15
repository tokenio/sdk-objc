//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;
@class GatewayService;
@class TKSecretKey;


/**
 * An authenticated RPC client that is used to talk to Token gateway. The
 * class is a thin wrapper on top of gRPC generated client. Makes the API
 * easier to use.
 */
@interface TKClient : NSObject

/**
 * @param gateway gateway gRPC client
 * @param key secret key to use for authentication
 * @return newly created client
 */
- (id)initWithGateway:(GatewayService *)gateway
             memberId:(NSString *)memberId
            secretKey:(TKSecretKey *)key;

/**
 * Looks up member information for the current user. The user is defined by
 * the key used for authentication.
 *
 * @return member information
 */
- (void)getMember:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError;

@end