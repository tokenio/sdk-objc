//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"

@class TKKeyInfo;

/**
 * Defines a set of methods that deal with crypto, key generation, method
 * signing, etc.
 */
@protocol TKCryptoEngine

/**
 * Generates a set of keys needed by the app and returns them to the caller.
 * The keys are sorted from the most privileged to the least privileged.
 *
 * @return the newly created key pair information
 */
- (NSArray<TKKeyInfo*> *)generateKeys;

/**
 * Signs the data with the identified by the supplied key id.
 *
 * @param data payload to sign
 * @param keyId identifies the key used for signing
 * @return payload signature
 */
- (NSString *)signData:(NSData *)data
            usingKeyId:(NSString *)keyId;

/**
 * Verifies the payload signature.
 *
 * @param signature signature
 * @param data payload to verify the signature for.
 * @param keyId key id
 * @return true if successful
 */
- (bool)verifySignature:(NSString *)signature
                forData:(NSData *)data
             usingKeyId:(NSString *)keyId;

/**
 * Looks up current key for the given key type.
 *
 * @param type key type
 * @return  key info
 */
- (TKKeyInfo *)lookupKeyByType:(TKKeyType)type;

@end
