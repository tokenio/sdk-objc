//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.pbobjc.h"


@class TKKeyInfo;
@class TKSignature;
@protocol TKCryptoEngine;

/**
 * Defines possible secure key types based on usage.
 */
typedef NS_ENUM(NSInteger, TKKeyType) {
    kKeyAuth,
    kKeyKeyManagement,
    kKeySigning,
    kKeySigningHighPrivelege,
};

/**
 * An abstract class that defines a set of methods that deal with crypto,
 * key generation, method signing, etc. There are two abstract methods
 * that need to be implemented in the derived classes signData and
 * verifySignature:forData.
 */
@interface TKCrypto : NSObject

- (id)initWithEngine:(id<TKCryptoEngine>)engine;

/**
 * Generates a set of keys needed by the app and returns them to the caller.
 *
 * @return the newly created key pair information
 */
- (NSArray<TKKeyInfo*> *)generateKeys;

/**
 * Signs a message with the secret key specified by the supplied id.
 *
 * @param message message to sign
 * @param keyType key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)sign:(GPBMessage *)message
             usingKey:(TKKeyType)keyType;

/**
 * Signs a token with the secret key specified by the supplied id.
 *
 * @param token token to sign
 * @param action action being signed on
 * @param keyType key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)sign:(Token *)token
               action:(TokenSignature_Action)action
             usingKey:(TKKeyType)keyType;

/**
 * Signs a token payload with the secret key specified by the supplied id.
 *
 * @param tokenPayload token payload to sign
 * @param action action being signed on
 * @param keyType key to use
 * @return signed message, Base64 encoded
 */
- (TKSignature *)signPayload:(TokenPayload *)tokenPayload
                      action:(TokenSignature_Action)action
                    usingKey:(TKKeyType)keyType;

/**
 * Signs a payload with the secret key specified by the supplied id.
 *
 * @param key the key to be used for signing
 * @param payload the payload to be signed
 * @param keyType key to use
 * @return a payload signature
 */
- (TKSignature *)signPayload:(NSString *)payload
                    usingKey:(TKKeyType)keyType;

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
