//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKTestBase.h"
#import "Account.pbobjc.h"
#import "TokenIOSync.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKJson.h"


@interface TKNotificationsTests : TKTestBase
@end

@implementation TKNotificationsTests {
    TKAccountSync *payerAccount;
    TKMemberSync *payer;
    TKMemberSync *payerAnotherDevice;

    TKAccountSync *payeeAccount;
    TKMemberSync *payee;
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
        [NSException raise:message format:@"%@", message];
    }
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIOSync *tokenIO) {
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
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.toAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        [payee redeemToken:token amount:@(50) currency:@"USD" description:@"" destination:destination];

        [self waitForNotification:@"PAYER_TRANSFER_PROCESSED"];
    }];
}

- (void)testNotifyPayeeTransfer {
    [self run: ^(TokenIOSync *tokenIO) {
        [payee subscribeToNotifications:@"token" handlerInstructions:instructions];
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        builder.toAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];

        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        [payee redeemToken:token amount:@(50) currency:@"USD" description:@"" destination:destination];

        [self waitForNotification:@"PAYEE_TRANSFER_PROCESSED" member:payee];
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        BankAuthorization* auth = [BankAuthorization message];
        auth.bankId = @"iron";
        [auth.accountsArray addObjectsFromArray:@[[SealedMessage new]]];
        
        [tokenIO notifyLinkAccounts:payer.firstAlias
                      authorization:auth];

        [self waitForNotification:@"LINK_ACCOUNTS"];
    }];
}

- (void)testNotifyAddKey {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstAlias
                      keyName:@"Chrome 53.0"
                          key:key];

        [self waitForNotification:@"ADD_KEY"];
    }];
}

- (void)testGetPairedDevices {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstAlias
                      keyName:@"Chrome 53.0"
                          key:key];

        [self waitForNotification:@"ADD_KEY"];
        [payer approveKey:key];

        NSArray<Device *> *devices = [payer getPairedDevices];
        XCTAssertEqual(1, [devices count]);
        XCTAssert([@"Chrome 53.0" isEqualToString:devices[0].name]);
        XCTAssert([key isEqual:devices[0].key]);
    }];
}

- (void)testGetPairedDevicesUnapprovedKey {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstAlias
                      keyName:@"Chrome 53.0"
                          key:key];

        [self waitForNotification:@"ADD_KEY"];

        NSArray<Device *> *devices = [payer getPairedDevices];
        XCTAssertEqual(0, [devices count]);
    }];
}

- (void)testNotifyPaymentRequest {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        TokenPayload *token = [TokenPayload message];
        token.description_p = @"Description: 🍷🌺🌹";
        token.from.alias = payer.firstAlias;
        token.to.alias = payee.firstAlias;
        token.transfer.amount = @"50";
        token.transfer.lifetimeAmount = @"100";
        token.transfer.currency = @"EUR";
        [tokenIO notifyPaymentRequest:token];

        [self waitForNotification:@"PAYMENT_REQUEST"];
    }];
}

- (void)testStepUp {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        TokenOperationResult *result = [payer endorseToken:token withKey:Key_Level_Low];
        XCTAssertEqual(result.status, TokenOperationResult_Status_MoreSignaturesNeeded);
        
        NotifyStatus status = [payer triggerStepUpNotification:token.id_p];
        XCTAssertEqual(status, NotifyStatus_Accepted);
        
        [self waitForNotification:@"STEP_UP"];
        
        result = [payer endorseToken:token withKey:Key_Level_Standard];
        XCTAssertEqual(result.status, TokenOperationResult_Status_Success);
    }];
}

- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        Key *key = [[payerAnotherDevice keys] firstObject];
        BankAuthorization* auth = [BankAuthorization message];
        auth.bankId = @"iron";
        [auth.accountsArray addObjectsFromArray:@[[SealedMessage new]]];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstAlias
                               authorization:auth
                                     keyName:@"Chrome 53.0"
                                         key:key];

        [self waitForNotification:@"LINK_ACCOUNTS_AND_ADD_KEY"];
    }];
}

