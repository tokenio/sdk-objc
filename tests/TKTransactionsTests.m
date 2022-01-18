//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Transaction.pbobjc.h"
#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKBalance.h"
#import "PagedArray.h"

@interface TKTransactionsTests : TKTestBase
@end

@implementation TKTransactionsTests {
    TKAccount *payerAccount;
    TKMember *payer;
    TKAccount *payeeAccount;
    TKMember *payee;
}

- (void)setUp {
    [super setUp];
    TokenClient *tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testGetBalance {
    TKTestExpectation *expactation = [[TKTestExpectation alloc] init];
    [payerAccount getBalance:Key_Level_Low
                   onSuccess:^(TKBalance *balance) {
                       Money *currentBalance = balance.current;
                       XCTAssert([currentBalance.value intValue] > 0);
                       XCTAssertEqualObjects(@"USD", currentBalance.currency);
                       Money *availableBalance = balance.available;
                       XCTAssert([availableBalance.value intValue] > 0);
                       XCTAssertEqualObjects(@"USD", availableBalance.currency);
                       [expactation fulfill];
                   } onError:THROWERROR];
    [self waitForExpectations:@[expactation] timeout:10];
}

- (void)testGetBalances {
    OauthBankAuthorization *auth = [self createBankAuthorization:payer];
    NSArray<TKAccount *> *accounts = [self linkAccounts:auth to:payer];
    XCTAssert(accounts.count == 1);
    TKAccount *secondAccount = accounts[0];
    NSArray<NSString *> *accountIds = @[payerAccount.id, secondAccount.id];
    
    TKTestExpectation *expactation = [[TKTestExpectation alloc] init];
    [payer getBalances:accountIds withKey:Key_Level_Low onSuccess:^(NSDictionary<NSString *, TKBalance *> *balances) {
        XCTAssert(balances.allKeys.count == 2);
        TKBalance *balance = balances[self->payerAccount.id];
        Money *currentBalance = balance.current;
        XCTAssert([currentBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", currentBalance.currency);
        Money *availableBalance = balance.available;
        XCTAssert([availableBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", availableBalance.currency);
        [expactation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expactation] timeout:10];
}

- (void)testLookupTransaction {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    
    TKTestExpectation *expactation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *created) {
        [self->payer endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            [self->payee
             redeemToken:[result token]
             amount:amount
             currency:@"USD"
             description:@"full amount"
             destination:destination onSuccess:^(Transfer *transfer) {
                 [self->payerAccount
                  getTransaction:transfer.transactionId
                  withKey:Key_Level_Low
                  onSuccess:^(Transaction *transaction) {
                      XCTAssertEqualObjects(amount, [NSDecimalNumber decimalNumberWithString:transaction.amount.value]);
                      XCTAssertEqualObjects(@"USD", transaction.amount.currency);
                      XCTAssertEqualObjects(created.id_p, transaction.tokenId);
                      XCTAssertEqualObjects(transfer.id_p, transaction.tokenTransferId);
                      XCTAssertTrue([transaction.description containsString:@"full amount"]);
                      [expactation fulfill];
                  } onError:THROWERROR];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expactation] timeout:10];
}

- (void)testLookupTransactions {
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"49.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    __block Token *endorsed = nil;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            endorsed = [endorsedResult token];
            [expectation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = self->payeeAccount.member.id;
    destination.account.token.accountId = self->payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"49.99"];
    for (int i = 0; i < 3; i++) {
        TKTestExpectation *redeemExpectation = [[TKTestExpectation alloc] init];
        [self->payee
         redeemToken:endorsed
         amount:redeemAmount
         currency:@"USD"
         description:nil
         destination:destination
         onSuccess:^(Transfer *transfer) {
             [redeemExpectation fulfill];
         } onError:THROWERROR];
        [self waitForExpectations:@[redeemExpectation] timeout:10];
    }
    
    TKTestExpectation *lookedUpExpectation = [[TKTestExpectation alloc] init];
    [payerAccount
     getTransactionsOffset:NULL
     limit:3
     withKey:Key_Level_Low
     onSuccess:^(PagedArray<Transaction *> *lookedUp) {
        XCTAssertEqual(3, lookedUp.items.count);
        XCTAssertNotNil(lookedUp.offset);
        [lookedUpExpectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[lookedUpExpectation] timeout:10];
}
@end
