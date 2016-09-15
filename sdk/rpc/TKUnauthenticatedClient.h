//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GatewayService;
@class Member;
@class TKSecretKey;

@interface TKUnauthenticatedClient : NSObject

- (id)initWithGateway:(GatewayService *)gateway;

- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
             onError:(void(^)(NSError *))onError;

- (void)addFirstKey:(TKSecretKey *)key
          forMember:(NSString *)memberId
       onSuccess:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError;

@end