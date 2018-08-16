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
        XCTAssertEqual([member getKeys].count, 3);
        
        [member deleteMember];
        XCTAssertThrows([tokenIO getMember:member.id]);
    }];
}

- (void)testProvisionNewDevice {
    Alias *alias = [self generateAlias];
    // Create a member.
    TKMemberSync *member = [self runWithResult:^TKMemberSync *(TokenIOSync *tokenIO) {
        return [tokenIO createMember:alias];
    }];

    // Wait until the alias is created
    [self waitUntil:^{
        NSArray<Alias *> *aliases = [member getAliases];
        [self check:@"Can not create alias" condition:[alias isEqual:aliases.firstObject]];
    }];
    
    // Generate keys on a new device, get the keys approved and login
    // with the new keys.
    [self run: ^(TokenIOSync *tokenIO) {
        DeviceInfo *newDevice = [tokenIO provisionDevice:member.firstAlias];
        [member approveKeys:newDevice.keys];

        TKMemberSync *memberNewDevice = [tokenIO getMember:newDevice.memberId];
        XCTAssertEqualObjects(member.firstAlias, memberNewDevice.firstAlias);
        XCTAssertEqual([memberNewDevice getKeys].count, 6); // 3 keys per device.
    }];
}

- (void)testKeyExpiration {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [tokenIO createMember:alias];
        XCTAssertEqual([member getKeys].count, 3);
        
        id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
        id<TKCryptoEngine> engine = [[TKTokenCryptoEngineFactory factoryWithStore:store
                                                           useLocalAuthentication:NO]
                                     createEngine:@"Another"];
        
        NSNumber *futureExpriation = [NSNumber numberWithDouble:([[NSDate date] timeIntervalSince1970] * 1000 + 2000)];
        [member approveKey:[engine generateKey:Key_Level_Privileged]];
        [member approveKey:[engine generateKey:Key_Level_Standard withExpiration:futureExpriation]];
        
        XCTAssertEqual([member getKeys].count, 5);
        
        // Wait until the key expires
        sleep(3);
        XCTAssertEqual([member getKeys].count, 4);
    }];
}

- (void)testRemoveNonStoredKeys {
    [self run: ^(TokenIOSync *tokenIO) {
        TKMemberSync *member = [self createMember:tokenIO];
        id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
        id<TKCryptoEngine> engine = [[TKTokenCryptoEngineFactory factoryWithStore:store
                                                           useLocalAuthentication:NO]
                                     createEngine:@"Another"];
        
        [member approveKey:[engine generateKey:Key_Level_Privileged]];
        [member approveKey:[engine generateKey:Key_Level_Standard]];
        [member approveKey:[engine generateKey:Key_Level_Low]];
        
        XCTAssertEqual([member getKeys].count, 6);
        [member removeNonStoredKeys];
        XCTAssertEqual([member getKeys].count, 3);
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIOSync *tokenIO) {
        TKMemberSync *created = [self createMember:tokenIO];
        
        TKMemberSync *loggedIn = [tokenIO getMember:created.id];
        XCTAssert(loggedIn.id.length > 0);
        XCTAssertEqual([loggedIn getKeys].count, 3);
        XCTAssertEqualObjects(created.firstAlias, loggedIn.firstAlias);
    }];
}

- (void)testAliasExists {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [self createMember:tokenIO];
        
        XCTAssertEqual([tokenIO aliasExists:alias], NO);
        
        [member addAlias:alias];
        // Wait until the alias is created
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Can not create alias" condition:[aliases containsObject:alias]];
        }];
        XCTAssertEqual([tokenIO aliasExists:alias], YES);
    }];
}

- (void)testGetMemberID {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        TKMemberSync *member = [self createMember:tokenIO];
        
        XCTAssertNil([tokenIO getMemberId:alias]);
        [member addAlias:alias];
        
        // Wait until the alias is created
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Can not create alias" condition:[aliases containsObject:alias]];
        }];
        XCTAssertTrue([[tokenIO getMemberId:alias] isEqualToString:member.id]);
    }];
}

- (void)testGetTokenMember {
    [self run: ^(TokenIOSync *tokenIO) {
        //TODO: After the ResolveAliasRequest support other type (phone etc), we need to add tests here
        TKMemberSync *emailMember = [self createMember:tokenIO];
        
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
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Can not find alias2" condition:(aliases.count == 2)];
        }];
        
        [member addAlias:alias3];
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Can not find alias3" condition:(aliases.count == 3)];
        }];
    }];
}

- (void)testGetAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];
        
        TKMemberSync *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];
        
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Aliases count should be 3" condition:(aliases.count == 3)];
        }];
        
        // test aliases after login
        TKMemberSync *loginMember = [tokenIO getMember:member.id];
        XCTAssertEqual(loginMember.aliases.count, 3);
    }];
}

- (void)testRemoveAlias {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];

        TKMemberSync *member = [self createMember:tokenIO];
        [member addAlias:alias2];
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Aliases count should be 2" condition:(aliases.count == 2)];
        }];

        [member removeAlias:alias2];
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Aliases count should be 1" condition:(aliases.count == 1)];
        }];
    }];
}

- (void)testRemoveAliases {
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias2 = [self generateAlias];
        Alias *alias3 = [self generateAlias];

        TKMemberSync *member = [self createMember:tokenIO];
        [member addAliases:@[alias2, alias3]];
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Aliases count should be 3" condition:(aliases.count == 3)];
        }];

        [member removeAliases:@[alias2, alias3]];
        [self waitUntil:^{
            NSArray<Alias *> *aliases = [member getAliases];
            [self check:@"Aliases count should be 1" condition:(aliases.count == 1)];
        }];
    }];
}

@end
