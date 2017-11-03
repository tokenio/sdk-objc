//
//  TKAccountSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/3/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"

#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKMemberSync.h"
#import "TKTestKeyStore.h"
#import "TKLogManager.h"

#import "TKUtil.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKAccountSamples : TKTestBase

@end

@implementation TKAccountSamples

- (void)testGetAccounts {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *memberSync = [self createMember:tokenIOSync];
    [memberSync linkAccounts:[self createBankAuthorization:memberSync]];
    [memberSync linkAccounts:[self createBankAuthorization:memberSync]];
    TKMember *member = memberSync.async;
    NSMutableDictionary *sums = [NSMutableDictionary dictionaryWithCapacity:10];
    
    [member getAccounts:^(NSArray<TKAccount *> *accounts) {
        for (TKAccount *a in accounts) {
            TKLogDebug(@"ACCOUNT %@", a);
        }
    } onError: ^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"GetAccountsException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    
    [self runUntilTrue:^ {
        return false; // TODO
    }];
}
@end
