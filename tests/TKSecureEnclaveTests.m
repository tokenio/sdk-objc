//
//  TKSecureEnclaveTests.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKCrypto.h"
#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKSignature.h"
#import "TKError.h"

@interface TKSecureEnclaveTests : XCTestCase

@end

@implementation TKSecureEnclaveTests {
    TKCrypto *crypto;
}

- (void)setUp {
    [super setUp];
    id<TKCryptoEngine> engine = [[[TKSecureEnclaveCryptoEngineFactory alloc] init] createEngine:@"member_id_123"];
    crypto = [[TKCrypto alloc] initWithEngine:engine];
}

- (void)testSignAndVerify_message {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    Key *key = [crypto generateKey:Key_Level_Low];
    TKSignature *signature = [crypto sign:token usingKey:Key_Level_Low reason:nil onError:nil];
    XCTAssertEqualObjects(signature.key.id_p, key.id_p);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                forMessage:token
                                usingKeyId:key.id_p];
    XCTAssert(success);
}

- (void)testSignAndVerify_token {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    Key *key = [crypto generateKey:Key_Level_Low];
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:Key_Level_Low
                                   reason:nil
                                  onError:nil];
    XCTAssertEqualObjects(signature.key.id_p, key.id_p);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                  forToken:token
                                    action:TokenSignature_Action_Endorsed
                                usingKeyId:key.id_p];
    XCTAssert(success);
    
    success = [crypto verifySignature:signature.value
                             forToken:token
                               action:TokenSignature_Action_Cancelled
                           usingKeyId:key.id_p];
    XCTAssert(!success);
}

- (void)testSignAndVerify_token_touchID {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    Key *key = [crypto generateKey:Key_Level_Privileged];
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:Key_Level_Privileged
                                   reason:nil
                                  onError:nil];
    XCTAssertEqualObjects(signature.key.id_p, key.id_p);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                  forToken:token
                                    action:TokenSignature_Action_Endorsed
                                usingKeyId:key.id_p];
    XCTAssert(success);
    
    success = [crypto verifySignature:signature.value
                             forToken:token
                               action:TokenSignature_Action_Cancelled
                           usingKeyId:key.id_p];
    XCTAssert(!success);
}

#if !(TARGET_IPHONE_SIMULATOR)
- (void)testCancelSign {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    [crypto generateKey:Key_Level_Privileged];
    __block NSInteger errorCode = 0;
    [crypto sign:token
          action:TokenSignature_Action_Endorsed
        usingKey:Key_Level_Privileged
          reason:@"Cancel Touch ID for test to succeed!"
         onError:^(NSError *error) {
             errorCode = error.code;
         }];
    XCTAssertEqual(errorCode, kTKErrorUserCancelled);
}
#endif

@end
