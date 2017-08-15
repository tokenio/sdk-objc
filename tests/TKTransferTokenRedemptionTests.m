//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"


@interface TKTransferTokenRedemptionTests : TKTestBase
@end

@implementation TKTransferTokenRedemptionTests {
    TKAccountSync *payerAccount;
    TKMember *payer;
    TKAccountSync *payeeAccount;
    TKMember *payee;
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

- (void)testRedeemToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);

        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token amount:@(50.1)
                                          currency:@"USD"
                                       description:@"lunch"
                                       destination:destination];
        bool transferComplete = transfer.status == TransactionStatus_Success
            || transfer.status == TransactionStatus_Processing;
        XCTAssert(transferComplete);
        XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testRedeemTokenBankAuthorization {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.bankAuthorization = [self createBankAuthorization:tokenIO memberId:payer.id];
        builder.redeemerAlias = payer.firstAlias;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        NSLog(@"%@", payee.firstAlias);
        NSLog(@"%@", payee.firstAlias);
        

        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payer redeemToken:token amount:@(50.1)
                                          currency:@"USD"
                                       description:@"lunch"
                                       destination:destination];
        bool transferComplete = transfer.status == TransactionStatus_Success
            || transfer.status == TransactionStatus_Processing;
        XCTAssert(transferComplete);
        XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testRedeemToken_withParams {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token
                                            amount:@99.12
                                          currency:@"USD"
                                       description:@"test"
                                       destination:destination];

        bool transferComplete = transfer.status == TransactionStatus_Success
            || transfer.status == TransactionStatus_Processing;
        XCTAssert(transferComplete);
        XCTAssertEqualObjects(@"99.12", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testRedeemTokenDestination {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;
        NSArray<TransferEndpoint *> *destinations = [NSArray arrayWithObjects:destination, nil];
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.destinations = destinations;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);

        Transfer *transfer = [payee redeemToken:token
                                            amount:@(50.1)
                                          currency:@"USD"
                                       description:@"lunch"
                                       destination:destination];
        
        bool transferComplete = transfer.status == TransactionStatus_Success
            || transfer.status == TransactionStatus_Processing;
        XCTAssert(transferComplete);
        XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupTransfer {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.42
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token amount:@99.12 currency:@"USD" description:nil destination:destination];
        Transfer *lookedUp = [payer getTransfer:transfer.id_p];
        
        XCTAssertEqualObjects(transfer, lookedUp);
    }];
}

- (void)testLookupTransfers {
    [self run: ^(TokenIOSync *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
        token = [endorsedResult token];
        
        XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        [payee redeemToken:token amount:@11.11 currency:@"USD" description:nil destination:destination];
        
        PagedArray<Transfer *> *lookedUp = [payer getTransfersOffset:NULL
                                                            limit:100
                                                          tokenId:token.id_p];
        
        XCTAssertEqual(3, lookedUp.items.count);
        XCTAssertNotNil(lookedUp.offset);
    }];
}

@end
