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
 * base64 encoding/decoding with padding.
 */
- (void)testBase64_differentLength_withPadding {
    NSString *input = @"This is a very very very very very very very long input";
    for (int i = 0; i < input.length; i++) {
        NSString *original = [input substringToIndex:i];
        NSString *encoded = [TKUtil base64EncodeData:[original dataUsingEncoding:NSASCIIStringEncoding] padding:true];
        NSData *decodedData = [TKUtil base64DecodeString:encoded];
        NSString *decoded = [[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding];
        XCTAssertEqualObjects(original, decoded);
    }
}

/**
 * base64Url encoding/decoding with padding.
 */
- (void)testBase64Url_differentLength_withPadding {
    NSString *input = @"Born and raised in Pennsylvania, Swift moved to Nashville, Tennessee at age 14 to pursue a career in country music. She signed with the independent label Big Machine Records and became the youngest artist ever signed by the Sony/ATV Music publishing house. Her eponymous debut album in 2006 peaked at number five on Billboard 200 and spent the most weeks on the chart in the 2000s. The album's third single, \"Our Song\", made her the youngest person to single-handedly write and perform a number-one song on the Hot Country Songs chart. Swift's second album, Fearless, was released in 2008. Buoyed by the pop crossover success of the singles \"Love Story\" and \"You Belong with Me\", Fearless became the best-selling album of 2009 in the United States. The album won four Grammy Awards, with Swift becoming the youngest Album of the Year winner.";
    for (int i = 0; i < input.length; i++) {
        NSString *original = [input substringToIndex:i];
        NSString *encoded = [TKUtil base64UrlEncodeData:[original dataUsingEncoding:NSASCIIStringEncoding] padding:true];
        NSData *decodedData = [TKUtil base64UrlDecodeString:encoded];
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

/**
 * Case conversion.
 */
- (void)testCaseConversion {
    NSString *original = @"one_two_three";
    NSString *camel = [TKUtil snakeCaseToCamelCase:original];
    XCTAssertEqualObjects(camel, @"oneTwoThree");

    NSString *snake = [TKUtil camelCaseToSnakeCase:camel];
    XCTAssertEqualObjects(original, snake);
}

/**
 * Case conversion.
 */
- (void)testCaseConversion_manyCases {
    NSArray<NSString *> *input = @[
            @"",
            @"one_two",
            @"one_two_three",
    ];

    for (NSString *s in input) {
        NSString *camel = [TKUtil snakeCaseToCamelCase:s];
        NSString *snake = [TKUtil camelCaseToSnakeCase:camel];
        XCTAssertEqualObjects(s, snake);
    }
}

@end
