//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"

#import "HostAndPort.h"
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
    bankId = @"iron";
    member = [self createMember:[self syncSDK]];
    NSString *firstName = [@"FirstName-" stringByAppendingString:[TKUtil nonce]];
    NSString *lastName = [@"LastName-" stringByAppendingString:[TKUtil nonce]];
    fankClient = [self.bank addClientWithFirstName:firstName lastName:lastName];
    BankAuthorization *auth = [BankAuthorization message];
    auth.bankId = bankId;
    FankAccount *checking = [self.bank addAccountWithName: @"Checking"
                                                forClient: fankClient
                                        withAccountNumber: [@"iban:checking-" stringByAppendingString:[TKUtil nonce]]
                                                   amount: @"1000000.00"
                                                 currency: @"USD"];
    FankAccount *saving = [self.bank addAccountWithName: @"Savings"
                                              forClient: fankClient
                                      withAccountNumber: [@"iban:saving-" stringByAppendingString:[TKUtil nonce]]
                                                 amount: @"1000000.00"
                                               currency: @"USD"];
    
    NSArray<SealedMessage*> *encAccounts = [self.bank authorizeAccountLinkingFor: member.id
                                                                        clientId: fankClient.id_p
                                                                  accountNumbers: [NSArray arrayWithObjects: checking.accountNumber, saving.accountNumber, nil]];
    [auth.accountsArray addObjectsFromArray:encAccounts];
    accounts = [member linkAccounts:auth];
}

- (void)testDefaultAccount {
    XCTAssert(accounts.count == 2);
    XCTAssertNotNil(accounts[0].id);
    XCTAssertNotNil(accounts[1].id);
    
    // Confirm default is already set.
    TKAccountSync *val = [member getDefaultAccount];
    XCTAssertEqualObjects(val.id, accounts[0].id);
    
    // Set new default and ensure it works.
    [member setDefaultAccount:accounts[1].id];
    val = [member getDefaultAccount];
    XCTAssertEqualObjects(val.id, accounts[1].id);
    
    // Ensure unlinking an account results in a new default.
    [member unlinkAccounts:@[accounts[1].id]];
    val = [member getDefaultAccount];
    XCTAssertEqualObjects(val.id, accounts[0].id);
    XCTAssertNotEqualObjects(val.id, accounts[1].id);
}

- (void)testLinkAccounts {
    XCTAssert(accounts.count == 2);
    XCTAssertNotNil(accounts[0].id);
    XCTAssertEqualObjects(@"Checking", accounts[0].name);
    XCTAssertEqualObjects(bankId, accounts[0].bankId);
    
    [member unlinkAccounts:@[accounts[0].id]];
    accounts = [member getAccounts];
    XCTAssert(accounts.count == 1);
}

- (void)testLookupAccounts {
    accounts = [member getAccounts];
    XCTAssert(accounts.count == 2);
    XCTAssertEqualObjects(@"Checking", accounts[0].name);
}

- (void)testLookupAccount {
    accounts = [member getAccounts];
    XCTAssert(accounts.count == 2);
    XCTAssertEqualObjects(@"Checking", accounts[0].name);
    XCTAssertEqualObjects(@"iron", accounts[0].bankId);
    XCTAssert(!accounts[0].isLocked);
    XCTAssert(accounts[0].supportsReceivePayment);
    XCTAssert(accounts[0].supportsSendPayment);
    XCTAssert(accounts[0].supportsInformation);
    XCTAssert(!accounts[0].requiresExternalAuth);
    
    TKAccountSync *account = [member getAccount:accounts[0].id];
    XCTAssertEqualObjects(@"Checking", account.name);
    XCTAssertEqualObjects(@"iron", account.bankId);
}

@end
