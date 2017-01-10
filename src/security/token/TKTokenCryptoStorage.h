//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Security.pbobjc.h"
#import "TKCrypto.h"

@class TKTokenSecretKey;


/**
 * A key storage for the TKTokenCryptoEngine.
 */
@protocol TKTokenCryptoStorage

/**
 * Adds a secret key to the storage.
 *
 * @param key
 */
- (void)addKey:(TKTokenSecretKey *)key;

/**
 * Looks up secret key by its id. Exception is thrown if key is
 * not found.
 *
 * @param id key id
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyById:(NSString *)id;


/**
 * Looks up secret key by its id. Exception is thrown if key is
 * not found.
 *
 * @param level level of the key to lookup
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)level;

@end