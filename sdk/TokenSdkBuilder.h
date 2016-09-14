//
//  TokenClientBuilder.h
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenClientBuilder_h
#define TokenClientBuilder_h

#import <objc/NSObject.h>

@class TokenSdk;

@interface TokenSdkBuilder : NSObject

@property (readwrite, copy) NSString *host;
@property (readwrite) int port;

- (id)init;
- (TokenSdk *)build;

@end

#endif /* TokenClientBuilder_h */
