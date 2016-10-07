//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Token.pbobjc.h"
#import "Payment.pbobjc.h"


@interface TKPaymentRedemptionTests : TKTestBase
@end

@implementation TKPaymentRedemptionTests {
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

- (void)testRedeemToken {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];
        Payment *payment = [payee redeemPaymentToken:token];

        XCTAssertEqualObjects(@"100.99", payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        XCTAssertEqual(2, payment.payloadSignaturesArray_Count);
    }];
}

- (void)testRedeemToken_withParams {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];

        Payment *payment = [payee redeemPaymentToken:token amount:@99.12 currency:@"USD"];

        XCTAssertEqualObjects(@"99.12", payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        XCTAssertEqual(2, payment.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupPayment {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];

        Payment *payment = [payee redeemPaymentToken:token amount:@99.12 currency:@"USD"];
        Payment *lookedUp = [payer getPayment:payment.id_p];

        XCTAssertEqualObjects(payment, lookedUp);
    }];
}

- (void)testLookupPayments {
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

        NSArray<Payment *> *lookedUp = [payer getPaymentsOffset:0
                                                          limit:100
                                                        tokenId:token.id_p];

        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
