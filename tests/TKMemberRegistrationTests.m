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
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMember *member = [tokenIO createMember:alias];
        XCTAssert(member.id.length > 0);
        XCTAssertEqualObjects(member.firstAlias, alias);
        XCTAssertEqual(member.keys.count, 3);
    }];
}

- (void)testProvisionNewDevice {
    // Create a member.
    TKMember *member = [self runWithResult:^TKMember *(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        return [tokenIO createMember:alias];
    }];

    // Generate keys on a new device, get the keys approved and login
    // with the new keys.
    [self run: ^(TokenIOSync *tokenIO) {
        DeviceInfo *newDevice = [tokenIO provisionDevice:member.firstAlias];
        [member approveKeys:newDevice.keys];

        TKMember *memberNewDevice = [tokenIO loginMember:newDevice.memberId];
        XCTAssertEqualObjects(member.firstAlias, memberNewDevice.firstAlias);
        XCTAssertEqual(memberNewDevice.keys.count, 6); // 3 keys per device.
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIOSync *tokenIO) {
        TKMember *created = [self createMember:tokenIO];
        TKMember *loggedIn = [tokenIO loginMember:created.id];
        XCTAssert(loggedIn.id.length > 0);
        XCTAssertEqual(loggedIn.keys.count, 3);
        XCTAssertEqualObjects(created.firstAlias, loggedIn.firstAlias);
    }];
}

- (void)testAliasExists {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMember *member = [self createMember:tokenIO];
        
        XCTAssertEqual([tokenIO aliasExists:alias], NO);
        [member addAlias:alias];
        XCTAssertEqual([tokenIO aliasExists:alias], YES);
    }];
}

- (void)testGetMemberID {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMember *member = [self createMember:tokenIO];
        
        XCTAssertNil([tokenIO getMemberId:alias]);
        [member addAlias:alias];
        XCTAssertTrue([[tokenIO getMemberId:alias] isEqualToString:member.id]);
    }];
}

- (void)testAddAlias {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMember *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        [member addAlias:alias3];

        XCTAssertEqual(member.aliases.count, 3);
    }];
}

- (void)testAddAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMember *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];

        XCTAssertEqual(member.aliases.count, 3);
    }];
}

- (void)testRemoveAlias {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];

        TKMember *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        XCTAssertEqual(member.aliases.count, 2);

        [member removeAlias:alias2];
        XCTAssertEqual(member.aliases.count, 1);
    }];
}

- (void)testRemoveAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMember *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];
        XCTAssertEqual(member.aliases.count, 3);

        [member removeAliases:@[alias2, alias3]];
        XCTAssertEqual(member.aliases.count, 1);
    }];
}

@end
