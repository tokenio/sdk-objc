//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"

#import "TKAccount.h"
#import "TKJson.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"


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
        NSString *bankId = @"iron";

        AccountLinkPayload *payload = [AccountLinkPayload message];
        payload.username = member.firstUsername;
        payload.accountName = @"Checking";
        payload.accountNumber = @"iban:checking";
        payload.expirationMs = [[NSDate date] timeIntervalSince1970] * 1000 + 10000;

        NSString *payloadBase64 = [TKJson serializeBase64:payload];
        NSArray *payloads = [NSArray arrayWithObject:payloadBase64];
        NSArray<TKAccount *> *accounts = [member linkAccounts:bankId
                                                 withPayloads:payloads];

        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}

- (void)testLookupAccounts {
    [self testLinkAccounts];

    [self run: ^(TokenIO *tokenIO) {
        NSArray<TKAccount *> *accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}

- (void)testLookupAccount {
    [self testLinkAccounts];

    [self run: ^(TokenIO *tokenIO) {
        NSArray<TKAccount *> *accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
        
        TKAccount *account = [member getAccount:accounts[0].id];
        XCTAssertEqualObjects(@"Checking", account.name);
    }];
}

@end
