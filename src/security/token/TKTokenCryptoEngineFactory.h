//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngineFactory.h"

@protocol TKKeyStore;


@interface TKTokenCryptoEngineFactory : NSObject<TKCryptoEngineFactory>

+ (id<TKCryptoEngineFactory>)factoryWithStore:(id<TKKeyStore>)storage
                       useLocalAuthentication:(BOOL)useLocalAuthentication;

@end
