//
//  TKAccountSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 11/3/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKTestBase.h"

#import "TokenSdk.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKAccountSamples : TKTestBase

@end

@implementation TKAccountSamples

- (void)testGetAccounts {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKMemberSync *memberSync = [self createMember:tokenIOSync];
    [memberSync linkAccounts:[self createBankAuthorization:memberSync]];
    [memberSync linkAccounts:[self createBankAuthorization:memberSync]];
    TKMember *member = memberSync.async;
    NSMutableDictionary *sums = [NSMutableDictionary dictionaryWithCapacity:10];
    
    // account loop begin snippet to include in docs
    [member getAccounts:^(NSArray<TKAccount *> *accounts) {
        for (TKAccount *a in accounts) {
            [a getBalance:^(TKBalance *b) {
                sums[b.available.currency] = @([(NSNumber*)sums[b.available.currency] floatValue] + [b.available.value floatValue]);
            } onError:^(NSError *e) {
                // Something went wrong.
                @throw [NSException exceptionWithName:@"GetBalanceException"
                                               reason:[e localizedFailureReason]
                                             userInfo:[e userInfo]];
            }];
        }
    } onError: ^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"GetAccountsException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // account loop done snippet to include in docs
    
    [self runUntilTrue:^ {
        // assumes createBankAuthorization gives a million dollars
        // NSNumber * dollars = sums[@"USD"];
        // return ([dollars floatValue] > 1000001.0);
        return ([(NSNumber*)sums[@"USD"] floatValue] > 1000001.0);
    }];
}

- (void)testGetTransactions {
    TokenIOSync *tokenIOSync = [[self sdkBuilder] buildSync];
    TKAccountSync *payerAccountSync = [self createAccount:tokenIOSync];
    TKAccountSync *payeeAccountSync = [self createAccount:tokenIOSync];
    TKMemberSync *payerSync = payerAccountSync.member;
    TKMember *payer = payerSync.async;
    TKAccount *payerAccount = payerAccountSync.async;
    TransferEndpoint *destination = [TransferEndpoint message];
    destination.account.token.accountId = payeeAccountSync.id;
    destination.account.token.memberId = payeeAccountSync.member.id;
    NSString *transactionId = nil;
    
    // generate some activity: create+endorse+redeem some transfer tokens
    for (int count = 0; count < 5; count++) {
        TransferTokenBuilder *builder = [payerSync createTransferToken:100.00 + count currency:@"EUR"];
        builder.accountId = payerAccountSync.id;
        builder.redeemerMemberId = payerSync.id;
        builder.destinations = @[destination];
        Token *transferToken = [builder execute];
        [payerSync endorseToken:transferToken withKey:Key_Level_Standard];
        transactionId =[payerSync redeemToken:transferToken].transactionId;
    }
    
    __block int displayed = 0;
    void (^displayMoney)(NSString*, NSString*) = ^(NSString *cur, NSString *val) {
        // ignores inputs, but makes examples look purposeful
        displayed++;
    };
    
    // getTransactionsOffset begin snippet to include in docs
    [payer getTransactionsOffset:NULL // NULL: get first "page" of results
                           limit:10
                      forAccount:payerAccount.id
                       onSuccess:^(PagedArray<Transaction *> *ary) {
                           for (Transaction *tr in ary.items) {
                               // use transactions
                               displayMoney(tr.amount.currency, tr.amount.value);
                           }
                       } onError:^(NSError *e) {
                           // Something went wrong.
                           @throw [NSException exceptionWithName:@"GetTransactionsException"
                                                          reason:[e localizedFailureReason]
                                                        userInfo:[e userInfo]];
                       }];
    // getTransactionsOffset done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (displayed > 0);
    }];
    
    displayed = 0;
    
    // getTransaction begin snippet to include in docs
    [payer getTransaction:transactionId
                forAccount:payerAccount.id
                onSuccess:^(Transaction *tr) {
                    // use the transaction
                    displayMoney(tr.amount.currency, tr.amount.value);
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"GetTransactionException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    // getTransaction done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (displayed > 0);
    }];
    
    displayed = 0;
    
    // getTransferTokensOffset begin snippet to include in docs
    [payer getTransferTokensOffset:NULL // NULL: get first "page" of results
                             limit:10
                         onSuccess:^(PagedArray<Token*> *ary) {
                             for (Token *tt in ary.items) {
                                 // use the tokens
                                 displayMoney(tt.payload.transfer.currency, tt.payload.transfer.amount);
                             }
                         } onError:^(NSError *e) {
                             // Something went wrong.
                             @throw [NSException exceptionWithName:@"GetTransferTokensException"
                                                            reason:[e localizedFailureReason]
                                                          userInfo:[e userInfo]];
                         }];
    // getTransferTokensOffset done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (displayed > 0);
    }];
    
    displayed = 0;
    
    // getTransfersOffset begin snippet to include in docs
    [payer getTransfersOffset:NULL // NULL: get first "page" of results
                        limit:10
                      tokenId:NULL // NULL: don't filter by token
                    onSuccess:^(PagedArray<Transfer*> *ary) {
                        for (Transfer *t in ary.items) {
                            // use the transfers
                            displayMoney(t.payload.amount.currency, t.payload.amount.value);
                        }
                    } onError:^(NSError *e) {
                        // Something went wrong.
                        @throw [NSException exceptionWithName:@"GetTransfersException"
                                                       reason:[e localizedFailureReason]
                                                     userInfo:[e userInfo]];
                    }];
    // getTransfersOffset done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (displayed > 0);
    }];
}

@end
