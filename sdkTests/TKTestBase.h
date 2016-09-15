//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@class TokenIO;

typedef void (^AsyncTestBlock)(TokenIO *);

/**
 * Base class for the integration tests. The derived classes invoke run method
 * and supply a callback wich accepts a connected sdk client.
 *
 * gRPC posts completion tasks to the main dispatch queue, so we have to fake
 * running a main application event loop to make the tests work.
 */
@interface TKTestBase : XCTestCase

- (void)setUp;

/**
 * Executes the specified block on a thread and processes the main dispatch queue
 * while waiting for the block to finish.
 *
 * @param block block of code to execute
 */
- (void)run:(AsyncTestBlock)block;

@end