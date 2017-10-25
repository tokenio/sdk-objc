//
//  TKSetupSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 10/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"

#import "TokenIOSync.h"
#import "TokenIOBuilder.h"

@interface TKSetupSamples : TKTestBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    TokenIOBuilder *builder = [TokenIOSync builder];
    builder.host = @"api-grpc.sandbox.token.io"; // "sandbox." for test; omit for real
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    TokenIOSync *tokenIO = [builder buildSync];
    XCTAssertNotNil(tokenIO);
}

@end
