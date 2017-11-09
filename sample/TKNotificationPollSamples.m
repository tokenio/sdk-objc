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
    Alias *payerAlias = [self generateAlias];
    TKMemberSync *payerSync = [tokenIOSync createMember:payerAlias];
    [payerSync linkAccounts:[self createBankAuthorization:payerSync]];
    TKMember *payer = payerSync.async;
    
    __block Subscriber *subscriber = nil;
    
    [payer subscribeToNotifications:@"iron"
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
    
    // generate a notification to poll for...
    TokenPayload *payload = [TokenPayload message];
    payload.from.alias = payerAlias;
    payload.to.id_p = [self createAccount:tokenIOSync].member.id;
    payload.transfer.lifetimeAmount = @"100";
    payload.transfer.currency = @"EUR";
    [tokenIOSync notifyPaymentRequest:payload];
    
    __block Notification *notification = nil;
    
    // poll begin snippet to include in docs
    [payer getNotificationsOffset:NULL
                            limit:10
                        onSuccess:^(PagedArray<Notification *> *ary) {
                            for (Notification *n in ary.items) {
                                if ([n.content.type isEqualToString:@"PAYMENT_REQUEST"]) {
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
