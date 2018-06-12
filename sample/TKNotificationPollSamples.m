//
//  TKNotificationPollSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/8/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSampleBase.h"

#import "TokenSdk.h"

@interface TKNotificationPollSamples : TKSampleBase

@end

@implementation TKNotificationPollSamples

-(void)testNotificationPolling {
    TKMember *payee = self.payeeSync.async;
    
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
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [self.payerSync createTransferToken:amount
                                                               currency:@"USD"];
    builder.accountId = self.payerAccountSync.id;
    builder.redeemerMemberId = self.payerSync.id;
    builder.toMemberId = self.payeeSync.id;
    Token *token = [builder execute];
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payee.id;
    [self.payerSync endorseToken:token withKey:Key_Level_Standard];
    NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    [self.payerSync redeemToken:token
                         amount:redeemAmount
                       currency:@"USD"
                    description:@"notify them"
                    destination:destination];

    // wait until we're sure notification has gone through...
    [self runUntilTrue:^ {
        PagedArray<Notification *> *notifications = [self.payeeSync getNotificationsOffset:NULL
                                                                                     limit:10];
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
