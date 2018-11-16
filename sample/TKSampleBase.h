//
//  TKSampleBase.h
//  TokenSdk
//
//  Shared setup for our code samples.
//  Creates two members and links a bank account for each.
//
//  Created by Larry Hosken on 11/9/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKTestBase.h"

@interface TKSampleBase : TKTestBase

@property(readonly) TokenIOSync *tokenIOSync;

@property(readonly) Alias *payerAlias;
@property(readonly) TKMemberSync *payerSync;
@property(readonly) TKAccountSync *payerAccountSync;

@property(readonly) Alias *payeeAlias;
@property(readonly) TKMemberSync *payeeSync;
@property(readonly) TKAccountSync *payeeAccountSync;

- (void)setUp;


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

@end
