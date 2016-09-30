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
        Token *token = [payer createTokenForAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                      redeemerAlias:payee.firstAlias
                                        description:@"Book purchase"];

        XCTAssertEqualObjects(@"100.99", token.payment.amount);
        XCTAssertEqualObjects(@"USD", token.payment.currency);
        XCTAssertEqualObjects(payee.firstAlias, token.payment.redeemer.alias);
        XCTAssertEqual(0, token.signaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenForAccount:payerAccount.id amount:100.99 currency:@"USD"];
        Token *lookedUp = [payer lookupToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        [payer createTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        [payer createTokenForAccount:payerAccount.id amount:100.22 currency:@"USD"];
        [payer createTokenForAccount:payerAccount.id amount:100.33 currency:@"USD"];

        NSArray<Token *> *lookedUp = [payer lookupTokensOffset:0 limit:100];
        XCTAssertEqual(lookedUp.count, 3);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        Token *endorsed = [payer endorseToken:token];

        XCTAssertEqual(0, token.signaturesArray_Count);

        XCTAssertEqualObjects(@"100.11", endorsed.payment.amount);
        XCTAssertEqualObjects(@"USD", endorsed.payment.currency);
        XCTAssertEqual(2, endorsed.signaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.signaturesArray[0].action);
    }];
}

- (void)testDeclineToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        Token *declined = [payer declineToken:token];

        XCTAssertEqual(0, token.signaturesArray_Count);

        XCTAssertEqualObjects(@"100.11", declined.payment.amount);
        XCTAssertEqualObjects(@"USD", declined.payment.currency);
        XCTAssertEqual(2, declined.signaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Declined, declined.signaturesArray[0].action);
    }];
}

- (void)testRevokeToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        Token *endorsed = [payer endorseToken:token];
        Token *revoked = [payer revokeToken:endorsed];

        XCTAssertEqual(0, token.signaturesArray_Count);
        XCTAssertEqual(2, endorsed.signaturesArray_Count);

        XCTAssertEqualObjects(@"100.11", revoked.payment.amount);
        XCTAssertEqualObjects(@"USD", revoked.payment.currency);
        XCTAssertEqual(4, revoked.signaturesArray_Count);
    }];
}

@end
