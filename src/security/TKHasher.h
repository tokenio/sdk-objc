//
//  TKHasher.h
//  TokenSdk
//
//  Created by Colin Man on 7/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gateway/Gateway.pbrpc.h"

@interface TKHasher : NSObject

+ (NSData *)hashData:(NSData *)input;
+ (NSData *)hashString:(NSString *)input;

+ (NSString *)serializeReadable:(NSData *)data;
+ (NSString *)hashAlias:(Alias *)alias;

@end
