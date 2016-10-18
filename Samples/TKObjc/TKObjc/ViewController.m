//
//  ViewController.m
//  TKObjc
//
//  Created by Greg Cockroft on 9/27/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

/*
   Not much yet. Few calls copied from the test project
   Just enough to prove the non-framework Pod works
 */
#import "ViewController.h"
#import "TokenSdk/TokenSdk.h"

@class TokenIO;
@class TKMember;
@class TKAccount;

@interface ViewController ()

@end


@implementation ViewController {
    TKMember *member;
    TokenIO *tokenIO;
    dispatch_queue_t queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self createMember];
}

- (void)setUp {

}

typedef void (^AsyncTestBlock)(TokenIO *);

- (void)run:(AsyncTestBlock)block {
    __block NSException *error;
    
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        @try {
            block(tokenIO);
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


- (TKMember *)createMember:(TokenIO *)token {
    NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
    return [token createMember:username];
}

- (void)createMember
{
    
    TokenIOBuilder *builder = [TokenIO builder];
    builder.host = @"dev.api.token.io";
    builder.port = 90;
    tokenIO = [builder build];
    //bank = [TKBankClient bankClientWithHost:fank.host
      //                                 port:fank.port];
    
    queue = dispatch_queue_create("io.token.Test", nil);
    [self run: ^(TokenIO *tkIO) {
        member = [self createMember:tkIO];
    }];
    
    
}


@end
