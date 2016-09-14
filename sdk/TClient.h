//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member;
@class GatewayService;
@class TSecretKey;


@interface TClient : NSObject

- (id)initWithGateway:(GatewayService *)gateway secretKey:(TSecretKey *)key;

- (void)getMember:(NSString *)memberId
        onSuccess:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError;

@end