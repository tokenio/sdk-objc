//
//  TKTrustedBeneficiaryTest.m
//  TokenSdkTests
//
//  Created by Gianluca Pane on 10/15/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "TKMemberSync.h"

@interface TKTrustedBeneficiaryTests : TKTestBase

@end

@implementation TKTrustedBeneficiaryTests {
    TKMemberSync *member;
}

- (void)setUp {
    [super setUp];
    member = [[self syncSDK] createMember:[self generateAlias]];
}

- (void)testAddTrustedBeneficiary {
    XCTAssertEqual([member getTrustedBeneficiaries].count, 0);

    NSString *beneficiaryMemberId = [[self syncSDK] createMember:[self generateAlias]].id;
    [member addTrustedBeneficiary:beneficiaryMemberId];
    
    XCTAssertEqual([member getTrustedBeneficiaries].count, 1);
}

- (void)testRemoveTrustedBeneficiaries {
    NSString *beneficiaryMemberId1 = [[self syncSDK] createMember:[self generateAlias]].id;
    NSString *beneficiaryMemberId2 = [[self syncSDK] createMember:[self generateAlias]].id;
    [member addTrustedBeneficiary:beneficiaryMemberId1];
    [member addTrustedBeneficiary:beneficiaryMemberId2];
    XCTAssertEqual([member getTrustedBeneficiaries].count, 2);
    
    [member removeTrustedBeneficiary:beneficiaryMemberId1];
    XCTAssertEqual([member getTrustedBeneficiaries].count, 1);
    
    [member removeTrustedBeneficiary:beneficiaryMemberId2];
    XCTAssertEqual([member getTrustedBeneficiaries].count, 0);
}

@end
