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
@interface TKSignature : NSObject

+ (TKSignature *)signature:(NSString *)signature
                signedWith:(TKKeyInfo*)key;

@property (atomic, readonly) NSString *value;
@property (atomic, readonly) TKKeyInfo *key;

@end