//
//  TKTransferSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 10/31/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"

#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKMember.h"
#import "TKMemberSync.h"
#import "TKAccount.h"
#import "TKAccountSync.h"
#import "TKUtil.h"

#import "Account.pbobjc.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKTransferSamples : TKTestBase

@end

@implementation TKTransferSamples

- (void)testNotifyPaymentRequest {
    TokenIO *tokenIO = [self asyncSDK];
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *payee = [self createMember:tokenIOSync];
    
    // payer: all we need is the alias. but the notification fails
    // if the recipient doesn't exist, so create...
    Alias *payerAlias = [self generateAlias];
    [tokenIOSync createMember:payerAlias];
    
    __block int waitingForPayment = false;
    
    // notifyPaymentRequest begin snippet to include in docs
    TokenPayload *payload = [TokenPayload message]; // hoped-for payment
    payload.description_p = @"lunch";
    payload.from.alias = payerAlias;
    payload.to.id_p = payee.id;
    payload.transfer.lifetimeAmount = @"100";
    payload.transfer.currency = @"EUR";
    
    [tokenIO notifyPaymentRequest:payload
                        onSuccess:^ {
                            // Notification sent.
                            waitingForPayment = true;
                        } onError:^(NSError *e) {
                            // Something went wrong.
                            // Maybe we used wrong alias?
                            @throw [NSException exceptionWithName:@"NotifyException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }
     ];
     // notifyPaymentRequest done snippet to include in docs
    
    [self runUntilTrue:^ {
        return waitingForPayment;
    }];
}

- (void)testCreateEndorseTransferToken {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *payerSync = [self createMember:tokenIOSync];
    TKMember *payer = payerSync.async;
    TKAccountSync *payerAccountSync = [payerSync linkAccounts:[self createBankAuthorization:payerSync]][0];
    TKAccount *payerAccount = payerAccountSync.async;
    Alias *payeeAlias = [self generateAlias];
    TKMemberSync *payeeSync = [tokenIOSync createMember:payeeAlias];
    TKMember *payee = payeeSync.async;
    NSString *refId = @"purchase:2017-11-01:28293336394ffby";
    __block Token *transferToken = nil;
    
    // createTransferToken begin snippet to include in docs
    TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.redeemerAlias = payeeAlias;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t) {
        // Use token.
        transferToken = t;
    }   onError:^(NSError *e) {
        // Something went wrong. (We don't just build a structure; we also
        // upload it to Token cloud. So things can go wrong.)
        @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // createTransferToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken != nil);
    }];
    
    // endorseToken begin snippet to include in docs
    [payer endorseToken:transferToken
                withKey:Key_Level_Standard
              onSuccess:^(TokenOperationResult *result) {
                  // Update transferToken with newer value:
                  // Payload is same; now has signatures attached.
                  transferToken = result.token;
              } onError:^(NSError *e) {
                  // something went wrong
                  @throw [NSException exceptionWithName:@"EndorseException"
                                                 reason:[e localizedFailureReason]
                                               userInfo:[e userInfo]];
              }];
    // endorseToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken.payloadSignaturesArray_Count > 0);
    }];
    
    __block Transfer *transfer = nil;
    
    // redeemToken begin snippet to include in docs
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    // There are a few ways to specify destination; here we use (fake) IBAN
    destination.account.sepa.iban = @"123";
    [payee getToken:transferToken.id_p
          onSuccess:^(Token *token) {
              [payee redeemToken:token
                          amount:nil // use default
                        currency:nil // use default
                     description:nil // use default
                     destination:destination
                        onSuccess:^(Transfer *t) {
                            // use transfer
                            transfer = t;
                        } onError:^(NSError *e) {
                            // something went wrong
                            @throw [NSException exceptionWithName:@"RedeemException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
          } onError:^(NSError *e) {
              // something went wrong
              @throw [NSException exceptionWithName:@"GetTokenException"
                                             reason:[e localizedFailureReason]
                                           userInfo:[e userInfo]];
          }];
    // redeemToken done snippet to include in docs
    
    // make sure it worked
    [self runUntilTrue:^ {
        return (transfer != nil);
    }];
}

- (void)testCancelTransferToken {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *payerSync = [self createMember:tokenIOSync];
    TKMember *payer = payerSync.async;
    TKAccountSync *payerAccountSync = [payerSync linkAccounts:[self createBankAuthorization:payerSync]][0];
    TKAccount *payerAccount = payerAccountSync.async;
    Alias *payeeAlias = [self generateAlias];
    [tokenIOSync createMember:payeeAlias];
    NSString *refId = @"purchase:2017-11-01:28293336394ffby";
    __block Token *transferToken = nil;
    
    // createTransferToken begin snippet to include in docs
    TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.redeemerAlias = payeeAlias;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t) {
            [payer endorseToken:t
                        withKey:Key_Level_Standard
                      onSuccess:^(TokenOperationResult *result) {
                          transferToken = result.token;
                      } onError:^(NSError *e) {
                          // something went wrong
                          @throw [NSException exceptionWithName:@"EndorseException"
                                                         reason:[e localizedFailureReason]
                                                       userInfo:[e userInfo]];
                      }];
    }   onError:^(NSError *e) {
        // Something went wrong. (We don't just build a structure; we also
        // upload it to Token cloud. So things can go wrong.)
        @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    
    [self runUntilTrue:^ {
        return (transferToken != nil);
    }];
    
    // cancelToken begin snippet to include in docs
    [payer cancelToken:transferToken
             onSuccess:^(TokenOperationResult *result) {
                 // token now has more signatures; in this case, at least
                 // one is a cancellation signature
                 transferToken = result.token;
             } onError: ^(NSError *e) {
                 // Something went wrong
             }];
    // cancelToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken.payloadSignaturesArray_Count > 0);
    }];
}

@end
