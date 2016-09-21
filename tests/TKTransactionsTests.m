//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Transaction.pbobjc.h>
#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Money.pbobjc.h"
#import "Token.pbobjc.h"
#import "Payment.pbobjc.h"


@interface TKTransactionsTests : TKTestBase
@end

@implementation TKTransactionsTests {
    TKAccount *payer;
    TKAccount *payee;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIO *tokenIO) {
        payer = [self createAccount:tokenIO];
        payee = [self createAccount:tokenIO];
    }];
}

- (void)testLookupBalance {
    [self run: ^(TokenIO *tokenIO) {
        Money *balance = [payer lookupBalance];
        XCTAssert(balance.value > 0);
        XCTAssertEqualObjects(@"USD", balance.currency);
    }];
}

- (void)testLookupTransaction {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];
        Payment *payment = [payee redeemToken:token];

        Transaction *transaction = [payer lookupTransaction:payment.referenceId];

        XCTAssertEqualObjects(@"100.99", transaction.amount.value);
        XCTAssertEqualObjects(@"USD", transaction.amount.currency);
        XCTAssertEqualObjects(token.id_p, transaction.tokenId);
        XCTAssertEqualObjects(payment.id_p, transaction.tokenPaymentId);
    }];
}

- (void)testLookupTransactions {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];
        [payee redeemToken:token amount:@11.11 currency:@"USD"];
        [payee redeemToken:token amount:@11.11 currency:@"USD"];
        [payee redeemToken:token amount:@11.11 currency:@"USD"];

        NSArray<Payment *> *lookedUp = [payer lookupTransactionsOffset:0 limit:3];
        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
