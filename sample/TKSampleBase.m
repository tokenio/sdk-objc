//
//  TKSampleBase.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/9/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "TKSampleBase.h"

#import "TokenSdk.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@implementation TKSampleBase

-(void)setUp {
    [super setUp];
    _tokenClient = [[self sdkBuilder] build];
    
    _payerAccount = [self createAccount:_tokenClient];
    _payer = _payerAccount.member;
    _payerAlias = _payer.firstAlias;
    
    _payeeAccount = [self createAccount:_tokenClient];
    _payee = _payeeAccount.member;
    _payeeAlias = _payee.firstAlias;
}

@end
