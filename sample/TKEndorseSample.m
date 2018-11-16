//
//  TKEndorseSample.m
//  TokenSdkTests
//
//  Created by Sibin Lu on 11/16/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSampleBase.h"
#import "TKSampleModel.h"
#import "TokenSdk.h"

@interface TKEndorseSample : TKSampleBase

@end

@implementation TKEndorseSample

- (void)testEndorseAccessToken {
    TKMember *member = self.payerSync.async;
    TKMember *aisp = self.payeeSync.async;
    __block NSString *notificationId = nil;
    __block BOOL isFinished = NO;
    
    [aisp
     storeTokenRequest:[TKSampleModel aispEndrosePayload:member to:aisp]
     options:[NSDictionary dictionary]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenIOSync.async
          notifyEndorseAndAddKey:[TKSampleModel aispEndrosePayload:member to:aisp]
          keys:[NSArray arrayWithObject:[TKSampleModel lowKey:aisp.id]]
          deviceMetadata:[TKSampleModel deviceMetadata]
          tokenRequestId:tokenRequestId
          bankId:@"gold"
          state:[TKUtil nonce]
          contact:[TKSampleModel receiptContact:member.firstAlias.value]
          onSuccess:^(NotifyResult *result) {
              notificationId = result.notificationId;
          } onError:^(NSError *e) {
              // Something went wrong.
              @throw [NSException exceptionWithName:@"NotificationException"
                                             reason:[e localizedFailureReason]
                                           userInfo:[e userInfo]];
              
          }];
     }
     onError:^(NSError *e) {
         // Something went wrong.
         @throw [NSException exceptionWithName:@"StoreTokenRequestException"
                                        reason:[e localizedFailureReason]
                                      userInfo:[e userInfo]];
         
     }];
    
    [self runUntilTrue:^{
        return notificationId != nil;
    }];
    
    NSString *accountId = self.payerAccountSync.id;
    // aisp endore and add key begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"ENDORSE_AND_ADD_KEY"]) {
             EndorseAndAddKey *content = [TKJson
                                          deserializeMessageOfClass:[EndorseAndAddKey class]
                                          fromJSON:notification.content.payload];
             AccessTokenConfig *config = [[AccessTokenConfig alloc] initWithPayload:content.payload];
             [config forAccount:accountId];
             [config forAccountBalances:accountId];
             // Create Token
             [member
              createAccessToken:config
              onSuccess:^(Token *token) {
                  // Endorse Token
                  [member
                   endorseToken:token
                   withKey:Key_Level_Standard
                   onSuccess:^(TokenOperationResult *result) {
                       // Sign the token request state
                       [member
                        signTokenRequestState:content.tokenRequestId
                        tokenId:result.token.id_p
                        state:content.state
                        onSuccess:^(Signature *ignore) {
                            // (Optional) Add keys to the member.
                            [member
                             approveKeys:content.addKey.keysArray
                             onSuccess:^ {
                                 // Success
                                 isFinished = YES;
                             }
                             onError: ^(NSError *e) {
                                 // Something went wrong.
                                 @throw [NSException exceptionWithName:@"AddKeyException"
                                                                reason:[e localizedFailureReason]
                                                              userInfo:[e userInfo]];
                             }];
                        }
                        onError: ^(NSError *e) {
                            // Something went wrong.
                            @throw [NSException exceptionWithName:@"signTokenRequestStateException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
                   }
                   onError: ^(NSError *e) {
                       // Something went wrong.
                       @throw [NSException exceptionWithName:@"EndorseTokenException"
                                                      reason:[e localizedFailureReason]
                                                    userInfo:[e userInfo]];
                   }];
              }
              onError: ^(NSError *e) {
                  // Something went wrong.
                  @throw [NSException exceptionWithName:@"CreateTokenException"
                                                 reason:[e localizedFailureReason]
                                               userInfo:[e userInfo]];
              }];
            
         } else {
             // This notification is for something else.
         }
     }
     onError: ^(NSError *e) {
         // Something went wrong.
         @throw [NSException exceptionWithName:@"GetNotificationException"
                                        reason:[e localizedFailureReason]
                                      userInfo:[e userInfo]];
     }];
    // aisp endore and add key end snippet to include in docs
    
    [self runUntilTrue:^{
        return isFinished == YES;
    }];
}

