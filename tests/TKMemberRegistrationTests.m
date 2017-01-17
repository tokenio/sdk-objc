//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"


@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests

- (void)testCreateMember {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [tokenIO createMember:username];
        XCTAssert(member.id.length > 0);
        XCTAssertEqualObjects(member.firstUsername, username);
        XCTAssertEqual(member.keys.count, 3);
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIO *tokenIO) {
        TKMember *created = [self createMember:tokenIO];
        TKMember *loggedIn = [tokenIO loginMember:created.id];
        XCTAssert(loggedIn.id.length > 0);
        XCTAssertEqual(loggedIn.keys.count, 3);
        XCTAssertEqualObjects(created.firstUsername, loggedIn.firstUsername);
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
