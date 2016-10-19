//
//  TKAccessRedemptionTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"


@interface TKAccessRedemptionTests : TKTestBase

@end

@implementation TKAccessRedemptionTests {
    TKAccount *grantorAccount;
    TKMember *grantor;
    TKMember *grantee;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        grantorAccount = [self createAccount:tokenIO];
        grantor = [grantorAccount member];
        grantee = [self createMember:tokenIO];
    }];
}

- (void)testAnyAddressToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        Token *token = [grantor createAddressAccessToken:grantee.firstUsername];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAddressToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        Token *token = [grantor createAddressAccessToken:grantee.firstUsername
                                            restrictedTo:address.id_p];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAnyBalanceToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [grantor createBalanceAccessToken:grantee.firstUsername];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testBalanceToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [grantor createBalanceAccessToken:grantee.firstUsername
                                            restrictedTo:grantorAccount.id];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testAnyAccountToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [grantor createAccountAccessToken:grantee.firstUsername];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        TKAccount *lookedUpAccount = [grantee getAccount:grantorAccount.id];
        XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
    }];
}

- (void)testAccountToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *token = [grantor createAccountAccessToken:grantee.firstUsername
                                            restrictedTo:grantorAccount.id];
        token = [grantor endorseToken:token];
        
        [grantee useAccessToken:token.id_p];
        TKAccount *lookedUpAccount = [grantee getAccount:grantorAccount.id];
        XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
    }];
}

- (void)testAnyAccountTransactionsToken {
    [self run: ^(TokenIO *tokenIO) {
        TKAccount *redeemerAccount = [self createAccount:tokenIO];
        TKMember *redeemer = redeemerAccount.member;
        
        // Create and redeem transfer token to create a transaction.
        Token *transferToken = [grantor createTransferToken:redeemer.firstUsername
                                                 forAccount:grantorAccount.id
                                                     amount:100.99
                                                   currency:@"USD"
                                                description:@"transfer test"];
        transferToken = [grantor endorseToken:transferToken];
        [redeemer createTransfer:transferToken];
        
        Token *accessToken = [grantor createTransactionsAccessToken:grantee.firstUsername];
        accessToken = [grantor endorseToken:accessToken];
        
        [grantee useAccessToken:accessToken.id_p];
        NSArray<Transaction*> *lookedUpTransactions = [grantee getTransactionsOffset:nil
                                                                               limit:100
                                                                          forAccount:grantorAccount.id];
        XCTAssertEqual(1, [lookedUpTransactions count]);
    }];
}

- (void)testTransactionsToken {
    [self run: ^(TokenIO *tokenIO) {
        TKAccount *redeemerAccount = [self createAccount:tokenIO];
        TKMember *redeemer = redeemerAccount.member;
        
        // Create and redeem transfer token to create a transaction.
        Token *transferToken = [grantor createTransferToken:redeemer.firstUsername
                                                 forAccount:grantorAccount.id
                                                     amount:100.99
                                                   currency:@"USD"
                                                description:@"transfer test"];
        transferToken = [grantor endorseToken:transferToken];
        [redeemer createTransfer:transferToken];
        
        Token *accessToken = [grantor createTransactionsAccessToken:grantee.firstUsername
                                                       restrictedTo:grantorAccount.id];
        accessToken = [grantor endorseToken:accessToken];
        
        [grantee useAccessToken:accessToken.id_p];
        NSArray<Transaction*> *lookedUpTransactions = [grantee
                                                       getTransactionsOffset:nil
                                                       limit:100
                                                       forAccount:grantorAccount.id];
        XCTAssertEqual(1, [lookedUpTransactions count]);
    }];
}

@end
