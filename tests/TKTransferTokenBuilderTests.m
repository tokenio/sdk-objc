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
        builder.accountId = payeeAccount.id;
        builder.redeemerUsername = payee.firstUsername;
        Token *token = [builder execute];
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
        builder.redeemerUsername = payee.firstUsername;
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
        builder.accountId = payeeAccount.id;
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
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payeeAccount.id;
        builder.redeemerUsername = payee.firstUsername;
        builder.redeemerMemberId = payee.id;
        builder.toUsername = payee.firstUsername;
        builder.toMemberId = payee.id;
        builder.destinations = destinations;
        builder.effectiveAtMs = CFAbsoluteTimeGetCurrent();
        builder.expiresAtMs = CFAbsoluteTimeGetCurrent() + 10000;
        builder.descr = @"Test token";
        builder.chargeAmount = 20;
        
        Token *token = [builder execute];
        
        
        XCTAssertEqual(token.payload.description, @"Test token");
    }];
}

@end
