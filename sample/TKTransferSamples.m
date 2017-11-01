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
                        onSuccess:^{
                            // Notification sent.
                            waitingForPayment = true;
                        } onError:^(NSError *e){
                            // Something went wrong.
                            // Maybe we used wrong alias.
                            // Check error.
                        }
     ];
     // notifyPaymentRequest done snippet to include in docs
    
    [self runUntilTrue:^{
        return waitingForPayment;
    }];
}

- (void)testCreateTransferToken {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *payerSync = [self createMember:tokenIOSync];
    TKMember* payer = payerSync.async;
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
    // createTransferToken done snippet to include in docs

    [self runUntilTrue:^{
        return (transferToken != nil);
    }];
}

@end
