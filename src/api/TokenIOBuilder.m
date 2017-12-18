//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TokenIOBuilder.h"
#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKTokenCryptoEngineFactory.h"
#import "TKTokenBrowser.h"

@implementation TokenIOBuilder

- (id)init {
    self = [super init];

    if (self) {
        self.host = @"api.token.io";
        self.port = 9000;
        self.timeoutMs = 60 * 1000; // 60 seconds.
        self.useSsl = YES;
        self.useLocalAuthentication = YES;
        self.globalRpcErrorCallback = ^(NSError *error) {/* noop default callback */};
    }

    return self;
}

- (TokenIOSync *)buildSync {
    TokenIO* tokenIO = [self buildAsync];
    return [[TokenIOSync alloc] initWithDelegate:tokenIO];
}

- (TokenIO *)buildAsync {
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    if (self.keyStore) {
        cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:self.keyStore
                                                    useLocalAuthentication:self.useLocalAuthentication];
    } else {
        cryptoEngineFactory = [[TKSecureEnclaveCryptoEngineFactory alloc] init];
    }
    
    if (!self.browserFactory) {
        self.browserFactory = ^(id<TKBrowserDelegate> delegate) {
            return [[TKTokenBrowser alloc] initWithBrowserDelegate:delegate];
        };
    }
    

    return [[TokenIO alloc]
            initWithHost:self.host
            port:self.port
            timeoutMs:self.timeoutMs
            developerKey:self.developerKey
            crypto:cryptoEngineFactory
            browserFactory:self.browserFactory
            useSsl:self.useSsl
            globalRpcErrorCallback:self.globalRpcErrorCallback];
}

@end
