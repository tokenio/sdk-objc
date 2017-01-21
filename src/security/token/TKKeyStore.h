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
@protocol TKKeyStore

/**
 * Adds a secret key to the storage.
 *
 * @param key key to add
 * @param memberId member id
 */
- (void)addKey:(TKTokenSecretKey *)key forMember:(NSString *)memberId;

/**
 * Looks up secret key by its id. Exception is thrown if key is
 * not found.
 *
 * @param id key id
 * @param memberId member id
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyById:(NSString *)id forMember:(NSString *)memberId;


/**
 * Looks up secret key by its id. Exception is thrown if key is
 * not found.
 *
 * @param keyLevel level of the key to lookup
 * @param memberId member id
 * @return looked up key
 */
- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)keyLevel forMember:(NSString *)memberId;

@end