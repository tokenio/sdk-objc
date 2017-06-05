//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"

@interface TKTransferTokenTests : TKTestBase
@end

@implementation TKTransferTokenTests {
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
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;

        NSArray<TransferEndpoint *> *destinations = @[destination];

        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerUsername = payee.firstUsername;
        builder.destinations = destinations;
        Token *token = [builder execute];
        
        XCTAssertEqualObjects(@"100.99", token.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
        XCTAssertEqualObjects(payee.firstUsername, token.payload.transfer.redeemer.username);
        XCTAssertEqual(token.payload.transfer.instructions.destinationsArray.count, 1);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerUsername = payee.firstUsername;
        Token *token = [builder execute];
        Token *lookedUp = [payer getToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerUsername = payee.firstUsername;
        [builder execute];
        
        TransferTokenBuilder *builder2 = [payer createTransferToken:100.22
                                                          currency:@"USD"];
        builder2.accountId = payerAccount.id;
        builder2.redeemerUsername = payee.firstUsername;
        [builder2 execute];
        
        TransferTokenBuilder *builder3 = [payer createTransferToken:100.33
                                                          currency:@"USD"];
        builder3.accountId = payerAccount.id;
        builder3.redeemerUsername = payee.firstUsername;
        [builder3 execute];
        
        PagedArray<Token *> *lookedUp = [payer getTransferTokensOffset:NULL limit:100];
        XCTAssertEqual(lookedUp.items.count, 3);
        XCTAssertNotNil(lookedUp.offset);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerUsername = payee.firstUsername;
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


- (void)testCancelToken {
    [self run: ^(TokenIO *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerUsername = payee.firstUsername;
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
