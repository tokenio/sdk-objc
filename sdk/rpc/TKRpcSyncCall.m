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
        _onSuccess = ^(id result_) {
            result = result_;
            dispatch_semaphore_signal(isDone);
        };
        _onError = ^(NSError *error_) {
            error = error_;
            dispatch_semaphore_signal(isDone);
        };
    }

    return self;
}

- (id)run:(void(^)())block {
    block();
    dispatch_semaphore_wait(isDone, DISPATCH_TIME_FOREVER);

    if (error) {
        @throw [NSException
                exceptionWithName:error.localizedDescription
                           reason:error.localizedFailureReason
                         userInfo:error.userInfo];
    }

    return result;
}

- (void)onSuccess:(id)result_ {
    result = result_;
    dispatch_semaphore_signal(isDone);
}

- (void)onError:(NSError *)error_ {
    error = error_;
    dispatch_semaphore_signal(isDone);
}

@end