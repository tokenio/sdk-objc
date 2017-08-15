//
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Bankinfo.pbobjc.h"

@interface TKBankInfoTests : TKTestBase
@end

@implementation TKBankInfoTests {
    TKMember *member;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIOSync *tokenIO) {
        member = [self createMember:tokenIO];
    }];
}

- (void)testGetBanks {
    [self run: ^(TokenIOSync *tokenIO) {
        NSArray *banks = [member getBanks];
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
