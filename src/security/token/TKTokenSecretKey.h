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

+ (TKTokenSecretKey *)keyWithLevel:(Key_Level)level
                        privateKey:(NSData *)sk
                         publicKey:(NSData *)pk
                        expiration:(NSNumber *) expiresAtMs;

@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) Key_Level level;
@property (nonatomic, readonly) NSData *publicKey;
@property (nonatomic, readonly) NSData *privateKey;
@property (nonatomic, readonly) Key *keyInfo;
@property (nonatomic, readonly) NSNumber *expiresAtMs;

@end
