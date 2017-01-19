//
//  TKSecureEnclaveTests.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKCrypto.h"
#import "TKKeyInfo.h"
#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKSignature.h"

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
    
    TKKeyInfo *key = [crypto generateKey:Key_Level_Privileged];
    TKSignature *signature = [crypto sign:token usingKey:Key_Level_Privileged];
    XCTAssertEqualObjects(signature.key.id, key.id);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                forMessage:token
                                usingKeyId:key.id];
    XCTAssert(success);
}

- (void)testHelloWorld {
    
    TKKeyInfo *key = [crypto generateKey:Key_Level_Privileged];
    NSData *data = [@"Hello World" dataUsingEncoding:NSUTF8StringEncoding];

    TKSignature *signature = [crypto signData:data usingKey:Key_Level_Privileged];
    NSLog(@"Signature for Hello World: %@", signature.value);
    NSLog(@"Public key: %@", signature.key.publicKeyStr);
    XCTAssertEqualObjects(signature.key.id, key.id);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                   forData:data
                                usingKeyId:key.id];
    XCTAssert(success);
}

- (void)testSignAndVerify_token {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    TKKeyInfo *key = [crypto generateKey:Key_Level_Privileged];
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:Key_Level_Privileged];
    XCTAssertEqualObjects(signature.key.id, key.id);
    XCTAssert(signature.value.length > 0);
    
    bool success = [crypto verifySignature:signature.value
                                  forToken:token
                                    action:TokenSignature_Action_Endorsed
                                usingKeyId:key.id];
    XCTAssert(success);
    
    success = [crypto verifySignature:signature.value
                             forToken:token
                               action:TokenSignature_Action_Cancelled
                           usingKeyId:key.id];
    XCTAssert(!success);
}

@end
