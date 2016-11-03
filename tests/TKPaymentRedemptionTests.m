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
#import "Transfer.pbobjc.h"


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
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                           amount:100.99
                                         currency:@"USD"
                                      description:@"transfer test"];
        TokenOperationResult *endorsedResult = [payer endorseToken:token];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);

        Transfer *transfer = [payee createTransfer:token];
        
        XCTAssertEqualObjects(@"", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testRedeemToken_withParams {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                           amount:100.99
                                         currency:@"USD"
                                      description:@"transfer test"];
        TokenOperationResult *endorsedResult = [payer endorseToken:token];
        
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        Transfer *transfer = [payee createTransfer:token amount:@99.12 currency:@"USD"];
        
        XCTAssertEqualObjects(@"99.12", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupTransfer {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                           amount:100.99
                                         currency:@"USD"
                                      description:@"transfer test"];
        TokenOperationResult *endorsedResult = [payer endorseToken:token];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        Transfer *transfer = [payee createTransfer:token amount:@99.12 currency:@"USD"];
        Transfer *lookedUp = [payer getTransfer:transfer.id_p];
        
        XCTAssertEqualObjects(transfer, lookedUp);
    }];
}

- (void)testLookupTransfers {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                           amount:100.99
                                         currency:@"USD"
                                      description:@"transfer test"];
        TokenOperationResult *endorsedResult = [payer endorseToken:token];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        [payee createTransfer:token amount:@11.11 currency:@"USD"];
        
        NSArray<Transfer *> *lookedUp = [payer getTransfersOffset:NULL
                                                            limit:100
                                                          tokenId:token.id_p];
        
        XCTAssertEqual(3, lookedUp.count);
    }];
}

@end
