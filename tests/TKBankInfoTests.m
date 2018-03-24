//
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Bankinfo.pbobjc.h"

@interface TKBankInfoTests : TKTestBase
@end

@implementation TKBankInfoTests {
    TKMemberSync *member;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIOSync *tokenIO) {
        member = [self createMember:tokenIO];
    }];
}

- (void)testGetBanks {
    [self run: ^(TokenIOSync *tokenIO) {
        NSArray *banks = [tokenIO getBanks:nil
                                    search:nil
                                   country:nil
                                      page:1
                                   perPage:5
                                      sort:@"name"];
        XCTAssertTrue(banks.count == 5);
        
        banks = [tokenIO getBanks:@[@"iron",@"gold"]
                           search:nil
                          country:nil
                             page:1
                          perPage:10
                             sort:@"name"];
        XCTAssertTrue(banks.count == 2);
        
        banks = [tokenIO getBanks:nil
                           search:@"GOLD"
                          country:nil
                             page:1
                          perPage:10
                             sort:@"country"];
        XCTAssertTrue(banks.count > 0);
        
        banks = [tokenIO getBanks:nil search:nil country:@"US" page:1 perPage:10 sort:@"name"];
        XCTAssertTrue(banks.count > 0);
    }];
}

- (void)testGetBankInfo {
    [self run: ^(TokenIOSync *tokenIO) {
        NSString *bankId = @"iron";

        BankInfo *info = [member getBankInfo:bankId];

        XCTAssertNotNil(info.linkingUri);
        XCTAssertNotNil(info.redirectUriRegex);
    }];
}

@end
