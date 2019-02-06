//
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Bankinfo.pbobjc.h"

@interface TKBankInfoTests : TKTestBase
@end

@implementation TKBankInfoTests

- (void)testGetBanks {
    TokenClient *tokenClient = [self client];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    expectation.expectedFulfillmentCount = 4;
    
    [tokenClient
     getBanks:nil
     search:nil
     country:nil
     page:1
     perPage:5
     sort:@"name"
     provider:@""
     onSuccess:^(NSArray *banks) {
         XCTAssertTrue(banks.count == 5);
         [expectation fulfill];
     } onError:THROWERROR];
    
    [tokenClient
     getBanks:@[@"iron",@"gold"]
     search:nil
     country:nil
     page:1
     perPage:10
     sort:@"name"
     provider:@""
     onSuccess:^(NSArray *banks) {
         XCTAssertTrue(banks.count == 2);
         [expectation fulfill];
     } onError:THROWERROR];
    
    [tokenClient
     getBanks:nil
     search:@"GOLD"
     country:nil
     page:1
     perPage:10
     sort:@"country"
     provider:@""
     onSuccess:^(NSArray *banks) {
         XCTAssertTrue(banks.count > 0);
         [expectation fulfill];
     } onError:THROWERROR];
    
    [tokenClient
     getBanks:nil
     search:nil
     country:@"US"
     page:1
     perPage:10
     sort:@"name"
     provider:@""
     onSuccess:^(NSArray *banks) {
         XCTAssertTrue(banks.count > 0);
         [expectation fulfill];
     } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetBankInfo {
    TKMember *member = [self createMember:[self client]];
    NSString *bankId = @"iron";
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    
    [member getBankInfo:bankId onSuccess:^(BankInfo *info) {
        XCTAssertNotNil(info.linkingUri);
        XCTAssertNotNil(info.redirectUriRegex);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetBanksCountries {
    TokenClient *tokenClient = [self client];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    
    [tokenClient getBanksCountries:@"token" onSuccess:^(NSArray<NSString *> *countries) {
        XCTAssertTrue(countries.count > 0);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}
@end
