//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKUtil.h"

@interface TKUtilTests : XCTestCase
@end

@implementation TKUtilTests

/**
 * base64 encoding/decoding.
 */
- (void)testBase64 {
    NSData *original = [@"Hello world" dataUsingEncoding:NSASCIIStringEncoding];
    NSString *encoded = [TKUtil base64EncodeData:original];
    NSData *decoded = [TKUtil base64DecodeString:encoded];
    XCTAssertEqualObjects(original, decoded);
}

/**
 * base64 encoding/decoding.
 */
- (void)testBase64_differentLength {
    NSString *input = @"This is a very very very very very very very long input";
    for (int i = 0; i < input.length; i++) {
        NSString *original = [input substringToIndex:i];
        NSString *encoded = [TKUtil base64EncodeData:[original dataUsingEncoding:NSASCIIStringEncoding]];
        NSData *decodedData = [TKUtil base64DecodeString:encoded];
        NSString *decoded = [[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding];
        XCTAssertEqualObjects(original, decoded);
    }
}

/**
 * ID generation.
 */
- (void)testId {
    NSString *input = @"This is a very very very very very very very long input";
    for (int i = 0; i < input.length; i++) {
        NSString *original = [input substringToIndex:i];
        NSString *id = [TKUtil idForString:original];
        XCTAssert(id.length > 0);
        XCTAssert(id.length <= 16);
    }
}

@end