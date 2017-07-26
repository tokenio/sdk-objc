//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@class TokenIO;
@class BankAuthorization;
@class TKMember;
@class TKAccount;
@class TKBankClient;
@class HostAndPort;

typedef void (^AsyncTestBlock)(TokenIO *);
typedef id (^AsyncTestBlockWithResult)(TokenIO *);

/**
 * Base class for the integration tests. The derived classes invoke run method
 * and supply a callback wich accepts a connected sdk client.
 *
 * gRPC posts completion tasks to the main dispatch queue, so we have to fake
 * running a main application event loop to make the tests work.
 */
@interface TKTestBase : XCTestCase

@property(readonly) TKBankClient *bank;

- (void)setUp;

/**
 * Executes the specified block on a thread and processes the main dispatch queue
 * while waiting for the block to finish.
 *
 * @param block block of code to execute
 */
- (void)run:(AsyncTestBlock)block;

/**
 * Executes the specified block on a thread and processes the main dispatch queue
 * while waiting for the block to finish. Returns result back to the caller.
 *
 * @param block block of code to execute
 */
- (id)runWithResult:(AsyncTestBlockWithResult)block;

/**
 * Creates a new member with a specified username and key.
 *
 * @param tokenIO
 * @return
 */
- (TKMember *)createMember:(TokenIO *)token;

/**
 * Creates a new member/account.
 *
 * @param tokenIO
 * @return
 */
- (TKAccount *)createAccount:(TokenIO *)tokenIO;

/**
 * Creates a new bank authorization for a member
 *
 * @param tokenIO
 * @param username
 * @return
 */
- (BankAuthorization *)createBankAuthorization:(TokenIO *)tokenIO
                                      username:(NSString *)username;

/**
 * Formats HostAndPort instance.
 *
 * @param var env variable holding connection details
 * @param port default port number
 * @return HostAndPort instance
 */
- (HostAndPort *)hostAndPort:(NSString *)var withDefaultPort:(int)port;

@end
