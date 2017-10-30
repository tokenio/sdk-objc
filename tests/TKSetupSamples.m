//
//  TKSetupSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 10/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"

#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKMemberSync.h"
#import "TKLogManager.h"
#import "TKTestKeyStore.h"

#import "TKUtil.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKSetupSamples : TKTestBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    
    // createSDK begin snippet to include in docs
    TokenIOBuilder *builder = [TokenIO sandboxBuilder];
    // For tests, we use TKTestKeyStore, which "forgets" private keys.
    // For real members, we would use a different keystore.
    TKTestKeyStore *keyStore = [[TKTestKeyStore alloc] init];
    builder.keyStore = keyStore;
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    TokenIO *tokenIO = [builder buildAsync];
    // createSDK done snippet to include in docs
    
    // make sure it worked:
    [self runUntilDone:^(dispatch_semaphore_t done){
        [tokenIO createMember:[self generateEmailAlias] onSuccess:^(TKMember *m){
            XCTAssertNotNil(m);
            dispatch_semaphore_signal(done);
        } onError:^(NSError *e){
            XCTAssertTrue(false);
        }];
    }];
    
}

- (void)testCreateMember {
    TokenIO *tokenIO = [self asyncSDK];
    TKMember __block *newMember;
    
    [self runUntilDone:^(dispatch_semaphore_t done) {
        // createMember begin snippet to include in docs
        Alias *alias = [Alias new];
        // For this test user, we generate a random alias to make sure nobody else has claimed it.
        // The "+noverify@" means Token automatically verifies this alias (only works in test environments).
        alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
        alias.type = Alias_Type_Email;
        [tokenIO createMember:alias onSuccess:^(TKMember *m){
            newMember = m; // Use member.
            dispatch_semaphore_signal(done); // SLATE_EXCERPT_OMIT don't show this line in web docs
        } onError:^(NSError *e){
            // Something went wrong.
            @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
        }];
        // createMember done snippet to include in docs
     }];
    XCTAssertNotNil(newMember);
}

- (void)testLoginExistingMember {
    TKMember __block *member;
    // TKTestBase's usual SDK builder uses a new non-persisting keystore.
    // So if we use one SDK to create a member and another SDK to log in,
    // the second SDK wouldn't "see" the first SDK's private keys (and fail).
    id<TKKeyStore> store = [[TKTestKeyStore alloc] init];
    TokenIOBuilder *beforeBuilder = [self sdkBuilder];
    beforeBuilder.keyStore = store;
    TokenIO *beforeTokenIO = [beforeBuilder buildAsync];
    
    [self runUntilDone:^(dispatch_semaphore_t done) {
        Alias *alias = [Alias new];
        // For this test user, we generate a random alias to make sure nobody else has claimed it.
        // The "+noverify@" means Token automatically verifies this alias (only works in test environments).
        alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
        alias.type = Alias_Type_Email;
        [beforeTokenIO createMember:alias onSuccess:^(TKMember *m){
            member = m; // Use member.
            dispatch_semaphore_signal(done);
        } onError:^(NSError *e){
            // Something went wrong.
            @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
        }];
    }];
    NSString *memberId = member.id;
    
    TKMember __block *loggedInMember;
    [self runUntilDone:^(dispatch_semaphore_t done) {
        // loginMmeber begin snippet to include in docs
        TokenIOBuilder *builder = [self sdkBuilder];
        builder.keyStore = store;
        TokenIO *tokenIO = [builder buildAsync];
    
        [tokenIO loginMember:memberId onSuccess:^(TKMember* m) {
            loggedInMember = m; // Use member.
            dispatch_semaphore_signal(done); // SLATE_EXCERPT_OMIT don't show this line in web docs
        } onError:^(NSError *e) {
            // Something went wrong.
            @throw [NSException exceptionWithName:@"LoginMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
        }];
        // loginMmeber done snippet to include in docs
    }];
         
    XCTAssertNotNil(loggedInMember);
}
@end
