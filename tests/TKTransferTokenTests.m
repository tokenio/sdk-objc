//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"

@interface TKTransferTokenTests : TKTestBase
@end

@implementation TKTransferTokenTests {
    TKMemberSync *payer;
    TKAccountSync *payerAccount;
    TKMemberSync *payee;
    TKAccountSync *payeeAccount;
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

- (void)testCreateToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;

        NSArray<TransferEndpoint *> *destinations = @[destination];

        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.destinations = destinations;
        Token *token = [builder execute];
        
        XCTAssertEqualObjects(@"100.99", token.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
        XCTAssertEqualObjects(payee.firstAlias, token.payload.transfer.redeemer.alias);
        XCTAssertEqual(token.payload.transfer.instructions.destinationsArray.count, 1);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    }];
}

- (void)testCreateToken_invalidCurrency {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;
        
        NSArray<TransferEndpoint *> *destinations = @[destination];
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"XXX"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.destinations = destinations;
        
        @try {
            [builder execute];
        } @catch(NSError *error) {
            XCTAssertTrue(error.code == TransferTokenStatus_FailureInvalidCurrency);
            return;
        }
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        Token *lookedUp = [payer getToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.toAlias = payee.firstAlias;
        Token *token = [builder execute];
        [payer endorseToken:token withKey:Key_Level_Standard];
        
        TransferTokenBuilder *builder2 = [payer createTransferToken:100.22
                                                          currency:@"USD"];
        builder2.accountId = payerAccount.id;
        builder2.redeemerAlias = payee.firstAlias;
        builder2.toAlias = payee.firstAlias;
        Token *token2 = [builder2 execute];
        [payer endorseToken:token2 withKey:Key_Level_Standard];
        
        TransferTokenBuilder *builder3 = [payer createTransferToken:100.33
                                                          currency:@"USD"];
        builder3.accountId = payerAccount.id;
        builder3.redeemerAlias = payee.firstAlias;
        builder3.toAlias = payee.firstAlias;
        Token *token3 = [builder3 execute];
        [payer endorseToken:token3 withKey:Key_Level_Standard];
        
        [self waitUntil:^{
            PagedArray<Token *> *lookedUpPayer = [payer getTransferTokensOffset:NULL limit:100];
            PagedArray<Token *> *lookedUpPayee = [payee getTransferTokensOffset:NULL limit:100];

            [self check:@"Payer Transfer Token count" condition:lookedUpPayer.items.count == 3];
            [self check:@"Payer Offset is present" condition:lookedUpPayer.offset != nil];

            [self check:@"Payee Transfer Token count" condition:lookedUpPayee.items.count == 3];
            [self check:@"Payee Offset is present" condition:lookedUpPayee.offset != nil];
        }];
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        Token* endorsed = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        
        XCTAssertEqualObjects(@"100.11", endorsed.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", endorsed.payload.transfer.currency);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
    }];
}

- (void)testEndorseToken_Unicode {
    [self run: ^(TokenIOSync *tokenIO) {
        NSString *descr = @"e\u0301\U0001F30D\U0001F340🇧🇭👰🏿👩‍👩‍👧‍👧我"; // decomposed é, globe, leaf; real unicode symbols

        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.descr = descr;
        Token *token = [builder execute];

        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        Token* endorsed = [endorsedResult token];

        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);

        XCTAssertEqualObjects(descr, endorsed.payload.description_p);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
    }];
}

- (void)testCancelToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        TokenOperationResult *cancelledResult = [payer cancelToken:token];
        Token *cancelled = [cancelledResult token];
        XCTAssertEqual([cancelledResult status], TokenOperationResult_Status_Success);

        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        
        XCTAssertEqualObjects(@"100.11", cancelled.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", cancelled.payload.transfer.currency);
        XCTAssertEqual(2, cancelled.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
    }];
}

@end
