//
// Created by Maxim Khutornenko on 2/22/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


@interface TKRpcErrorHandler : NSObject

/**
 * Creates an instance with provided global error callback.
 *
 * @param globalRpcErrorCallback_ global RPC error callback
 * @return TKRpcErrorHandler instance
 */
- (id)initWithGlobalRpcErrorCallback:(OnError) globalRpcErrorCallback_;

/**
 * Handles RPC error and calls the provided onError.
 *
 * @param onError invoked on error
 * @param error RPC error raised
 */
- (void)handle:(OnError) onError
     withError:(NSError *) error;

@end