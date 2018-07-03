//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKCrypto.h"
#import "TKInMemoryKeyStore.h"
#import "TKTokenCryptoEngineFactory.h"
#import "TKSignature.h"
#import "TKLogManager.h"

@interface TKCryptoTests : XCTestCase
@end

@implementation TKCryptoTests {
    TKCrypto *crypto;
}

- (void)setUp {
    [super setUp];
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    id<TKCryptoEngine> engine = [[TKTokenCryptoEngineFactory factoryWithStore:store useLocalAuthentication:NO] createEngine:@"member_id_123"];
    crypto = [[TKCrypto alloc] initWithEngine:engine];
}

- (void)testSignAndVerify_message {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";

    Key *low = [crypto generateKey:Key_Level_Low];

    TKSignature *signature = [crypto sign:token
                                 usingKey:Key_Level_Low
                                   reason:nil
                                  onError:^(NSError *error) {
                                      TKLogError(@"testSignAndVerify_message sign fail with error %@", error);
                                  }];
    XCTAssertEqualObjects(signature.key.id_p, low.id_p);
    XCTAssert(signature.value.length > 0);

    bool success = [crypto verifySignature:signature.value
                                forMessage:token
                                usingKeyId:low.id_p];
    XCTAssert(success);
}

- (void)testSignAndVerify_token {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";

    Key *standard = [crypto generateKey:Key_Level_Standard];
    TKSignature *signature = [crypto sign:token
                                   action:TokenSignature_Action_Endorsed
                                 usingKey:Key_Level_Standard
                                   reason:nil
                                  onError:^(NSError *error) {
                                      TKLogError(@"testSignAndVerify_token sign fail with error %@", error);
                                  }];
    XCTAssertEqualObjects(signature.key.id_p, standard.id_p);
    XCTAssert(signature.value.length > 0);

    bool success = [crypto verifySignature:signature.value
                                  forToken:token
                                    action:TokenSignature_Action_Endorsed
                                usingKeyId:standard.id_p];
    XCTAssert(success);

    success = [crypto verifySignature:signature.value
                             forToken:token
                               action:TokenSignature_Action_Cancelled
                           usingKeyId:standard.id_p];
    XCTAssert(!success);
}

- (void)testSign_usesValidKey {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";

    long long now = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    long long tomorrow = now + 86400000;
    Key *valid = [crypto generateKey:Key_Level_Low withExpiration:[NSNumber numberWithLongLong:tomorrow]];
    [crypto generateKey:Key_Level_Low withExpiration:[NSNumber numberWithLongLong:(now+2000)]];
    sleep(3);
    TKSignature *signature = [crypto sign:token
                                 usingKey:Key_Level_Low
                                   reason:nil
                                  onError:^(NSError *error) {
                                      TKLogError(@"testSign_usesValidKey sign fail with error %@", error);
                                  }];
    XCTAssertEqualObjects(signature.key.id_p, valid.id_p);

    now = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    [crypto generateKey:Key_Level_Standard withExpiration:[NSNumber numberWithLongLong:(now+2000)]];
    Key *validStandard = [crypto generateKey:Key_Level_Standard];
    sleep(3);
    TKSignature *signature2 = [crypto sign:token
                                  usingKey:Key_Level_Standard
                                    reason:nil
                                   onError:^(NSError *error) {
                                       TKLogError(@"testSign_usesValidKey sign fail with error %@", error);
                                   }];
    XCTAssertEqualObjects(signature2.key.id_p, validStandard.id_p);
}

- (void)testVerify_throwsOnExpiredKey {
    Token *token = [Token message];
    token.payload.transfer.amount = @"100.23";
    
    long long now = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    Key *low = [crypto generateKey:Key_Level_Low withExpiration:[NSNumber numberWithLongLong:(now+2000)]];
    
    TKSignature *signature = [crypto sign:token
                                 usingKey:Key_Level_Low
                                   reason:nil
                                  onError:^(NSError *error) {
                                      TKLogError(@"testVerify_throwsOnExpiredKey sign fail with error %@", error);
                                  }];
    sleep(3);
    XCTAssertThrows([crypto verifySignature:signature.value
                                 forMessage:token
                                 usingKeyId:low.id_p]);
}

@end
