//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <objc/NSObject.h>
#import "TKTypedef.h"
#import "TKBrowser.h"
#import "TokenCluster.h"


@class TokenIOSync;
@class TokenIO;
@protocol TKCryptoEngineFactory;
@protocol TKKeyStore;

/**
 * A builder that is used to customize and create `TokenIO` and 
 * `TokenIOSync` instances that serve as the Token API entry points.
 */
@interface TokenIOBuilder : NSObject

/// TokenCluster.
@property (readwrite, strong) TokenCluster *tokenCluster;

/// Host port.
@property (readwrite) int port;

/// Request timeout duration used with RPC requests.
@property (readwrite) int timeoutMs;

/**
 * Key that "tags" requests with ID of developer organization.
 * Ask Token for a developer key you can use.
 */
@property (readwrite, copy) NSString *developerKey;

/// The SDK language code.
@property (readwrite, copy) NSString *languageCode;

/// Use SSL to protect connection?
@property (readwrite) BOOL useSsl;

/**
 * Set this property if you prefer a customized crypto engine factory.
 * You can use TKTokenCryptoEngineFactory for a customized keyStore.
 * Token Sdk will use TKSecureEnclaveCryptoEngineFactory by default.
 */
@property (readwrite) id<TKCryptoEngineFactory> cryptoEngineFactory;

/// Uses custom grpc certs.
@property (readwrite, copy) NSString *certsPath;
/**
 * Set this property to create customized browser for external authorization.
 * Token Sdk will use TKTokenBrowser by default in iOS.
 */
@property (readwrite) TKBrowserFactory browserFactory;

/**
 * Optional callback to invoke when a cross-cutting RPC error is raised (for example:
 * kTKErrorSdkVersionMismatch). This is in addition to the rpc-specific onError handler, which is
 * still invoked after the rpcErrorCallback.
 */
@property (readwrite) OnError globalRpcErrorCallback;

- (id)init;

/**
 * Creates a synchronous Token client object that is used as the 
 * entry point to the Token API.
 */
- (TokenIOSync *)buildSync;

/**
 * Creates an asynchronous Token client object that is used as the
 * entry point to the Token API.
 */
- (TokenIO *)buildAsync;

@end
