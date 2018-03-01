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
#if TARGET_OS_IPHONE
#import "TKTokenBrowser.h"
#endif

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

- (TokenIOSync *)buildSync {
    TokenIO* tokenIO = [self buildAsync];
    return [[TokenIOSync alloc] initWithDelegate:tokenIO];
}

- (TokenIO *)buildAsync {
    if (!self.cryptoEngineFactory) {
        self.cryptoEngineFactory =
        [TKSecureEnclaveCryptoEngineFactory factoryWithAuthenticationOption:false];
    }
    
#if TARGET_OS_IPHONE
    if (!self.browserFactory) {
        self.browserFactory = ^(id<TKBrowserDelegate> delegate) {
            return [[TKTokenBrowser alloc] initWithBrowserDelegate:delegate];
        };
    }
#endif

    return [[TokenIO alloc]
            initWithHost:self.host
            port:self.port
            timeoutMs:self.timeoutMs
            developerKey:self.developerKey
            languageCode:self.languageCode
            crypto:self.cryptoEngineFactory
            browserFactory:self.browserFactory
            useSsl:self.useSsl
            certsPath:self.certsPath
            globalRpcErrorCallback:self.globalRpcErrorCallback];
}

@end
