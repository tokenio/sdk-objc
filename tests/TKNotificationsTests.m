//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Transfer.pbobjc.h"


@interface TKNotificationsTests : TKTestBase
@end

@implementation TKNotificationsTests {
    TKAccount *payerAccount;
    TKMember *payer;
    TKMember *payerAnotherDevice;

    TKAccount *payeeAccount;
    TKMember *payee;
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
    }];
}

- (void)testTransfer {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        [payee createTransfer:token];

        [self waitForNotification:@"TRANSFER_PROCESSED"];
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

        [tokenIO notifyLinkAccounts:payer.firstUsername
                             bankId:@"iron"
                           bankName:@"bank-name"
                accountLinkPayloads:@[[SealedMessage new]]];

        [self waitForNotification:@"LINK_ACCOUNTS"];
    }];
}

- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                      keyName:@"Chrome 53.0"
                          key:key];

        [self waitForNotification:@"ADD_KEY"];
    }];
}

- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

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
        Subscriber *subscriber = [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

        XCTAssert([payer getSubscribers].count == 1);

        Subscriber * lookedUp = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
        XCTAssert([subscriber.target isEqualToString:lookedUp.target]);
        XCTAssert(subscriber.platform == lookedUp.platform);
    }];
}

- (void)testGetSubscribersWithBankId {
    [self run: ^(TokenIO *tokenIO) {
        Subscriber *subscriber = [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test withBankId:@"iron"];
        
        XCTAssert([payer getSubscribers].count == 1);
        
        Subscriber * lookedUp = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
        XCTAssert([subscriber.target isEqualToString:lookedUp.target]);
        XCTAssert(subscriber.platform == lookedUp.platform);
    }];
}


- (void)testTransferNotification {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test withBankId:@"iron"];

        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        Transfer *transfer = [payee createTransfer:token];
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testGetNotifications {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:[TKUtil nonce] platform:Platform_Test];

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
