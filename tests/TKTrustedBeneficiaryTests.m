//
//  TKTrustedBeneficiaryTest.m
//  TokenSdkTests
//
//  Created by Gianluca Pane on 10/15/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKTestBase.h"
#import "TokenClient.h"
#import "TKMember.h"
#import "TKRpcSyncCall.h"

@interface TKTrustedBeneficiaryTests : TKTestBase

@end

@implementation TKTrustedBeneficiaryTests {
    TokenClient *client;
    TKMember *member;
}

- (void)setUp {
    [super setUp];
    client = [self client];
    member = [self createMember:client];
}

- (void)testAddTrustedBeneficiary {
    [self assertTrustedBeneficiariesCount:0];

    NSString *beneficiaryMemberId = [self createMember:client].id;
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member addTrustedBeneficiary:beneficiaryMemberId
                        onSuccess:^ {
                            [expectation fulfill];
                        } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertTrustedBeneficiariesCount:1];
}

- (void)testRemoveTrustedBeneficiary {
    NSString *beneficiaryMemberId1 = [self createMember:client].id;
    NSString *beneficiaryMemberId2 = [self createMember:client].id;
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    expectation.expectedFulfillmentCount = 2;
    [member addTrustedBeneficiary:beneficiaryMemberId1
                        onSuccess:^ {
                            [expectation fulfill];
                        } onError:THROWERROR];
    [member addTrustedBeneficiary:beneficiaryMemberId2
                        onSuccess:^ {
                            [expectation fulfill];
                        } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertTrustedBeneficiariesCount:2];

    expectation = [[XCTestExpectation alloc] init];
    [member removeTrustedBeneficiary:beneficiaryMemberId1
                           onSuccess:^ {
                               [expectation fulfill];
                           } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertTrustedBeneficiariesCount:1];

    expectation = [[XCTestExpectation alloc] init];
    [member removeTrustedBeneficiary:beneficiaryMemberId2
                           onSuccess:^ {
                               [expectation fulfill];
                           } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    [self assertTrustedBeneficiariesCount:0];
}

- (void) assertTrustedBeneficiariesCount:(NSInteger)count {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member getTrustedBeneficiaries:^(NSArray<TrustedBeneficiary *> * array) {
        XCTAssertEqual(array.count, count);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

@end
