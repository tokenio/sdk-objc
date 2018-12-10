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
     storeTokenRequest:[TKSampleModel accessTokenRequestPayload:aisp]
     requestOptions:[TKSampleModel tokenRequestOptions:member]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenIOSync.async
          notifyCreateAndEndorseToken:tokenRequestId
          keys:[NSArray arrayWithObject:[TKSampleModel lowKey:aisp.id]]
          deviceMetadata:[TKSampleModel deviceMetadata]
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
    // aisp create and endorse token begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"CREATE_AND_ENDORSE_TOKEN"]) {
             CreateAndEndorseToken *content = [TKJson
                                          deserializeMessageOfClass:[CreateAndEndorseToken class]
                                          fromJSON:notification.content.payload];
             AccessTokenConfig *config = [[AccessTokenConfig alloc] initWithTokenRequest:content.tokenRequest.requestPayload withRequestOptions:content.tokenRequest.requestOptions];
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
                        signTokenRequestState:content.tokenRequest.id_p
                        tokenId:result.token.id_p
                        state:content.tokenRequest.requestPayload.callbackState
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
    // aisp create and endorse token end snippet to include in docs
    
    [self runUntilTrue:^{
        return isFinished == YES;
    }];
}

- (void)testEndorseTransferToken {
    TKMember *member = self.payerSync.async;
    TKMember *pisp = self.payeeSync.async;
    __block NSString *notificationId = nil;
    __block BOOL isFinished = NO;
    
    [pisp
     storeTokenRequest:[TKSampleModel transferTokenRequestPayload:pisp]
     requestOptions:[TKSampleModel tokenRequestOptions:member]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenIOSync.async
          notifyCreateAndEndorseToken:tokenRequestId
          keys:[NSArray arrayWithObject:[TKSampleModel lowKey:pisp.id]]
          deviceMetadata:[TKSampleModel deviceMetadata]
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
    // pisp create and endorse token begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"CREATE_AND_ENDORSE_TOKEN"]) {
             CreateAndEndorseToken *content = [TKJson
                                          deserializeMessageOfClass:[CreateAndEndorseToken class]
                                          fromJSON:notification.content.payload];
             NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:content.tokenRequest.requestPayload.transferBody.lifetimeAmount];
             TransferTokenBuilder *builder =[member createTransferToken:amount currency:content.tokenRequest.requestPayload.transferBody.currency];
             builder.toMemberId = content.tokenRequest.requestPayload.to.id_p;
             if (content.tokenRequest.requestPayload.to.hasAlias) {
                 builder.toAlias = content.tokenRequest.requestPayload.to.alias;
             }
             builder.accountId = accountId;
             builder.refId = [TKUtil nonce];
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
                        signTokenRequestState:content.tokenRequest.id_p
                        tokenId:result.token.id_p
                        state:content.tokenRequest.requestPayload.callbackState
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
    // pisp create and endorse token end snippet to include in docs
    
    [self runUntilTrue:^{
        return isFinished == YES;
    }];
}

@end
