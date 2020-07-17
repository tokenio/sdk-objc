//
//  TKAccessTokenTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "AccessTokenBuilder.h"
#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"
#import "PagedArray.h"
#import "TokenRequestResult.h"

@interface TKAccessTokenTests : TKTestBase

@end

@implementation TKAccessTokenTests {
    TKMember *grantee;
    TKAccount *grantorAccount;
    TKMember *grantor;
    TokenRequestPayload *requestPayload;
    TokenRequestOptions *requestOptions;
    TokenRequest *tokenRequest;
    Token *token;
}

- (void)setUp {
    [super setUp];
    TokenClient *tokenClient = [self client];
    grantee = [self createMember:tokenClient];
    grantorAccount = [self createAccount:tokenClient];
    grantor = grantorAccount.member;
    
    requestPayload = [[TokenRequestPayload alloc] init];
    requestPayload.userRefId = [TKUtil nonce];
    requestPayload.redirectURL = @"https://token.io";
    requestPayload.to.id_p = grantee.id;
    requestPayload.description_p = @"Account and balance access";
    requestPayload.callbackState = [TKUtil nonce];
    
    GPBEnumArray *types = [[GPBEnumArray alloc] init];
    [types addValue:TokenRequestPayload_AccessBody_ResourceType_Accounts];
    [types addValue:TokenRequestPayload_AccessBody_ResourceType_Balances];
    requestPayload.accessBody.typeArray = types;
    
    TokenRequestOptions *requestOptions = [[TokenRequestOptions alloc] init];
    requestOptions.bankId = @"iron";
    requestOptions.receiptRequested = false;
    requestOptions.from.id_p = grantor.id;
    
    tokenRequest = [TokenRequest message];
    tokenRequest.requestPayload = requestPayload;
    tokenRequest.requestOptions = requestOptions;
    AccessTokenBuilder *access = [AccessTokenBuilder fromTokenRequest:tokenRequest];
    [access forAccount:grantorAccount.id];
    [access forAccountBalances:grantorAccount.id];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor createAccessToken:access onSuccess:^(Token *created) {
        self->token = created;
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCreateToken {
    XCTAssertEqual(0, token.payloadSignaturesArray_Count);
}

- (void)testLookupToken {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantee getToken:token.id_p onSuccess:^(Token *lookedUp) {
        XCTAssertEqualObjects(self->token, lookedUp);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testLookupTokens {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self waitUntil:^{
        __block PagedArray<Token *> *lookedUp = nil;
        TKTestExpectation *lookedUpExpectation = [[TKTestExpectation alloc] init];
        [self->grantor getAccessTokensOffset:NULL limit:100 onSuccess:^(PagedArray<Token *> *result) {
            lookedUp = result;
            [lookedUpExpectation fulfill];
        } onError:THROWERROR];
        [self waitForExpectations:@[lookedUpExpectation] timeout:10];
        
        [self check:@"Access Token count" condition:lookedUp.items.count == 1];
        [self check:@"Offset is present" condition:lookedUp.offset != nil];
    }];
}

- (void)testEndorseToken {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
        XCTAssertEqual(0, self->token.payloadSignaturesArray_Count);
        XCTAssertEqual(2, [result token].payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, [result token].payloadSignaturesArray[0].action);
        
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testCancelToken {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor cancelToken:token onSuccess:^(TokenOperationResult *result) {
        XCTAssertEqual(0, self->token.payloadSignaturesArray_Count);
        XCTAssertEqual(2, [result token].payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, [result token].payloadSignaturesArray[0].action);
        
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testReplaceToken {
    AccessTokenBuilder *accessToken = [AccessTokenBuilder fromPayload:token.payload];
    [accessToken forAccount:grantorAccount.id];
    [accessToken forAccountTransactions:grantorAccount.id];
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantor replaceAccessToken:token accessTokenBuilder:accessToken onSuccess:^(TokenOperationResult *result) {
        XCTAssertEqual(TokenOperationResult_Status_MoreSignaturesNeeded, [result status]);
        XCTAssertEqual(0, [[result token] payloadSignaturesArray_Count]);
        
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testAddingPermissionsIdempotent {
    AccessTokenBuilder *accessToken = [AccessTokenBuilder fromTokenRequest:tokenRequest]; 
    [accessToken forAccount:grantorAccount.id];
    [accessToken forAccount:grantorAccount.id];
    [accessToken forAccount:grantorAccount.id];
    [accessToken forAccountBalances:grantorAccount.id];
    [accessToken forAccountBalances:grantorAccount.id];

    TokenPayload *tokenPayload = [accessToken toTokenPayload];
    NSUInteger count = [tokenPayload.access resourcesArray_Count];
    XCTAssertEqual(2, count);
    XCTAssertNotEqual(token.payload.refId, tokenPayload.refId);
}

- (void)sampleGetTokenRequestResult {
    TokenClient *tokenClient = [self client];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [grantee storeTokenRequest:requestPayload requestOptions:requestOptions onSuccess:^(NSString *tokenRequestId) {
        [self->grantor
         signTokenRequestState:tokenRequestId
         tokenId:self->token.id_p
         state:self->requestPayload.callbackState onSuccess:^(Signature *signature) {
             [tokenClient getTokenRequestResult:tokenRequestId onSuccess:^(TokenRequestResult *result) {
                 XCTAssert([result.tokenId isEqualToString: self->token.id_p]);
                 XCTAssert([result.signature.signature isEqualToString: signature.signature]);
                 [expectation fulfill];
             } onError:THROWERROR];
         } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}
@end
