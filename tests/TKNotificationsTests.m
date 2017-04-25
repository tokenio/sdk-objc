//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"



@interface TKNotificationsTests : TKTestBase
@end

@implementation TKNotificationsTests {
    TKAccount *payerAccount;
    TKMember *payer;
    TKMember *payerAnotherDevice;

    TKAccount *payeeAccount;
    TKMember *payee;
    NSMutableDictionary * instructions;
}

/**
 * Checks the specified condition, throws NSException if condition is false.
 *
 * @param message error message
 * @param condition condition to check
 */
void check(NSString *message, BOOL condition) {
    if (!condition) {
        [NSException raise:message format:message];
    }
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payerAnotherDevice = [self createMember:tokenIO];

        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
        instructions = [NSMutableDictionary dictionaryWithDictionary:@{
                    @"PLATFORM": @"TEST",
                    @"TARGET": @"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979"}];
    }];
}

- (void)testTransfer {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        [payee createTransfer:token amount:@(50) currency:@"USD" description:@"" destination:destination];

        [self waitForNotification:@"TRANSFER_PROCESSED"];
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        [tokenIO notifyLinkAccounts:payer.firstUsername
                             bankId:@"iron"
                           bankName:@"bank-name"
                accountLinkPayloads:@[[SealedMessage new]]];

        [self waitForNotification:@"LINK_ACCOUNTS"];
    }];
}

- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {
        Subscriber * subscriber = [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                      keyName:@"Chrome 53.0"
                          key:key];

        [self waitForNotification:@"ADD_KEY"];
    }];
}

- (void)testNotifyAddKeyIos {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableDictionary * instructionsDev = [NSMutableDictionary dictionaryWithDictionary:@{
                        @"PLATFORM": @"IOS",
                        @"TARGET": @"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979"}];
        Subscriber * subscriber = [payer subscribeToNotifications:@"token" handlerInstructions:instructionsDev];
        XCTAssert([subscriber.handlerInstructions[@"DEVELOPMENT"] isEqualToString:@"false"]);
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                      keyName:@"Chrome 53.0"
                          key:key];
    }];
}

- (void)testNotifyAddKeyIosDev {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableDictionary * instructionsDev = [NSMutableDictionary dictionaryWithDictionary:@{
                        @"PLATFORM": @"IOS",
                        @"TARGET": @"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979",
                        @"DEVELOPMENT": @"true"}];
        Subscriber * subscriber = [payer subscribeToNotifications:@"token" handlerInstructions:instructionsDev];
        XCTAssert([subscriber.handlerInstructions[@"DEVELOPMENT"] isEqualToString:@"true"]);
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                      keyName:@"Chrome 53.0"
                          key:key];
    }];
}

- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstUsername
                                      bankId:@"iron"
                                    bankName:@"bank-name"
                         accountLinkPayloads:@[[SealedMessage new]]
                                     keyName:@"Chrome 53.0"
                                         key:key];

        [self waitForNotification:@"LINK_ACCOUNTS_AND_ADD_KEY"];
    }];
}

- (void)testGetSubscribers {
    [self run: ^(TokenIO *tokenIO) {
        Subscriber * subscriber = [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        XCTAssert([payer getSubscribers].count == 1);

        Subscriber * lookedUp = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
        XCTAssert([subscriber.handler isEqualToString:lookedUp.handler]);
        XCTAssert([subscriber.handlerInstructions[@"PLATFORM"]
                   isEqualToString:lookedUp.handlerInstructions[@"PLATFORM"]]);
    }];
}

- (void)testGetSubscribersWithBankId {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableDictionary * instructionsEmpty = [NSMutableDictionary dictionaryWithDictionary:@{}];
        Subscriber * subscriber = [payer subscribeToNotifications:@"iron" handlerInstructions:instructionsEmpty];
        
        XCTAssert([payer getSubscribers].count == 1);
        
        Subscriber * lookedUp = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
        XCTAssert([subscriber.handler isEqualToString:lookedUp.handler]);
    }];
}


- (void)testTransferNotification {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        NSMutableDictionary * instructionsEmpty = [NSMutableDictionary dictionaryWithDictionary:@{}];
        [payer subscribeToNotifications:@"iron" handlerInstructions:instructionsEmpty];
        
        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        Destination *destination = [[Destination alloc] init];
        destination.tokenDestination.accountId = payeeAccount.id;
        Transfer *transfer = [payee createTransfer:token amount:@(100.99) currency:@"USD" description:@"" destination:destination];
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testGetNotifications {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername keyName:@"Chrome 53.0" key:key];

        [self waitForNotification:@"ADD_KEY"];
    }];
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 */
- (void)waitForNotification:(NSString *)type {
    [self waitUntil:^{
        PagedArray<Notification *> *notifications = [payer getNotificationsOffset:nil limit:100];
        check(@"Notification count", notifications.items.count == 1);

        Notification* notification = [notifications.items objectAtIndex:0];
        check(@"Delivery Status", notification.status == Notification_Status_Delivered);
        check(@"Notification Type", [notification.content.type isEqualToString:type]);
    }];
}

/**
 * Retries the supplied block until it has been successful or a time limit has
 * been reached.
 *
 * @param block block to try
 */
- (void)waitUntil:(void (^)(void))block {
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    for (useconds_t waitTimeMs = 100; ; waitTimeMs *= 2) {
        typedef void (^AsyncTestBlock)(TokenIO *);
        @try {
            block();
            return;
        }
        @catch (...) {
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            if (now - start < 5) {
                usleep(waitTimeMs * 1000);
            } else {
                raise;
            }
        }
    }
}

@end
