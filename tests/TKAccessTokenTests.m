//
//  TKAccessTokenTests.m
//  TokenSdk
//
//  Created by Alexey Kalinichenko on 10/17/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"


@interface TKAccessTokenTests : TKTestBase

@end

@implementation TKAccessTokenTests {
    TKMember *grantor;
    TKMember *grantee;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        grantor = [self createMember:tokenIO];
        grantee = [self createMember:tokenIO];
    }];
}

- (void)testCreateToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *address = [grantor addAddressWithName:@"Home" withData:@"Data"];
        Token *token = [grantor createAccessToken:grantee.firstUsername
                                       forAddress:address.id_p];
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
    }];
}

- (void)testLookupToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *address = [grantor addAddressWithName:@"Home" withData:@"Data"];
        Token *token = [grantor createAccessToken:grantee.firstUsername
                                       forAddress:address.id_p];
        
        Token *lookedUp = [grantee getToken:token.id_p];
        XCTAssertEqualObjects(token, lookedUp);
    }];
}

- (void)testLookupTokens {
    [self run: ^(TokenIO *tokenIO) {
        Address *address = [grantor addAddressWithName:@"Home" withData:@"Data"];
        [grantor createAccessToken:grantee.firstUsername forAddress:address.id_p];
        [grantor createAccessToken:grantee.firstUsername forAddress:address.id_p];
        [grantor createAccessToken:grantee.firstUsername forAddress:address.id_p];
        
        NSArray<Token *> *lookedUp = [grantor getAccessTokensOffset:NULL limit:100];
        XCTAssertEqual(lookedUp.count, 3);
    }];
}

- (void)testEndorseToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *address = [grantor addAddressWithName:@"Home" withData:@"Data"];
        Token *token = [grantor createAccessToken:grantee.firstUsername
                                       forAddress:address.id_p];
        Token *endorsed = [grantor endorseToken:token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqual(1, endorsed.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Endorsed, endorsed.payloadSignaturesArray[0].action);
    }];
}

- (void)testCancelToken {
    [self run: ^(TokenIO *tokenIO) {
        Address *address = [grantor addAddressWithName:@"Home" withData:@"Data"];
        Token *token = [grantor createAccessToken:grantee.firstUsername
                                       forAddress:address.id_p];
        Token *cancelled = [grantor cancelToken:token];
        
        XCTAssertEqual(0, token.payloadSignaturesArray_Count);
        XCTAssertEqual(1, cancelled.payloadSignaturesArray_Count);
        XCTAssertEqual(TokenSignature_Action_Cancelled, cancelled.payloadSignaturesArray[0].action);
    }];
}


@end
