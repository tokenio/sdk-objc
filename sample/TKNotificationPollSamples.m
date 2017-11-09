//
//  TKNotificationPollSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/8/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTestBase.h"

#import "TokenSdk.h"

@interface TKNotificationPollSamples : TKTestBase

@end

@implementation TKNotificationPollSamples

-(void)testNotificationPolling {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    Money *money = [Money message];
    money.currency = @"EUR";
    money.value = @"5678.90";
    Alias *payerAlias = [self generateAlias];
    TKMemberSync *payerSync = [tokenIOSync createMember:payerAlias];
    TKAccountSync *payerAccountSync = [payerSync linkAccounts:[payerSync createTestBankAccount:money]][0];
    Alias *payeeAlias = [self generateAlias];
    TKMemberSync *payeeSync = [tokenIOSync createMember:payeeAlias];
    [payeeSync linkAccounts:[payeeSync createTestBankAccount:money]];
    TKMember *payee = payeeSync.async;
    
    __block Subscriber *subscriber = nil;
    
    [payee subscribeToNotifications:@"iron"
                handlerInstructions:(NSMutableDictionary<NSString *, NSString *> *) [NSMutableDictionary dictionary]
                          onSuccess:^(Subscriber *s) {
                              subscriber = s;
                          } onError:^(NSError *e) {
                              // Something went wrong.
                              @throw [NSException exceptionWithName:@"SubscribeException"
                                                             reason:[e localizedFailureReason]
                                                           userInfo:[e userInfo]];
                          }];
    
    [self runUntilTrue:^ {
        return (subscriber != nil);
    }];
    
    // generate a notification so that our polling finds something.
    // To do this, we create, endorse, and redeem a transfer.
    // Payee receives a notification.
    TransferTokenBuilder *builder = [payerSync createTransferToken:100.99
                                                          currency:@"USD"];
    builder.accountId = payerAccountSync.id;
    builder.redeemerAlias = payerAlias;
    builder.toAlias = payeeAlias;
    Token *token = [builder execute];
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payee.id;
    [payerSync endorseToken:token withKey:Key_Level_Standard];
    [payerSync redeemToken:token amount:@(100.99) currency:@"USD" description:@"notify them" destination:destination];

    // wait until we're sure notification has gone through...
    [self runUntilTrue:^ {
        PagedArray<Notification *> *notifications = [payeeSync getNotificationsOffset:NULL limit:10];
        return (notifications.items.count > 0);
    }];

    __block Notification *notification = nil;

    // poll begin snippet to include in docs
    [payee getNotificationsOffset:NULL
                            limit:10
                        onSuccess:^(PagedArray<Notification *> *ary) {
                            for (Notification *n in ary.items) {
                                if ([n.content.type isEqualToString:@"PAYEE_TRANSFER_PROCESSED"]) {
                                    // use notification
                                    notification = n;
                                }
                            }
                        } onError:^(NSError *e) {
                            // Something went wrong.
                            @throw [NSException exceptionWithName:@"PollException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
    // poll done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (notification != nil);
    }];
}

@end
