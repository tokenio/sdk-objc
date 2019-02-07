//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "DeviceInfo.h"
#import "TKCrypto.h"
#import "TKTestBase.h"
#import "Token.pbobjc.h"
#import "TokenSdk.h"

@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests {
    TokenClient *tokenClient;
    TKMember *member;
}

-(void)setUp {
    [super setUp];
    tokenClient = [self client];
    member = [self createMember:tokenClient];
}

- (void)testCreateMember {
    Alias *alias = [self generateAlias];
    __block TKMember *newMember = nil;
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [tokenClient createMember:alias onSuccess:^(TKMember *created) {
        newMember = created;
        XCTAssert(created.id.length > 0);
        XCTAssertEqualObjects(created.firstAlias, alias);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertKeysCount:3 for:newMember];
    
    expectation = [[XCTestExpectation alloc] init];
    [newMember deleteMember:^{
        [self->tokenClient getMember:newMember.id
                           onSuccess:^(TKMember *member2) {
                               XCTFail(@"An unexpected member is found");
                           } onError:^(NSError *error) {
                               [expectation fulfill];
                           }];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testProvisionNewDevice {
    TokenClient *anotherClient = [self client];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    // Generate keys on a new device, get the keys approved and login
    // with the new keys.
    [anotherClient provisionDevice:member.firstAlias onSuccess:^(DeviceInfo *newDevice) {
        [self->member approveKeys:newDevice.keys onSuccess:^ {
            [anotherClient getMember:newDevice.memberId onSuccess:^(TKMember *memberNewDevice) {
                XCTAssertEqualObjects(self->member.firstAlias, memberNewDevice.firstAlias);
                
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertKeysCount:6 for:member]; // 3 keys per device.
}

- (void)testKeyExpiration {
    
    TKMember *member = [self createMember:tokenClient];
    [self assertKeysCount:3 for:member];
    
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    id<TKCryptoEngine> engine = [[TKTokenCryptoEngineFactory factoryWithStore:store
                                                       useLocalAuthentication:NO]
                                 createEngine:@"Another"];

    NSNumber *futureExpriation = [NSNumber numberWithDouble:([[NSDate date] timeIntervalSince1970] * 1000 + 2000)];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member approveKeys:@[[engine generateKey:Key_Level_Privileged],
                          [engine generateKey:Key_Level_Standard withExpiration:futureExpriation]]
              onSuccess:^{
                  [expectation fulfill];
              }
                onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertKeysCount:5 for:member];
    // Wait until the key expires
    sleep(3);
    [self assertKeysCount:4 for:member];
}

- (void)testRemoveNonStoredKeys {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    id<TKCryptoEngine> engine = [[TKTokenCryptoEngineFactory factoryWithStore:store
                                                       useLocalAuthentication:NO]
                                 createEngine:@"Another"];
    [member approveKeys:@[[engine generateKey:Key_Level_Privileged],
                          [engine generateKey:Key_Level_Standard],
                          [engine generateKey:Key_Level_Low]]
              onSuccess:^{
                  [expectation fulfill];
              }
                onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertKeysCount:6 for:member];
    
    expectation = [[XCTestExpectation alloc] init];
    [member removeNonStoredKeys:^ {
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertKeysCount:3 for:member];
}

- (void)testLoginMember {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    [tokenClient getMember:member.id onSuccess:^(TKMember * loggedInMember) {
        XCTAssert(loggedInMember.id.length > 0);
        XCTAssertEqualObjects(self->member.firstAlias, loggedInMember.firstAlias);
        
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testAliasExists {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    __weak TokenClient *weakClient = tokenClient;
    __weak TKMember *weakMember = member;
    Alias *alias = [self generateAlias];
    [weakClient aliasExists:alias onSuccess:^(BOOL exists) {
        XCTAssertEqual(exists, NO);
        [weakMember addAlias:alias onSuccess:^ {
            [weakClient aliasExists:alias onSuccess:^(BOOL exists) {
                XCTAssertEqual(exists, YES);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetMemberID {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    Alias *alias = [self generateAlias];
    __weak TKMember *weakMember = member;
    __weak TokenClient *weakClient = tokenClient;
    
    [weakClient getMemberId:alias onSuccess:^(NSString *memberId) {
        XCTAssertNil(memberId);
        
        [weakMember addAlias:alias onSuccess:^ {
            [weakClient getMemberId:alias onSuccess:^(NSString *memberId) {
                XCTAssertTrue([memberId isEqualToString:weakMember.id]);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetTokenMember {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    Alias *unknownAlias = [Alias new];
    unknownAlias.value = member.firstAlias.value;
    unknownAlias.type = Alias_Type_Unknown;
    
    [tokenClient getTokenMember:unknownAlias onSuccess:^(TokenMember *tokenMember) {
        XCTAssertEqual(tokenMember.alias.type, self->member.firstAlias.type);
        XCTAssertTrue([tokenMember.alias.value isEqualToString:self->member.firstAlias.value]);
        XCTAssertTrue([tokenMember.id_p isEqualToString:self->member.id]);
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testAddAlias {
    __weak TKMember *weakMember = member;
    
    for (int i = 0; i < 2; i++) {
        XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
        
        Alias *alias = [self generateAlias];
        [member addAlias:alias onSuccess:^{
            [expectation fulfill];
        } onError:THROWERROR];
        
        [self waitForExpectations:@[expectation] timeout:10];
        
        [self assertAliasesCount:(2 + i) for:weakMember];
    }
}

- (void)testGetAliases {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    
    Alias *alias2 = [self generateAlias];
    Alias *alias3 = [self generateAlias];
    
    [member addAliases:@[alias2, alias3] onSuccess:^{
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertAliasesCount:3 for:member];
}

- (void)testRemoveAlias {
    Alias *alias = [self generateAlias];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member addAlias:alias onSuccess:^{
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertAliasesCount:2 for:member];
    
    expectation = [[XCTestExpectation alloc] init];
    [member removeAlias:alias onSuccess:^{
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertAliasesCount:1 for:member];
}

- (void)testRemoveAliases {
    NSArray<Alias *> *aliases = @[[self generateAlias], [self generateAlias]];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member addAliases:aliases onSuccess:^{
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertAliasesCount:1 + aliases.count for:member];
    
    expectation = [[XCTestExpectation alloc] init];
    [member removeAliases:aliases onSuccess:^{
        [expectation fulfill];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    
    [self assertAliasesCount:1 for:member];
}

- (void)assertKeysCount:(NSInteger)count for:(TKMember *)member {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member getKeys:^(NSArray<Key *> *array) {
        XCTAssertEqual(array.count, count);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)assertAliasesCount:(NSInteger)count for:(TKMember *)member {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [member getAliases:^(NSArray<Alias *> *array) {
        XCTAssertEqual(array.count, count);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:20];
}
@end
