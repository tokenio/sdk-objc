//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngine.h"

@protocol TKKeyStore;

/**
 * Token implementation of the TKCrypto that performs all the crypto operations
 * in the user/app space (not secure enclave).
 */
@interface TKTokenCryptoEngine : NSObject<TKCryptoEngine>

- (id)initForMember:(NSString *)memberId
        useKeyStore:(id <TKKeyStore>)store_
useLocalAuthentication:(BOOL)useLocalAuthentication;

@end
