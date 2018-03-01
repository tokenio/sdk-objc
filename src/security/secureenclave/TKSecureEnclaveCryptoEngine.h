//
//  TKSecureEnclaveCryptoEngine.h
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCryptoEngine.h"

@interface TKSecureEnclaveCryptoEngine : NSObject<TKCryptoEngine>

- (id)initWithMemberId:(NSString *)memberId
  authenticationOption:(BOOL)useDevicePasscodeOnly;

@end
