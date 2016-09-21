//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIOAsync_h
#define TokenIOAsync_h

#import <objc/NSObject.h>
#import "TKTypedef.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;
@class TokenIO;


@interface TokenIOAsync : NSObject

@property (readonly, retain) TokenIO *sync;

+ (TokenIOBuilder *)builder;

- (id)initWithHost:(NSString *)host port:(int)port;

- (void)createMember:(NSString *)alias
            onSucess:(OnSuccessWithTKMemberAsync)onSuccess
             onError:(OnError)onError;

- (void)loginMember:(NSString *)memberId
          secretKey:(TKSecretKey *)key
           onSucess:(OnSuccessWithTKMemberAsync)onSuccess
            onError:(OnError)onError;

@end

#endif
