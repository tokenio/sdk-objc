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

#import "TKUtil.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKSetupSamples : TKTestBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    // begin snippet to include in docs
    
    TokenIOBuilder *builder = [TokenIO sandboxBuilder];
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    TokenIO *tokenIO = [builder buildAsync];
    
    // done snippet to include in docs
    
    // make sure it worked:
    TKMember __block *newMember;
    [tokenIO createMember:[self generateEmailAlias] onSuccess:^(TKMember *m){
        newMember = m;
    } onError:^(NSError *e){
        XCTAssertTrue(false);
    }];
    [self runUntilTrue:^{
        return (newMember != nil);
    }];
}

- (void)testCreateMember {
    TokenIO *tokenIO = [self asyncSDK];
    TKMember __block *newMember;
    
    // begin snippet to include in docs
    
    Alias *alias = [Alias new];
    // For this test user, we generate a random alias to make sure nobody else has claimed it.
    // The "+noverify@" means Token automatically verifies this alias (only works in test environments).
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
    alias.type = Alias_Type_Email;
    [tokenIO createMember:alias onSuccess:^(TKMember *m){
        newMember = m; // Use member.
    } onError:^(NSError *e){
        // Something went wrong.
        @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
    }];
    
    // done snippet to include in docs
    
    // make sure it worked
    [self runUntilTrue:^{
        return (newMember != nil);
    }];
}

- (void)testLinkBankAccount {
    // TODO: oh this is quite different than in other languages. punt on this example for now
}

- (void)testRunUntilDone {
    TokenIO *tokenIO = [self asyncSDK];
    TKMember __block *newMember;
    
    [self runUntilDone:^(dispatch_semaphore_t done) {
        TKLogDebug(@"UNO");
        dispatch_semaphore_signal(done);
    }];
    
    [self runUntilDone:^(dispatch_semaphore_t done) {
        TKLogDebug(@"DOS");
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
     }];
    TKLogDebug(@"newMember is %@", newMember);
    XCTAssertNotNil(newMember);
}

- (void)testLoginExistingMember {
    // using the TKTestBase built-in helper functions is not so helpful:
    // I gotta convert them from sync to async
    TKMemberSync __block *memberSync;
    [self run: ^(TokenIOSync *tokenIO) {
        memberSync = [self createMember:tokenIO];
    }];
    NSString *memberId = memberSync.id;
    TKMember __block *loggedInMember;
    // TKMember *member = memberSync.async; // OK, this excerpt doesn't actually use TKMember, but that's unusual
    TokenIO *tokenIO = [self asyncSDK];
    
    return; // TODO HA HA HA you don't have the keystore you created this member with
    // because you used the convenient TokenIOSync provided with "run" above
    [tokenIO loginMember:memberId onSuccess:^(TKMember* m) {
        TKLogDebug(@"great success");
        loggedInMember = m; // Use member.
    } onError:^(NSError *e) {
        // Something went wrong.
        TKLogDebug(@"uh-oh spaghetti-os");
        @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
    }];
    
    // begin snippet to include in docs
    // make sure it worked
    [self runUntilTrue:^{
        return (loggedInMember != nil);
    }];
        
    // end snippet to include in docs
}

@end
