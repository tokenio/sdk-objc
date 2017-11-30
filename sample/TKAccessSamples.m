//
//  TKAccessSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/6/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSampleBase.h"

#import "TokenSdk.h"

@interface TKAccessSamples : TKSampleBase

@end

@implementation TKAccessSamples

-(void)testAccessTokens {
    TKMember *grantor = self.payerSync.async;
    Alias *granteeAlias = self.payeeAlias;
    TKMember *grantee = self.payeeSync.async;
  
    __block Token *accessToken = nil;
    
    // createAccessToken begin snippet to include in docs
    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];
    [access forAllBalances];
    
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
    __block Money *balance0 = nil;
    
    // useAccessToken begin snippet to include in docs
    [grantee useAccessToken:accessTokenId]; // future requests will behave as if we were grantor
    [grantee getAccounts:^(NSArray <TKAccount *> *ary) {
        // use accounts
        [ary[0] getBalance:^(TKBalance * b) {
            balance0 = b.current;
        } onError:^(NSError *e) {
            @throw [NSException exceptionWithName:@"AccessBalanceException"
                                           reason:[e localizedFailureReason]
                                         userInfo:[e userInfo]];
        }];
        // if we're done using access token, clear it
        [grantee clearAccessToken]; // future requests will behave normally
    } onError:^(NSError *e) {
        @throw [NSException exceptionWithName:@"UseAccessException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // useAccessToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (balance0 != nil);
    }];
    
    __block Token *foundToken = nil;
    
    [self runUntilTrue:^ {
        // find token begin snippet to include in docs
        PagedArray<Token *> *ary = [self.payerSync getAccessTokensOffset:NULL limit:100];
        for (Token *at in ary.items) {
            if ([at.payload.to.alias isEqual:granteeAlias]) {
                foundToken = at;
                break;
            }
        }
        // find token done snippet to include in docs
    
        return (foundToken != nil) && [foundToken.id_p isEqual:accessToken.id_p];
    } backOffTimeMs:1000];

    // replaceAndEndorseAccessToken begin snippet to include in docs
    AccessTokenConfig *newAccess = [AccessTokenConfig fromPayload:foundToken.payload];
    [newAccess forAllAddresses];
    
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
    TKMember *grantor = self.payerSync.async;
    Alias *granteeAlias = self.payeeAlias;

    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];
    
    __block Token *accessToken = [self.payerSync createAccessToken:access];
    [self.payerSync endorseToken:accessToken withKey:Key_Level_Standard];
    Token *foundToken = accessToken;
   
    // replaceNoEndorse begin snippet to include in docs
    AccessTokenConfig *newAccess = [AccessTokenConfig fromPayload:foundToken.payload];
    [newAccess forAllAccounts];
    [newAccess forAllBalances];
    [newAccess forAllAddresses];

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
        return (![accessToken.id_p isEqual:foundToken.id_p]);
    }];
}

@end
