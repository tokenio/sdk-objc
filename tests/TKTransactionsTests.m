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

- (void)testLookupBalance {
    [self run: ^(TokenIOSync *tokenIO) {
        Money *balance = [payerAccount getBalance];
        XCTAssert(balance.value > 0);
        XCTAssertEqualObjects(@"USD", balance.currency);
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
