//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TKTestBase.h"
#import "DeviceInfo.h"


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

- (void)testProvisionNewDevice {
    // Create a member.
    TKMember *member = [self runWithResult:^TKMember *(TokenIO *tokenIO) {
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        return [tokenIO createMember:username];
    }];

    // Generate keys on a new device, get the keys approved and login
    // with the new keys.
    [self run: ^(TokenIO *tokenIO) {
        DeviceInfo *newDevice = [tokenIO provisionDevice:member.firstUsername];
        [member approveKeys:newDevice.keys];

        TKMember *memberNewDevice = [tokenIO loginMember:newDevice.memberId];
        XCTAssertEqualObjects(member.firstUsername, memberNewDevice.firstUsername);
        XCTAssertEqual(memberNewDevice.keys.count, 6); // 3 keys per device.
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

- (void)testGetMemberID {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
        TKMember *member = [self createMember:tokenIO];
        
        XCTAssertNil([tokenIO getMemberId:username]);
        [member addUsername:username];
        XCTAssertTrue([[tokenIO getMemberId:username] isEqualToString:member.id]);
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

- (void)testAddUsernames {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username2 = [@"username-" stringByAppendingString:[TKUtil nonce]];
        NSString *username3 = [@"username-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addUsernames:@[username2, username3]];

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

- (void)testRemoveUsernames {
    [self run: ^(TokenIO *tokenIO) {
        NSString *username2 = [@"username-" stringByAppendingString:[TKUtil nonce]];
        NSString *username3 = [@"username-" stringByAppendingString:[TKUtil nonce]];

        TKMember *member = [self createMember:tokenIO];
        [member addUsernames:@[username2, username3]];
        XCTAssertEqual(member.usernames.count, 3);

        [member removeUsernames:@[username2, username3]];
        XCTAssertEqual(member.usernames.count, 1);
    }];
}

@end
