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
#import "Payment.pbobjc.h"


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
        Money *balance = [payerAccount lookupBalance];
        XCTAssert(balance.value > 0);
        XCTAssertEqualObjects(@"USD", balance.currency);
    }];
}

- (void)testLookupTransaction {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];
        Payment *payment = [payee redeemPaymentToken:token];

        Transaction *transaction = [payerAccount lookupTransaction:payment.referenceId];

        XCTAssertEqualObjects(@"100.99", transaction.amount.value);
        XCTAssertEqualObjects(@"USD", transaction.amount.currency);
        XCTAssertEqualObjects(token.id_p, transaction.tokenId);
        XCTAssertEqualObjects(payment.id_p, transaction.tokenPaymentId);
    }];
}

- (void)testLookupTransactions {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];
        [payee redeemPaymentToken:token amount:@11.11 currency:@"USD"];
        [payee redeemPaymentToken:token amount:@11.11 currency:@"USD"];
        [payee redeemPaymentToken:token amount:@11.11 currency:@"USD"];

        NSArray<Payment *> *lookedUp = [payerAccount lookupTransactionsOffset:0 limit:3];
        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
