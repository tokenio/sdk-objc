//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPBMessage;


@interface TJson : NSObject

+ (NSString *)serialize:(GPBMessage *)message;

@end