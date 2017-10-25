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

#import "TKUtil.h"

@interface TKSetupSamples : TKTestBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    [self run: ^(TokenIOSync *tIO) {
        TokenIOBuilder *builder = [TokenIOSync builder];
        [builder forSandbox];
        builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
        TokenIOSync *tokenIO = [builder buildSync];

        // Use the SDK client.
        TKMemberSync *member = [tokenIO createMember:[TKUtil randomAlias]];
        XCTAssertNotNil(member);
    }];
}

@end
