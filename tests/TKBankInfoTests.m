//
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Bankinfo.pbobjc.h"

@interface TKBankInfoTests : TKTestBase
@end

@implementation TKBankInfoTests

- (void)testGetBanks {
    TokenIOSync *tokenIO = [self syncSDK];
    NSArray *banks = [tokenIO getBanks:nil
                                search:nil
                               country:nil
                                  page:1
                               perPage:5
                                  sort:@"name"
                              provider:@""];
    XCTAssertTrue(banks.count == 5);
    
    banks = [tokenIO getBanks:@[@"iron",@"gold"]
                       search:nil
                      country:nil
                         page:1
                      perPage:10
                         sort:@"name"
                     provider:@""];
    XCTAssertTrue(banks.count == 2);
    
    banks = [tokenIO getBanks:nil
                       search:@"GOLD"
                      country:nil
                         page:1
                      perPage:10
                         sort:@"country"
                     provider:@""];
    XCTAssertTrue(banks.count > 0);
    
    banks = [tokenIO getBanks:nil
                       search:nil
                      country:@"US"
                         page:1
                      perPage:10
                         sort:@"name"
                     provider:@""];
    XCTAssertTrue(banks.count > 0);
}

- (void)testGetBankInfo {
    TKMemberSync *member = [self createMember:[self syncSDK]];
    NSString *bankId = @"iron";
    
    BankInfo *info = [member getBankInfo:bankId];
    
    XCTAssertNotNil(info.linkingUri);
    XCTAssertNotNil(info.redirectUriRegex);
}

- (void)testGetBanksCountries {
    TokenIOSync *tokenIO = [self syncSDK];
    NSArray *countries = [tokenIO getBanksCountries:@"token"];
    XCTAssertTrue(countries.count > 0);
}
@end
