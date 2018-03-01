//
//  TKSecureEnclaveCryptoEngineFactory.h
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngineFactory.h"

@interface TKSecureEnclaveCryptoEngineFactory : NSObject<TKCryptoEngineFactory>

/**
 * Create TKSecureEnclaveCryptoEngineFactory with customized authentication option.
 * @param useDevicePasscodeOnly use device passcode to authenticate only.
 */
+ (id<TKCryptoEngineFactory>)factoryWithAuthenticationOption:(BOOL)useDevicePasscodeOnly;

@end
