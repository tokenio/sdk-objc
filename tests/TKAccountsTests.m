//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"

#import "HostAndPort.h"
#import "TKAccount.h"
#import "TKJson.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "TKBankClient.h"
#import "TKUtil.h"
#import "fank/Fank.pbobjc.h"
#import "TKRpcSyncCall.h"


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
    bankId = @"iron";
    member = [self createMember:[self client]];
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
    
    TKRpcSyncCall<NSArray<TKAccount *> *> *call = [TKRpcSyncCall create];
    accounts = [call run:^{
        [self->member linkAccounts:auth
                   onSuccess:call.onSuccess
                     onError:call.onError];
    }];
}

- (void)testDefaultAccount {
    __weak TKMember *weakMember = member;
    
    XCTAssert(accounts.count == 2);
    XCTAssertNotNil(accounts[0].id);
    XCTAssertNotNil(accounts[1].id);
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    // Confirm default is already set.
    [weakMember getDefaultAccount:^(TKAccount *defaultAccount) {
        XCTAssertEqualObjects(defaultAccount.id, self->accounts[0].id);
        // Set new default and ensure it works.
        [weakMember setDefaultAccount:self->accounts[1].id onSuccess:^ {
            [weakMember getDefaultAccount:^(TKAccount *defaultAccount) {
                XCTAssertEqualObjects(defaultAccount.id, self->accounts[1].id);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];

    [self waitForExpectations:@[expectation] timeout:10];
    
    expectation = [[XCTestExpectation alloc] init];
    // Ensure unlinking an account results in a new default.
    [weakMember unlinkAccounts:@[accounts[1].id] onSuccess:^ {
        [weakMember getDefaultAccount:^(TKAccount *defaultAccount) {
            XCTAssertEqualObjects(defaultAccount.id, self->accounts[0].id);
            [expectation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
 
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLinkAccounts {
    __weak TKMember *weakMember = member;
    
    XCTAssert(accounts.count == 2);
    XCTAssertNotNil(accounts[0].id);
    XCTAssertEqualObjects(@"Checking", accounts[0].name);
    XCTAssertEqualObjects(bankId, accounts[0].bankId);
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [weakMember unlinkAccounts:@[accounts[0].id] onSuccess:^ {
        [weakMember getAccounts:^(NSArray<TKAccount *> *array) {
            XCTAssert(array.count == 1);
            [expectation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupAccounts {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member getAccounts:^(NSArray<TKAccount *> *array) {
        XCTAssert(self->accounts.count == 2);
        XCTAssertEqualObjects(@"Checking", self->accounts[0].name);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupAccount {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member getAccounts:^(NSArray<TKAccount *> *array) {
        XCTAssert(self->accounts.count == 2);
        XCTAssertEqualObjects(@"Checking", self->accounts[0].name);
        XCTAssertEqualObjects(@"iron", self->accounts[0].bankId);
        XCTAssert(!self->accounts[0].isLocked);
        XCTAssert(self->accounts[0].supportsReceivePayment);
        XCTAssert(self->accounts[0].supportsSendPayment);
        XCTAssert(self->accounts[0].supportsInformation);
        XCTAssert(!self->accounts[0].requiresExternalAuth);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    expectation = [[XCTestExpectation alloc] init];
    [member getAccount:accounts[0].id onSuccess:^(TKAccount *account) {
        XCTAssertEqualObjects(@"Checking", account.name);
        XCTAssertEqualObjects(@"iron", account.bankId);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testResolveTransferDestinations {
    NSString *accountId = [[accounts objectAtIndex:0] id];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member resolveTransferDestinations:accountId onSuccess:^(NSArray<TransferEndpoint *> *array) {
        XCTAssert(array.count >= 1);
        TransferEndpoint *transferEndpoint = [array objectAtIndex:0];
        BankAccount *bankAccount = transferEndpoint.account;
        XCTAssertTrue(![bankAccount.swift.account isEqualToString:@""]);
        XCTAssertTrue(![bankAccount.swift.bic isEqualToString:@""]);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}
@end
