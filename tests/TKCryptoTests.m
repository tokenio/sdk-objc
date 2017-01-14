//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKCrypto.h"
#import "TKKeyInfo.h"
#import "TKTestTokenCryptoEngineFactory.h"
#import "TKSignature.h"

@interface TKCryptoTests : XCTestCase
@end

@implementation TKCryptoTests {
    TKCrypto *crypto;
}

- (void)setUp {
    [super setUp];
    id<TKCryptoEngine> engine = [[[TKTestTokenCryptoEngineFactory alloc] init] createEngine:@"member_id_123"];
    crypto = [[TKCrypto alloc] initWithEngine:engine];
}

- (void)testSignAndVerify_message {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";

    TKKeyInfo *low = [crypto generateKey:Key_Level_Low];

    TKSignature *signature = [crypto sign:token usingKey:Key_Level_Low];
    XCTAssertEqualObjects(signature.key.id, low.id);
    XCTAssert(signature.value.length > 0);

    bool success = [crypto verifySignature:signature.value
                                forMessage:token
                                usingKeyId:low.id];
    XCTAssert(success);
}

- (void)testSignAndVerify_token {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";

    TKKeyInfo *standard = [crypto generateKey:Key_Level_Standard];
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:Key_Level_Standard];
    XCTAssertEqualObjects(signature.key.id, standard.id);
    XCTAssert(signature.value.length > 0);

    bool success = [crypto verifySignature:signature.value
                                  forToken:token
                                    action:TokenSignature_Action_Endorsed
                                usingKeyId:standard.id];
    XCTAssert(success);

    success = [crypto verifySignature:signature.value
                             forToken:token
                               action:TokenSignature_Action_Cancelled
                           usingKeyId:standard.id];
    XCTAssert(!success);
}

@end
