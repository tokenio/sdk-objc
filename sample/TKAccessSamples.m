//
//  TKAccessSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/6/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTestBase.h"

#import "TokenSdk.h"

@interface TKAccessSamples : TKTestBase

@end

@implementation TKAccessSamples

-(void)testAccessTokens {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *grantorSync = [self createMember:tokenIOSync];
    // we test getAccounts, so create an account to get:
    Money *startingBalance = [Money message];
    startingBalance.currency = @"EUR";
    startingBalance.value = @"5678.00";
    [grantorSync linkAccounts: [grantorSync createTestBankAccount:startingBalance]];
    TKMember *grantor = grantorSync.async;
    
    Alias *granteeAlias = [self generateAlias];
    TKMemberSync *granteeSync = [tokenIOSync createMember:granteeAlias];
    TKMember *grantee = granteeSync.async;
  
    __block Token *accessToken = nil;
    
    // createAccessToken begin snippet to include in docs
    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];
    
    [grantor createAccessToken:access
                     onSuccess:^(Token *at) {
                         // created (and uploaded) but not yet endorsed
                         accessToken = at;
                     } onError:^(NSError *e) {
                         // Something went wrong.
                         @throw [NSException exceptionWithName:@"GrantAccessException"
                                                        reason:[e localizedFailureReason]
                                                      userInfo:[e userInfo]];
                     }];
    // createAccessToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accessToken != nil);
    }];
    
    // endorseAccessToken begin snippet to include in docs
    [grantor endorseToken:accessToken
                  withKey:Key_Level_Standard
                onSuccess:^(TokenOperationResult *result) {
                    accessToken = result.token;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"EndorseAccessException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    // endorseAccessToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accessToken.payloadSignaturesArray_Count > 0);
    }];
    NSString *accessTokenId = accessToken.id_p;
    __block NSArray<TKAccount *> *grantorAccounts = nil;
    
    // useAccessToken begin snippet to include in docs
    [grantee useAccessToken:accessTokenId]; // future requests will behave as if we were grantor
    [grantee getAccounts:^(NSArray <TKAccount *> *ary) {
        // use accounts
        grantorAccounts = ary;
        // if we're done using access token, clear it
        [grantee clearAccessToken]; // future requests will behave normally
    } onError:^(NSError *e) {
        @throw [NSException exceptionWithName:@"UseAccessException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // useAccessToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (grantorAccounts != nil);
    }];
    
    __block Token *foundToken = nil;
    
    // find token begin snippet to include in docs
    [grantor getAccessTokensOffset:NULL
                             limit:100
                         onSuccess:^(PagedArray<Token *> *ary) {
                             for (Token *at in ary.items) {
                                 if ([at.payload.to.alias isEqual:granteeAlias]) {
                                     foundToken = at;
                                     break;
                                 }
                             }
                         } onError:^(NSError* e) {
                               // something went wrong
                               @throw [NSException exceptionWithName:@"GetAccessTokensException"
                                                              reason:[e localizedFailureReason]
                                                            userInfo:[e userInfo]];
                           }];
    // find token done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (foundToken != nil) && [foundToken isEqual:accessToken];
    }];
    
    // replaceAndEndorseAccessToken begin snippet to include in docs
    AccessTokenConfig *newAccess = [AccessTokenConfig fromPayload:foundToken.payload];
    [newAccess forAllBalances];
    [newAccess forAllTransactions];
    
    [grantor replaceAndEndorseAccessToken:foundToken
                        accessTokenConfig:newAccess
                                onSuccess:^(TokenOperationResult *result) {
                                    accessToken = result.token;
                                } onError:^(NSError *e) {
                                    // something went wrong
                                    @throw [NSException exceptionWithName:@"ReplaceAccessTokenException"
                                                                   reason:[e localizedFailureReason]
                                                                 userInfo:[e userInfo]];
                                }];
    // replaceAndEndorseAccessToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accessToken.id_p != foundToken.id_p);
    }];
    
    // cancelToken begin snippet to include in docs
    [grantor cancelToken:accessToken
               onSuccess:^(TokenOperationResult *result) {
                   // token now has more signatures, including a CANCEL signature
                   accessToken = result.token;
               } onError:^(NSError *e) {
                   // something went wrong
                   @throw [NSException exceptionWithName:@"CancelAccessException"
                                                  reason:[e localizedFailureReason]
                                                userInfo:[e userInfo]];
               }];
    // cancelToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accessToken.payloadSignaturesArray_Count > 3);
    }];
}

-(void)testReplaceNoEndorse {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *grantorSync = [self createMember:tokenIOSync];
    // we test getAccounts, so create an account to get:
    Money *startingBalance = [Money message];
    startingBalance.currency = @"EUR";
    startingBalance.value = @"5678.00";
    [grantorSync linkAccounts: [grantorSync createTestBankAccount:startingBalance]];
    TKMember *grantor = grantorSync.async;

    Alias *granteeAlias = [self generateAlias];
    [tokenIOSync createMember:granteeAlias];

    __block Token *accessToken = nil;

    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];

    [grantor createAccessToken:access
                     onSuccess:^(Token *at) {
                         // created (and uploaded) but not yet endorsed
                         accessToken = at;
                     } onError:^(NSError *e) {
                         // Something went wrong.
                         @throw [NSException exceptionWithName:@"GrantAccessException"
                                                        reason:[e localizedFailureReason]
                                                      userInfo:[e userInfo]];
                     }];

    [self runUntilTrue:^ {
        return (accessToken != nil);
    }];

    [grantor endorseToken:accessToken
                  withKey:Key_Level_Standard
                onSuccess:^(TokenOperationResult *result) {
                    accessToken = result.token;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"EndorseAccessException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];

    __block Token *foundToken = nil;

    [grantor getAccessTokensOffset:NULL
                             limit:100
                         onSuccess:^(PagedArray<Token *> *ary) {
                             for (Token *at in ary.items) {
                                 if ([at.payload.to.alias isEqual:granteeAlias]) {
                                     foundToken = at;
                                     break;
                                 }
                             }
                         } onError:^(NSError* e) {
                             // something went wrong
                             @throw [NSException exceptionWithName:@"GetAccessTokensException"
                                                            reason:[e localizedFailureReason]
                                                          userInfo:[e userInfo]];
                         }];

    [self runUntilTrue:^ {
        return (foundToken != nil) && [foundToken isEqual:accessToken];
    }];

    // replaceNoEndorse begin snippet to include in docs
    AccessTokenConfig *newAccess = [AccessTokenConfig fromPayload:foundToken.payload];
    [newAccess forAllBalances];
    [newAccess forAllTransactions];

    [grantor replaceAccessToken:foundToken
              accessTokenConfig:newAccess
                      onSuccess:^(TokenOperationResult *result) {
                          accessToken = result.token;
                      } onError:^(NSError *e) {
                          @throw [NSException exceptionWithName:@"ReplaceAccessTokenException"
                                                         reason:[e localizedFailureReason]
                                                       userInfo:[e userInfo]];
                      }
     ];
    // replaceNoEndorse done snippet to include in docs

    [self runUntilTrue:^ {
        return (![accessToken isEqual:foundToken]);
    }];
}

@end
