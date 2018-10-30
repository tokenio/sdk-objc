//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Alias.pbobjc.h"

#import <XCTest/XCTest.h>

@class TokenIOSync;
@class TokenIO;
@class TokenIOBuilder;
@class OauthBankAuthorization;
@class TKMemberSync;
@class TKAccountSync;
@class TKBankClient;
@class HostAndPort;

typedef void (^AsyncTestBlock)(TokenIOSync *);
typedef id (^AsyncTestBlockWithResult)(TokenIOSync *);

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
 * Creates a TokenIO SDK client with settings for testing environment.
 */
- (TokenIO *)asyncSDK;

/**
 * Creates a TokenIOSync SDK client with settings for testing environment.
 */
- (TokenIOSync *)syncSDK;

/**
 * Creates a Token SDK builder with settings for testing environment.
 */
- (TokenIOBuilder *)sdkBuilder;

/**
 * Creates a new member with an auto generated alias and key.
 *
 * @param tokenIO an entry point for Token API
 * @return a member
 */
- (TKMemberSync *)createMember:(TokenIOSync *)tokenIO;

/**
 * Creates a new member/account.
 *
 * @param tokenIO an entry point for Token API
 * @return an account
 */
- (TKAccountSync *)createAccount:(TokenIOSync *)tokenIO;

/**
 * Creates a new bank authorization for a member
 *
 * @param member member
 * @return a bank authorization
 */
- (OauthBankAuthorization *)createBankAuthorization:(TKMemberSync *)member;

/**
 * Formats HostAndPort instance.
 *
 * @param var env variable holding connection details
 * @param port default port number
 * @return HostAndPort instance
 */
- (HostAndPort *)hostAndPort:(NSString *)var withDefaultPort:(int)port;

/**
 * Creates a random alias with default type (email).
 * @return Alias with default type (email)
 */
- (Alias *)generateAlias;

/**
 * Creates a random alias with email type.
 * @return Alias with email type
 */
- (Alias *)generateEmailAlias;

/**
 * Creates a random alias with phone type.
 * @return Alias with phone type
 */
- (Alias *)generatePhoneAlias;

/**
 * Checks the specified condition, throws NSException if condition is false.
 *
 * @param message error message
 * @param condition condition to check
 */
- (void)check:(NSString *)message condition:(BOOL)condition;

/**
 * Retries the supplied block until it has been successful or a time limit has
 * been reached.
 *
 * @param block block to try
 */
- (void)waitUntil:(void (^)(void))block;

@end
