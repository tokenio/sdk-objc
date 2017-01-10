//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCrypto.h"

@class TKTokenSecretKey;


/**
 * A key storage for the TKTokenCryptoEngine.
 */
@protocol TKTokenCryptoStorage

/**
 * Adds a secret key to the storage. If a key with a given type already exists
 * it is replaced with the given key. The old key is kept around and could be
 * looked up by its id.
 *
 * @param key
 */
- (void)addKey:(TKTokenSecretKey *)key ofType:(TKKeyType)type;

/**
 * Looks up secret key by its id. Exception is thrown if key is
 * not found.
 *
 * @param id key id
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyById:(NSString *)id;

/**
 * Looks up current secret key for a given type that should be used for
 * signing. Exception is thrown if key is not found.
 *
 * @param type key type
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyByType:(TKKeyType)type;

@end