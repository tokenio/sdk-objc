//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCrypto.h"
#import "Security.pbobjc.h"


/**
 * Secret key that identifies a given client device. The key is private/public
 * key pair.
 */
@interface TKTokenSecretKey : NSObject

+ (TKTokenSecretKey *)keyWithLevel:(Key_Level)level  privateKey:(NSData *)sk publicKey:(NSData *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) Key_Level level;
@property (atomic, readonly) NSData *publicKey;
@property (atomic, readonly) NSData *privateKey;
@property (atomic, readonly) Key *keyInfo;

@end