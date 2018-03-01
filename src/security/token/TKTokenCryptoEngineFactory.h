//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngineFactory.h"

@protocol TKKeyStore;


@interface TKTokenCryptoEngineFactory : NSObject<TKCryptoEngineFactory>

/**
 * Create TKTokenCryptoEngineFactory with customized key store.
 * @param storage the customized key store
 * @param useLocalAuthentication require local authentication to sign data. If you are using your
 * own key storage, Token crypto engine will ask for local authentication when you sign data
 * by default. Disables this will skip the local authentication
 */
+ (id<TKCryptoEngineFactory>)factoryWithStore:(id<TKKeyStore>)storage
                       useLocalAuthentication:(BOOL)useLocalAuthentication;

@end
