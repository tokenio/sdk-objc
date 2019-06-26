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
#import "PrepareTokenResult.h"

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

- (void)testPrepareToken {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [payer prepareTransferToken:[self preparedBuilder] onSuccess:^(PrepareTokenResult *result) {
        XCTAssertNotNil(result.policy);
        XCTAssertNotNil(result.tokenPayload);
        XCTAssertEqualObjects(result.policy.singleSignature.signer.memberId, self->payer.id);
        XCTAssertEqual(result.policy.singleSignature.signer.keyLevel, Key_Level_Standard);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testPrepareToken_lowValue {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [payer prepareTransferToken:[self preparedBuilder:@"10"] onSuccess:^(PrepareTokenResult *result) {
        XCTAssertNotNil(result.policy);
        XCTAssertNotNil(result.tokenPayload);
        XCTAssertEqualObjects(result.policy.singleSignature.signer.memberId, self->payer.id);
        XCTAssertEqual(result.policy.singleSignature.signer.keyLevel, Key_Level_Low);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCreateToken {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [payer prepareTransferToken:[self preparedBuilder] onSuccess:^(PrepareTokenResult *result) {
        [self->payer createToken:result.tokenPayload
            tokenRequestId:nil
                keyLevel:result.policy.singleSignature.signer.keyLevel
                 onSuccess:^ (Token *token){
                     XCTAssertEqualObjects(@"100.99", token.payload.transfer.lifetimeAmount);
                     XCTAssertEqualObjects(@"EUR", token.payload.transfer.currency);
                     XCTAssertEqual(token.payload.transfer.instructions.transferDestinationsArray.count, 1);
                     XCTAssertTrue(token.payloadSignaturesArray_Count >= 1);
                     [expectation fulfill];
                 } onError:THROWERROR];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCreateToken_invalidCurrency {
    TransferTokenBuilder *builder = [self preparedBuilder:@"100" currency:@"XXX"];
    @try {
        [self createToken:builder];
    } @catch(NSError *error) {
        XCTAssertTrue(error.code == TransferTokenStatus_FailureInvalidCurrency);
        return;
    }
}

- (void)testLookupToken {
    Token *token = [self createToken:[self preparedBuilder]];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [payer getToken:token.id_p onSuccess:^(Token *lookedUp) {
        XCTAssertEqualObjects(token, lookedUp);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTokens {
    NSArray<NSString *> * amounts = @[@"100.11", @"100.22", @"100.33"];
    
    for (int i = 0; i < 3; i++) {
        [self createToken:[self preparedBuilder:amounts[i]]];
    }
    
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

- (void)testCreateToken_Unicode {
    TransferTokenBuilder *builder = [self preparedBuilder];
    builder.descr = @"e\u0301\U0001F30D\U0001F340🇧🇭👰🏿👩‍👩‍👧‍👧我"; // decomposed é, globe, leaf; real unicode symbols

    Token *token = [self createToken:builder];
    XCTAssertEqualObjects(builder.descr, token.payload.description_p);
    XCTAssertEqual(2, token.payloadSignaturesArray_Count);
    XCTAssertEqual(TokenSignature_Action_Endorsed, token.payloadSignaturesArray[0].action);
}

- (void)testCancelToken {
    Token *token = [self createToken:[self preparedBuilder]];

    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [payer cancelToken:token onSuccess:^(TokenOperationResult *result) {
        Token* cancelled = [result token];
        XCTAssertEqualObjects(@"100.99", cancelled.payload.transfer.lifetimeAmount);
        XCTAssertEqualObjects(@"EUR", cancelled.payload.transfer.currency);
        XCTAssertEqual(4, cancelled.payloadSignaturesArray_Count);
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
        [self->payer prepareTransferToken:builder onSuccess:^(PrepareTokenResult *prepareTokenResult) {
            [self->payer createToken:prepareTokenResult.tokenPayload
                      tokenRequestId:tokenRequestId
                            keyLevel:prepareTokenResult.policy.singleSignature.signer.keyLevel
                           onSuccess:^(Token *token){
                [self->payer signTokenRequestState:tokenRequestId tokenId:token.id_p state:state onSuccess:^(Signature *signature) {
                    [self->tokenClient getTokenRequestResult:tokenRequestId onSuccess:^(TokenRequestResult *result) {
                        XCTAssert([result.tokenId isEqualToString: token.id_p]);
                        XCTAssert([result.signature.signature isEqualToString: signature.signature]);
                        [expectation fulfill];
                    } onError:THROWERROR];
                } onError:THROWERROR];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (TransferTokenBuilder *)preparedBuilder {
    return [self preparedBuilder:@"100.99"];
}

- (TransferTokenBuilder *)preparedBuilder:(NSString *)amount {
    return [self preparedBuilder:amount currency:@"EUR"];
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
