//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TokenSdk.h"

@class TKKeyInfo;

/**
 * Defines a set of methods that deal with crypto, key generation, method
 * signing, etc.
 */
@protocol TKCryptoEngine

/**
 * Generates a keys of the specified level. If the key with the specified level
 * already exists, it is replaced. Old key is still kept around because it
 * could be used for signature verification later.
 *
 * @param level key level
 * @return the newly created key pair information
 */
- (TKKeyInfo *)generateKey:(Key_Level)level;

/**
 * Signs the data with the identified by the supplied key id.
 *
 * @param data payload to sign
 * @param keyLevel level of the key to use
 * @return payload signature
 */
- (TKSignature *)signData:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel;

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

@end