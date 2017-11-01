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
#import "TKMemberSync.h"
#import "TKTestKeyStore.h"

#import "TKUtil.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKTransferSamples : TKTestBase

@end

@implementation TKTransferSamples

- (void)testNotifyPaymentRequest {
    TokenIO *tokenIO = [self asyncSDK];
    __block TKMember *payee = nil;
    [tokenIO createMember:[self generateAlias]
                onSuccess:^(TKMember *m) {
                    payee = m;
                } onError:^(NSError *e){
                    @throw [NSException exceptionWithName:@"CreateMemberFailedException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    [self runUntilTrue:^{
        return (payee != nil);
    }];
    
    // payer: all we need is the alias. but the notification fails
    // if the recipient doesn't exist or isn't subscribed to notifications,
    // so create payer and subscribe:
    Alias *payerAlias = [self generateAlias];
    [self run:^(TokenIOSync *tokenIOSync){
        [tokenIOSync createMember:payerAlias];
    }];
    __block int waiting = false;
    
    // notifyPaymentRequest begin snippet to include in docs
    TokenPayload *payload = [TokenPayload message]; // hoped-for payment
    payload.description_p = @"lunch";
    payload.from.alias = payerAlias;
    payload.to.id_p = payee.id;
    payload.transfer.lifetimeAmount = @"100";
    payload.transfer.currency = @"EUR";
    
    [tokenIO notifyPaymentRequest:payload
                        onSuccess:^{
                            // Notification sent.
                            waiting = true;
                        } onError:^(NSError *e){
                            // Something went wrong.
                            // Maybe we used wrong alias.
                            // Check error.
                        }
     ];
     // notifyPaymentRequest done snippet to include in docs
    
    [self runUntilTrue:^{
        return waiting;
    }];
}

- (void)testCreateTransferToken {
    TokenIO *tokenIO = [self asyncSDK];
    __block TKMember *payer = nil;
    __block TKAccount *payerAccount = nil;
    [tokenIO createMember:[self generateAlias]
                onSuccess:^(TKMember *m) {
                    payer = m;
                    Money *balance = [Money message]; // test account's starting balance
                    balance.currency = @"EUR";
                    balance.value = @"5678.00";
                    [m createTestBankAccount:balance
                                   onSuccess:^(BankAuthorization* auth) {
                                       [m linkAccounts:auth
                                             onSuccess:^(NSArray<TKAccount*> * _Nonnull accounts) {
                                                   // use accounts
                                                 payerAccount = accounts[0];
                                             } onError:^(NSError * _Nonnull e) {
                                                 // Something went wrong.
                                                 @throw [NSException exceptionWithName:@"LinkAccountException"
                                                                                reason:[e localizedFailureReason]
                                                                              userInfo:[e userInfo]];
                                                   }];
                                   } onError:^(NSError *e) {
                                       @throw [NSException exceptionWithName:@"TestAccountException"
                                                                      reason:[e localizedFailureReason]
                                                                    userInfo:[e userInfo]];
                                   }];
                }
                                     onError:^(NSError *e){
                    @throw [NSException exceptionWithName:@"CreateMemberFailedException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    [self runUntilTrue:^{
        return (payerAccount != nil);
    }];
    Alias *payeeAlias = [self generateAlias];
    [self run:^(TokenIOSync *tokenIOSync) {
        [tokenIOSync createMember:payeeAlias];
    }];
    NSString *refId = @"purchase:2017-06622528293336394";
    __block Token *transferToken = nil;
    
    TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.redeemerAlias = payeeAlias;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t){
        // Use token.
        transferToken = t;
    }   onError:^(NSError *e) {
        // Something went wrong.
        // (We don't just build a structure; we also upload it to Token cloud.)
        @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    
    [self runUntilTrue:^{
        return (transferToken != nil);
    }];
}

@end
