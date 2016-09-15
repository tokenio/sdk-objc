//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * Set of utility methods.
 */
@interface TKUtil : NSObject

/**
 * Generates a nonce, used by many of the SDK methods to ensure idempotency.
 *
 * @return a string nonce
 */
+ (NSString *)nonce;

/**
 * URL safe Base64 encoder implementation.
 *
 * @param data data to encode
 * @return base64 encoded data
 */
+ (NSString *)base64EncodeData:(NSData *)data;

/**
 * Returns an ID for a given string. We have the string value and Base64 encode
 * the result. Has to match what we do on the server.
 *
 * @param string content to generate an id for
 * @return id
 */
+ (NSString *)idForString:(NSString *)string;

/**
 * Returns an ID for a given string. We have the string value and Base64 encode
 * the result. Has to match what we do on the server.
 *
 * @param string content to generate an id for
 * @return id
 */
+ (NSString *)idForBytes:(const char *)buffer;

@end