//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKTypedef.h"


@class GatewayService;
@class TokenIOBuilder;
@class TKMember;
@class TKSecretKey;
@class TokenIOAsync;


@interface TokenIO : NSObject

@property (readonly, retain) TokenIOAsync *async;

+ (TokenIOBuilder *)builder;

- (id)initWithDelegate:(TokenIOAsync *)delegate;

- (TKMember *)createMember:(NSString *)alias;

- (TKMember *)loginMember:(NSString *)memberId secretKey:(TKSecretKey *)secretKey;

@end
