//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Alias.pbobjc.h"

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
 * Creates a new member with an auto generated alias and key.
 *
 * @param tokenIO an entry point for Token API
 * @return a member
 */
- (TKMember *)createMember:(TokenIO *)tokenIO;

/**
 * Creates a new member/account.
 *
 * @param tokenIO an entry point for Token API
 * @return an account
 */
- (TKAccount *)createAccount:(TokenIO *)tokenIO;

/**
 * Creates a new bank authorization for a member
 *
 * @param tokenIO an entry point for Token API
 * @param memberId member ID
 * @return a bank authorization
 */
- (BankAuthorization *)createBankAuthorization:(TokenIO *)tokenIO
                                      memberId:(NSString *)memberId;

/**
 * Formats HostAndPort instance.
 *
 * @param var env variable holding connection details
 * @param port default port number
 * @return HostAndPort instance
 */
- (HostAndPort *)hostAndPort:(NSString *)var withDefaultPort:(int)port;

/**
 * Creates a random alias with type email.
 * @return Alias with type email
 */
- (Alias *)generateAlias;

@end
