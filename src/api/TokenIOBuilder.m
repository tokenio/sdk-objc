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
#import "TokenIOAsync.h"
#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKTokenCryptoEngineFactory.h"


@implementation TokenIOBuilder

- (id)init {
    self = [super init];

    if (self) {
        self.host = @"api.token.io";
        self.port = 9000;
        self.timeoutMs = 10 * 1000; // 10 seconds.
        self.useSsl = YES;
    }

    return self;
}

- (TokenIO *)build {
    return [self buildAsync].sync;
}

- (TokenIOAsync *)buildAsync {
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    if (self.keyStore) {
        cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:self.keyStore];
    } else {
        cryptoEngineFactory = [[TKSecureEnclaveCryptoEngineFactory alloc] init];
    }

    return [[TokenIOAsync alloc]
            initWithHost:self.host
                    port:self.port
               timeoutMs:self.timeoutMs
                  crypto:cryptoEngineFactory
                  useSsl:self.useSsl];
}

@end
