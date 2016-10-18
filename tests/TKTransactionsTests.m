//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Transaction.pbobjc.h"
#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Money.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transfer.pbobjc.h"


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
    
    [self run: ^(TokenIO *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
    }];
}

- (void)testLookupBalance {
    [self run: ^(TokenIO *tokenIO) {
        Money *balance = [payerAccount getBalance];
        XCTAssert(balance.value > 0);
        XCTAssertEqualObjects(@"USD", balance.currency);
    }];
}

- (void)testLookupTransaction {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [payer endorseToken:token];
        Transfer *transfer = [payee createTransfer:token];
        
        Transaction *transaction = [payerAccount getTransaction:transfer.referenceId];
        
        XCTAssertEqualObjects(@"100.99", transaction.amount.value);
        XCTAssertEqualObjects(@"USD", transaction.amount.currency);
        XCTAssertEqualObjects(token.id_p, transaction.tokenId);
        XCTAssertEqualObjects(transfer.id_p, transaction.tokenTransferId);
    }];
}

- (void)testLookupTransactions {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [payer endorseToken:token];
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        
        NSArray<Transaction *> *lookedUp = [payerAccount getTransactionsOffset:NULL limit:3];
        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
