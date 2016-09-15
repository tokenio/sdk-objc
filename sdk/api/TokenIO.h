//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIO_h
#define TokenIO_h


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;

@interface TokenIO : NSObject {}

+ (TokenIOBuilder *)builder;

- (id)initWithHost:(NSString *)host port:(int)port;

- (TKMember *)createMember;

- (void)createMemberAsync:(void(^)(TKMember *))onSuccess
                  onError:(void(^)(NSError *))onError;

- (TKMember *)loginMember:(NSString *)memberId
               secretKey:(TKSecretKey *)secretKey;

- (void)loginMemberAsync:(NSString *)memberId
               secretKey:(TKSecretKey *)key
                onSucess:(void(^)(TKMember *member))onSuccess
                 onError:(void(^)(NSError *))onError;

@end

#endif
