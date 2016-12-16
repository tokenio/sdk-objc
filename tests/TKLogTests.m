//
//  TKLogTests.m
//  TokenSdk
//
//  Created by Vadim on 12/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKLogManager.h"

@interface TKLogTests : XCTestCase<TKExternalLoggerDelegate>

@end

@implementation TKLogTests {
    NSString* logText;
}

- (void)testLogDelegate {
    [TKLogManager logManagerWithDelegate:self muteNSLog:NO];
    logText = @"";
    NSString* testString = @"";
    TKLogInfo(@"Log Info with Parameters %@ %@", @(12.5), @"Some string");
    testString = [testString stringByAppendingString:[NSString stringWithFormat:@"Log Info with Parameters %@ %@", @(12.5), @"Some string"]];
    NSError* error = [NSError errorWithDomain:@"io.grpc"
                                         code:13
                                     userInfo:@{@"key":@"value"}];
    TKLogError(@"Log Error with Parameter %@", error);
    testString = [testString stringByAppendingString:[NSString stringWithFormat:@"Log Error with Parameter %@", error]];
    XCTAssertEqualObjects(logText, testString);
}

#pragma mark- TKExternalLoggerDelegate delagate methods

- (void)logInfo:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    logText = [logText stringByAppendingString:[[NSString alloc] initWithFormat:format arguments:args]];
    va_end(args);
}

- (void)logError:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    logText = [logText stringByAppendingString:[[NSString alloc] initWithFormat:format arguments:args]];
    va_end(args);
}

@end
