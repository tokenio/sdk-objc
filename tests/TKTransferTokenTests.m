//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Account.pbobjc.h"
#import "TokenRequestResult.h"
#import "Transferinstructions.pbobjc.h"

@interface TKTransferTokenTests : TKTestBase
@end

@implementation TKTransferTokenTests {
    TKMemberSync *payer;
    TKAccountSync *payerAccount;
    TKMemberSync *payee;
    TKAccountSync *payeeAccount;
}

- (void)setUp {
    [super setUp];
    TokenIOSync *tokenIO = [self syncSDK];
    payerAccount = [self createAccount:tokenIO];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenIO];
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
    Token *lookedUp = [payer getToken:token.id_p];
    XCTAssertEqualObjects(token, lookedUp);
}

- (void)testLookupTokens {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.receiptRequested = YES;
    Token *token = [builder execute];
    
    [payer endorseToken:token withKey:Key_Level_Standard];
    
    NSDecimalNumber *amount2 = [NSDecimalNumber decimalNumberWithString:@"100.22"];
    TransferTokenBuilder *builder2 = [payer createTransferToken:amount2
                                                       currency:@"USD"];
    builder2.accountId = payerAccount.id;
    builder2.toMemberId = payee.id;
    Token *token2 = [builder2 execute];
    [payer endorseToken:token2 withKey:Key_Level_Standard];
    
    NSDecimalNumber *amount3 = [NSDecimalNumber decimalNumberWithString:@"100.33"];
    TransferTokenBuilder *builder3 = [payer createTransferToken:amount3
                                                       currency:@"USD"];
    builder3.accountId = payerAccount.id;
    builder3.toMemberId = payee.id;
    Token *token3 = [builder3 execute];
    [payer endorseToken:token3 withKey:Key_Level_Standard];
    
    [self waitUntil:^{
        PagedArray<Token *> *lookedUpPayer = [self->payer getTransferTokensOffset:NULL limit:100];
        PagedArray<Token *> *lookedUpPayee = [self->payee getTransferTokensOffset:NULL limit:100];
        
        [self check:@"Payer Transfer Token count" condition:lookedUpPayer.items.count == 3];
        [self check:@"Payer Offset is present" condition:lookedUpPayer.offset != nil];
        
        [self check:@"Payee Transfer Token count" condition:lookedUpPayee.items.count == 3];
        [self check:@"Payee Offset is present" condition:lookedUpPayee.offset != nil];
    }];
}

- (void)testEndorseToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    Token* endorsed = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    
    XCTAssertEqualObjects(@"100.11", endorsed.payload.transfer.lifetimeAmount);
    XCTAssertEqualObjects(@"USD", endorsed.payload.transfer.currency);
    XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
    XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
}

- (void)testEndorseToken_Unicode {
    NSString *descr = @"e\u0301\U0001F30D\U0001F340🇧🇭👰🏿👩‍👩‍👧‍👧我"; // decomposed é, globe, leaf; real unicode symbols
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.descr = descr;
    Token *token = [builder execute];
    
    TokenOperationResult *endorsedResult = [payer endorseToken:token withKey:Key_Level_Standard];
    Token* endorsed = [endorsedResult token];
    
    XCTAssertEqual([endorsedResult status], TokenOperationResult_Status_Success);
    XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    
    XCTAssertEqualObjects(descr, endorsed.payload.description_p);
    XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
    XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
}

- (void)testCancelToken {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    
    TokenOperationResult *cancelledResult = [payer cancelToken:token];
    Token *cancelled = [cancelledResult token];
    XCTAssertEqual([cancelledResult status], TokenOperationResult_Status_Success);
    
    
    XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    
    XCTAssertEqualObjects(@"100.11", cancelled.payload.transfer.lifetimeAmount);
    XCTAssertEqualObjects(@"USD", cancelled.payload.transfer.currency);
    XCTAssertEqual(2, cancelled.payloadSignaturesArray_Count);
    XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
}

- (void)testGetTokenRequestResult {
    TokenIOSync *tokenIO = [self syncSDK];
    
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
    
    NSString *tokenRequestId = [payee storeTokenRequest:payload requestOptions:options];
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"EUR"];
    builder.toMemberId = payee.id;
    builder.accountId = payerAccount.id;
    builder.refId = payload.refId;
    builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
    // Optional settings
    builder.purposeOfPayment = PurposeOfPayment_PersonalExpenses;

    Token *token = [builder execute];
    
    NSString *state = [TKUtil nonce];
    Signature *signature = [payer signTokenRequestState:tokenRequestId
                                                  tokenId:token.id_p
                                                    state:state];
    TokenRequestResult *result = [tokenIO getTokenRequestResult:tokenRequestId];
    
    XCTAssert([result.tokenId isEqualToString: token.id_p]);
    XCTAssert([result.signature.signature isEqualToString: signature.signature]);
}
@end
