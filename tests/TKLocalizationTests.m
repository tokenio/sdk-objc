//
//  TKLocalizationTests.m
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKLocalizer.h"

@interface TKLocalizationTests : XCTestCase

@end

@implementation TKLocalizationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDefaultString {
    NSString* string = TKLocalizedString(@"Signature_Reason_UpdateMember", @"");
    XCTAssertEqualObjects(string, @"Authorize your Token account change");
}

- (void)testOverrideString {
    NSString* string = TKLocalizedString(@"Signature_Reason_CreateMember", @"");
    XCTAssertEqualObjects(string, @"Overridden string");
}

- (void)testOverrideCustomTableString {
    [TKLocalizer shared].stringsFile = @"CustomTable";
    NSString* string = TKLocalizedString(@"Signature_Reason_EndorseAccessToken", @"");
    XCTAssertEqualObjects(string, @"Overridden custom table string");
}
@end
