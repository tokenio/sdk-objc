//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TKMember.h"
#import "TKSecretKey.h"
#import "TKTestBase.h"
#import "TKUtil.h"
#import "TokenIO.h"
#import "Security.pbobjc.h"



@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests

- (void)testCreateMember {
    [self run: ^(TokenIO *tokenIO) {
        NSString *alias = [@"alias-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [tokenIO createMember:alias];
        XCTAssert(member.id.length > 0);
        XCTAssertEqualObjects(member.firstAlias, alias);
        XCTAssertEqual(member.publicKeys.count, 1);
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIO *tokenIO) {
        TKMember *created = [self createMember:tokenIO];
        TKMember *loggedIn = [tokenIO loginMember:created.id secretKey:created.key];
        XCTAssert(loggedIn.id.length > 0);
        XCTAssertEqual(loggedIn.publicKeys.count, 1);
    }];
}

- (void)testAddKey {
    [self run: ^(TokenIO *tokenIO) {
        TKSecretKey *key2 = [TKCrypto generateKey];
        TKSecretKey *key3 = [TKCrypto generateKey];

        TKMember *member = [self createMember:tokenIO];
        [member approveKey:key2 level:Key_Level_Standard];
        [member approveKey:key3 level:Key_Level_Low];

        XCTAssertEqual(member.publicKeys.count, 3);
    }];
}

- (void)testRemoveKey {
    [self run: ^(TokenIO *tokenIO) {
        TKSecretKey *key2 = [TKCrypto generateKey];

        TKMember *member = [self createMember:tokenIO];
        [member approveKey:key2 level:Key_Level_Privileged];
        XCTAssertEqual(member.publicKeys.count, 2);

        [member removeKey:key2.id];
        XCTAssertEqual(member.publicKeys.count, 1);
    }];
}

- (void)testAliasExists {
    [self run: ^(TokenIO *tokenIO) {
        NSString *alias = [@"alias-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [self createMember:tokenIO];
        
        XCTAssertEqual([member aliasExists:alias], @(NO));
        [member addAlias:alias];
        XCTAssertEqual([member aliasExists:alias], @(YES));
    }];
}

- (void)testAddAlias {
    [self run: ^(TokenIO *tokenIO) {
        NSString *alias2 = [@"alias-" stringByAppendingString:[TKUtil nonce]];
        NSString *alias3 = [@"alias-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        [member addAlias:alias3];

        XCTAssertEqual(member.aliases.count, 3);
    }];
}

- (void)testRemoveAlias {
    [self run: ^(TokenIO *tokenIO) {
        NSString *alias2 = [@"alias-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        XCTAssertEqual(member.aliases.count, 2);

        [member removeAlias:alias2];
        XCTAssertEqual(member.aliases.count, 1);
    }];
}

@end
