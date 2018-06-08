//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TokenSdk.h"
#import "TKCrypto.h"
#import "TKTestBase.h"
#import "DeviceInfo.h"
#import "Token.pbobjc.h"

@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests

- (void)testCreateMember {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [tokenIO createMember:alias];
        XCTAssert(member.id.length > 0);
        XCTAssertEqualObjects(member.firstAlias, alias);
        XCTAssertEqual(member.keys.count, 3);
        
        [member deleteMember];
        XCTAssertThrows([tokenIO getMember:member.id]);
    }];
}

- (void)testProvisionNewDevice {
    // Create a member.
    TKMemberSync *member = [self runWithResult:^TKMemberSync *(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        return [tokenIO createMember:alias];
    }];

    // Generate keys on a new device, get the keys approved and login
    // with the new keys.
    [self run: ^(TokenIOSync *tokenIO) {
        DeviceInfo *newDevice = [tokenIO provisionDevice:member.firstAlias];
        [member approveKeys:newDevice.keys];

        TKMemberSync *memberNewDevice = [tokenIO getMember:newDevice.memberId];
        XCTAssertEqualObjects(member.firstAlias, memberNewDevice.firstAlias);
        XCTAssertEqual(memberNewDevice.keys.count, 6); // 3 keys per device.
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIOSync *tokenIO) {
        TKMemberSync *created = [self createMember:tokenIO];
        TKMemberSync *loggedIn = [tokenIO getMember:created.id];
        XCTAssert(loggedIn.id.length > 0);
        XCTAssertEqual(loggedIn.keys.count, 3);
        XCTAssertEqualObjects(created.firstAlias, loggedIn.firstAlias);
    }];
}

- (void)testAliasExists {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [self createMember:tokenIO];
        
        XCTAssertEqual([tokenIO aliasExists:alias], NO);
        [member addAlias:alias];
        XCTAssertEqual([tokenIO aliasExists:alias], YES);
    }];
}

- (void)testGetMemberID {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [self createMember:tokenIO];
        
        XCTAssertNil([tokenIO getMemberId:alias]);
        [member addAlias:alias];
        XCTAssertTrue([[tokenIO getMemberId:alias] isEqualToString:member.id]);
    }];
}

- (void)testGetTokenMember {
    [self run: ^(TokenIOSync *tokenIO) {
        //TODO: After the ResolveAliasRequest support other type (phone etc), we need to add tests here
        TKMemberSync *emailMember = [tokenIO createMember:[self generateEmailAlias]];
        
        Alias *unknownAlias = [Alias new];
        unknownAlias.value = emailMember.firstAlias.value;
        unknownAlias.type = Alias_Type_Unknown;
        
        TokenMember* emailTokenMember = [tokenIO getTokenMember:unknownAlias];
        XCTAssertEqual(emailTokenMember.alias.type, emailMember.firstAlias.type);
        XCTAssertTrue([emailTokenMember.alias.value isEqualToString:emailMember.firstAlias.value]);
        XCTAssertTrue([emailTokenMember.id_p isEqualToString:emailMember.id]);
        
    }];
}

- (void)testAddAlias {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMemberSync *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        [member addAlias:alias3];

        XCTAssertEqual(member.aliases.count, 3);
    }];
}

- (void)testGetAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];
        
        TKMemberSync *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];
        
        NSArray<Alias *> *aliases = [member getAliases];
        
        XCTAssertEqual(aliases.count, 3);
        XCTAssertEqual(member.aliases.count, 3);
        
        // test aliases after login
        TKMemberSync *loginMember = [tokenIO getMember:member.id];
        XCTAssertEqual(loginMember.aliases.count, 3);
    }];
}

- (void)testAddAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMemberSync *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];

        XCTAssertEqual(member.aliases.count, 3);
    }];
}

- (void)testRemoveAlias {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];

        TKMemberSync *member = [self createMember:tokenIO];
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

        TKMemberSync *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];
        XCTAssertEqual(member.aliases.count, 3);

        [member removeAliases:@[alias2, alias3]];
        XCTAssertEqual(member.aliases.count, 1);
    }];
}

@end
