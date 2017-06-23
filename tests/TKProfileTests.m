//
//  TKProfileTests.m
//  TokenSdk
//
//  Created by Sibin Lu on 6/23/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKTestBase.h"
#import "TKUtil.h"
#import "TokenIO.h"
#import "TKMember.h"

@interface TKProfileTests : TKTestBase

@end

@implementation TKProfileTests {
    TKMember* member;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        member = [tokenIO createMember:username];
    }];
}

- (void)testProfile {
    [self run: ^(TokenIO *tokenIO) {
        Profile* profile = [[Profile alloc] init];
        profile.displayNameFirst = @"Meimei";
        profile.displayNameLast = @"Han";
        
        Profile* result = [member setProfile:profile];
        result = [member getProfile:member.id];
        
        XCTAssertEqualObjects(profile.displayNameFirst, result.displayNameFirst);
        XCTAssertEqualObjects(profile.displayNameLast, result.displayNameLast);
        
    }];
}


@end
