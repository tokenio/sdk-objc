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

-(void)testSomething {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *grantorSync = [self createMember:tokenIOSync];
    Alias *granteeAlias = [self generateAlias];
    [tokenIOSync createMember:granteeAlias];
    TKMember *grantor = grantorSync.async;
    __block Token *accessToken = nil;
    
    // createAccessToken begin snippet to include in docs
    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];
    [grantor createAccessToken:access
                     onSuccess:^(Token *t) {
                         // use token
                         accessToken = t;
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
}

@end
