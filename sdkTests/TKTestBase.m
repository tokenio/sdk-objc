//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.#import "TKSdk.h"
//

#import "TKTestBase.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"


@implementation TKTestBase {
    TokenIO *sdk;
    dispatch_queue_t queue;
}

- (void)setUp {
    [super setUp];

    TokenIOBuilder *builder = [TokenIO builder];
    builder.host = @"localhost";
    builder.port = 9000;

    sdk = [builder build];
    queue = dispatch_queue_create("io.token.Test", nil);
}

- (void)run:(AsyncTestBlock)block {
    __block NSException *error;

    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        @try {
            block(sdk);
        } @catch(NSException *e) {
            error = e;
        } @finally {
            dispatch_semaphore_signal(done);
        }
    });

    // Wait for the block above to finish executing while running the main
    // event loop. gRPC posts to the main dispatch queue, so we have to run it
    // for the callbacks to be completed.
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

        // Are we done yet?
        if (dispatch_semaphore_wait(done, DISPATCH_TIME_NOW) == 0) {
            break;
        }
    }

    if (error) {
        @throw error;
    }
}

@end
