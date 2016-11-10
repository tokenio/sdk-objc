//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.pbobjc.h"

@class TKSecretKey;
@class GPBMessage;
@class Token;


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
+(NSString *)sign:(GPBMessage *)message
         usingKey:(TKSecretKey *)key;

/**
 * Signs a token with the supplied secret key.
 *
 * @param token token to sign
 * @param action action being signed on
 * @param key key to sign with
 * @return signed message, Base64 encoded
 */
+ (NSString *)sign:(Token *)token
            action:(TokenSignature_Action)action
          usingKey:(TKSecretKey *)key;

/**
 * Signs a token payload with the supplied secret key.
 *
 * @param tokenPayload token payload to sign
 * @param action action being signed on
 * @param key key to sign with
 * @return signed message, Base64 encoded
 */
+ (NSString *)signPayload:(TokenPayload *)tokenPayload
                   action:(TokenSignature_Action)action
                 usingKey:(TKSecretKey *)key;

/**
 * Signs the specified payload using given key
 *
 * @param key the key to be used for signing
 * @param payload the payload to be signed
 * @return a payload signature
 */
+(NSString *)signPayload:(NSString *)payload
                usingKey:(TKSecretKey *)key;

/**
 * Verifies a message signature.
 *
 * @param signature signature to verify
 * @param message message to verify the signature for
 * @param key public key used to verify the signature
 * @return true if signature verifies
 */
+(bool)verifySignature:(NSString *)signature
            forMessage:(GPBMessage *)message
        usingPublicKey:(NSData *)key;

/**
 * Verifies a token signature.
 *
 * @param signature signature to verify
 * @param token token to verify the signature for
 * @param action action to verify the signature for
 * @param key public key used to verify the signature
 * @return true if signature verifies
 */
+(bool)verifySignature:(NSString *)signature
              forToken:(Token *)token
                action:(TokenSignature_Action) action
        usingPublicKey:(NSData *)key;

/**
 * Generates a new key pair.
 *
 * @return newly created key pair
 */
+(TKSecretKey *)generateKey;

@end
