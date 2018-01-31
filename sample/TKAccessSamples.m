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
    [newAccess forAllAccounts];
    [newAccess forAllBalances];
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

-(Money*)carefullyUse:(TKMember*)grantee
              tokenId:(NSString*)tokenId {
    TKMemberSync *granteeSync = [TKMemberSync member:grantee];
    Token *accessToken = [granteeSync getToken:tokenId];
    while ([accessToken.replacedByTokenId length] > 0) {
        accessToken = [granteeSync getToken:accessToken.replacedByTokenId];
    }
    NSMutableArray *accountIds = [NSMutableArray array];
    Boolean haveAllAccountsAccess = false;
    Boolean haveAllBalancesAccess = false;
    for (int i = 0; i < accessToken.payload.access.resourcesArray_Count; i++) {
        switch (accessToken.payload.access.resourcesArray[i].resourceOneOfCase) {
            case AccessBody_Resource_Resource_OneOfCase_Balance:
                [accountIds addObject: accessToken.payload.access.resourcesArray[i].balance.accountId];
                break;
            case AccessBody_Resource_Resource_OneOfCase_AllAccounts:
                haveAllAccountsAccess = true;
                break;
            case AccessBody_Resource_Resource_OneOfCase_AllBalances:
                haveAllBalancesAccess = true;
                break;
            default:
                break;
        }
    }
    [granteeSync useAccessToken:accessToken.id_p];
    if (haveAllAccountsAccess && haveAllBalancesAccess) {
        NSArray<TKAccountSync *> *accounts = [granteeSync getAccounts];
        for (int i = 0 ; i < accounts.count; i++) {
            [accountIds addObject:accounts[i].id];
        }
    }

    if (accountIds.count < 1) {
        // We have access to no accounts; return zero balance
        return [Money new];
    }
    
    for (int i = 0; i < accountIds.count; i++) {
        @try {
            Money *balance = [granteeSync getBalance:accountIds[i]
                                             withKey:Key_Level_Standard].available;
            [granteeSync clearAccessToken];
            return balance;
        }
        @catch (NSError *error) {
            // If access grantor un-linked an account,
            // getting that account's balance fails.
            if (error.code == 9) {
                // skip this account
                continue;
            }
            // ...but if we hit some other type of error, it's really an error
            @throw error;
        }
    }
    
    // We have access to no accounts; return zero balance
    return [Money new];
}

/**
 * Use an access token that might or might not grant allAccounts access
 * (so maybe )
 */
-(void)testCarefullyUse {
    TKMember *grantor = self.payerSync.async;
    TKAccount *grantorAccount = self.payerAccountSync.async;
    Alias *granteeAlias = self.payeeAlias;
    TKMember *grantee = self.payeeSync.async;

    __block Token *token1 = nil;

    // createAccessToken begin snippet to include in docs
    AccessTokenConfig *access = [AccessTokenConfig create:granteeAlias];
    [access forAllAccounts];
    [access forAllBalances];

    [grantor createAccessToken:access
                     onSuccess:^(Token *at) {
                         // created (and uploaded) but not yet endorsed
                         token1 = at;
                     } onError:^(NSError *e) {
                         // Something went wrong.
                         @throw [NSException exceptionWithName:@"GrantAccessException"
                                                        reason:[e localizedFailureReason]
                                                      userInfo:[e userInfo]];
                     }];
    // createAccessToken done snippet to include in docs

    [self runUntilTrue:^ {
        return (token1 != nil);
    }];

    [grantor endorseToken:token1
                  withKey:Key_Level_Standard
                onSuccess:^(TokenOperationResult *result) {
                    token1 = result.token;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"EndorseAccessException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];

    [self runUntilTrue:^ {
        return (token1.payloadSignaturesArray_Count > 0);
    }];

    Money * balance1 = [self carefullyUse:grantee
                                  tokenId:token1.id_p];
    NSAssert([balance1.value floatValue] > 10.0, @"I should see a legitimate balance");

    AccessTokenConfig *newAccess = [AccessTokenConfig fromPayload:token1.payload];
    [newAccess forAccount:grantorAccount.id];
    [newAccess forAccountBalances:grantorAccount.id];

    __block Token *token2 = nil;

    [grantor replaceAndEndorseAccessToken:token1
                        accessTokenConfig:newAccess
                                onSuccess:^(TokenOperationResult *result) {
                                    token2 = result.token;
                                } onError:^(NSError *e) {
                                    // something went wrong
                                    @throw [NSException exceptionWithName:@"ReplaceAccessTokenException"
                                                                   reason:[e localizedFailureReason]
                                                                 userInfo:[e userInfo]];
                                }];

    [self runUntilTrue:^ {
        return (token2 != nil);
    }];

    Money * balance2 = [self carefullyUse:grantee
                                  tokenId:token1.id_p];
    NSAssert([balance2.value floatValue] > 10.0, @"I should see a legitimate balance");
    
    __block int finishedUnlink = 0;
    [grantor unlinkAccounts:@[grantorAccount.id]
                  onSuccess:^() {
                      finishedUnlink = 1;
                  } onError:^(NSError *e) {
                      // something went wrong
                      @throw [NSException exceptionWithName:@"UnlinkAccountException"
                                                     reason:[e localizedFailureReason]
                                                   userInfo:[e userInfo]];
                  }];
    
    [self runUntilTrue:^ {
        return finishedUnlink;
    }];
    
    Money * balance3 = [self carefullyUse:grantee
                                  tokenId:token1.id_p];
    NSAssert([balance3.value floatValue] == 0.0, @"I should see 0 balance (no accessed accounts)");
}

@end
