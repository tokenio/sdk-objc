//
//  TKAccessRedemptionTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Transferinstructions.pbobjc.h"


@interface TKAccessRedemptionTests : TKTestBase

@end

@implementation TKAccessRedemptionTests {
    TKAccountSync *grantorAccount;
    TKMemberSync *grantor;
    TKMemberSync *grantee;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIOSync *tokenIO) {
        grantorAccount = [self createAccount:tokenIO];
        grantor = [grantorAccount member];
        grantee = [self createMember:tokenIO];
    }];
}

- (void)testAnyAddressToken {
    [self run: ^(TokenIOSync *tokenIO) {
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstAlias];
        [access forAllAddresses];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAddressToken {
    [self run: ^(TokenIOSync *tokenIO) {
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstAlias];
        [access forAddress:address.id_p];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        AddressRecord *lookedUp = [grantee getAddressWithId:address.id_p];
        
        XCTAssertEqualObjects(address, lookedUp);
    }];
}

- (void)testAnyBalanceToken {
    [self run: ^(TokenIOSync *tokenIO) {
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstAlias];
        [access forAllBalances];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testBalanceToken {
    [self run: ^(TokenIOSync *tokenIO) {
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstAlias];
        [access forAccountBalances:grantorAccount.id];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        Money *lookedUpBalance = [grantee getBalance:grantorAccount.id];
        XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance);
    }];
}

- (void)testAnyAccountToken {
    [self run: ^(TokenIOSync *tokenIO) {
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstAlias];
        [access forAllAccounts];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        TKAccountSync *lookedUpAccount = [grantee getAccount:grantorAccount.id];
        XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
    }];
}

- (void)testAccountToken {
    [self run: ^(TokenIOSync *tokenIO) {
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstAlias];
        [access forAccount:grantorAccount.id];
        Token *token = [grantor createAccessToken:access];

        token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:token.id_p];
        TKAccountSync *lookedUpAccount = [grantee getAccount:grantorAccount.id];
        XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
    }];
}

- (void)testAnyAccountTransactionsToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TKAccountSync *redeemerAccount = [self createAccount:tokenIO];
        TKMemberSync *redeemer = redeemerAccount.member;
        
        // Create and redeem transfer token to create a transaction.
        TransferTokenBuilder *builder = [grantor createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = grantorAccount.id;
        builder.redeemerAlias = redeemer.firstAlias;
        Token *transferToken = [builder execute];
        
        transferToken = [[grantor endorseToken:transferToken withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = redeemerAccount.member.id;
        destination.account.token.accountId = redeemerAccount.id;
        [redeemer redeemToken:transferToken amount:@(50) currency:@"USD" description:@"" destination:destination];
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstAlias];
        [access forAllTransactions];
        Token *accessToken = [grantor createAccessToken:access];
        
        accessToken = [[grantor endorseToken:accessToken withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:accessToken.id_p];
        PagedArray<Transaction *> *lookedUpTransactions = [grantee getTransactionsOffset:nil
                                                                               limit:100
                                                                          forAccount:grantorAccount.id];
        XCTAssertEqual(1, lookedUpTransactions.items.count);
        XCTAssertNotNil(lookedUpTransactions.offset);
    }];
}

- (void)testTransactionsToken {
    [self run: ^(TokenIOSync *tokenIO) {
        TKAccountSync *redeemerAccount = [self createAccount:tokenIO];
        TKMemberSync *redeemer = redeemerAccount.member;
        
        // Create and redeem transfer token to create a transaction.
        TransferTokenBuilder *builder = [grantor createTransferToken:100.11
                                                          currency:@"USD"];
        builder.accountId = grantorAccount.id;
        builder.redeemerAlias = redeemer.firstAlias;
        Token *transferToken = [builder execute];
        transferToken = [[grantor endorseToken:transferToken withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = redeemerAccount.member.id;
        destination.account.token.accountId = redeemerAccount.id;
        [redeemer redeemToken:transferToken
                          amount:@(50)
                        currency:@"USD"
                     description:@"lunch"
                     destination:destination];
        
        
        AccessTokenConfig *access = [[AccessTokenConfig alloc] initWithRedeemer:grantee.firstAlias];
        [access forAccountTransactions:grantorAccount.id];
        Token *accessToken = [grantor createAccessToken:access];

        accessToken = [[grantor endorseToken:accessToken withKey:Key_Level_Standard] token];
        
        [grantee useAccessToken:accessToken.id_p];
        PagedArray<Transaction *> *lookedUpTransactions = [grantee
                                                       getTransactionsOffset:nil
                                                       limit:100
                                                       forAccount:grantorAccount.id];
        XCTAssertEqual(1, lookedUpTransactions.items.count);
        XCTAssertNotNil(lookedUpTransactions.offset);
    }];
}

@end
