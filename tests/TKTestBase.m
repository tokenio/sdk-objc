//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "Money.pbobjc.h"
#import "bankapi/Fank.pbobjc.h"

#import "HostAndPort.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKBankClient.h"
#import "TKMember.h"
#import "TKAccount.h"
#import "TKTestKeyStore.h"


@implementation TKTestBase {
    TokenIO *tokenIO;
    dispatch_queue_t queue;
    BOOL useSsl;
}

- (void)setUp {
    [super setUp];
    NSString *sslOverride = [[[NSProcessInfo processInfo] environment] objectForKey:@"TOKEN_USE_SSL"];
    useSsl = sslOverride ? [sslOverride boolValue] : NO;

    HostAndPort *fank = [self hostAndPort:@"TOKEN_BANK" withDefaultPort:9100];
    _bank = [TKBankClient bankClientWithHost:fank.host
                                        port:fank.port
                                      useSsl:useSsl];

    queue = dispatch_queue_create("io.token.Test", nil);
}

- (void)run:(AsyncTestBlock)block {
   [self runWithResult: ^id(TokenIO *tio) {
       block(tio);
       return nil;
   }];
}

- (id)runWithResult:(AsyncTestBlockWithResult)block {
    __block NSException *error;
    __block id result = nil;

    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        @try {
            HostAndPort *gateway = [self hostAndPort:@"TOKEN_GATEWAY" withDefaultPort:9000];

            TokenIOBuilder *builder = [TokenIO builder];
            builder.host = gateway.host;
            builder.port = gateway.port;
            builder.useSsl = useSsl;
            builder.timeoutMs = 10 * 60 * 1000; // 10 minutes timeout to make debugging easier.
            builder.keyStore = [[TKTestKeyStore alloc] init];
            tokenIO = [builder build];

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

    return result;
}

- (TKMember *)createMember:(TokenIO *)token {
    NSString *username = [@"username-" stringByAppendingString:[TKUtil nonce]];
    return [token createMember:username];
}

- (TKAccount *)createAccount:(TokenIO *)token {
    TKMember *member = [self createMember:token];

    NSString *firstName = @"Test";
    NSString *lastName = @"Testoff";
    NSString *bankId = @"iron";
    NSString *accountName = @"Checking";
    NSString *bankAccountNumber = [@"iban:" stringByAppendingString:[TKUtil nonce]];
    
    FankClient *fankClient = [_bank addClientWithFirstName:firstName lastName:lastName];
    [_bank addAccountWithName:accountName
                    forClient:fankClient
            withAccountNumber:bankAccountNumber
                       amount:@"1000000.00"
                     currency:@"USD"];
    
    NSString *clientId = fankClient.id_p;
    NSArray<SealedMessage*> *payloads = [_bank authorizeAccountLinkingFor:member.firstUsername
                                                                 clientId:clientId
                                                           accountNumbers:@[bankAccountNumber]];
                             
    NSArray<TKAccount *> *accounts = [member linkAccounts:bankId
                                              withPayloads:payloads];
    XCTAssert(accounts.count == 1);
    return accounts[0];
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

@end
