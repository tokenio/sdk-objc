//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "Pricing.pbobjc.h"

@interface TKTransferTokenBuilderTests : TKTestBase
@end

@implementation TKTransferTokenBuilderTests {
    TKMember *payer;
    TKAccount *payerAccount;
    TKMember *payee;
    TKAccount *payeeAccount;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
    }];
}

- (void)testCreate {
    [self run: ^(TokenIO *tokenIO) {
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        XCTAssertNotNil(token);
    }];
}

- (void)testNoSource {
    [self run: ^(TokenIO *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;
        
        NSArray<TransferEndpoint *> *destinations = @[destination];
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.redeemerAlias = payee.firstAlias;
        builder.destinations = destinations;
        XCTAssertThrows([builder execute]);
    }];
}

- (void)testNoRedeemer {
    [self run: ^(TokenIO *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;
        
        NSArray<TransferEndpoint *> *destinations = @[destination];
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.destinations = destinations;
        XCTAssertThrows([builder execute]);
    }];
}

- (void)testFull {
    [self run: ^(TokenIO *tokenIO) {
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        
        destination.account.token.accountId = payeeAccount.id;
        destination.account.token.memberId = payee.id;
        
        NSArray<TransferEndpoint *> *destinations = @[destination];
        Pricing *pricing = [Pricing message];
        pricing.sourceQuote.feesTotal = @"0.45";
        pricing.sourceQuote.accountCurrency = @"GBP";
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.redeemerMemberId = payee.id;
        builder.toAlias = payee.firstAlias;
        builder.toMemberId = payee.id;
        builder.destinations = destinations;
        builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
        builder.expiresAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0 + 100000;
        builder.purposeOfPayment = PurposeOfPayment_Other;
        builder.pricing = pricing;
        builder.descr = @"Test token";
        builder.chargeAmount = 20;
        
        Token *token = [builder execute];
        
        XCTAssertEqualObjects(@"USD", token.payload.transfer.currency);
        XCTAssertEqualObjects(payee.firstAlias, token.payload.to.alias);
        XCTAssertEqualObjects(payee.id, token.payload.to.id_p);
        XCTAssertEqual(PurposeOfPayment_Other, token.payload.transfer.instructions.transferPurpose);
        XCTAssertEqualObjects(pricing.sourceQuote, token.payload.transfer.pricing.sourceQuote);
        XCTAssertEqualObjects(payee.firstAlias, token.payload.transfer.redeemer.alias);
        XCTAssertEqualObjects(payee.id, token.payload.transfer.redeemer.id_p);
    }];
}

@end
