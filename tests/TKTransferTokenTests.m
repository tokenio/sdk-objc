//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Account.pbobjc.h"
#import "TokenRequestResult.h"
#import "Transferinstructions.pbobjc.h"
#import "PagedArray.h"

@interface TKTransferTokenTests : TKTestBase
@end

@implementation TKTransferTokenTests {
    TKMember *payer;
    TKAccount *payerAccount;
    TKMember *payee;
    TKAccount *payeeAccount;
    TokenClient *tokenClient;
}

- (void)setUp {
    [super setUp];
    tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testCreateToken {
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
    destination.account.token.accountId = payeeAccount.id;
    destination.account.token.memberId = payee.id;
    
    NSArray<TransferEndpoint *> *destinations = @[destination];
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    Token *token = [builder execute];
    
    XCTAssertEqualObjects(@"100.99", token.payload.transfer.lifetimeAmount);
    XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
    XCTAssertEqual(token.payload.transfer.instructions.destinationsArray.count, 1);
    XCTAssertEqual(0, token.payloadSignaturesArray_Count);
}

- (void)testCreateToken_invalidCurrency {
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
    destination.account.token.accountId = payeeAccount.id;
    destination.account.token.memberId = payee.id;
    
    NSArray<TransferEndpoint *> *destinations = @[destination];
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"XXX"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    
    @try {
        [builder execute];
    } @catch(NSError *error) {
        XCTAssertTrue(error.code == TransferTokenStatus_FailureInvalidCurrency);
        return;
    }
}

- (void)testLookupToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [payer getToken:token.id_p onSuccess:^(Token *lookedUp) {
        XCTAssertEqualObjects(token, lookedUp);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTokens {
    NSArray<NSDecimalNumber *> * amounts =
    @[[NSDecimalNumber decimalNumberWithString:@"100.11"],
      [NSDecimalNumber decimalNumberWithString:@"100.22"],
      [NSDecimalNumber decimalNumberWithString:@"100.33"]];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    expectation.expectedFulfillmentCount = amounts.count;
    for (int i = 0; i < 3; i++) {
        NSDecimalNumber *amount = amounts[i];
        TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.toMemberId = payee.id;
        builder.receiptRequested = YES;
        Token *token = [builder execute];
        
        [payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            [expectation fulfill];
        } onError:THROWERROR];
    }
    [self waitForExpectations:@[expectation] timeout:10];
    
    TKTestExpectation *payerExpectation = [[TKTestExpectation alloc] initWithDescription:@"Payer transfer tokens"];
    TKTestExpectation *payeeExpectation = [[TKTestExpectation alloc] initWithDescription:@"Payee transfer tokens"];
    [self runUntilTrue:^{
        [self->payer getTransferTokensOffset:NULL limit:100 onSuccess:^(PagedArray<Token *> *lookedUp) {
            if (lookedUp.items.count == 3 && lookedUp.offset != nil) {
                [payerExpectation fulfill];
            }
        } onError:THROWERROR];
        
        [self->payee getTransferTokensOffset:NULL limit:100 onSuccess:^(PagedArray<Token *> *lookedUp) {
            if (lookedUp.items.count == 3 && lookedUp.offset != nil) {
                [payeeExpectation fulfill];
            }
        } onError:THROWERROR];
        
        return (payerExpectation.isFulfilled && payeeExpectation.isFulfilled) ;
    }];
    [self waitForExpectations:@[payerExpectation, payeeExpectation] timeout:10];
    
}

- (void)testEndorseToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];

    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
        Token* endorsed = [result token];
        XCTAssertEqual([result status], TokenOperationResult_Status_Success);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqualObjects(@"100.11", endorsed.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", endorsed.payload.transfer.currency);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testEndorseToken_Unicode {
    NSString *descr = @"e\u0301\U0001F30D\U0001F340🇧🇭👰🏿👩‍👩‍👧‍👧我"; // decomposed é, globe, leaf; real unicode symbols

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.descr = descr;
    Token *token = [builder execute];

    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
        Token* endorsed = [result token];
        XCTAssertEqual([result status], TokenOperationResult_Status_Success);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        
        XCTAssertEqualObjects(descr, endorsed.payload.description_p);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCancelToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];

    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [payer cancelToken:token onSuccess:^(TokenOperationResult *result) {
        Token* cancelled = [result token];
        XCTAssertEqual([result status], TokenOperationResult_Status_Success);
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqualObjects(@"100.11", cancelled.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"USD", cancelled.payload.transfer.currency);
        XCTAssertEqual(2, cancelled.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetTokenRequestResult {
    TokenRequestPayload *payload = [[TokenRequestPayload alloc] init];
    payload.refId = [TKUtil nonce];
    payload.redirectURL = @"https://token.io";
    payload.to.id_p = payee.id;
    payload.callbackState = [TKUtil nonce];
    payload.transferBody.lifetimeAmount = @"100.99";
    payload.transferBody.currency = @"EUR";

    TokenRequestOptions *options = [[TokenRequestOptions alloc] init];
    options.bankId = @"iron";
    options.receiptRequested = false;
    options.from.id_p = payer.id;

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"EUR"];
    builder.toMemberId = payee.id;
    builder.accountId = payerAccount.id;
    builder.refId = payload.refId;
    builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
    // Optional settings
    builder.purposeOfPayment = PurposeOfPayment_PersonalExpenses;
    
    NSString *state = [TKUtil nonce];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [payee storeTokenRequest:payload requestOptions:options onSuccess:^(NSString *tokenRequestId) {
        [builder executeAsync:^(Token *token){
            [self->payer signTokenRequestState:tokenRequestId tokenId:token.id_p state:state onSuccess:^(Signature *signature) {
                [self->tokenClient getTokenRequestResult:tokenRequestId onSuccess:^(TokenRequestResult *result) {
                    XCTAssert([result.tokenId isEqualToString: token.id_p]);
                    XCTAssert([result.signature.signature isEqualToString: signature.signature]);
                    [expectation fulfill];
                } onError:THROWERROR];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}
@end