- (void)testGetSubscribers {
    [self run: ^(TokenIOSync *tokenIO) {
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
    [self run: ^(TokenIOSync *tokenIO) {
        NSMutableDictionary * instructionsEmpty = [NSMutableDictionary dictionaryWithDictionary:@{}];
        Subscriber * subscriber = [payer subscribeToNotifications:@"iron" handlerInstructions:instructionsEmpty];
        
        XCTAssert([payer getSubscribers].count == 1);
        
        Subscriber * lookedUp = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
        XCTAssert([subscriber.handler isEqualToString:lookedUp.handler]);
    }];
}


- (void)testTransferNotification {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        NSMutableDictionary * instructionsEmpty = [NSMutableDictionary dictionaryWithDictionary:@{}];
        [payer subscribeToNotifications:@"iron" handlerInstructions:instructionsEmpty];
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token
                                            amount:@(100.99)
                                          currency:@"USD"
                                       description:@""
                                       destination:destination];
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

- (void)testGetNotifications {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];

        
        Key *key = [[payerAnotherDevice keys] firstObject];
        [tokenIO notifyAddKey:payer.firstAlias keyName:@"Chrome 53.0" key:key];

        [self waitForNotification:@"ADD_KEY"];
    }];
}
    
- (void)testBalanceStepUpNotification {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        
        NotifyStatus status = [payer triggerBalanceStepUpNotification:payerAccount.id];
        XCTAssertEqual(status, NotifyStatus_Accepted);
        
        [self waitUntil:^{
            PagedArray<Notification *> *notifications = [payer getNotificationsOffset:nil
                                                                                limit:100];
            check(@"Notification count", notifications.items.count == 1);
            
            Notification* notification = [notifications.items objectAtIndex:0];
            check(@"Delivery Status", notification.status == Notification_Status_Delivered);
            check(@"Notification Type", [notification.content.type
                                         isEqualToString:@"BALANCE_STEP_UP"]);
            
            BalanceStepUp *balanceStepUp = [TKJson
                                            deserializeMessageOfClass:[BalanceStepUp class]
                                            fromJSON:notification.content.payload];
            check(@"BalanceStepUp AccountID",
                  [balanceStepUp.accountId isEqualToString: payerAccount.id]);
        }];
        
    }];
}
    
- (void)testTransationStepUpNotification {
    [self run: ^(TokenIOSync *tokenIO) {
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        
        TransferTokenBuilder *builder = [payer createTransferToken:100.99
                                                          currency:@"USD"];
        builder.accountId = payerAccount.id;
        builder.redeemerAlias = payee.firstAlias;
        Token *token = [builder execute];
        token = [[payer endorseToken:token withKey:Key_Level_Standard] token];
        
        TransferEndpoint *destination = [[TransferEndpoint alloc] init];
        destination.account.token.memberId = payeeAccount.member.id;
        destination.account.token.accountId = payeeAccount.id;
        Transfer *transfer = [payee redeemToken:token
                                         amount:@100.99
                                       currency:@"USD"
                                    description:@"full amount"
                                    destination:destination];
        
        NotifyStatus status = [payer triggerTransactionStepUpNotification:transfer.transactionId
                                                                accountID:payerAccount.id];
        XCTAssertEqual(status, NotifyStatus_Accepted);
        
        [self waitUntil:^{
            PagedArray<Notification *> *notifications = [payer getNotificationsOffset:nil
                                                                                limit:100];
            check(@"Notification count", notifications.items.count == 2);
            
            Notification* notification = [notifications.items objectAtIndex:0];
            check(@"Delivery Status", notification.status == Notification_Status_Delivered);
            check(@"Notification Type", [notification.content.type
                                         isEqualToString:@"TRANSACTION_STEP_UP"]);
            
            TransactionStepUp *transactionStepup = [TKJson
                                            deserializeMessageOfClass:[TransactionStepUp class]
                                            fromJSON:notification.content.payload];
            check(@"TransactionStepUp TransactionID",
                  [transactionStepup.transactionId isEqualToString: transfer.transactionId]);
            check(@"TransactionStepUp AccountID",
                  [transactionStepup.accountId isEqualToString: payerAccount.id]);
        }];
        
    }];
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 * @param member user to check notifications for
 */
- (void)waitForNotification:(NSString *)type
                     member:(TKMemberSync *)member {
    [self waitUntil:^{
        PagedArray<Notification *> *notifications = [member getNotificationsOffset:nil limit:100];
        check(@"Notification count", notifications.items.count == 1);

        Notification* notification = [notifications.items objectAtIndex:0];
        check(@"Delivery Status", notification.status == Notification_Status_Delivered);
            check(@"Notification Type", [notification.content.type isEqualToString:type]);
    }];
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 */
- (void)waitForNotification:(NSString *)type {
    [self waitForNotification:type member:payer];
}

@end
