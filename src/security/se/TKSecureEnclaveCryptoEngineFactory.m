//
//  TKSecureEnclaveCryptoEngineFactory.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKSecureEnclaveCryptoEngine.h"

@implementation TKSecureEnclaveCryptoEngineFactory

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId {
    return [[TKSecureEnclaveCryptoEngine alloc] initWithMemberId:memberId];
}

@end
