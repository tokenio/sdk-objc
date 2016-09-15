//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#ifndef TokenIOBuilder_h
#define TokenIOBuilder_h

#import <objc/NSObject.h>


@class TokenIO;

@interface TokenIOBuilder : NSObject

@property (readwrite, copy) NSString *host;
@property (readwrite) int port;

- (id)init;
- (TokenIO *)build;

@end

#endif
