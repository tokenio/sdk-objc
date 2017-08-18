//
//  TKHasherTests.m
//  TokenSdk
//
//  Created by Colin Man on 8/18/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Alias.pbobjc.h"
#import "TKHasher.h"

@interface TKHasherTests : XCTestCase

@end

@implementation TKHasherTests

- (void)testHashAndSerialize {
    Alias *alias = [Alias message];
    alias.value = @"alias@token.io";
    alias.type = Alias_Type_Email;
    XCTAssertEqualObjects([TKHasher hashAlias:alias], @"5cmRKhdQaKFrkso7E4UHyY6AB5yUN2UE6JLfAJCQDZo2");
}

@end
