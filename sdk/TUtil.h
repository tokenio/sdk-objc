//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TUtil : NSObject

+ (NSString *)nonce;

+ (NSString *)base64EncodeData:(NSData *)data;

+ (NSString *)idForString:(NSString *)string;

+ (NSString *)idForBytes:(const char *)buffer;

@end