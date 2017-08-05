//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TokenIOBuilder.h"
#import "TokenIO.h"
#import "TokenIOSync.h"
#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKTokenCryptoEngineFactory.h"


@implementation TokenIOBuilder

- (id)init {
    self = [super init];

    if (self) {
        self.host = @"api.token.io";
        self.port = 9000;
        self.timeoutMs = 60 * 1000; // 60 seconds.
        self.useSsl = YES;
        self.globalRpcErrorCallback = ^(NSError *error) {/* noop default callback */};
    }

    return self;
}

- (TokenIO *)build {
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    if (self.keyStore) {
        cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:self.keyStore];
    } else {
        cryptoEngineFactory = [[TKSecureEnclaveCryptoEngineFactory alloc] init];
    }

    return [[TokenIO alloc]
            initWithHost:self.host
                    port:self.port
               timeoutMs:self.timeoutMs
                  crypto:cryptoEngineFactory
                  useSsl:self.useSsl
  globalRpcErrorCallback:self.globalRpcErrorCallback];
}

@end
