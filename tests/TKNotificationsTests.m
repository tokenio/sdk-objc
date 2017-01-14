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

- (void)testSubscribeAndUnsubscribe {
    [self run: ^(TokenIO *tokenIO) {
        
        Subscriber *s = [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                                               platform:Platform_Ios];
        
        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        [payee createTransfer:token];
        
        [payer unsubscribeFromNotifications:s.id_p];
        
        Token *token2 = [payer createTransferToken:payee.firstUsername
                                        forAccount:payerAccount.id
                                            amount:100.99
                                          currency:@"USD"
                                       description:@"transfer test"];
        token = [[payer endorseToken:token2 withKey:Key_Level_Standard] token];
        [payee createTransfer:token];
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];
        
        NSArray<SealedMessage*> *payloads = [NSArray arrayWithObjects: [SealedMessage new], nil];
        
        [tokenIO notifyLinkAccounts:payer.firstUsername
                             bankId:@"iron"
                           bankName:@"bank-name"
                accountLinkPayloads:payloads];
    }];
}

- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];

        NSString *key = [[payerAnotherDevice publicKeys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                    publicKey:key
                         name:@"Chrome 53.0"];
    }];
}

- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];
        
        NSArray<SealedMessage*> *payloads = [NSArray arrayWithObjects: [SealedMessage new], nil];
        NSString *key = [[payerAnotherDevice publicKeys] firstObject];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstUsername
                                      bankId:@"iron"
                                    bankName:@"bank-name"
                         accountLinkPayloads:payloads
                                   publicKey:key
                                        name:@"Chrome 53.0"];
    }];
}

- (void)testGetSubscribers {
    [self run: ^(TokenIO *tokenIO) {
        Subscriber * subscriber = [payer
                subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                                platform:Platform_Test];
        
        [payer getSubscribers];
        XCTAssert([payer getSubscribers].count == 1);
        Subscriber * subscriber2 = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:subscriber2.id_p]);
        XCTAssert([subscriber.target isEqualToString:subscriber2.target]);
        XCTAssert(subscriber.platform == subscriber2.platform);
    }];
}

- (void)testTransferNotification {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        
        [payer subscribeToNotifications:@"notificationUri"
                               platform:Platform_Ios];
        
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
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
            
        [payer subscribeToNotifications:@"notificationUri"
                                platform:Platform_Ios];

        NSArray<Notification*> *notifications = [payer getNotifications];
        XCTAssert(notifications.count == 0);
        NSString *key = [[payerAnotherDevice publicKeys] firstObject];
        [tokenIO notifyAddKey:payer.firstUsername
                    publicKey:key
                         name:@"Chrome 53.0"];
        
        notifications = [payer getNotifications];
        XCTAssert(notifications.count == 1);

        Notification* notification = [payer getNotification:notifications[0].id_p];
        XCTAssert([notifications[0].id_p isEqualToString:notification.id_p]);
        XCTAssert([notifications[0].subscriberId isEqualToString:notification.subscriberId]);
        XCTAssert([notifications[0].content.title isEqualToString:notification.content.title]);
    }];
}

@end