- (void)testEndorseTransferToken {
    TKMember *member = self.payerSync.async;
    TKMember *aisp = self.payeeSync.async;
    __block NSString *notificationId = nil;
    __block BOOL isFinished = NO;
    
    [aisp
     storeTokenRequest:[TKSampleModel pispEndrosePayload:member to:aisp]
     options:[NSDictionary dictionary]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenIOSync.async
          notifyEndorseAndAddKey:[TKSampleModel pispEndrosePayload:member to:aisp]
          keys:[NSArray arrayWithObject:[TKSampleModel lowKey:aisp.id]]
          deviceMetadata:[TKSampleModel deviceMetadata]
          tokenRequestId:tokenRequestId
          bankId:@"gold"
          state:[TKUtil nonce]
          contact:[TKSampleModel receiptContact:member.firstAlias.value]
          onSuccess:^(NotifyResult *result) {
              notificationId = result.notificationId;
          } onError:^(NSError *e) {
              // Something went wrong.
              @throw [NSException exceptionWithName:@"NotificationException"
                                             reason:[e localizedFailureReason]
                                           userInfo:[e userInfo]];
              
          }];
     }
     onError:^(NSError *e) {
         // Something went wrong.
         @throw [NSException exceptionWithName:@"StoreTokenRequestException"
                                        reason:[e localizedFailureReason]
                                      userInfo:[e userInfo]];
         
     }];
    
    [self runUntilTrue:^{
        return notificationId != nil;
    }];
    
    NSString *accountId = self.payerAccountSync.id;
    // pisp endore and add key begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"ENDORSE_AND_ADD_KEY"]) {
             EndorseAndAddKey *content = [TKJson
                                          deserializeMessageOfClass:[EndorseAndAddKey class]
                                          fromJSON:notification.content.payload];
             NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:content.payload.transfer.lifetimeAmount];
             TransferTokenBuilder *builder =[member createTransferToken:amount currency:content.payload.transfer.currency];
             builder.toAlias = content.payload.to.alias;
             builder.toMemberId = content.payload.to.id_p;
             builder.accountId = accountId;
             builder.refId = content.payload.refId;
             builder.effectiveAtMs = [[NSDate date] timeIntervalSince1970] * 1000.0;
             // Optional settings
             builder.purposeOfPayment = PurposeOfPayment_PersonalExpenses;
             builder.descr = @"Lunch";
             
             // Create Token
             [builder
              executeAsync:^(Token *token) {
                  // Endorse Token
                  [member
                   endorseToken:token
                   withKey:Key_Level_Standard
                   onSuccess:^(TokenOperationResult *result) {
                       // Sign the token request state
                       [member
                        signTokenRequestState:content.tokenRequestId
                        tokenId:result.token.id_p
                        state:content.state
                        onSuccess:^(Signature *ignore) {
                            // (Optional) Add keys to the member.
                            [member
                             approveKeys:content.addKey.keysArray
                             onSuccess:^ {
                                 // Success
                                 isFinished = YES;
                             }
                             onError: ^(NSError *e) {
                                 // Something went wrong.
                                 @throw [NSException exceptionWithName:@"AddKeyException"
                                                                reason:[e localizedFailureReason]
                                                              userInfo:[e userInfo]];
                             }];
                        }
                        onError: ^(NSError *e) {
                            // Something went wrong.
                            @throw [NSException exceptionWithName:@"signTokenRequestStateException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
                   }
                   onError: ^(NSError *e) {
                       // Something went wrong.
                       @throw [NSException exceptionWithName:@"EndorseTokenException"
                                                      reason:[e localizedFailureReason]
                                                    userInfo:[e userInfo]];
                   }];
              }
              onError: ^(NSError *e) {
                  // Something went wrong.
                  @throw [NSException exceptionWithName:@"CreateTokenException"
                                                 reason:[e localizedFailureReason]
                                               userInfo:[e userInfo]];
              }];
             
         } else {
             // This notification is for something else.
         }
     }
     onError: ^(NSError *e) {
         // Something went wrong.
         @throw [NSException exceptionWithName:@"GetNotificationException"
                                        reason:[e localizedFailureReason]
                                      userInfo:[e userInfo]];
     }];
    // pisp endore and add key end snippet to include in docs
    
    [self runUntilTrue:^{
        return isFinished == YES;
    }];
}

@end
