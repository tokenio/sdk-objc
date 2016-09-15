//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * Secret key that identifies a given client device. The key is private/public
 * key pair.
 */
@interface TKSecretKey : NSObject

+ (TKSecretKey *)withPrivateKey:(NSData *)sk publicKey:(NSData *)pk;
- (id)initWithPrivateKey:(NSData *)sk publicKey:(NSData *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSData *publicKey;
@property (atomic, readonly) NSString *publicKeyStr;
@property (atomic, readonly) NSData *privateKey;

@end