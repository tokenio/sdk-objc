//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TokenSdk.h"

/**
 * Defines a set of methods that deal with crypto, key generation, method
 * signing, etc.
 */
@protocol TKCryptoEngine

/**
 * Generates a key-pair of the specified level. If the key with the specified level
 * already exists, it is replaced. Old key is still kept around in the Token Cloud
 * because it could be used for signature verification later.
 *
 * @param level key level
 * @return the newly created key pair information
 */
- (Key *)generateKey:(Key_Level)level;

/**
 * Signs the data with the identified by the supplied key id.
 *
 * @param data payload to sign
 * @param keyLevel level of the key to use
 * @param reason the reason the data is being signed
 * @param onError callback to invoke on errors or user not authorizing the
 * signature
 * @return payload signature
 */
- (TKSignature *)signData:(NSData *)data
            usingKeyLevel:(Key_Level)keyLevel
                   reason:(NSString *)reason
                  onError:(OnError)onError;

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
