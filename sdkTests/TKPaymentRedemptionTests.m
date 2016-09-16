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

- (void)testRedeemToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];

        Payment *payment = [payee redeemToken:token];

        XCTAssertEqual(100.99, payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        XCTAssertEqual(2, payment.signatureArray_Count);
    }];
}

- (void)testRedeemToken_withParams {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];

        Payment *payment = [payee redeemToken:token amount:@99.12 currency:@"USD"];

        XCTAssertEqual(99.12, payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        XCTAssertEqual(2, payment.signatureArray_Count);
    }];
}

- (void)testLookupPayment {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];

        Payment *payment = [payee redeemToken:token amount:@99.12 currency:@"USD"];
        Payment *lookedUp = [payer.member lookupPayment:payment.id_p];

        XCTAssertEqualObjects(payment, lookedUp);
    }];
}

- (void)testLookupPayments {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenWithAmount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.member.firstAlias
                                        description:@"payment test"];
        token = [payer endorseToken:token];

        [payee redeemToken:token amount:@11.11 currency:@"USD"];
        [payee redeemToken:token amount:@11.11 currency:@"USD"];
        [payee redeemToken:token amount:@11.11 currency:@"USD"];

        NSArray<Payment *> *lookedUp = [payer.member
                lookupPaymentsOffset:0
                               limit:100
                             tokenId:token.id_p];

        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
