//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Money.pbobjc.h>

#import "TKTestBase.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKBankClient.h"
#import "TKMember.h"
#import "TKAccount.h"
#import "TKUtil.h"
#import "bankapi/Fank.pbobjc.h"

@interface HostAndPort : NSObject
@property NSString *host;
@property int port;
@end

@implementation HostAndPort
@end


@implementation TKTestBase {
    TokenIO *tokenIO;
    TKBankClient *bank;
    dispatch_queue_t queue;
}

- (void)setUp {
    [super setUp];
    HostAndPort *gateway = [self hostAndPort:@"TOKEN_GATEWAY" withDefaultPort:9000];
    HostAndPort *fank = [self hostAndPort:@"TOKEN_BANK" withDefaultPort:9100];

    TokenIOBuilder *builder = [TokenIO builder];
    builder.host = gateway.host;
    builder.port = gateway.port;
    tokenIO = [builder build];
    bank = [TKBankClient bankClientWithHost:fank.host
                                       port:fank.port];

    queue = dispatch_queue_create("io.token.Test", nil);
}

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
    NSString *alias = [@"alias-" stringByAppendingString:[TKUtil nonce]];
    return [token createMember:alias];
}

- (TKAccount *)createAccount:(TokenIO *)token {
    TKMember *member = [self createMember:token];

    NSString *alias = member.firstAlias;
    NSString *firstName = @"Test";
    NSString *lastName = @"Testoff";
    NSString *bankId = @"bank-id";
    NSString *accountName = @"Checking";
    NSString *bankAccountNumber = [@"iban:" stringByAppendingString:[TKUtil nonce]];

    FankMetadata_ClientAccount *account = [FankMetadata_ClientAccount message];
    account.accountNumber = bankAccountNumber;
    account.name = accountName;
    account.balance.value = @"1000000.00";
    account.balance.currency = @"USD";

    FankMetadata *metadata = [FankMetadata message];
    metadata.client.firstName = firstName;
    metadata.client.lastName = lastName;
    [metadata.clientAccountsArray addObject:account];

    NSData *linkPayload = [bank startAccountsLinkingForAlias:alias
                                              accountNumbers:@[bankAccountNumber]
                                                    metadata:metadata];
    NSArray<TKAccount *> *accounts = [member linkAccounts:bankId
                                              withPayload:linkPayload];
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
