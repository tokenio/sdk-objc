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
        Token *token = [payer createTransferTokenForAccount:payerAccount.id
                                                     amount:100.99
                                                   currency:@"USD"
                                              redeemerAlias:payee.firstAlias
                                                description:@"Book purchase"];
        
        XCTAssertEqualObjects(@"100.99", token.payload.transfer.amount);
        XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
        XCTAssertEqualObjects(payee.firstAlias, token.payload.transfer.redeemer.alias);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferTokenForAccount:payerAccount.id
                                                     amount:100.99
                                                   currency:@"USD"];
        Token *lookedUp = [payer getTransferToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        [payer createTransferTokenForAccount:payerAccount.id amount:100.11 currency:@"USD"];
        [payer createTransferTokenForAccount:payerAccount.id amount:100.22 currency:@"USD"];
        [payer createTransferTokenForAccount:payerAccount.id amount:100.33 currency:@"USD"];
        
        NSArray<Token *> *lookedUp = [payer getTransferTokensOffset:0 limit:100];
        XCTAssertEqual(lookedUp.count, 3);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferTokenForAccount:payerAccount.id
                                                     amount:100.11
                                                   currency:@"USD"];
        Token *endorsed = [payer endorseTransferToken:token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        
        XCTAssertEqualObjects(@"100.11", endorsed.payload.transfer.amount);
        XCTAssertEqualObjects(@"USD", endorsed.payload.transfer.currency);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
    }];
}

- (void)testCancelToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferTokenForAccount:payerAccount.id
                                                     amount:100.11
                                                   currency:@"USD"];
        Token *cancelled = [payer cancelTransferToken:token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        
        XCTAssertEqualObjects(@"100.11", cancelled.payload.transfer.amount);
        XCTAssertEqualObjects(@"USD", cancelled.payload.transfer.currency);
        XCTAssertEqual(2, cancelled.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
    }];
}

@end
