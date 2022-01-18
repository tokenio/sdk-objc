//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "Account.pbobjc.h"
#import "TokenClient.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "Notification.pbobjc.h"
#import "TKJson.h"
#import "PagedArray.h"

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
        [NSException raise:message format:@"%@", message];
    }
}

- (void)setUp {
    [super setUp];
    TokenClient *tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payerAnotherDevice = [self createMember:tokenClient];

    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
    instructions = [NSMutableDictionary dictionaryWithDictionary:
                    @{@"PLATFORM": @"TEST",
                      @"TARGET":@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979"}];
}

- (void)testTransfer {
    [self subscribeNotificationsFor:payer];

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token* created) {
        [self->payer endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
            
            [self->payee
             redeemToken:[result token]
             amount:redeemAmount
             currency:@"USD"
             description:@""
             destination:destination onSuccess:^(Transfer *transfer) {
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    [self waitForNotification:@"PAYER_TRANSFER_PROCESSED" member:payer status:(Notification_Status)Notification_Status_NoActionRequired];
}

- (void)testNotifyPayeeTransfer {
    [self subscribeNotificationsFor:payee];
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token* created) {
        [self->payer endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
            
            [self->payee
             redeemToken:[result token]
             amount:redeemAmount
             currency:@"USD"
             description:@""
             destination:destination onSuccess:^(Transfer *transfer) {
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    [self waitForNotification:@"PAYEE_TRANSFER_PROCESSED" member:payee status:Notification_Status_NoActionRequired];
}

- (void)testNotifyAddKey {
    [self subscribeNotificationsFor:payer];
    DeviceMetadata *metadata = [DeviceMetadata message];
    metadata.application = @"Chrome";
    metadata.applicationVersion = @"53.0";
    metadata.device = @"Mac";
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payerAnotherDevice getKeys:^(NSArray<Key *> * keys) {
        [[self client] notifyAddKey:self->payer.firstAlias keys:keys deviceMetadata:metadata onSuccess:^ {
            [expectation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    [self waitForNotification:@"ADD_KEY"];
}

- (void)testNotifyPaymentRequest {
    [self subscribeNotificationsFor:payer];
    TokenPayload *tokenPayload = [TokenPayload message];
    tokenPayload.description_p = @"Description: 🍷🌺🌹";
    tokenPayload.from.alias = payer.firstAlias;
    tokenPayload.to.alias = payee.firstAlias;
    tokenPayload.transfer.amount = @"50";
    tokenPayload.transfer.lifetimeAmount = @"100";
    tokenPayload.transfer.currency = @"EUR";
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [[self client] notifyPaymentRequest:tokenPayload onSuccess:^ {
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    [self waitForNotification:@"PAYMENT_REQUEST"];
}

- (void)testGetSubscribers {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer subscribeToNotifications:@"token" handlerInstructions:instructions onSuccess:^(Subscriber * subscriber) {
        [self->payer getSubscribers:^(NSArray<Subscriber *> *subscribers) {
            XCTAssert(subscribers.count == 1);
            
            [self->payer getSubscriber:subscriber.id_p onSuccess:^(Subscriber * lookedUp) {
                XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
                XCTAssert([subscriber.handler isEqualToString:lookedUp.handler]);
                XCTAssert([subscriber.handlerInstructions[@"PLATFORM"]
                           isEqualToString:lookedUp.handlerInstructions[@"PLATFORM"]]);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetSubscribersWithBankId {
    NSMutableDictionary * instructionsEmpty = [NSMutableDictionary dictionaryWithDictionary:@{}];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer subscribeToNotifications:@"iron" handlerInstructions:instructionsEmpty onSuccess:^(Subscriber * subscriber) {
        [self->payer getSubscribers:^(NSArray<Subscriber *> *subscribers) {
            XCTAssert(subscribers.count == 1);
            
            [self->payer getSubscriber:subscriber.id_p onSuccess:^(Subscriber * lookedUp) {
                XCTAssert([subscriber.id_p isEqualToString:lookedUp.id_p]);
                XCTAssert([subscriber.handler isEqualToString:lookedUp.handler]);
                [expectation fulfill];
            } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}


- (void)testTransferNotification {
    [self subscribeNotificationsFor:payer];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token* created) {
        [self->payer endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
            [self->payee
             redeemToken:[result token]
             amount:redeemAmount
             currency:@"USD"
             description:@""
             destination:destination onSuccess:^(Transfer *transfer) {
                 XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
                 [expectation fulfill];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testBalanceStepUpNotification {
    [self subscribeNotificationsFor:payer];

    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer triggerBalanceStepUpNotification:@[payerAccount.id] onSuccess:^(NotifyStatus status) {
        XCTAssertEqual(status, NotifyStatus_Accepted);
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
    
    expectation = [[TKTestExpectation alloc] init];
    [self runUntilTrue:^{
        [self->payer getNotificationsOffset:nil limit:100 onSuccess:^(PagedArray<Notification *> *notifications) {
            if (notifications.items.count >= 1) {
                Notification* notification = [notifications.items objectAtIndex:0];
                if ((notification.status == Notification_Status_Pending)
                    && ([notification.content.type isEqualToString:@"BALANCE_STEP_UP"])) {
                    BalanceStepUp *balanceStepUp = [TKJson
                                                    deserializeMessageOfClass:[BalanceStepUp class]
                                                    fromJSON:notification.content.payload];
                    if ([balanceStepUp.accountIdArray[0] isEqualToString: self->payerAccount.id]) {
                        [expectation fulfill];
                    }
                }
            }
        } onError:THROWERROR];
        return (int) expectation.isFulfilled;
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testTransationStepUpNotification {
    [self subscribeNotificationsFor:payer];

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"USD"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    
    __block NSString *transactionId = nil;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [builder executeAsync:^(Token* created) {
        [self->payer endorseToken:created withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
            TransferEndpoint *destination = [[TransferEndpoint alloc] init];
            destination.account.token.memberId = self->payeeAccount.member.id;
            destination.account.token.accountId = self->payeeAccount.id;
            NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
            
            [self->payee
             redeemToken:[result token]
             amount:redeemAmount
             currency:@"USD"
             description:@""
             destination:destination onSuccess:^(Transfer *transfer) {
                 transactionId = transfer.transactionId;
                 [self->payer
                  triggerTransactionStepUpNotification:transfer.transactionId
                  accountID:self->payerAccount.id
                  onSuccess:^(NotifyStatus status) {
                      XCTAssertEqual(status, NotifyStatus_Accepted);
                      [expectation fulfill];
                 } onError:THROWERROR];
             } onError:THROWERROR];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    expectation = [[TKTestExpectation alloc] init];
    [self runUntilTrue:^{
        [self->payer getNotificationsOffset:nil limit:100 onSuccess:^(PagedArray<Notification *> *notifications) {
            if (notifications.items.count >= 1) {
                Notification* notification = [notifications.items objectAtIndex:0];
                
                if ((notification.status == Notification_Status_Pending)
                    && ([notification.content.type isEqualToString:@"TRANSACTION_STEP_UP"])) {
                    TransactionStepUp *transactionStepup = [TKJson
                                                            deserializeMessageOfClass:[TransactionStepUp class]
                                                            fromJSON:notification.content.payload];
                    if ([transactionStepup.transactionId isEqualToString: transactionId]
                        && [transactionStepup.accountId isEqualToString: self->payerAccount.id]) {
                        [expectation fulfill];
                    }
                }
            }
        } onError:THROWERROR];
        return (int) expectation.isFulfilled;
    }];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testUpdateNotificationStatus {
    [self subscribeNotificationsFor:payer];
    TokenPayload *tokenPayload = [TokenPayload message];
    tokenPayload.description_p = @"Description: 🍷🌺🌹";
    tokenPayload.from.alias = payer.firstAlias;
    tokenPayload.to.alias = payee.firstAlias;
    tokenPayload.transfer.amount = @"50";
    tokenPayload.transfer.lifetimeAmount = @"100";
    tokenPayload.transfer.currency = @"EUR";
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [[self client] notifyPaymentRequest:tokenPayload onSuccess:^ {
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];

    NSString *notificationId = [self waitForNotification:@"PAYMENT_REQUEST"];

    TKTestExpectation *expectation2 = [[TKTestExpectation alloc] init];
    [payer updateNotificationStatus:notificationId
                             status:Notification_Status_Declined
                          onSuccess:^ {
                              [expectation2 fulfill];
                          } onError:THROWERROR];
    [self waitForExpectations:@[expectation2] timeout:10];

    [self waitForNotification:@"PAYMENT_REQUEST" member:payer status:Notification_Status_Declined];
}

- (void)subscribeNotificationsFor:(TKMember *)member {
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [member subscribeToNotifications:@"token" handlerInstructions:instructions onSuccess:^(Subscriber *subscriber) {
        [expectation fulfill];
    } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 * @param member user to check notifications for
 * @param status expected notification status
 * @return notificaiton id
 */
- (NSString *)waitForNotification:(NSString *)type
                           member:(TKMember *)member
                           status:(Notification_Status)status {
    __block NSString *notificationId;
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [self runUntilTrue:^{
        [member getNotificationsOffset:nil limit:100 onSuccess:^(PagedArray<Notification *> *notifications) {
            if (notifications.items.count == 1) {
                Notification* notification = [notifications.items objectAtIndex:0];
                if ((notification.status == status)
                    && ([notification.content.type isEqualToString:type])) {
                    notificationId = notification.id_p;
                    [expectation fulfill];
                }
            }
        } onError:THROWERROR];
        return (int) expectation.isFulfilled;
    }];
    [self waitForExpectations:@[expectation] timeout:10];
    return notificationId;
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 * @param member user to check notifications for
 * @return notificaiton id
 */
- (NSString *)waitForNotification:(NSString *)type
                           member:(TKMember *)member {
    return [self waitForNotification:type member:member status:Notification_Status_Pending];
}

/**
 * Wait for the delivered notification of the specified type.
 *
 * @param type notification type
 * @return notificaiton id
 */
- (NSString *)waitForNotification:(NSString *)type {
    return [self waitForNotification:type member:payer];
}

@end
