//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <objc/NSObject.h>
#import "TKTypedef.h"


@class TokenIOSync;
@class TokenIO;
@protocol TKCryptoEngineFactory;
@protocol TKKeyStore;

/**
 * A builder that is used to customize and create `TokenIO` and 
 * `TokenIOSync` instances that serve as the Token API entry points.
 */
@interface TokenIOBuilder : NSObject

/// Host address. For example, "api-grpc.sandbox.token.io".
@property (readwrite, copy) NSString *host;

/// Host port.
@property (readwrite) int port;

/// Request timeout duration used with RPC requests.
@property (readwrite) int timeoutMs;

/// Key that "tags" requests with ID of developer organization. Ask Token for a developer key you can use.
@property (readwrite, copy) NSString *developerKey;

/// Use SSL to protect connection?
@property (readwrite) BOOL useSsl;

/// Crypto key storage. By default, uses Secure Enclave.
@property (readwrite) id<TKKeyStore> keyStore;

/// If you are using your own key storage, Token crypto engine will ask for local authentication when you sign data by default. Disables this will skip the local authentication.
@property (readwrite) BOOL useLocalAuthentication;

/// Uses custom grpc certs.
@property (readwrite, copy) NSString *certsPath;
/**
 * Optional callback to invoke when a cross-cutting RPC error is raised (for example: kTKErrorSdkVersionMismatch).
 * This is in addition to the rpc-specific onError handler, which is still invoked after the rpcErrorCallback.
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
