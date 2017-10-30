//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKRpcSyncCall.h"


@implementation TKRpcSyncCall {
    id result;
    NSError *error;
    dispatch_semaphore_t isDone;
}

+ (TKRpcSyncCall *)create {
    return [[TKRpcSyncCall alloc] init];
}

- (id)init {
    self = [super init];

    if (self) {
        isDone = dispatch_semaphore_create(0);
        
        dispatch_semaphore_t semaphore = isDone;
        _onSuccess = ^(id result_) {
            result = result_;
            dispatch_semaphore_signal(semaphore);
        };
        _onError = ^(NSError *error_) {
            error = error_;
            dispatch_semaphore_signal(semaphore);
        };
    }

    return self;
}

- (id)run:(void(^)())block {
    block();
    while (dispatch_semaphore_wait(isDone, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }

    if (error) {
        @throw error;
    }

    return result;
}

@end
