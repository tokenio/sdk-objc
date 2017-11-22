//
//  TKSetupSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 10/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TokenSdk.h"
#import "DeviceInfo.h"
#import "TKSampleBase.h"
#import "TKInMemoryKeyStore.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKSetupSamples : TKSampleBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    // createSDK begin snippet to include in docs
    TokenIOBuilder *builder = [TokenIO sandboxBuilder];
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    TokenIO *tokenIO = [builder buildAsync];
    // createSDK done snippet to include in docs
}

- (void)testCreateMember {
    TokenIO *tokenIO = [self asyncSDK];
    __block TKMember *newMember;
    
    // createMember begin snippet to include in docs
    Alias *alias = [Alias new];
    // For this test user, we generate a random alias to make sure nobody else
    // has claimed it. The "+noverify@" means Token automatically verifies this
    // alias (only works in test environments).
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]]
                    stringByAppendingString:@"+noverify@token.io"]
                   lowercaseString];
    alias.type = Alias_Type_Email;
    [tokenIO createMember:alias onSuccess:^(TKMember *m) {
        newMember = m; // Use member.
    } onError:^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"CreateMemberFailedException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // createMember done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (newMember != nil);
    }];
}

- (void)testLinkTestBankAccount {
    __block TKMember *member = nil;
    TokenIO *tokenIO = [self asyncSDK];
    [tokenIO createMember:[self generateAlias] onSuccess:^(TKMember *m) {
        member = m;
    } onError:^(NSError *e) {
        @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
    }];
    [self runUntilTrue:^ {
        return (member != nil);
    }];
    __block TKAccount *account = nil;
    
    // linkTestBankAccount begin snippet to include in docs
    Money *balance = [Money message]; // test account's starting balance
    balance.currency = @"EUR";
    balance.value = @"5678.00";
    [member createTestBankAccount:balance
                        onSuccess:^(BankAuthorization* auth) {
        [member linkAccounts:auth
                   onSuccess:^(NSArray<TKAccount*> * _Nonnull accounts) {
            // use accounts
            account = accounts[0];
        } onError:^(NSError * _Nonnull e) {
            // Something went wrong.
            @throw [NSException exceptionWithName:@"LinkAccountException"
                                           reason:[e localizedFailureReason]
                                         userInfo:[e userInfo]];
        }];
    } onError:^(NSError * _Nonnull e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"TestAccountException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // linkTestBankAccount done snippet to include in docs
    
    // make sure it worked
    [self runUntilTrue:^ {
        return (account != nil);
    }];
}

- (void)testLoginExistingMember {
    __block TKMember *member = nil;
    // TKTestBase's usual SDK builder uses a new non-persisting keystore;
    // unlike the default keystore, these TKTestKeyStores don't share data.
    // So if we use one SDK to create a member and another SDK to log in,
    // the second SDK wouldn't "see" the first SDK's private keys (and fails).
    // We'll create a member with one member and log in with another;
    // we'll have them use the same keystore so that they can share keys
    // (as would happen if they used the "regular" keystore).
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    TokenIOBuilder *beforeBuilder = [self sdkBuilder];
    beforeBuilder.keyStore = store;
    TokenIO *beforeTokenIO = [beforeBuilder buildAsync];
    
    Alias *alias = [Alias new];
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
    alias.type = Alias_Type_Email;
    [beforeTokenIO createMember:alias onSuccess:^(TKMember *m) {
        member = m; // Use member.
    } onError:^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"CreateMemberFailedException" reason:[e localizedFailureReason] userInfo:[e userInfo]];
    }];
    [self runUntilTrue:^ {
        return (member != nil);
    }];
    NSString *memberId = member.id;
    TokenIOBuilder *builder = [self sdkBuilder];
    builder.keyStore = store;
    TokenIO *tokenIO = [builder buildAsync];
    
    __block TKMember *loggedInMember;

    // loginMember begin snippet to include in docs
    [tokenIO loginMember:memberId onSuccess:^(TKMember *m) {
        loggedInMember = m; // Use member.
    } onError:^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"LoginMemberFailedException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // loginMember done snippet to include in docs
    
    // make sure it worked:
    [self runUntilTrue:^ {
        return (loggedInMember != nil);
    }];
}

-(void)testProvisionDevice {
    // We have two sdks, one for our new device, one for our "main" device.
    // Each needs its own keystore: provisionDevice _replaces_ keys.
    TokenIOBuilder *builder = [self sdkBuilder];
    builder.keyStore = [[TKInMemoryKeyStore alloc] init];
    TokenIO *tokenIO = [builder buildAsync];
    Alias *memberAlias = self.payerAlias;
    __block Key *sentKey = nil;
    
    // provisionNotify begin snippet to include in docs
    [tokenIO provisionDevice:memberAlias
                   onSuccess:^(DeviceInfo *di) {
                       for (Key* k in di.keys) {
                           if (k.level == Key_Level_Low) {
                               [tokenIO notifyAddKey:memberAlias
                                             keyName:@"Sample"
                                                 key:k
                                           onSuccess:^() {
                                               sentKey = k;
                                           } onError:^(NSError *e) {
                                               @throw [NSException exceptionWithName:@"NotifyFailedException"
                                                                              reason:[e localizedFailureReason]
                                                                            userInfo:[e userInfo]];
                                           }];
                               break;
                           }
                       }
                   } onError:^(NSError *e) {
                       @throw [NSException exceptionWithName:@"ProvisionDeviceFailedException"
                                                      reason:[e localizedFailureReason]
                                                    userInfo:[e userInfo]];
                   }];
    // provisionNotify done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (sentKey != nil);
    }];
    
    [self.payerSync approveKey:sentKey];
    
    __block TKMember *member = nil;
    
    // provisionLogin begin snippet to include in docs
    [tokenIO getMemberId:memberAlias
               onSuccess:^(NSString *id) {
                   [tokenIO loginMember:id
                              onSuccess:^(TKMember *m) {
                                  member = m;
                              } onError:^(NSError *e) {
                                  @throw [NSException exceptionWithName:@"LoginFailedException"
                                                                 reason:[e localizedFailureReason]
                                                               userInfo:[e userInfo]];
                              }];
               } onError:^(NSError *e) {
                   @throw [NSException exceptionWithName:@"FindMemberFailedException"
                                                  reason:[e localizedFailureReason]
                                                userInfo:[e userInfo]];
               }];
    // provisionLogin done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (member != nil);
    }];
}

