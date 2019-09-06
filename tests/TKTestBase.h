//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Alias.pbobjc.h"
#import "TKTestExpectation.h"
#import "TokenSdk.h"

NS_ASSUME_NONNULL_BEGIN
@class TKBankClient;
@class HostAndPort;

typedef void (^AsyncTestBlock)(TokenClient *);
typedef id _Nonnull (^AsyncTestBlockWithResult)(TokenClient *);

#define THROWERROR ^(NSError *error) { @throw error; }
#define IGNOREERROR ^(NSError *error) { @throw error; }

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
 * Creates a Token client with settings for testing environment.
 */
- (TokenClient *)client;

/**
 * Creates a Token SDK builder with settings for testing environment.
 */
- (TokenClientBuilder *)sdkBuilder;

/**
 * Creates a new member with an auto generated alias and key.
 *
 * @param tokenClient an entry point for Token API
 * @return a member
 */
- (TKMember *)createMember:(TokenClient *)tokenClient;

/**
 * Creates a new member/account.
 *
 * @param tokenClient an entry point for Token API
 * @return an account
 */
- (TKAccount *)createAccount:(TokenClient *)tokenClient;

/**
 * Creates a new bank authorization for a member
 *
 * @param member member
 * @return a bank authorization
 */
- (OauthBankAuthorization *)createBankAuthorization:(TKMember *)member;

/**
 * Links accounnts to a member.
 *
 * @param bankAuthorization bank authorization for accounts.
 * @param member member
 * @return a bank authorization
 */
- (NSArray<TKAccount *> *)linkAccounts:(OauthBankAuthorization *)bankAuthorization to:(TKMember *)member;

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

/**
 * Invokes grpc-using block. Runs until `condition` block returns true,
 * hits exception, or times out.
 *
 * Sample code uses async, as we expect most devs will use.
 * We want to make sure sample code works without cluttering it with asserts.
 * Thus the async sample code has side effects;
 * after the sample code, runUntilTrue to assert side effect happens.
 *
 * @param condition block that returns a Boolean
 * @param backOffTimeMs how long to wait between invocations of `condition`
 * @param waitingTimeMs how long to wait the process to complete
 */
- (void)runUntilTrue:(int (^)(void))condition backOffTimeMs:(int)backOffTimeMs waitingTimeMs:(int)waitingTimeMs;

/**
 * Invokes grpc-using block. Runs until `condition` block returns true,
 * hits exception, or times out. Does not sleep between invocations of
 * `condition`.
 *
 * @param condition block that returns a Boolean
 */
- (void)runUntilTrue:(int (^)(void))condition;

/**
 * Runs until one notification found, hits exception, or times out.
 *
 * @param member member
 */
- (Notification *)runUntilNotificationReceived:(TKMember *)member;

/**
 * Creates a transfer token with a transfer token builder.
 *
 * @param builder transer token builder
 */
- (Token *)createToken:(TransferTokenBuilder *)builder;

/**
 * Returns a yyyy-MM-dd date time of tomorrow.
 *
 */
- (NSString *)tomorrow;

/**
 * Returns a yyyy-MM-dd date time of next week.
 *
 */
- (NSString *)nextWeek;

@end
NS_ASSUME_NONNULL_END
