//
//  TKAccessTokenTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "AccessTokenConfig.h"
#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Address.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"
#import "PagedArray.h"


@interface TKAccessTokenTests : TKTestBase

@end

@implementation TKAccessTokenTests {
    TKMember *grantor;
    TKMember *grantee;
    Token *token;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        grantor = [self createMember:tokenIO];
        grantee = [self createMember:tokenIO];
        Address *payload = [Address message];
        AddressRecord *address = [grantor addAddress:payload withName:@"name"];
        
        AccessTokenConfig *access = [AccessTokenConfig create:grantee.firstUsername];
        [access forAddress:address.id_p];
        token = [grantor createAccessToken:access];
    }];
}

- (void)testCreateToken {
    [self run: ^(TokenIO *tokenIO) {
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *lookedUp = [grantee getToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        PagedArray<Token *> *lookedUp = [grantor getAccessTokensOffset:NULL limit:100];
        XCTAssertEqual(lookedUp.items.count, 1);
        XCTAssertNotNil(lookedUp.offset);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *endorsed = [[grantor endorseToken:token withKey:Key_Level_Standard] token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqual(2, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
    }];
}

- (void)testCancelToken {
    [self run: ^(TokenIO *tokenIO) {
        Token *cancelled = [[grantor cancelToken:token] token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqual(2, cancelled.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
    }];
}

- (void)testReplaceToken {
    [self run: ^(TokenIO *tokenIO){
        AccessTokenConfig *access = [AccessTokenConfig fromPayload:token.payload];
        [access forAll];
        TokenOperationResult *replaced = [grantor replaceAccessToken:token accessTokenConfig:access];
        XCTAssertEqual(TokenOperationResult_Status_MoreSignaturesNeeded, [replaced status]);
        XCTAssertEqual(0, [[replaced token] payloadSignaturesArray_Count]);
    }];
}

- (void)testReplaceAndEndorseToken {
    [self run: ^(TokenIO *tokenIO){
        AccessTokenConfig *access = [AccessTokenConfig fromPayload:token.payload];
        [access forAll];
        TokenOperationResult *replaced = [grantor replaceAndEndorseAccessToken:token accessTokenConfig:access];
        XCTAssertEqual(TokenOperationResult_Status_Success, [replaced status]);
        XCTAssertEqual(2, [[replaced token] payloadSignaturesArray_Count]);
        XCTAssert([[grantor getToken:token.id_p].replacedByTokenId isEqualToString:replaced.token.id_p]);
    }];
}

- (void)testAddingPermissionsIdempotent {
    [self run: ^(TokenIO *tokenIO){
        AccessTokenConfig *access = [AccessTokenConfig fromPayload:token.payload];
        [access forAccount:grantee.id];
        [access forAccount:grantee.id];
        [access forAccount:grantee.id];
        [access forAllAddresses];
        [access forAllAddresses];
        
        [access from:grantee.id];
        TokenPayload *payload = [access toTokenPayload];
        NSUInteger count = [payload.access resourcesArray_Count];
        XCTAssertEqual(2, count);
        XCTAssertNotEqual(token.payload.nonce, payload.nonce);
    }];
}

@end
