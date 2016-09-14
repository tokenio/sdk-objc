//
//  Token.h
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenSdk_h
#define TokenSdk_h


@class GatewayService;
@class TSdkBuilder;
@class TMember;
@class TSecretKey;

@interface TSdk : NSObject {}

+ (TSdkBuilder *)builder;

- (id)initWithHost:(NSString *)host port:(int)port;

- (TMember *)createMember;

- (void)createMemberAsync:(void(^)(TMember *))onSuccess
                  onError:(void(^)(NSError *))onError;

- (TMember *)loginMember:(NSString *)memberId
               secretKey:(TSecretKey *)secretKey;

- (void)loginMemberAsync:(NSString *)memberId
               secretKey:(TSecretKey *)key
                onSucess:(void(^)(TMember *member))onSuccess
                 onError:(void(^)(NSError *))onError;

@end

#endif
