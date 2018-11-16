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
#import "TKTokenCryptoEngineFactory.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKSetupSamples : TKSampleBase

@end

@implementation TKSetupSamples

- (void)testCreateSDKClient {
    // createSDK begin snippet to include in docs
    TokenIOBuilder *builder = [[TokenIOBuilder alloc] init];
    // change the cluster if necessary
    builder.tokenCluster = [TokenCluster sandbox];
    builder.port = 443;
    builder.useSsl = YES;
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    TokenIO *tokenIO = [builder buildAsync];
    // createSDK done snippet to include in docs
    
    XCTAssertNotNil(tokenIO);
}

- (void)testCreateMember {
    TokenIO *tokenIO = [self asyncSDK];
    __block TKMember *newMember;
    
    // createMember begin snippet to include in docs
    Alias *alias = [[Alias alloc] init];
    // For this test user, we generate a random alias to make sure nobody else
    // has claimed it. The "+noverify@" means Token automatically verifies this
    // alias (only works in test environments).
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]]
                    stringByAppendingString:@"+noverify@token.io"]
                   lowercaseString];
    alias.type = Alias_Type_Email;
    alias.realm = @"token";
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
                        onSuccess:^(OauthBankAuthorization* auth) {
        [member linkAccounts:auth.bankId
                 accessToken:auth.accessToken
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
    beforeBuilder.cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:store
                                                              useLocalAuthentication:NO];
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
    builder.cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:store
                                                        useLocalAuthentication:NO];
    TokenIO *tokenIO = [builder buildAsync];
    
    __block TKMember *loggedInMember;

    // loginMember begin snippet to include in docs
    [tokenIO getMember:memberId onSuccess:^(TKMember *m) {
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
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    builder.cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:store
                                                        useLocalAuthentication:NO];
    TokenIO *tokenIO = [builder buildAsync];
    Alias *memberAlias = self.payerAlias;
    __block Key *sentKey = nil;
    
    DeviceMetadata *metadata = [DeviceMetadata message];
    metadata.application = @"Token Test";
    metadata.device = @"iPhone";
    // provisionNotify begin snippet to include in docs
    [tokenIO provisionDevice:memberAlias
                   onSuccess:^(DeviceInfo *di) {
                       for (Key* k in di.keys) {
                           if (k.level == Key_Level_Low) {
                               [tokenIO notifyAddKey:memberAlias
                                             keys:@[k]
                                      deviceMetadata:metadata
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
                   [tokenIO getMember:id
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
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    builder.cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:store
                                                        useLocalAuthentication:NO];
    TokenIO *tokenIO = [builder buildAsync];
    __block int prompting = NO;

    void (^showPrompt)(NSString *s) = ^(NSString *s) {
        prompting = YES;
    };
    
    __block NSString* verificationId = nil;
    // beginRecovery begin snippet to include in docs
    [tokenIO beginMemberRecovery:self.payerAlias
                       onSuccess:^(NSString *verificationId_) {
                           // prompt user to enter code:
                           verificationId = verificationId_;
                           showPrompt(@"Enter code emailed to you:");
                       } onError:^(NSError *e) {
                           @throw [NSException exceptionWithName:@"BeginRecoveryFailedException"
                                                          reason:[e localizedFailureReason]
                                                        userInfo:[e userInfo]];
                       }];
    // beginRecovery done snippet to include in docs

    [self runUntilTrue:^ {
        return (prompting != NO);
    }];

    NSString *userEnteredCode = @"1thru6"; // The test users can bypass the verification, so any code works.
    __block TKMember *member = nil;

    // completeRecovery begin snippet to include in docs
    [tokenIO verifyMemberRecovery:self.payerAlias
                         memberId:self.payerSync.id
                   verificationId:verificationId
                             code:userEnteredCode
                        onSuccess:^() {
                            [tokenIO completeMemberRecovery:self.payerAlias
                                                   memberId:self.payerSync.id
                                             verificationId:verificationId
                                                       code:userEnteredCode
                                                  onSuccess:^(TKMember *newMember) {
                                                      member = newMember;
                                                  } onError:^(NSError *e) {
                                                      @throw [NSException exceptionWithName:@"CompleteRecoveryFailedException"
                                                                                     reason:[e localizedFailureReason]
                                                                                   userInfo:[e userInfo]];
                                                  }];
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

- (void)testProfile {
    __weak TKMember *member = self.payerSync.async;
    __block NSString *fullName = nil;
    
    Profile *profile = [[Profile alloc] init];
    profile.displayNameFirst = @"Jon";
    profile.displayNameLast = @"Snow";
    [member setProfile:profile
             onSuccess:^(Profile *ignore) {
                 [member getProfile:member.id
                          onSuccess:^(Profile *p) {
                              fullName = [NSString stringWithFormat:@"%@ %@", p.displayNameFirst, p.displayNameLast];
                          }
                            onError:^(NSError *e) {
                                @throw [NSException exceptionWithName:@"GetProfileException"
                                                               reason:[e localizedFailureReason]
                                                             userInfo:[e userInfo]];
                            }
                  ];
             } onError:^(NSError *e) {
                 @throw [NSException exceptionWithName:@"SetProfileException"
                                                reason:[e localizedFailureReason]
                                              userInfo:[e userInfo]];
             }
     ];
    // create profile picture done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (fullName != nil);
    }];
}

- (void)testProfilePicture {
    __weak TKMember *member = self.payerSync.async;
    __block BOOL gotBlob = false;
    
    NSData* (^loadImage)(NSString*) = ^(NSString* ignored) {
        return [[NSData alloc]
                initWithBase64EncodedString:@"R0lGODlhAQABAIABAP///wAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
                options:0];
    };
    
    void (^displayImage)(NSData*) = ^(NSData* ignored) {
        // doesn't use data, but makes example easier to understand
        gotBlob = true;
    };
    
    // create profile picture begin snippet to include in docs
    [member setProfilePicture:member.id
                     withType: @"image/gif"
                     withName: @"selfie.gif"
                     withData: loadImage(@"selfie.gif")
                    onSuccess:^() {
                        [member getProfilePicture:member.id
                                             size:ProfilePictureSize_Small
                                        onSuccess:^(Blob *blob) {
                                            displayImage(blob.data);
                                        } onError:^(NSError *e) {
                                            @throw [NSException exceptionWithName:@"GetProfilePictureException"
                                                                           reason:[e localizedFailureReason]
                                                                         userInfo:[e userInfo]];
                                        }
                         ];
                    } onError:^(NSError *e) {
                        @throw [NSException exceptionWithName:@"SetProfilePictureException"
                                                       reason:[e localizedFailureReason]
                                                     userInfo:[e userInfo]];
                    }
     ];
    // create profile picture done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (gotBlob == true);
    }];
}
@end
