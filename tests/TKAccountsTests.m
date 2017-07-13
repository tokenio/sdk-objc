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
#import "TKBankClient.h"
#import "TKUtil.h"
#import "fank/Fank.pbobjc.h"


@interface TKAccountsTests : TKTestBase
@end

@implementation TKAccountsTests {
    TKMember *member;
    FankClient *fankClient;
    NSArray<TKAccount *> *accounts;
    NSString *bankId;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIO *tokenIO) {
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

        NSArray<SealedMessage*> *encAccounts = [self.bank authorizeAccountLinkingFor: member.firstUsername
                                                                         clientId: fankClient.id_p
                                                                   accountNumbers: [NSArray arrayWithObjects: checking.accountNumber, nil]];
        BankAuthorization* auth = [BankAuthorization message];
        auth.bankId = bankId;
        [auth.accountsArray addObjectsFromArray:encAccounts];
        accounts = [member linkAccounts:auth];
    }];
}

- (void)testLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
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
    [self run: ^(TokenIO *tokenIO) {
        accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
    }];
}

- (void)testLookupAccount {
    [self run: ^(TokenIO *tokenIO) {
        accounts = [member getAccounts];
        XCTAssert(accounts.count == 1);
        XCTAssertEqualObjects(@"Checking", accounts[0].name);
        XCTAssertEqualObjects(@"iron", accounts[0].bankId);
        
        TKAccount *account = [member getAccount:accounts[0].id];
        XCTAssertEqualObjects(@"Checking", account.name);
        XCTAssertEqualObjects(@"iron", account.bankId);
    }];
}

@end
