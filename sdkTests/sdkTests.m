//
//  sdkTests.m
//  sdkTests
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TokenSdk.h"
#import "TokenSdkBuilder.h"


@interface sdkTests : XCTestCase
@property (strong, nonatomic) TokenSdk *sdk;
@end

@implementation sdkTests

- (void)setUp {
    [super setUp];

    TokenSdkBuilder *builder = [TokenSdk builder];
    builder.host = @"localhost";
    builder.port = 9000;

    self.sdk = [builder build];
}

- (void)testExample {
    NSLog(@"DONE: %@", self.sdk.debugDescription);
}

@end
