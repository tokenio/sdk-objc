//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "Pricing.pbobjc.h"

@interface TKTransferTokenBuilderTests : TKTestBase
@end

@implementation TKTransferTokenBuilderTests {
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


- (void)testCreate {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    Token *token = [builder execute];
    XCTAssertNotNil(token);
}

- (void)testNoSource {
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
    destination.account.token.accountId = payeeAccount.id;
    destination.account.token.memberId = payee.id;
    
    NSArray<TransferEndpoint *> *destinations = @[destination];
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    XCTAssertThrows([builder execute]);
}

- (void)testFull {
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    
    destination.account.token.accountId = payeeAccount.id;
    destination.account.token.memberId = payee.id;
    
    NSArray<TransferEndpoint *> *destinations = @[destination];
    Pricing *pricing = [Pricing message];
    pricing.sourceQuote.feesTotal = @"0.45";
    pricing.sourceQuote.accountCurrency = @"GBP";
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
    builder.expiresAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0 + 100000;
    builder.purposeOfPayment = PurposeOfPayment_Other;
    builder.pricing = pricing;
    builder.descr = @"Test token";
    builder.chargeAmount = [NSDecimalNumber decimalNumberWithString:@"20"];
    
    Token *token = [builder execute];
    
    XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
    XCTAssertEqualObjects(payee.id, token.payload.to.id_p);
    XCTAssertEqual(PurposeOfPayment_Other, token.payload.transfer.instructions.metadata.transferPurpose);
    XCTAssertEqualObjects(pricing.sourceQuote, token.payload.transfer.pricing.sourceQuote);
}

@end
