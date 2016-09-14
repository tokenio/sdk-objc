//
//  Token.h
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenClient_h
#define TokenClient_h

@class TokenSdkBuilder;

@interface TokenSdk : NSObject

+ (TokenSdkBuilder *)builder;
- (id)initWithHost:(NSString *)host port:(int)port;

@end

#endif /* TokenClient_h */