-(void)testRecoverMember {
    NSString *memberAliasString = self.payerAlias.value;

    // Create a new SDK client with its own keystore to make sure
    // we don't interfere with/use keys used to create the member
    TokenIOBuilder *builder = [self sdkBuilder];
    builder.keyStore = [[TKInMemoryKeyStore alloc] init];
    TokenIO *tokenIO = [builder buildAsync];
    __block int prompting = false;

    void (^showPrompt)(NSString *s) = ^(NSString *s) {
        prompting = true;
    };

    // beginRecovery begin snippet to include in docs
    [tokenIO beginMemberRecovery:memberAliasString
                       onSuccess:^() {
                           // prompt user to enter code:
                           showPrompt(@"Enter code emailed to you:");
                       } onError:^(NSError *e) {
                           @throw [NSException exceptionWithName:@"BeginRecoveryFailedException"
                                                          reason:[e localizedFailureReason]
                                                        userInfo:[e userInfo]];
                       }];
    // beginRecovery done snippet to include in docs

    [self runUntilTrue:^ {
        return (prompting != false);
    }];

    NSString *userEnteredCode = @"1thru6"; // The test users can bypass the verification, so any code works.
    __block TKMember *member = nil;

    // completeRecovery begin snippet to include in docs
    [tokenIO verifyMemberRecoveryCode:userEnteredCode
                            onSuccess:^(BOOL reallySuccessful) {
                                if (reallySuccessful) {
                                    [tokenIO completeMemberRecovery:^(TKMember *newMember) {
                                        member = newMember;
                                    } onError:^(NSError *e) {
                                        @throw [NSException exceptionWithName:@"CompleteRecoveryFailedException"
                                                                       reason:[e localizedFailureReason]
                                                                     userInfo:[e userInfo]];
                                    }];
                                } else {
                                    showPrompt(@"Please try again. Enter code emailed to you:");
                                }
                            } onError:^(NSError *e) {
                                @throw [NSException exceptionWithName:@"VerifyRecCodeFailedException"
                                                               reason:[e localizedFailureReason]
                                                             userInfo:[e userInfo]];
                            }];
    // completeRecovery done snippet to include in docs

    [self runUntilTrue:^ {
        return (member != nil);
    }];
    TKMemberSync *memberSync = [TKMemberSync member:member];
    XCTAssertEqualObjects([memberSync firstAlias].value, memberAliasString);
}
@end
