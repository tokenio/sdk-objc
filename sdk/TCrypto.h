//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSecretKey;
@class GPBMessage;


@interface TCrypto : NSObject

+(NSString *)sign:(GPBMessage *)message usingKey:(TSecretKey *)key;
+(TSecretKey *)generateKey;

@end