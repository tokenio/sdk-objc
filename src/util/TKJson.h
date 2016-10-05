//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPBMessage;

/**
 * Converts proto buffer messages to JSON. gRPC lib from Google doesn't
 * implement this yet. We want the code to match what Google does because
 * we use this to compile a message content for signing.
 *
 * See implementation notes.
 */
@interface TKJson : NSObject

/**
 * Converts proto buffer message into JSON string.
 *
 * @param message proto buffer message
 * @return JSON string
 */
+ (NSString *)serialize:(GPBMessage *)message;

/**
 * Converts proto buffer message into Base64 encoded JSON string.
 *
 * @param message proto buffer message
 * @return JSON string
 */
+ (NSString *)serializeBase64:(GPBMessage *)message;

@end
