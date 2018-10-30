//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
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
    TKMemberSync *payer;
    TKAccountSync *payeeAccount;
    TKMemberSync *payee;
}

- (void)setUp {
    [super setUp];
    TokenIOSync *tokenIO = [self syncSDK];
    payerAccount = [self createAccount:tokenIO];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenIO];
    payee = payeeAccount.member;
}

- (void)testRedeemToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    token = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payeeAccount.member.id;
    destination.account.token.accountId = payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50.1"];
    Transfer *transfer = [payee redeemToken:token
                                     amount:redeemAmount
                                   currency:@"USD"
                                description:@"lunch"
                                destination:destination];
    bool transferComplete = transfer.status == TransactionStatus_Success
    || transfer.status == TransactionStatus_Processing;
    XCTAssert(transferComplete);
    XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
    XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
    XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
}

- (void)testRedeemToken_withParams {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    
    token = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payeeAccount.member.id;
    destination.account.token.accountId = payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"99.12"];
    Transfer *transfer = [payee redeemToken:token
                                     amount:redeemAmount
                                   currency:@"USD"
                                description:@"test"
                                destination:destination];
    
    bool transferComplete = transfer.status == TransactionStatus_Success
    || transfer.status == TransactionStatus_Processing;
    XCTAssert(transferComplete);
    XCTAssertEqualObjects(@"99.12", transfer.payload.amount.value);
    XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
    XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
}

- (void)testRedeemTokenDestination {
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.accountId = payeeAccount.id;
    destination.account.token.memberId = payee.id;
    NSArray<TransferEndpoint *> *destinations = [NSArray arrayWithObjects:destination, nil];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    Token *token = [builder execute];
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    token = [endorsedResult token];
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50.1"];
    Transfer *transfer = [payee redeemToken:token
                                     amount:redeemAmount
                                   currency:@"USD"
                                description:@"lunch"
                                destination:destination];
    
    bool transferComplete = transfer.status == TransactionStatus_Success
    || transfer.status == TransactionStatus_Processing;
    XCTAssert(transferComplete);
    XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
    XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
    XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
}

- (void)testLookupTransfer {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.42"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    token = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payeeAccount.member.id;
    destination.account.token.accountId = payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"99.12"];
    Transfer *transfer = [payee redeemToken:token
                                     amount:redeemAmount
                                   currency:@"USD"
                                description:nil
                                destination:destination];
    Transfer *lookedUp = [payer getTransfer:transfer.id_p];
    
    XCTAssertEqualObjects(transfer, lookedUp);
}

- (void)testLookupTransfers {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    token = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payeeAccount.member.id;
    destination.account.token.accountId = payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"11.11"];
    [payee redeemToken:token amount:redeemAmount currency:@"USD" description:nil destination:destination];
    [payee redeemToken:token amount:redeemAmount currency:@"USD" description:nil destination:destination];
    [payee redeemToken:token amount:redeemAmount currency:@"USD" description:nil destination:destination];
    
    
    [self waitUntil:^{
        PagedArray<Transfer *> *lookedUpPayer = [self->payer getTransfersOffset:NULL
                                                                          limit:100
                                                                        tokenId:token.id_p];
        PagedArray<Transfer *> *lookedUpPayee = [self->payee getTransfersOffset:NULL
                                                                          limit:100
                                                                        tokenId:token.id_p];
        
        [self check:@"Payer Transfer count" condition:lookedUpPayer.items.count == 3];
        [self check:@"Payer Offset is present" condition:lookedUpPayer.offset != nil];
        
        [self check:@"Payee Transfer count" condition:lookedUpPayee.items.count == 3];
        [self check:@"Payee Offset is present" condition:lookedUpPayee.offset != nil];
    }];
}

@end
