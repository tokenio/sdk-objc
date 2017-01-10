//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngine.h"

/**
 * Instantiates CryptoEngine instances. New instance is created for each member
 * because it stores member keys.
 */
@protocol TKCryptoEngineFactory <NSObject>

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId;

@end