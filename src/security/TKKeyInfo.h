//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCrypto.h"


@interface TKKeyInfo : NSObject

+ (TKKeyInfo *)keyInfoWithId:(NSString *)id type:(TKKeyType)type publicKey:(NSData *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) TKKeyType type;
@property (atomic, readonly) NSData *publicKey;
@property (atomic, readonly) NSString *publicKeyStr;

@end