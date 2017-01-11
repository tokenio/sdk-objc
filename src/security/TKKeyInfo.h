//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKCrypto.h"
#import "Security.pbobjc.h"


@interface TKKeyInfo : NSObject

+ (TKKeyInfo *)keyInfoWithId:(NSString *)id
                       level:(Key_Level)level
                   algorithm:(Key_Algorithm)algorithm
                   publicKey:(NSData *)pk;

@property (atomic, readonly) NSString *id;
@property (atomic, readonly) Key_Level level;
@property (atomic, readonly) Key_Algorithm algorithm;
@property (atomic, readonly) NSData *publicKey;
@property (atomic, readonly) NSString *publicKeyStr;

@end