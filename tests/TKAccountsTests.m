//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"

#import "TKAccountSync.h"
#import "TKJson.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "TKBankClient.h"
#import "TKUtil.h"
#import "fank/Fank.pbobjc.h"


@interface TKAccountsTests : TKTestBase
@end

@implementation TKAccountsTests {
    TKMemberSync *member;
    FankClient *fankClient;
    NSArray<TKAccountSync *> *accounts;
    NSString *bankId;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIOSync *tokenIO) {
        bankId = @"iron";
        member = [self createMember:tokenIO];
        NSString *firstName = [@"FirstName-" stringByAppendingString:[TKUtil nonce]];
        NSString *lastName = [@"LastName-" stringByAppendingString:[TKUtil nonce]];
        fankClient = [self.bank addClientWithFirstName:firstName lastName:lastName];
        FankAccount *checking = [self.bank addAccountWithName: @"Checking"
                                                    forClient: fankClient
                                            withAccountNumber: [@"iban:checking-" stringByAppendingString:[TKUtil nonce]]
                                                       amount: @"1000000.00"
                                                     currency: @"USD"];

        NSArray<SealedMessage*> *encAccounts = [self.bank authorizeAccountLinkingFor: member.id
                                                                         clientId: fankClient.id_p
                                                                   accountNumbers: [NSArray arrayWithObjects: checking.accountNumber, nil]];
        BankAuthorization* auth = [BankAuthorization message];
        auth.bankId = bankId;
        [auth.accountsArray addObjectsFromArray:encAccounts];
        accounts = [member linkAccounts:auth];
    }];
}

- (void)testLinkAccounts {
    [self run: ^(TokenIOSync *tokenIO) {
        XCTAssert(accounts.count == 1);
        XCTAssertNotNil(accounts[0].id);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
        XCTAssertEqualObjects(bankId, accounts[0].bankId);

        [member unlinkAccounts:@[accounts[0].id]];
        accounts = [member getAccounts];
        XCTAssert(accounts.count == 0);
    }];
}

- (void)testLookupAccounts {
    [self run: ^(TokenIOSync *tokenIO) {
        accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}

- (void)testLookupAccount {
    [self run: ^(TokenIOSync *tokenIO) {
        accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
        XCTAssertEqualObjects(@"iron", accounts[0].bankId);
        
        TKAccountSync *account = [member getAccount:accounts[0].id];
        XCTAssertEqualObjects(@"Checking", account.name);
        XCTAssertEqualObjects(@"iron", account.bankId);
    }];
}

@end
