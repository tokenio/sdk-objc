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
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [tokenIO createMember:username];
        XCTAssert(member.id.length > 0);
        XCTAssertEqualObjects(member.firstUsername, username);
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

- (void)testUsernameExists {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [self createMember:tokenIO];
        
        XCTAssertEqual([tokenIO usernameExists:username], NO);
        [member addUsername:username];
        XCTAssertEqual([tokenIO usernameExists:username], YES);
    }];
}

- (void)testAddUsername {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username2 = [@"username-" stringByAppendingString:[TKUtil nonce]];
        NSString *username3 = [@"username-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addUsername:username2];
        [member addUsername:username3];

        XCTAssertEqual(member.usernames.count, 3);
    }];
}

- (void)testRemoveUsername {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username2 = [@"username-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addUsername:username2];
        XCTAssertEqual(member.usernames.count, 2);

        [member removeUsername:username2];
        XCTAssertEqual(member.usernames.count, 1);
    }];
}

@end
