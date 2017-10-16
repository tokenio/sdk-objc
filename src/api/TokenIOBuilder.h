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

@property (readwrite, copy) NSString *host;
@property (readwrite) int port;
@property (readwrite) int timeoutMs;
@property (readwrite, copy) NSString *developerKey;
@property (readwrite) BOOL useSsl;
@property (readwrite) id<TKKeyStore> keyStore;
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
