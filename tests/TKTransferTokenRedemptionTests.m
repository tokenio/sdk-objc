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
    Token *endorsed = [self createToken:[self preparedBuilder]];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = self->payeeAccount.member.id;
    destination.account.token.accountId = self->payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    [self->payee
     redeemToken:endorsed
     amount:redeemAmount
     currency:@"USD"
     description:@"lunch"
     destination:destination
     onSuccess:^(Transfer *transfer) {
         XCTAssert((transfer.status == TransactionStatus_Success)
                   || (transfer.status == TransactionStatus_Processing));
         XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
         XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
         XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
         [expectation fulfill];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testRedeemToken_withParams {
    Token *endorsed = [self createToken:[self preparedBuilder]];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = self->payeeAccount.member.id;
    destination.account.token.accountId = self->payeeAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    [self->payee
     redeemToken:endorsed
     amount:redeemAmount
     currency:@"USD"
     description:@"test"
     destination:destination
     onSuccess:^(Transfer *transfer) {
         XCTAssert((transfer.status == TransactionStatus_Success)
                   || (transfer.status == TransactionStatus_Processing));
         XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
         XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
         XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
         [expectation fulfill];
     } onError:THROWERROR];    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testRedeemTokenDestination {
    TransferDestination *destination = [TransferDestination message];
    destination.token.accountId = payeeAccount.id;
    destination.token.memberId = payee.id;
    
    Token *endorsed = [self createToken:[self preparedBuilder]];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    [self->payee
     redeemToken:endorsed
     amount:redeemAmount
     currency:@"USD"
     description:@"lunch"
     transferDestination:destination
     onSuccess:^(Transfer *transfer) {
         XCTAssert((transfer.status == TransactionStatus_Success)
                   || (transfer.status == TransactionStatus_Processing));
         XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
         XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
         XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
         [expectation fulfill];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTransfer {
    TransferDestination *destination = [TransferDestination message];
    destination.token.accountId = payeeAccount.id;
    destination.token.memberId = payee.id;
    
    Token * _Nonnull endorsed = [self createToken:[self preparedBuilder]];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    [self->payee
     redeemToken:endorsed
     amount:redeemAmount
     currency:@"USD"
     description:nil
     transferDestination:destination
     onSuccess:^(Transfer *transfer) {
         [self->payer getTransfer:transfer.id_p onSuccess:^(Transfer *lookedUp) {
             XCTAssertEqualObjects(transfer, lookedUp);
             [expectation fulfill];
         } onError:THROWERROR];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (TransferTokenBuilder *)preparedBuilder {
    return [self preparedBuilder:@"100.99"];
}

- (TransferTokenBuilder *)preparedBuilder:(NSString *)amount {
    return [self preparedBuilder:@"100.99" currency:@"USD"];
}

- (TransferTokenBuilder *)preparedBuilder:(NSString *)amount currency:(NSString *)currency {
    TransferDestination *transferDestination = [[TransferDestination alloc] init];
    transferDestination.token.accountId = payeeAccount.id;
    transferDestination.token.memberId = payee.id;
    
    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:amount];
    TransferTokenBuilder *builder = [payer createTransferToken:decimal
                                                      currency:currency];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.transferDestinations = @[transferDestination];
    return builder;
}
@end
