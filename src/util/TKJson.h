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

/**
 * Deserializes proto message from JSON string.
 *
 * @param aClass proto message class
 * @param jsonString json string to parse/deserialize
 * @return initialized instance of proto message
 */
+ (id)deserializeMessageOfClass:(Class)aClass fromJSON:(NSString*)jsonString;

/**
 * Deserializes proto message from Dictionary.
 *
 * @param aClass proto message class
 * @param dictionary disctionary to deserialize from
 * @return initialized instance of proto message
 */
+ (id)deserializeMessageOfClass:(Class)aClass fromDictionary:(NSDictionary*)dictionary;

@end
