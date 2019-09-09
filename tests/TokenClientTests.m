//
//  TokenIOTests.m
//  TokenSdkTests
//
//  Created by Alex Kandybaev on 10/13/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TokenClient.h"

@interface TokenClientTests : XCTestCase

@end

@implementation TokenClientTests

- (void)testInitWithDeveloperKey {
    NSString *validDeveloperKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    XCTAssertNotNil([[TokenClient alloc] initWithTokenCluster:[TokenCluster localhost]
                                                         port:9001
                                                    timeoutMs:1000
                                                 developerKey:validDeveloperKey
                                                 languageCode:@"en"
                                                       crypto:nil
                                               browserFactory:nil
                                                       useSsl:NO
                                                    certsPath:nil
                                       globalRpcErrorCallback:^(NSError *error) {
                                           /* noop default callback */
                                       }]);
}

@end
