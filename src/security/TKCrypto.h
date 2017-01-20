//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.pbobjc.h"
#import "TokenSdk.h"


@class TKSignature;
@protocol TKCryptoEngine;

/**
 * An abstract class that defines a set of methods that deal with crypto,
 * key generation, method signing, etc. There are two abstract methods
 * that need to be implemented in the derived classes signData and
 * verifySignature:forData.
 */
@interface TKCrypto : NSObject

- (id)initWithEngine:(id<TKCryptoEngine>)engine;

/**
 * Generates a set of keys to be used by a given member.
 *
 * @param level key level
 * @return the newly created key pair information
 */
- (NSArray<Key *> *)generateKeys;

/**
 * Generates a key of the given level.
 *
 * @param level key level
 * @return the newly created key pair information
 */
- (Key *)generateKey:(Key_Level)level;

/**
 * Signs a message with the secret key specified by the supplied type.
 *
 * @param message message to sign
 * @param keyLevel key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)sign:(GPBMessage *)message
             usingKey:(Key_Level)keyLevel;

/**
 * Signs a token with the secret key specified by the supplied type.
 *
 * @param token token to sign
 * @param action action being signed on
 * @param keyLevel key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)sign:(Token *)token
               action:(TokenSignature_Action)action
             usingKey:(Key_Level)keyLevel;

/**
 * Signs a token payload with the secret key specified by the supplied type.
 *
 * @param tokenPayload token payload to sign
 * @param action action being signed on
 * @param keyLevel key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)signPayload:(TokenPayload *)tokenPayload
                      action:(TokenSignature_Action)action
                    usingKey:(Key_Level)keyLevel;

/**
 * Verifies a message signature.
 *
 * @param signature signature to verify
 * @param message message to verify the signature for
 * @param keyType key to use
 * @return true if signature verifies
 */
- (bool)verifySignature:(NSString *)signature
             forMessage:(GPBMessage *)message
               usingKeyId:(NSString *)keyId;

/**
 * Verifies a token signature.
 *
 * @param signature signature to verify
 * @param token token to verify the signature for
 * @param action action to verify the signature for
 * @param keyType key to use
 * @return true if signature verifies
 */
- (bool)verifySignature:(NSString *)signature
               forToken:(Token *)token
                 action:(TokenSignature_Action) action
             usingKeyId:(NSString *)keyId;

@end
