//
//  TKMemberRegistrationTests.m
//  TKMemberRegistrationTests
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMember.h"
#import "TKSdk.h"
#import "TKTestBase.h"


@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests

- (void)testCreateMember {
    [self run: ^(TKSdk *sdk) {
        TKMember *member = [sdk createMember];
        NSLog(@"DONE: %@", member.debugDescription);
    }];
}

- (void)testLoginMember {
    [self run: ^(TKSdk *sdk) {
        TKMember *created = [sdk createMember];
        TKMember *loggedIn = [sdk loginMember:created.id secretKey:created.key];
        NSLog(@"DONE: %@", loggedIn.debugDescription);
    }];
}

@end
