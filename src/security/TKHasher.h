//
//  TKHasher.h
//  TokenSdk
//
//  Created by Colin Man on 7/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKHasher : NSObject

+ (NSData *)hash:(NSString *)input;
+ (NSString *)hashAndSerialize:(NSString *)input;

@end
