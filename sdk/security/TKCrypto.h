//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKSecretKey;
@class GPBMessage;


@interface TKCrypto : NSObject

+(NSString *)sign:(GPBMessage *)message usingKey:(TKSecretKey *)key;
+(TKSecretKey *)generateKey;

@end