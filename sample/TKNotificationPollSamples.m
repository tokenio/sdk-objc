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
    TKMember *payee = self.payee;
    
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
    TransferTokenBuilder *builder = [self.payer createTransferToken:amount currency:@"USD"];
    builder.accountId = self.payerAccount.id;
    builder.toMemberId = self.payee.id;
    Token *token = [builder execute];
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.token.memberId = payee.id;
    
    __block Transfer *transfer = nil;
    [self.payer endorseToken:token
                     withKey:Key_Level_Standard
                   onSuccess:^(TokenOperationResult *result) {
                       NSDecimalNumber *redeemAmount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
                       [self.payee redeemToken:token
                                        amount:redeemAmount
                                      currency:@"USD"
                                   description:@"notify them"
                                   destination:destination
                                     onSuccess:^(Transfer *t) {
                                         transfer = t;
                                     } onError:^(NSError *e) {
                                         // Something went wrong.
                                         @throw [NSException exceptionWithName:@"EndorseTokenException"
                                                                        reason:[e localizedFailureReason]
                                                                      userInfo:[e userInfo]];
                                     }];
                   } onError:^(NSError *e) {
                       // Something went wrong.
                       @throw [NSException exceptionWithName:@"RedeemTokenException"
                                                      reason:[e localizedFailureReason]
                                                    userInfo:[e userInfo]];
                   }];

    [self runUntilTrue:^ {
        return (transfer != nil);
    }];
    // wait until we're sure notification has gone through...
    [self runUntilNotificationReceived:self.payee];

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
