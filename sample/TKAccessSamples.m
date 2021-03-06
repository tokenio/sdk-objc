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
    TKMember *grantor = self.payer;
    TKMember *grantee = self.payee;
  
    __block Token *accessToken = nil;
    
    NSString *accountId = self.payerAccount.id;

    // createAccessToken begin snippet to include in docs
    AccessTokenBuilder *access = [AccessTokenBuilder createWithToId:self.payee.id];
    [access forAccount:accountId];
    [access forAccountBalances:accountId];
    
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
    id<TKRepresentable> representable = [grantee forAccessToken:accessTokenId]; // future requests will behave as if we were grantor
    [representable getAccounts:^(NSArray <TKAccount *> *ary) {
        // use accounts
        [ary[0] getBalance:Key_Level_Low onSuccess:^(TKBalance * b) {
            balance0 = b.current;
        } onError:^(NSError *e) {
            @throw [NSException exceptionWithName:@"AccessBalanceException"
                                           reason:[e localizedFailureReason]
                                         userInfo:[e userInfo]];
        }];
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
    // find token begin snippet to include in docs
    [self.payer getActiveAccessToken:self.payee.id onSuccess:^(Token *token) {
        foundToken = token;
    } onError:^(NSError *e) {
        @throw [NSException exceptionWithName:@"GetActiveAccessTokenException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // find token done snippet to include in docs
    [self runUntilTrue:^{
        return (foundToken != nil);
    }];

    // replaceAndEndorseAccessToken begin snippet to include in docs
    AccessTokenBuilder *newAccess = [AccessTokenBuilder fromPayload:foundToken.payload];
    [newAccess forAccount:accountId];
    [newAccess forAccountBalances:accountId];
    [newAccess forAccountTransactions:accountId];
    
    [grantor replaceAccessToken:foundToken
              accessTokenBuilder:newAccess
                      onSuccess:^(TokenOperationResult *result) {
                          [grantor endorseToken:result.token
                                        withKey:Key_Level_Standard
                                      onSuccess:^(TokenOperationResult *result) {
                                          accessToken = result.token;
                                      } onError:^(NSError *e) {
                                          // something went wrong
                                          @throw [NSException exceptionWithName:@"ReplaceAccessTokenException"
                                                                         reason:[e localizedFailureReason]
                                                                       userInfo:[e userInfo]];
                                      }];
                      }
                        onError:^(NSError *e) {
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
    TKMember *grantor = self.payer;
    NSString *accountId = self.payerAccount.id;
    
    AccessTokenBuilder *access = [AccessTokenBuilder createWithToId:self.payee.id];
    [access forAccount:accountId];
    
    __block Token *originToken = nil;
    [grantor createAccessToken:access
                     onSuccess:^(Token *at) {
                         [grantor endorseToken:at
                                       withKey:Key_Level_Standard
                                     onSuccess:^(TokenOperationResult *result) {
                                         originToken = result.token;
                                     } onError:^(NSError *e) {
                                         // Something went wrong.
                                         @throw [NSException exceptionWithName:@"EndorseAccessException"
                                                                        reason:[e localizedFailureReason]
                                                                      userInfo:[e userInfo]];
                                     }];
                     } onError:^(NSError *e) {
                         // Something went wrong.
                         @throw [NSException exceptionWithName:@"GrantAccessException"
                                                        reason:[e localizedFailureReason]
                                                      userInfo:[e userInfo]];
                     }];
    
    [self runUntilTrue:^ {
        return (originToken != nil);
    }];
   
    
    __block Token *accessToken = nil;
    // replaceNoEndorse begin snippet to include in docs
    AccessTokenBuilder *newAccess = [AccessTokenBuilder fromPayload:originToken.payload];
    [newAccess forAccount:accountId];
    [newAccess forAccountBalances:accountId];

    [grantor replaceAccessToken:originToken
              accessTokenBuilder:newAccess
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
        return (![accessToken.id_p isEqual:originToken.id_p]);
    }];
}

-(Token *)findAccessToken:(TKMember*)grantee tokenId:(NSString*)tokenId {
    __block Token *accessToken = nil;
    [grantee getToken:tokenId onSuccess:^(Token *token) {
        accessToken = token;
    } onError:^(NSError *e) {
        @throw [NSException exceptionWithName:@"GetAccessTokenException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    [self runUntilTrue:^ {
        return (accessToken != nil);
    }];
    
    if ([accessToken.replacedByTokenId length] > 0) {
        return [self findAccessToken:grantee tokenId:accessToken.replacedByTokenId];
    } else {
        return accessToken;
    }
}
@end
