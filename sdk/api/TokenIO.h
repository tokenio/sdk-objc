//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIO_h
#define TokenIO_h

#import "TKTypedef.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;


@interface TokenIO : NSObject {}

+ (TokenIOBuilder *)builder;

- (id)initWithHost:(NSString *)host port:(int)port;

- (TKMember *)createMember:(NSString *)alias;

- (void)asyncCreateMember:(NSString *)alias
                 onSucess:(OnSuccessWithTKMember)onSuccess
                  onError:(OnError)onError;

- (TKMember *)loginMember:(NSString *)memberId
               secretKey:(TKSecretKey *)secretKey;

- (void)asyncLoginMember:(NSString *)memberId
               secretKey:(TKSecretKey *)key
                onSucess:(OnSuccessWithTKMember)onSuccess
                 onError:(OnError)onError;

@end

#endif
