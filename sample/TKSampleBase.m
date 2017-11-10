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
    _tokenIOSync = [[self sdkBuilder] buildSync];
    _payerAlias = [self generateAlias];
    _payerSync = [_tokenIOSync createMember:_payerAlias];
    Money *fortune = [Money message];
    fortune.currency = @"EUR";
    fortune.value = @"5678.90";
    _payerAccountSync = [_payerSync linkAccounts:[_payerSync createTestBankAccount:fortune]][0];
    _payeeAlias = [self generateAlias];
    _payeeSync = [_tokenIOSync createMember:_payeeAlias];
    _payeeAccountSync = [_payeeSync linkAccounts:[_payeeSync createTestBankAccount:fortune]][0];
}

- (void)runUntilTrue:(int (^)(void))condition {
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    while(true) {
        if (condition()) {
            return;
        }
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - start < 20) {
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                                  beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } else {
            // time is up; try one last time...
            XCTAssertTrue(condition());
            return;
        }
    }
}

@end
