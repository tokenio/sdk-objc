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
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAllAddresses];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAddressToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAddress:address.id_p];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAnyBalanceToken {
    [self run: ^(TokenIO *tokenIO) {
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAllBalances];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testBalanceToken {
    [self run: ^(TokenIO *tokenIO) {
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAccountBalances:grantorAccount.id];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testAnyAccountToken {
    [self run: ^(TokenIO *tokenIO) {
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAllAccounts];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
        [grantee useAccessToken:token.id_p];
        TKAccount *lookedUpAccount = [grantee getAccount:grantorAccount.id];
        XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
    }];
}

- (void)testAccountToken {
    [self run: ^(TokenIO *tokenIO) {
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAccount:grantorAccount.id];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token] token];
        
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
        transferToken = [[grantor endorseToken:transferToken] token];
        [redeemer createTransfer:transferToken];
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAllTransactions];
        Token *accessToken = [grantor createAccessToken:access];
        
        accessToken = [[grantor endorseToken:accessToken] token];
        
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
        transferToken = [[grantor endorseToken:transferToken] token];
        [redeemer createTransfer:transferToken];
        
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstUsername];
        [access forAccountTransactions:grantorAccount.id];
        Token *accessToken = [grantor createAccessToken:access];

        accessToken = [[grantor endorseToken:accessToken] token];
        
        [grantee useAccessToken:accessToken.id_p];
        NSArray<Transaction*> *lookedUpTransactions = [grantee
                                                       getTransactionsOffset:nil
                                                       limit:100
                                                       forAccount:grantorAccount.id];
        XCTAssertEqual(1, [lookedUpTransactions count]);
    }];
}

@end
