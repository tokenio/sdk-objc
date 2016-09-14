//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GatewayService;
@class Member;
@class TSecretKey;

@interface TUnauthenticatedClient : NSObject

- (id)initWithGateway:(GatewayService *)gateway;

- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
             onError:(void(^)(NSError *))onError;

- (void)addFirstKey:(TSecretKey *)key
          forMember:(NSString *)memberId
       onSuccess:(void(^)(Member*))onSuccess
          onError:(void(^)(NSError *))onError;

@end