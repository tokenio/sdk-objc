//
//  TokenIOTests.m
//  TokenSdkTests
//
//  Created by Alex Kandybaev on 10/13/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Member.pbobjc.h"
#import "TKClient.h"
#import "TKMember.h"
#import "TokenClient.h"

/**
 * Records the requests it is given instead of sending them, and fails each
 * call so that nothing downstream reaches the network.
 */
@interface RecordingClient : TKClient
@property (nonatomic) BOOL createMemberIdCalled;
@property (nonatomic) enum CreateMemberType requestedMemberType;
@property (nonatomic, copy) NSString *requestedTokenRequestId;
@end

@implementation RecordingClient

- (void)createMemberId:(enum CreateMemberType)memberType
             onSuccess:(OnSuccessWithString)onSuccess
               onError:(OnError)onError {
    self.createMemberIdCalled = YES;
    self.requestedMemberType = memberType;
    onError([NSError errorWithDomain:@"io.token.test" code:1 userInfo:nil]);
}

- (void)getTokenRequestResult:(NSString *)tokenRequestId
                    onSuccess:(OnSuccessWithTokenRequestResult)onSuccess
                      onError:(OnError)onError {
    self.requestedTokenRequestId = tokenRequestId;
    onError([NSError errorWithDomain:@"io.token.test" code:1 userInfo:nil]);
}

@end

@interface TokenClientTests : XCTestCase

@end

@implementation TokenClientTests

- (void)testInitWithDeveloperKey {
    NSString *validDeveloperKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    XCTAssertNotNil([[TokenClient alloc] initWithTokenCluster:[TokenCluster localhost]
                                                         port:9001
                                                    timeoutMs:1000
                                                 developerKey:validDeveloperKey
                                                 languageCode:@"en"
                                                       crypto:nil
                                               browserFactory:nil
                                                       useSsl:NO
                                                    certsPath:nil
                                       globalRpcErrorCallback:^(NSError *error) {
                                           /* noop default callback */
                                       }]);
}

// Creating a member with an authenticating member must go through that member's
// authenticated client, as a PERSONAL member. Passing a recovery agent keeps the
// call off the network: no agent lookup, and the recording client stops the flow
// before the new member's keys are registered.
- (void)testCreateMemberAuthenticatedAsUsesTheAuthenticatedClient {
    RecordingClient *client = [[RecordingClient alloc] init];
    TKMember *authenticatedAs = [TKMember member:[Member message]
                                    tokenCluster:[TokenCluster localhost]
                                       useClient:client
                               useBrowserFactory:nil
                                         aliases:[NSMutableArray array]];

    TokenClient *tokenClient = [self tokenClient];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [tokenClient createMember:[self alias]
              authenticatedAs:authenticatedAs
                recoveryAgent:@"m:recovery-agent"
                    onSuccess:^(TKMember *created) {
                        XCTFail(@"The member creation was expected to fail");
                    }
                      onError:^(NSError *error) {
                          [expectation fulfill];
                      }];

    [self waitForExpectations:@[expectation] timeout:1];
    XCTAssertTrue(client.createMemberIdCalled);
    XCTAssertEqual(client.requestedMemberType, CreateMemberType_Personal);
}

// A member's token request result lookup must go through that member's
// authenticated client, not the unauthenticated one TokenClient uses.
- (void)testGetTokenRequestResultUsesTheMembersAuthenticatedClient {
    // Given
    RecordingClient *client = [[RecordingClient alloc] init];
    TKMember *member = [TKMember member:[Member message]
                           tokenCluster:[TokenCluster localhost]
                              useClient:client
                      useBrowserFactory:nil
                                aliases:[NSMutableArray array]];
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];

    // When
    [member getTokenRequestResult:@"rq:token-request"
                        onSuccess:^(TokenRequestResult *result) {
                            XCTFail(@"The lookup was expected to fail");
                        }
                          onError:^(NSError *error) {
                              [expectation fulfill];
                          }];

    // Then
    [self waitForExpectations:@[expectation] timeout:1];
    XCTAssertEqualObjects(client.requestedTokenRequestId, @"rq:token-request");
}

- (TokenClient *)tokenClient {
    return [[TokenClient alloc] initWithTokenCluster:[TokenCluster localhost]
                                                port:9001
                                           timeoutMs:1000
                                        developerKey:@"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI"
                                        languageCode:@"en"
                                              crypto:nil
                                      browserFactory:nil
                                              useSsl:NO
                                           certsPath:nil
                              globalRpcErrorCallback:^(NSError *error) {
                                  /* noop default callback */
                              }];
}

- (Alias *)alias {
    Alias *alias = [Alias message];
    alias.type = Alias_Type_Email;
    alias.value = [NSString stringWithFormat:@"%@+noverify@token.io", [[NSUUID UUID] UUIDString]];
    return alias;
}

@end
