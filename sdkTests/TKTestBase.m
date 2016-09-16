//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.#import "TKSdk.h"
//

#import <protos/Money.pbobjc.h>
#import "TKTestBase.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKBankClient.h"
#import "TKMember.h"
#import "TKAccount.h"
#import "TKUtil.h"
#import "Account.pbobjc.h"
#import "bankapi/Fank.pbobjc.h"


@implementation TKTestBase {
    TokenIO *tokenIO;
    TKBankClient *bank;
    dispatch_queue_t queue;
}

- (void)setUp {
    [super setUp];

    TokenIOBuilder *builder = [TokenIO builder];
    builder.host = @"localhost";
    builder.port = 9000;
    tokenIO = [builder build];
    bank = [TKBankClient bankClientWithHost:@"localhost"
                                       port:9100];

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
    account.balance.value = 1000000.00;
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

@end
