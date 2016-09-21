//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


/**
 * Helps to turn async RPC calls into sync ones. Provides thread synchronization
 * semantics.
 */
@interface TKRpcSyncCall<T> : NSObject

/**
 * Creates new object instance.
 *
 * @return new instance
 */
+ (TKRpcSyncCall *)create;

/**
 * Runs the specified block that initiates RPC call. The block is responsible
 * for invoking onSuccess or onError methods as appropriate. After one of the
 * methods has been invoked the run method exits. If error has been reported
 * an exception is thrown.
 *
 * @param block RPC handling block
 * @return operation result
 */
- (T)run:(void(^)())block;

/**
 * Invoked by the RPC block to signal that call completed successfully.
 *
 * @param result RPC call result
 */
@property (readonly, retain) void(^onSuccess)(T);

/**
 * Invoked by the RPC block to signal that call completed with an error.
 *
 * @param error error information
 */
@property (readonly, retain) OnError onError;

@end