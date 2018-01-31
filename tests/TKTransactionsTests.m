//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Transaction.pbobjc.h"
#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKBalance.h"

@interface TKTransactionsTests : TKTestBase
@end

@implementation TKTransactionsTests {
    TKAccountSync *payerAccount;
    TKMemberSync *payer;
    TKAccountSync *payeeAccount;
    TKMemberSync *payee;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIOSync *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
    }];
}

- (void)testGetBalance {
    [self run: ^(TokenIOSync *tokenIO) {
        TKBalance *balance = [payerAccount getBalance];
        Money *currentBalance = balance.current;
        XCTAssert([currentBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", currentBalance.currency);
        Money *availableBalance = balance.available;
        XCTAssert([availableBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", availableBalance.currency);
    }];     
}

- (void)testGetBalances {
    [self run: ^(TokenIOSync *tokenIO) {
        BankAuthorization *auth = [self createBankAuthorization:payer];
        NSArray<TKAccountSync *> *accounts = [payer linkAccounts:auth];
        XCTAssert(accounts.count == 1);
        TKAccountSync *secondAccount = accounts[0];
        NSArray<NSString *> *accountIds = @[payerAccount.id, secondAccount.id];
        NSDictionary<NSString *,TKBalance *> *balances = [payer getBalances:accountIds withKey:Key_Level_Low];
        XCTAssert(balances.allKeys.count == 2);
        
        TKBalance *balance = balances[payerAccount.id];
        Money *currentBalance = balance.current;
        XCTAssert([currentBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", currentBalance.currency);
        Money *availableBalance = balance.available;
        XCTAssert([availableBalance.value intValue] > 0);
        XCTAssertEqualObjects(@"USD", availableBalance.currency);
        
    }];
}

- (void)testLookupTransaction {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token
                                            amount:@100.99
                                          currency:@"USD"
                                       description:@"full amount"
                                       destination:destination];
        
        Transaction *transaction = [payerAccount getTransaction:transfer.transactionId];
        
        XCTAssertEqualWithAccuracy(100.99, [transaction.amount.value doubleValue], 0.0);
        XCTAssertEqualObjects(@"USD", transaction.amount.currency);
        XCTAssertEqualObjects(token.id_p, transaction.tokenId);
        XCTAssertEqualObjects(transfer.id_p, transaction.tokenTransferId);
        XCTAssertTrue([transaction.description containsString:@"full amount"]);
    }];
}

- (void)testLookupTransactions {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:49.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:@"one" destination:destination];
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:@"two" destination:destination];
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:@"three" destination:destination];
        
        PagedArray<Transaction *> *lookedUp = [payerAccount getTransactionsOffset:NULL limit:3];
        XCTAssertEqual(3, lookedUp.items.count);
        XCTAssertNotNil(lookedUp.offset);
    }];
}

@end
