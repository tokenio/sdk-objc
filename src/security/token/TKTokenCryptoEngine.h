//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngine.h"

@protocol TKTokenCryptoStorage;

/**
 * Token implementation of the TKCrypto that performs all the crypto operations
 * in the user/app space (not secure enclave).
 */
@interface TKTokenCryptoEngine : NSObject<TKCryptoEngine>

- (id)initWithStorage:(id<TKTokenCryptoStorage>)storage;

@end
