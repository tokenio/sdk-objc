//
//  TokenIOTests.m
//  TokenSdkTests
//
//  Created by Alex Kandybaev on 10/13/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TokenIO.h"


@interface TokenIOTests : XCTestCase

@end

@implementation TokenIOTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithDeveloperKey {
    XCTAssertNotNil([[TokenIO alloc] initWithHost:@"localhost"
                                             port:9001
                                        timeoutMs:1000
                                     developerKey:@"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI"
                                     languageCode:@"en"
                                           crypto:nil
                                   browserFactory:nil
                                           useSsl:NO
                                        certsPath:nil
                           globalRpcErrorCallback:^(NSError *error) {/* noop default callback */}]);
}

- (void)testInitWithoutDeveloperKey {
    XCTAssertThrowsSpecificNamed([[TokenIO alloc] initWithHost:@"localhost"
                                                          port:9001
                                                     timeoutMs:1000
                                                  developerKey:nil
                                                  languageCode:@"en"
                                                        crypto:nil
                                                browserFactory:nil
                                                        useSsl:NO
                                                     certsPath:nil
                                        globalRpcErrorCallback:^(NSError *error) {/* noop default callback */}],
                                 NSException,
                                 @"NoDeveloperKeyException");
}

@end
