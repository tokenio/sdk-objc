//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Money.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"


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
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);

        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        Transfer *transfer = [payee createTransfer:token amount:@(50.1) currency:@"USD" description:@"lunch" destination:destination];
        
        XCTAssertEqual(TransactionStatus_Success, transfer.status);
        XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
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
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        Transfer *transfer = [payee createTransfer:token amount:@99.12 currency:@"USD" description:@"test" destination:destination];

        XCTAssertEqual(TransactionStatus_Success, transfer.status);
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
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        Transfer *transfer = [payee createTransfer:token amount:@99.12 currency:@"USD" description:nil destination:destination];
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
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        [payee createTransfer:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        [payee createTransfer:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        [payee createTransfer:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        
        PagedArray<Transfer *> *lookedUp = [payer getTransfersOffset:NULL
                                                            limit:100
                                                          tokenId:token.id_p];
        
        XCTAssertEqual(3, lookedUp.items.count);
        XCTAssertNotNil(lookedUp.offset);
    }];
}

@end
