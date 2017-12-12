//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Money.pbobjc.h"

#import "TKTestBase.h"
#import "HostAndPort.h"
#import "TKBankClient.h"
#import "TokenIOSync.h"
#import "TokenIOBuilder.h"
#import "TKMemberSync.h"
#import "TKAccountSync.h"
#import "TKInMemoryKeyStore.h"
#import "TKLogManager.h"


@implementation TKTestBase {
    TokenIOSync *tokenIO;
    dispatch_queue_t queue;
    BOOL useSsl;
}

- (void)setUp {
    [super setUp];
    NSString *sslOverride = [[[NSProcessInfo processInfo] environment] objectForKey:@"TOKEN_USE_SSL"];
    useSsl = sslOverride ? [sslOverride boolValue] : NO;

    HostAndPort *fank = [self hostAndPort:@"TOKEN_BANK" withDefaultPort:8100];
    _bank = [TKBankClient bankClientWithHost:fank.host
                                        port:fank.port
                                      useSsl:useSsl];

    queue = dispatch_queue_create("io.token.Test", nil);
}

- (void)run:(AsyncTestBlock)block {
   [self runWithResult: ^id(TokenIOSync *tio) {
       block(tio);
       return nil;
   }];
}


// create an SDK client builder with settings appropriate for testing environment
- (TokenIOBuilder *)sdkBuilder {
    HostAndPort *gateway = [self hostAndPort:@"TOKEN_GATEWAY" withDefaultPort:9000];
    
    TokenIOBuilder *builder = [TokenIOSync builder];
    builder.host = gateway.host;
    builder.port = gateway.port;
    builder.useSsl = useSsl;
    builder.timeoutMs = 10 * 60 * 1000; // 10 minutes timeout to make debugging easier.
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    builder.keyStore = [[TKInMemoryKeyStore alloc] init];
    builder.useLocalAuthentication = NO;
    return builder;
}

- (TokenIO *)asyncSDK {
    return [[self sdkBuilder] buildAsync];
}

- (id)runWithResult:(AsyncTestBlockWithResult)block {
    __block NSException *error;
    __block id result = nil;

    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        @try {
            TokenIOBuilder *builder = [self sdkBuilder];
            tokenIO = [builder buildSync];

            result = block(tokenIO);
        } @catch(NSException *e) {
            error = e;
        } @finally {
            dispatch_semaphore_signal(done);
        }
    });

    // Wait for the block above to finish executing while running the main
    // event loop. gRPC posts to the main dispatch queue, so we have to run it
    // for the callbacks to be completed.
    int loopCount = 0;
    while (true) {
        loopCount++;
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
    TKLogDebug(@"runWithResult loopCount: %d", loopCount);
    return result;
}

- (TKMemberSync *)createMember:(TokenIOSync *)token {
    return [token createMember:[self generateAlias]];
}

- (TKAccountSync *)createAccount:(TokenIOSync *)token {
    TKMemberSync *member = [self createMember:token];
    
    BankAuthorization * auth = [self createBankAuthorization:member];

    NSArray<TKAccountSync *> *accounts = [member linkAccounts:auth];
    XCTAssert(accounts.count == 1);
    return accounts[0];
}

- (BankAuthorization *)createBankAuthorization:(TKMemberSync *)member {
    Money *balance = [Money message];
    balance.value = @"1000000.00";
    balance.currency = @"USD";
    return [member createTestBankAccount:balance];
}

- (HostAndPort *)hostAndPort:(NSString *)var withDefaultPort:(int)port {
    NSString *override = [[[NSProcessInfo processInfo] environment] objectForKey:var];
    NSArray<NSString *> *parts = [override componentsSeparatedByString:@":"];

    HostAndPort *hostAndPort = [[HostAndPort alloc] init];
    hostAndPort.host = @"localhost";
    hostAndPort.port = port;

    switch (parts.count) {
        case 1:
            hostAndPort.host = parts[0];
            break;
        case 2:
            hostAndPort.host = parts[0];
            hostAndPort.port = [parts[1] intValue];
            break;
        default:
            break;
    }

    NSLog(@"Targeting %@: %@:%d", var, hostAndPort.host, hostAndPort.port);
    return hostAndPort;
}

- (Alias *)generateAlias {
    return [self generateEmailAlias];
}

- (Alias *)generateEmailAlias {
    Alias *alias = [Alias new];
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
    alias.type = Alias_Type_Email;
    return alias;
}

- (Alias *)generatePhoneAlias {
    Alias *alias = [Alias new];
    alias.value = [[[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"] lowercaseString];
    alias.type = Alias_Type_Phone;
    return alias;
}

- (void)check:(NSString *)message condition:(BOOL)condition {
    if (!condition) {
        [NSException raise:message format:@"%@", message];
    }
}

- (void)waitUntil:(void (^)(void))block {
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    for (useconds_t waitTimeMs = 100; ; waitTimeMs *= 2) {
        typedef void (^AsyncTestBlock)(TokenIOSync *);
        @try {
            block();
            return;
        }
        @catch (...) {
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            if (now - start < 20) {
                usleep(waitTimeMs * 1000);
            } else {
                @throw;
            }
        }
    }
}

@end
