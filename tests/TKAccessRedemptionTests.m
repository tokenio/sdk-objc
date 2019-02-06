//
//  TKAccessRedemptionTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKRepresentable.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKBalance.h"
#import "TKError.h"
#import "PagedArray.h"

@interface TKAccessRedemptionTests : TKTestBase

@end

@implementation TKAccessRedemptionTests {
    TKAccount *grantorAccount;
    TKMember *grantor;
    TKMember *grantee;
}

- (void)setUp {
    [super setUp];
    TokenClient *tokenClient = [self client];
    grantorAccount = [self createAccount:tokenClient];
    grantor = [grantorAccount member];
    grantee = [self createMember:tokenClient];
}

- (void)testBalanceToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccountBalances:grantorAccount.id];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor createAccessToken:access onSuccess:^(Token *created) {
        [self->grantor endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            id<TKRepresentable> representable = [self->grantee forAccessToken:[result token].id_p];
            
            [representable getBalance:self->grantorAccount.id withKey:Key_Level_Low onSuccess:^(TKBalance *lookedUpBalance) {
                [self->grantorAccount getBalance:^(TKBalance *balance) {
                    XCTAssertEqualObjects(lookedUpBalance.current, balance.current);
                    XCTAssertEqualObjects(lookedUpBalance.available, balance.available);
                    [expectation fulfill];
                } onError:THROWERROR];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testAccountToken {
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccount:grantorAccount.id];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor createAccessToken:access onSuccess:^(Token *created) {
        [self->grantor endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            id<TKRepresentable> representable = [self->grantee forAccessToken:[result token].id_p];
            
            [representable getAccount:self->grantorAccount.id onSuccess:^(TKAccount *lookedUpAccount) {
                    XCTAssertEqualObjects(lookedUpAccount.name, self->grantorAccount.name);
                
                    [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testTransactionsToken {
    TKAccount *redeemerAccount = [self createAccount:[self client]];
    TKMember *redeemer = redeemerAccount.member;
    
    // Create and redeem transfer token to create a transaction.
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
    TransferTokenBuilder *builder = [grantor createTransferToken:amount
                                                        currency:@"USD"];
    builder.accountId = grantorAccount.id;
    builder.toMemberId = redeemer.id;
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token *created) {
        [self->grantor endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = redeemerAccount.member.id;
            destination.account.token.accountId = redeemerAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"50"];
            [redeemer
             redeemToken:[result token]
             amount:redeemAmount
             currency:@"USD"
             description:@"lunch"
             destination:destination onSuccess:^(Transfer *transfer) {
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    AccessTokenConfig *access = [AccessTokenConfig createWithToId:grantee.id];
    [access forAccountTransactions:grantorAccount.id];
    
    expectation = [[TKTestExpectation alloc] init];
    [grantor createAccessToken:access onSuccess:^(Token *created) {
        [self->grantor endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            id<TKRepresentable> representable = [self->grantee forAccessToken:[result token].id_p];
            
            [representable
             getTransactionsOffset:nil
             limit:100
             forAccount:self->grantorAccount.id
             withKey:Key_Level_Low
             onSuccess:^(PagedArray<Transaction *> *lookedUpTransactions) {
                 XCTAssertEqual(1, lookedUpTransactions.items.count);
                 XCTAssertNotNil(lookedUpTransactions.offset);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}
@end
