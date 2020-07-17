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

- (void)sampleEndorseAccessToken {
    TKMember *member = self.payer;
    TKMember *aisp = self.payee;
    __block NSString *notificationId = nil;
    __block BOOL isFinished = NO;
    
    [aisp
     storeTokenRequest:[TKSampleModel accessTokenRequestPayload:aisp]
     requestOptions:[TKSampleModel tokenRequestOptions:member]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenClient
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
    
    NSString *accountId = self.payerAccount.id;
    // aisp create and endorse token begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"CREATE_AND_ENDORSE_TOKEN"]) {
             CreateAndEndorseToken *content = [TKJson
                                               deserializeMessageOfClass:[CreateAndEndorseToken class]
                                               fromJSON:notification.content.payload];
             AccessTokenBuilder *builder = [[AccessTokenBuilder alloc] initWithTokenRequest:content.tokenRequest];
             [builder forAccount:accountId];
             [builder forAccountBalances:accountId];
             // Create Token
             [member
              createAccessToken:builder
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

- (void)sampleEndorseTransferToken {
    TKMember *member = self.payer;
    TKMember *pisp = self.payee;
    __block NSString *notificationId = nil;
    __block BOOL isFinished = NO;
    
    [pisp
     storeTokenRequest:[TKSampleModel transferTokenRequestPayload:pisp]
     requestOptions:[TKSampleModel tokenRequestOptions:member]
     onSuccess:^(NSString * tokenRequestId) {
         [self.tokenClient
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
    
    NSString *accountId = self.payerAccount.id;
    // pisp create and endorse token begin snippet to include in docs
    [member
     getNotification:notificationId
     onSuccess:^(Notification *notification) {
         if ([notification.content.type isEqualToString:@"CREATE_AND_ENDORSE_TOKEN"]) {
             CreateAndEndorseToken *content = [TKJson
                                          deserializeMessageOfClass:[CreateAndEndorseToken class]
                                          fromJSON:notification.content.payload];
             
             TransferTokenBuilder *builder =[member createTransferToken:content.tokenRequest];
             builder.accountId = accountId;
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
