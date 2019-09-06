//
//  StandingOrderTests.m
//  TokenSdkTests
//
//  Created by Sibin Lu on 9/5/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"
#import "TokenClient.h"
#import "TKMember.h"

@interface StandingOrderTests : TKTestBase {
    TKMember *payer;
    TKAccount *payerAccount;
    TKMember *payee;
    TKAccount *payeeAccount;
    TokenClient *tokenClient;
}
@end

@implementation StandingOrderTests

- (void)setUp {
    [super setUp];
    tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testStandingOrderToken {
    Token *token = [self standingOrderToken:@"100.99"];
    XCTAssertEqualObjects(@"100.99", token.payload.standingOrder.amount);
    XCTAssertEqualObjects(@"EUR", token.payload.standingOrder.currency);
    XCTAssertEqualObjects(@"DAIL", token.payload.standingOrder.frequency);
    XCTAssertEqualObjects([self tomorrow], token.payload.standingOrder.startDate);
    XCTAssertEqualObjects([self nextWeek], token.payload.standingOrder.endDate);
}

- (void)testGetStandingOrder {
    StandingOrderSubmission *submission = [self standingOrderSubmission:@"100.99"];

    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer getStandingOrder:submission.standingOrderId
                 forAccount:payerAccount.id
                    withKey:Key_Level_Low
                  onSuccess:^(StandingOrder *standingOrder) {
                      XCTAssertEqualObjects(standingOrder.id_p, submission.standingOrderId);
                      XCTAssertEqualObjects(standingOrder.tokenSubmissionId, submission.id_p);
                      [expectation fulfill];
                  }
                    onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    TKTestExpectation *expectation2 = [[TKTestExpectation alloc] init];
    [payer getStandingOrderSubmission:submission.id_p
                            onSuccess:^(StandingOrderSubmission *standingOrderSubmission) {
                                XCTAssertEqualObjects(standingOrderSubmission.id_p, submission.id_p);
                                XCTAssertEqualObjects(@"100.99", standingOrderSubmission.payload.amount);
                                XCTAssertEqualObjects(@"EUR", standingOrderSubmission.payload.currency);
                                XCTAssertEqualObjects(@"DAIL", standingOrderSubmission.payload.frequency);
                                XCTAssertEqualObjects([self tomorrow], standingOrderSubmission.payload.startDate);
                                XCTAssertEqualObjects([self nextWeek], standingOrderSubmission.payload.endDate);
                                [expectation2 fulfill];
                            } onError:THROWERROR];
    [self waitForExpectations:@[expectation2] timeout:10];
}

- (void)testGetStandingOrders {
    StandingOrderSubmission *submission0 = [self standingOrderSubmission:@"100.99"];
    StandingOrderSubmission *submission1 = [self standingOrderSubmission:@"101.99"];
    StandingOrderSubmission *submission2 = [self standingOrderSubmission:@"102.99"];

    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer getStandingOrdersOffset:nil
                             limit:10
                        forAccount:payerAccount.id
                           withKey:Key_Level_Low
                         onSuccess:^(PagedArray<StandingOrder *> *pagedArray) {
                             XCTAssertEqual(pagedArray.items.count, 3);
                             XCTAssertEqualObjects(pagedArray.items[0].tokenSubmissionId, submission2.id_p);
                             XCTAssertEqualObjects(pagedArray.items[1].tokenSubmissionId, submission1.id_p);
                             XCTAssertEqualObjects(pagedArray.items[2].tokenSubmissionId, submission0.id_p);
                             [expectation fulfill];
                         } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    TKTestExpectation *expectation2 = [[TKTestExpectation alloc] init];
    [self runUntilTrue:^{
        [self->payer getStandingOrderSubmissionsOffset:nil
                                                 limit:10
                                             onSuccess:^(PagedArray<StandingOrderSubmission *> *pagedArray) {
                                                 if (pagedArray.items.count == 3) {
                                                     XCTAssertEqualObjects(pagedArray.items[0].id_p, submission2.id_p);
                                                     XCTAssertEqualObjects(pagedArray.items[1].id_p, submission1.id_p);
                                                     XCTAssertEqualObjects(pagedArray.items[2].id_p, submission0.id_p);
                                                     [expectation2 fulfill];
                                                 }
                                             } onError:THROWERROR];
        return (int) expectation2.isFulfilled ;
    }];

    [self waitForExpectations:@[expectation2] timeout:10];
}

- (StandingOrderSubmission *)standingOrderSubmission:(NSString *)amount {
    Token *token = [self standingOrderToken:amount];
    __block StandingOrderSubmission *result = nil;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer redeemStandingOrderToken:token.id_p
                          onSuccess:^(StandingOrderSubmission *submission) {
                              result = submission;
                              [expectation fulfill];
                          } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    return result;
}

- (Token *)standingOrderToken:(NSString *)amount {
    __block Token *result = nil;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer
     prepareStandingOrderToken:[self preparedBuilder:amount]
     onSuccess:^(PrepareTokenResult *prepareTokenResult) {
         [self->payer createToken:prepareTokenResult.tokenPayload
             tokenRequestId:nil
                   keyLevel:Key_Level_Standard
                  onSuccess:^(Token *token) {
                      result = token;
                      [expectation fulfill];
                  } onError:THROWERROR];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    return result;
}

- (StandingOrderTokenBuilder *)preparedBuilder:(NSString *)amount {
    return [self preparedBuilder:amount currency:@"EUR"];
}

- (StandingOrderTokenBuilder *)preparedBuilder:(NSString *)amount currency:(NSString *)currency {
    TransferDestination *transferDestination = [[TransferDestination alloc] init];
    transferDestination.token.accountId = payeeAccount.id;
    transferDestination.token.memberId = payee.id;

    NSDecimalNumber *decimal = [NSDecimalNumber decimalNumberWithString:amount];
    StandingOrderTokenBuilder *builder = [payer createStandingOrderTokenBuilder:decimal
                                                                       currency:currency
                                                                      frequency:@"DAIL"
                                                                      startDate:[self tomorrow]
                                                                        endDate:[self nextWeek]];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.fromAlias = payer.aliases.firstObject;
    builder.toAlias = payee.aliases.firstObject;
    builder.transferDestinations = @[transferDestination];
    return builder;
}
@end
