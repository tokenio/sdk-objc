//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Token.pbobjc.h"


@interface TKPaymentTokenTests : TKTestBase
@end

@implementation TKPaymentTokenTests {
    TKMember *payer;
    TKAccount *payerAccount;
    TKMember *payee;
    TKAccount *payeeAccount;
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

- (void)testCreateToken {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"Book purchase"];

        XCTAssertEqualObjects(@"100.99", token.payload.amount);
        XCTAssertEqualObjects(@"USD", token.payload.currency);
        XCTAssertEqualObjects(payee.firstAlias, token.payload.redeemer.alias);
        XCTAssertEqual(0, token.signaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"];
        PaymentToken *lookedUp = [payer lookupPaymentToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        [payer createPaymentTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        [payer createPaymentTokenForAccount:payerAccount.id amount:100.22 currency:@"USD"];
        [payer createPaymentTokenForAccount:payerAccount.id amount:100.33 currency:@"USD"];

        NSArray<PaymentToken *> *lookedUp = [payer lookupPaymentTokensOffset:0 limit:100];
        XCTAssertEqual(lookedUp.count, 3);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.11
                                                         currency:@"USD"];
        PaymentToken *endorsed = [payer endorsePaymentToken:token];

        XCTAssertEqual(0, token.signaturesArray_Count);

        XCTAssertEqualObjects(@"100.11", endorsed.payload.amount);
        XCTAssertEqualObjects(@"USD", endorsed.payload.currency);
        XCTAssertEqual(2, endorsed.signaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.signaturesArray[0].action);
    }];
}

- (void)testCancelToken {
    [self run: ^(TokenIO *tokenIO) {
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.11
                                                         currency:@"USD"];
        PaymentToken *cancelled = [payer cancelPaymentToken:token];

        XCTAssertEqual(0, token.signaturesArray_Count);

        XCTAssertEqualObjects(@"100.11", cancelled.payload.amount);
        XCTAssertEqualObjects(@"USD", cancelled.payload.currency);
        XCTAssertEqual(2, cancelled.signaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.signaturesArray[0].action);
    }];
}

@end
