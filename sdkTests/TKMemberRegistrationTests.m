//
//  TKMemberRegistrationTests.m
//  TKMemberRegistrationTests
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKMember.h"
#import "TKSdk.h"
#import "TKSdkBuilder.h"


@interface TKMemberRegistrationTests : XCTestCase
@property (strong, nonatomic) TKSdk *sdk;
@property (strong, nonatomic) dispatch_queue_t queue;
@end

@implementation TKMemberRegistrationTests

- (void)setUp {
    [super setUp];

    TKSdkBuilder *builder = [TKSdk builder];
    builder.host = @"localhost";
    builder.port = 9000;

    self.sdk = [builder build];
    self.queue = dispatch_queue_create("io.token.Test", nil);
}

typedef void (^Block)();

- (void)async:(Block)block {
    __block NSException *error;

    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(self.queue, ^{
        @try {
            block();
        } @catch(NSException *e) {
            error = e;
        } @finally {
            dispatch_semaphore_signal(done);
        }
    });

    while (true) {
        @try {
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                                  beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } @catch(NSException *e) {
            NSLog(@"**ERROR: %@", e);
            break;
        } @catch(NSObject *o) {
            NSLog(@"**UNKNOWN ERROR: %@", o);
            break;
        }

        if (dispatch_semaphore_wait(done, DISPATCH_TIME_NOW) == 0) {
            break;
        }
    }

    if (error) {
        @throw error;
    }
}

- (void)testCreateMember {
    [self async: ^{
        TKMember *member = [self.sdk createMember];
        NSLog(@"DONE: %@", member.debugDescription);
    }];
}

- (void)testLoginMember {
    [self async: ^{
        TKMember *created = [self.sdk createMember];
        TKMember *loggedIn = [self.sdk loginMember:created.id secretKey:created.key];
        NSLog(@"DONE: %@", loggedIn.debugDescription);
    }];
}

@end
