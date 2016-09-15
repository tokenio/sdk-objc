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

+ (TKSecretKey *)withPrivateKey:(NSString *)sk publicKey:(NSString *)pk;
- (id)initWithPrivateKey:(NSString *)sk publicKey:(NSString *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *publicKey;
@property (atomic, readonly) NSString *privateKey;

@end