//
//  TKAccessRedemptionTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKRepresentableSync.h"
#import "TKTestBase.h"
#import "TokenIOSync.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKBalance.h"
#import "TKError.h"

@interface TKAccessRedemptionTests : TKTestBase

@end

@implementation TKAccessRedemptionTests {
    TKAccountSync *grantorAccount;
    TKMemberSync *grantor;
    TKMemberSync *grantee;
}

- (void)setUp {
    [super setUp];
    TokenIOSync *tokenIO = [self syncSDK];
    grantorAccount = [self createAccount:tokenIO];
    grantor = [grantorAccount member];
    grantee = [self createMember:tokenIO];
}

- (void)testAnyAddressToken {
    Address *payload = [Address message];
    AddressRecord *address = [grantor addAddress:payload withName:@"name"];
    
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAllAddresses];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    AddressRecord *lookedUp = [representable getAddressWithId:address.id_p];
    
    XCTAssertEqualObjects(address, lookedUp);
}

- (void)testAddressToken {
    Address *payload = [Address message];
    AddressRecord *address = [grantor addAddress:payload withName:@"name"];
    
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAddress:address.id_p];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    AddressRecord *lookedUp = [representable getAddressWithId:address.id_p];
    
    XCTAssertEqualObjects(address, lookedUp);
}
    
- (void)testAnyBalanceToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAllBalances];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    
    Money *lookedUpBalance = [representable getBalance:grantorAccount.id
                                         withKey:Key_Level_Low].current;
    
    XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance.current);
}

- (void)testBalanceToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccountBalances:grantorAccount.id];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    Money *lookedUpBalance = [representable getBalance:grantorAccount.id
                                         withKey:Key_Level_Low].current;
    XCTAssertEqualObjects(lookedUpBalance, grantorAccount.getBalance.current);
}

- (void)testAnyAccountToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAllAccounts];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    TKAccountSync *lookedUpAccount = [representable getAccount:grantorAccount.id];
    XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
}

- (void)testAccountToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccount:grantorAccount.id];
    Token *token = [grantor createAccessToken:access];
    
    token = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:token.id_p];
    TKAccountSync *lookedUpAccount = [representable getAccount:grantorAccount.id];
    XCTAssertEqualObjects(grantorAccount.name, lookedUpAccount.name);
}

- (void)testAnyAccountTransactionsToken {
    TKAccountSync *redeemerAccount = [self createAccount:[self syncSDK]];
    TKMemberSync *redeemer = redeemerAccount.member;
    
    // Create and redeem transfer token to create a transaction.
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [grantor createTransferToken:amount
                                                        currency:@"USD"];
    builder.accountId = grantorAccount.id;
    builder.toMemberId = redeemer.id;
    Token *transferToken = [builder execute];
    
    transferToken = [[grantor endorseToken:transferToken withKey:Key_Level_Standard] token];
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = redeemerAccount.member.id;
    destination.account.token.accountId = redeemerAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50"];
    [redeemer redeemToken:transferToken
                   amount:redeemAmount
                 currency:@"USD"
              description:@""
              destination:destination];
    
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAllTransactions];
    Token *accessToken = [grantor createAccessToken:access];
    
    accessToken = [[grantor endorseToken:accessToken withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:accessToken.id_p];
    PagedArray<Transaction *> *lookedUpTransactions = [representable getTransactionsOffset:nil
                                                                               limit:100
                                                                          forAccount:grantorAccount.id
                                                                             withKey:Key_Level_Low];
    XCTAssertEqual(1, lookedUpTransactions.items.count);
    XCTAssertNotNil(lookedUpTransactions.offset);
}

- (void)testTransactionsToken {
    TKAccountSync *redeemerAccount = [self createAccount:[self syncSDK]];
    TKMemberSync *redeemer = redeemerAccount.member;
    
    // Create and redeem transfer token to create a transaction.
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [grantor createTransferToken:amount
                                                        currency:@"USD"];
    builder.accountId = grantorAccount.id;
    builder.toMemberId = redeemer.id;
    Token *transferToken = [builder execute];
    transferToken = [[grantor endorseToken:transferToken withKey:Key_Level_Standard] token];
    
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = redeemerAccount.member.id;
    destination.account.token.accountId = redeemerAccount.id;
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50"];
    [redeemer redeemToken:transferToken
                   amount:redeemAmount
                 currency:@"USD"
              description:@"lunch"
              destination:destination];
    
    
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccountTransactions:grantorAccount.id];
    Token *accessToken = [grantor createAccessToken:access];
    
    accessToken = [[grantor endorseToken:accessToken withKey:Key_Level_Standard] token];
    
    id<TKRepresentableSync> representable = [grantee forAccessToken:accessToken.id_p];
    PagedArray<Transaction *> *lookedUpTransactions = [representable
                                                       getTransactionsOffset:nil
                                                       limit:100
                                                       forAccount:grantorAccount.id
                                                       withKey:Key_Level_Low];
    XCTAssertEqual(1, lookedUpTransactions.items.count);
    XCTAssertNotNil(lookedUpTransactions.offset);
}

@end
