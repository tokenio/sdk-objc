//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Money.pbobjc.h"

#import "TKTestBase.h"
#import "HostAndPort.h"
#import "TKBankClient.h"
#import "TokenClient.h"
#import "TokenClientBuilder.h"
#import "TKMember.h"
#import "TKAccount.h"
#import "TKInMemoryKeyStore.h"
#import "TKLogManager.h"
#import "TKTokenCryptoEngineFactory.h"
#import "TKRpcSyncCall.h"
#import "PagedArray.h"
#import "PrepareTokenResult.h"

@implementation TKTestBase {
    TokenClient *tokenClient;
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
   [self runWithResult: ^id(TokenClient *tio) {
       block(tio);
       return nil;
   }];
}


// create an SDK client builder with settings appropriate for testing environment
- (TokenClientBuilder *)sdkBuilder {
    HostAndPort *gateway = [self hostAndPort:@"TOKEN_GATEWAY" withDefaultPort:9000];
    
    TokenClientBuilder *builder = [TokenClient builder];
    builder.tokenCluster = [[TokenCluster alloc] initWithEnvUrl:gateway.host
                                                      webAppUrl:gateway.host];
    builder.port = gateway.port;
    builder.useSsl = useSsl;
    builder.timeoutMs = 10 * 60 * 1000; // 10 minutes timeout to make debugging easier.
    builder.developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
    builder.languageCode = @"en";
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    builder.cryptoEngineFactory = [TKTokenCryptoEngineFactory factoryWithStore:store
                                                        useLocalAuthentication:NO];
    return builder;
}

- (TokenClient *)client {
    return [[self sdkBuilder] build];
}

- (id)runWithResult:(AsyncTestBlockWithResult)block {
    __block NSException *error;
    __block id result = nil;

    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        @try {
            self->tokenClient = [self client];

            result = block(self->tokenClient);
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

- (TKMember *)createMember:(TokenClient *)tokenClient {
    Alias *alias = [self generateAlias];
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [tokenClient createMember:alias
                        onSuccess:call.onSuccess
                          onError:call.onError];
         
    }];
}

- (TKAccount *)createAccount:(TokenClient *)tokenClient {
    TKMember *member = [self createMember:tokenClient];
    OauthBankAuthorization * auth = [self createBankAuthorization:member];

    NSArray<TKAccount *> *accounts = [self linkAccounts:auth to:member];
    
    XCTAssert(accounts.count == 1);
    return accounts[0];
}

- (NSArray<TKAccount *> *)linkAccounts:(OauthBankAuthorization *)bankAuthorization to:(TKMember *)member {
    TKRpcSyncCall<NSArray<TKAccount *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [member linkAccounts:bankAuthorization.bankId
                 accessToken:bankAuthorization.accessToken
                   onSuccess:call.onSuccess
                     onError:call.onError];
    }];
}

- (OauthBankAuthorization *)createBankAuthorization:(TKMember *)member {
    Money *balance = [Money message];
    balance.value = @"1000000.00";
    balance.currency = @"USD";
    TKRpcSyncCall<OauthBankAuthorization *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [member createTestBankAccount:balance
                            onSuccess:call.onSuccess
                              onError:call.onError];
        
    }];
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
    alias.value = [[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"];
    alias.type = Alias_Type_Email;
    return alias;
}

- (Alias *)generatePhoneAlias {
    Alias *alias = [Alias new];
    alias.value = [[@"alias-" stringByAppendingString:[TKUtil nonce]] stringByAppendingString:@"+noverify@token.io"];
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
        typedef void (^AsyncTestBlock)(TokenClient *);
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

- (void)runUntilTrue:(int (^)(void))condition {
    [self runUntilTrue:condition backOffTimeMs:0 waitingTimeMs:20000];
}

- (void)runUntilTrue:(int (^)(void))condition backOffTimeMs:(int)backOffTimeMs waitingTimeMs:(int)waitingTimeMs {
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    while(true) {
        if (condition()) {
            return;
        }
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - start < waitingTimeMs) {
            usleep(1000 * backOffTimeMs);
            [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode
                                  beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } else {
            // time is up; try one last time...
            XCTAssertTrue(condition());
            return;
        }
    }
}

- (Notification *)runUntilNotificationReceived:(TKMember *)member; {
    TKRpcSyncCall<PagedArray<Notification *> *> *call = [TKRpcSyncCall create];
    __block Notification *result = nil;
    [self runUntilTrue:^ {
        PagedArray<Notification *> * array = [call run:^{
            [member getNotificationsOffset:0
                                     limit:1
                                 onSuccess:call.onSuccess
                                   onError:call.onError];
            
        }];
        if (array.items.count > 0) {
            result = array.items[0];
            return true;
        }
        return false;
    }
         backOffTimeMs:2
         waitingTimeMs:60000];
    return result;
}

- (Token *)createToken:(TransferTokenBuilder *)builder {
    __block Token *ret = nil;
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    [builder.member prepareTransferToken:builder onSuccess:^(PrepareTokenResult *result) {
        [builder.member createToken:result.tokenPayload
                  tokenRequestId:nil
                        keyLevel:result.policy.singleSignature.signer.keyLevel
                       onSuccess:^ (Token *token) {
                           ret = token;
                           [expectation fulfill];
                       } onError:THROWERROR];
    } onError:THROWERROR];
    
    [self waitForExpectations:@[expectation] timeout:10];
    return ret;
}
@end
