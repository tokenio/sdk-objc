//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "Pricing.pbobjc.h"

@interface TKTransferTokenBuilderTests : TKTestBase
@end

@implementation TKTransferTokenBuilderTests {
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


- (void)testCreate {
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
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
    TransferTokenBuilder *builder = [payer createTransferToken:amount currency:@"USD"];
    builder.toMemberId = payee.id;
    builder.destinations = destinations;
    XCTAssertThrows([builder execute]);
}

- (void)testFull {
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
    builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
    builder.expiresAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0 + 100000;
    builder.purposeOfPayment = PurposeOfPayment_Other;
    builder.descr = @"Test token";
    builder.chargeAmount = [NSDecimalNumber decimalNumberWithString:@"20"];
    
    Token *token = [builder execute];
    
    XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
    XCTAssertEqualObjects(payee.id, token.payload.to.id_p);
    XCTAssertEqual(PurposeOfPayment_Other, token.payload.transfer.instructions.metadata.transferPurpose);
}

@end
