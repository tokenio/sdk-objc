//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenProto.h"

/**
 * Set of utility methods.
 */
@interface TKUtil : NSObject

/**
 * Returns the current Token SDK version.
 *
 * @return Token SDK version
 */
+ (NSString *)tokenSdkVersion;

/**
 * Generates a nonce, used by many of the SDK methods to ensure idempotency.
 *
 * @return a string nonce
 */
+ (NSString *)nonce;

/**
 * Base64 encoder implementation.
 *
 * @param bytes data to encode
 * @param length number of bytes to encode
 * @return base64 encoded data
 */
+ (NSString *)base64EncodeBytes:(const char *)bytes length:(NSUInteger)length;

/**
 * Base64Url encoder implementation.
 *
 * @param bytes data to encode
 * @param length number of bytes to encode
 * @return base64Url encoded data
 */
+ (NSString *)base64UrlEncodeBytes:(const char *)bytes length:(NSUInteger)length;

/**
 * Base64 encoder implementation.
 *
 * @param data data to encode
 * @return base64 encoded data
 */
+ (NSString *)base64EncodeData:(NSData *)data;

/**
 * Base64Url encoder implementation.
 *
 * @param data data to encode
 * @return base64Url encoded data
 */
+ (NSString *)base64UrlEncodeData:(NSData *)data;

/**
 * Base64 encoder implementation.
 *
 * @param data data to encode
 * @param padding if false, padding is stripped (= or == at the end of the message)
 * @return base64 encoded data
 */
+ (NSString *)base64EncodeData:(NSData *)data padding:(bool)padding;

/**
 * Base64Url encoder implementation.
 *
 * @param data data to encode
 * @param padding if false, padding is stripped (= or == at the end of the message)
 * @return base64Url encoded data
 */
+ (NSString *)base64UrlEncodeData:(NSData *)data padding:(bool)padding;

/**
 * Base64 decoder implementation.
 *
 * @param base64String Base64 encoded string
 * @return decoded string
 */
+ (NSData *)base64DecodeString:(NSString *)base64String;

/**
 * Base64Url decoder implementation.
 *
 * @param base64String Base64Url encoded string
 * @return decoded string
 */
+ (NSData *)base64UrlDecodeString:(NSString *)base64String;

/**
 * Returns an ID for a given string. We hash the string value and Base64 encode
 * the result. Has to match what we do on the server.
 *
 * @param string content to generate an id for
 * @return id
 */
+ (NSString *)idForString:(NSString *)string;

/**
 * Returns an ID for a given string. We hash the string value and Base64 encode
 * the result. Has to match what we do on the server.
 *
 * @param buffer content to generate an id for
 * @return id
 */
+ (NSString *)idForBytes:(const char *)buffer;

/**
 * Returns an ID for a given data. We hash the data value and Base64 encode
 * the result. Has to match what we do on the server.
 *
 * @param data content to generate an id for
 * @return id
 */
+ (NSString *)idForData:(NSData *)data;

/**
 * Converts string in the snake case to camel case.
 *
 * @param input input
 * @return converted string
 */
+ (NSString *)snakeCaseToCamelCase:(NSString *)input;

/**
 * Converts string in the camel case to snake case.
 *
 * @param string input
 * @return converted string
 */
+ (NSString *)camelCaseToSnakeCase:(NSString *)string;

/**
 * Normalize an alias.
 *
 * @param alias to normalize
 * @return normalized alias
 */
+ (Alias *)normalizeAlias:(Alias *)alias;

@end
