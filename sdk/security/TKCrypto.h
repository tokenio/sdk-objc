//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKSecretKey;
@class GPBMessage;


/**
 * Set of methods that deal with crypto, key generation, method signing, etc.
 */
@interface TKCrypto : NSObject

/**
 * Signs a message with the supplied secret key.
 *
 * @param message message to sign
 * @param key key to sign with
 * @return signed message, Base64 encoded
 */
+(NSString *)sign:(GPBMessage *)message usingKey:(TKSecretKey *)key;

/**
 * Generates a new key pair.
 *
 * @return newly created key pair
 */
+(TKSecretKey *)generateKey;

@end