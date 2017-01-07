//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngineFactory.h"

@protocol TKTokenCryptoStorage;


@interface TKTestTokenCryptoEngineFactory : NSObject<TKCryptoEngineFactory>

+ (id<TKCryptoEngineFactory>)factory;

@end