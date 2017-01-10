//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCrypto.h"


/**
 * Secret key that identifies a given client device. The key is private/public
 * key pair.
 */
@interface TKTokenSecretKey : NSObject

+ (TKTokenSecretKey *)keyWithPrivateKey:(NSData *)sk publicKey:(NSData *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSData *publicKey;
@property (atomic, readonly) NSString *publicKeyStr;
@property (atomic, readonly) NSData *privateKey;

@end