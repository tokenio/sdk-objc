//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "PagedArray.h"

@interface TKTransferTokenRedemptionTests : TKTestBase
@end

@implementation TKTransferTokenRedemptionTests {
    TKAccount *payerAccount;
    TKMember *payer;
    TKAccount *payeeAccount;
    TKMember *payee;
}

- (void)setUp {
    [super setUp];
    TokenClient *tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testRedeemToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            Token *endorsed = [endorsedResult token];
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50.1"];
            [self->payee
             redeemToken:endorsed
             amount:redeemAmount
             currency:@"USD"
             description:@"lunch"
             destination:destination
             onSuccess:^(Transfer *transfer) {
                 XCTAssert((transfer.status == TransactionStatus_Success)
                           || (transfer.status == TransactionStatus_Processing));
                 XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
                 XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
                 XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testRedeemToken_withParams {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            Token *endorsed = [endorsedResult token];
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"99.12"];
            [self->payee
             redeemToken:endorsed
             amount:redeemAmount
             currency:@"USD"
             description:@"test"
             destination:destination
             onSuccess:^(Transfer *transfer) {
                 XCTAssert((transfer.status == TransactionStatus_Success)
                           || (transfer.status == TransactionStatus_Processing));
                 XCTAssertEqualObjects(@"99.12", transfer.payload.amount.value);
                 XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
                 XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
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
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            Token *endorsed = [endorsedResult token];
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50.1"];
            [self->payee
             redeemToken:endorsed
             amount:redeemAmount
             currency:@"USD"
             description:@"lunch"
             destination:destination
             onSuccess:^(Transfer *transfer) {
                 XCTAssert((transfer.status == TransactionStatus_Success)
                           || (transfer.status == TransactionStatus_Processing));
                 XCTAssertEqualObjects(@"50.1", transfer.payload.amount.value);
                 XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
                 XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTransfer {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.42"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            Token *endorsed = [endorsedResult token];
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"99.12"];
            [self->payee
             redeemToken:endorsed
             amount:redeemAmount
             currency:@"USD"
             description:nil
             destination:destination
             onSuccess:^(Transfer *transfer) {
                 [self->payer getTransfer:transfer.id_p onSuccess:^(Transfer *lookedUp) {
                     XCTAssertEqualObjects(transfer, lookedUp);
                     [expectation fulfill];
                 } onError:THROWERROR];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTransfers {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.toMemberId = payee.id;
    
    __block Token *endorsed = nil;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *token) {
        [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *endorsedResult) {
            XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
            endorsed = [endorsedResult token];
            [expectation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = self->payeeAccount.member.id;
    destination.account.token.accountId = self->payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"11.11"];
    for (int i = 0; i < 3; i++) {
        TKTestExpectation *redeemExpectation = [[TKTestExpectation alloc] init];
        [self->payee
         redeemToken:endorsed
         amount:redeemAmount
         currency:@"USD"
         description:nil
         destination:destination
         onSuccess:^(Transfer *transfer) {
             [redeemExpectation fulfill];
         } onError:THROWERROR];
        [self waitForExpectations:@[redeemExpectation] timeout:10];
    }
    
    TKTestExpectation *payerExpectation = [[TKTestExpectation alloc] initWithDescription:@"Payer transfer tokens"];
    TKTestExpectation *payeeExpectation = [[TKTestExpectation alloc] initWithDescription:@"Payee transfer tokens"];
    [self runUntilTrue:^{
        [self->payer getTransfersOffset:NULL limit:100 onSuccess:^(PagedArray<Token *> *lookedUp) {
            if (lookedUp.items.count == 3 && lookedUp.offset != nil) {
                [payerExpectation fulfill];
            }
        } onError:THROWERROR];
        
        [self->payee getTransfersOffset:NULL limit:100 onSuccess:^(PagedArray<Token *> *lookedUp) {
            if (lookedUp.items.count == 3 && lookedUp.offset != nil) {
                [payeeExpectation fulfill];
            }
        } onError:THROWERROR];
        
        return (payerExpectation.isFulfilled && payeeExpectation.isFulfilled) ;
    }];
    [self waitForExpectations:@[payerExpectation, payeeExpectation] timeout:10];
}

@end
