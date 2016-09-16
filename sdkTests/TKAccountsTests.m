//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKJson.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"


@interface TKAccountsTests : TKTestBase
@end

@implementation TKAccountsTests {
    TKMember *member;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIO *tokenIO) {
        member = [self createMember:tokenIO];
    }];
}

- (void)testLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        NSString *bankId = @"bank-id";

        AccountLinkPayload_NamedAccount *account = [AccountLinkPayload_NamedAccount message];
        account.name = @"Checking";
        account.accountNumber = @"iban:checking";

        AccountLinkPayload *payload = [AccountLinkPayload message];
        payload.alias = member.firstAlias;

        [payload.accountsArray addObject:account];

        NSData *payloadData = [[TKJson serialize:payload] dataUsingEncoding:NSASCIIStringEncoding];
        NSArray<TKAccount *> *accounts = [member linkAccounts:bankId
                                                 withPayload:payloadData];

        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}

- (void)testLookupAccounts {
    [self testLinkAccounts];

    [self run: ^(TokenIO *tokenIO) {
        NSArray<TKAccount *> *accounts = [member lookupAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}
@end
