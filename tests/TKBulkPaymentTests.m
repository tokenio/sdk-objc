//
//  TKBulkPaymentTests.m
//  TokenSdkTests
//
//  Created by Sibin Lu on 10/16/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCTest/XCTest.h>
#import "TKTestBase.h"
#import "TokenClient.h"
#import "TKMember.h"

@interface TKBulkPaymentTests : TKTestBase {
    TKMember *payer;
    TKAccount *payerAccount;
    TKMember *payee;
    TKAccount *payeeAccount;
    TokenClient *tokenClient;
}
@end

@implementation TKBulkPaymentTests

- (void)setUp {
    [super setUp];
    tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testRedeemToken {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer
     prepareBulkTransferToken:[self createBulkTransferToken:5]
     onSuccess:^(PrepareTokenResult *result) {
        [self->payer
         createToken:result.tokenPayload
            tokenRequestId:nil
         keyLevel:Key_Level_Standard
         onSuccess:^(Token *token) {
            [self->payer
             redeemBulkTransferToken:token.id_p
             onSuccess:^(BulkTransfer *transfer) {
                 XCTAssertEqual(transfer.transactionsArray_Count, 5);
                 XCTAssertEqual([transfer.transactionsArray objectAtIndex:0].status, TransactionStatus_Success);
                                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetBulkTransfer {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer
     prepareBulkTransferToken:[self createBulkTransferToken:5]
     onSuccess:^(PrepareTokenResult *result) {
        [self->payer
         createToken:result.tokenPayload
            tokenRequestId:nil
         keyLevel:Key_Level_Standard
         onSuccess:^(Token *token) {
            [self->payer
             redeemBulkTransferToken:token.id_p
             onSuccess:^(BulkTransfer *transfer) {
                [self->payer
                 getBulkTransfer:transfer.id_p
                 onSuccess:^(BulkTransfer *transfer) {
                    XCTAssertEqual(transfer.transactionsArray_Count, 5);
                    XCTAssertEqual([transfer.transactionsArray objectAtIndex:0].status, TransactionStatus_Success);
                    [expectation fulfill];
                } onError:THROWERROR];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (BulkTransferBody_Transfer *) bulkTransfer:(NSDecimalNumber *) amount{
    BulkTransferBody_Transfer *transfer = [BulkTransferBody_Transfer message];
    transfer.refId = [TKUtil nonce];
    transfer.destination.swift.account = [TKUtil nonce];
    transfer.destination.swift.bic = [TKUtil nonce];
    transfer.currency = @"USD";
    transfer.amount = [amount stringValue];;

    return transfer;
}

- (BulkTransferTokenBuilder *)createBulkTransferToken:(NSInteger) count{
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *total = NSDecimalNumber.zero;
    NSMutableArray<BulkTransferBody_Transfer *> *transfers = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        [transfers addObject:[self bulkTransfer:amount]];
        total = [total decimalNumberByAdding:amount];
    }

    TransferEndpoint *source = [TransferEndpoint message];
    source.account.token.memberId = payer.id;
    source.account.token.accountId = payerAccount.id;

    BulkTransferTokenBuilder *builder = [payer createBulkTransferTokenBuilder:transfers
                                                                  totalAmount:total
                                                                       source:source];
    builder.toMemberId = payee.id;
    builder.toAlias = payee.firstAlias;

    return builder;
}
@end
