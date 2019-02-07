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
#import "TKSampleBase.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKAccountSamples : TKSampleBase

@end

@implementation TKAccountSamples

- (void)testGetBanks {
    TokenClient *tokenClient = self.tokenClient;
    
    __block NSArray<Bank *> *banks;
    
    // get 5 banks sorted by name loop begin snippet to include in docs
    [tokenClient getBanks:nil
                   search:nil
                  country:nil
                     page:1
                  perPage:5
                     sort:@"name"
                 provider:@""
                onSuccess:^(NSArray<Bank *> *banklist) {
                    banks = banklist;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"GetBankException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    // get 5 banks sorted by name loop done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (banks.count == 5);
    }];
    
    // get banks by ids loop begin snippet to include in docs
    [tokenClient getBanks:@[@"iron",@"gold"]
                   search:nil
                  country:nil
                     page:1
                  perPage:10
                     sort:@"name"
                 provider:@""
                onSuccess:^(NSArray<Bank *> *banklist) {
                    banks = banklist;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"GetBankException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
            }];
    // get banks by ids done begin snippet to include in docs
    
    [self runUntilTrue:^ {
        return (banks.count == 2);
    }];
    
    // get banks by search string loop begin snippet to include in docs
    [tokenClient getBanks:nil
                   search:@"GOLD"
                  country:nil
                     page:1
                  perPage:10
                     sort:@"country"
                 provider:@""
                onSuccess:^(NSArray<Bank *> *banklist) {
                    banks = banklist;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"GetBankException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    // get banks by search string done begin snippet to include in docs
    
    [self runUntilTrue:^ {
        return (banks.count > 0);
    }];
    
    // get banks by country code loop begin snippet to include in docs
    [tokenClient getBanks:nil
                   search:nil
                  country:@"US"
                     page:1
                  perPage:10
                     sort:@"name"
                 provider:@""
                onSuccess:^(NSArray<Bank *> *bankList) {
                    banks = bankList;
                } onError:^(NSError *e) {
                    // Something went wrong.
                    @throw [NSException exceptionWithName:@"GetBankException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
    // get banks by search string done begin snippet to include in docs
    
    [self runUntilTrue:^ {
        return (banks.count > 0);
    }];
}

// manual testing only
- (void)testInitiateAccountLinking {
    TKMember *member = self.payer;
    __block NSArray<TKAccount *> * accounts;
    
    // initiate account linking loop begin snippet to include in docs
    // This method will pop up TkBrowser with bank linking web page. After user finish the flow, the onSuccess callbank
    // will be invoked. If you want to customize your browser user interface, you can implemnt TkBrowser and add the
    // new TKBrowserFactory when you creating TokenIO.
    [member initiateAccountLinking:@"iron"
                         onSuccess:^(NSArray<TKAccount *> * accountList) {
                             accounts = accountList;
                         }
                           onError:^(NSError *e) {
                               if ([e.domain isEqualToString: kTokenErrorDomain]
                                   && e.code == kTKErrorUserCancelled) {
                                   // User Cancelled.
                               } else if ([e.domain isEqualToString:kTokenAccountLinkingErrorDomain]
                                   && e.code == AccountLinkingStatus_FailureBankAuthorizationRequired) {
                                   // Wait for the link accounts notification to complete the whole process
                               } else {
                                   // Something went wrong.
                                   @throw [NSException exceptionWithName:@"InitiateAccountLinkingException"
                                                                  reason:[e localizedFailureReason]
                                                                userInfo:[e userInfo]];
                               }
                           }];
    // initiate account linking loop done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accounts.count > 0);
    }
         backOffTimeMs:2
         waitingTimeMs:60000];
}

// manual testing only
-(void)testBankAuthorizationNotification {
    TKMember *member = self.payer;
    __block int finish = false;
    __block Notification *notification;
    __block NSArray<TKAccount *> * accounts;
    
    [member initiateAccountLinking:@"gold"
                         onSuccess:^(NSArray<TKAccount *> * accountList) {
                             //Success
                         }
                           onError:^(NSError *e) {
                               if ([e.domain isEqualToString: kTokenErrorDomain]
                                   && e.code == kTKErrorUserCancelled) {
                                   // User Cancelled.
                               } else if ([e.domain isEqualToString:kTokenAccountLinkingErrorDomain]
                                          && e.code == AccountLinkingStatus_FailureBankAuthorizationRequired) {
                                   // Wait for the link accounts notification to complete the whole process
                                   finish = true;
                               } else {
                                   // Something went wrong.
                                   @throw [NSException exceptionWithName:@"InitiateAccountLinkingException"
                                                                  reason:[e localizedFailureReason]
                                                                userInfo:[e userInfo]];
                               }
                           }];
    
    [self runUntilTrue:^ {
        return finish;
    }];
    
    notification = [self runUntilNotificationReceived: self.payer];
    
    NSString *notificationId = notification.id_p;
    
    // bank authorization notification loop begin snippet to include in docs
    // Notification is available in push notification.
    [member getNotification:notificationId
                  onSuccess:^(Notification *notification) {
                      if ([notification.content.type isEqualToString:@"LINK_ACCOUNTS"]) {
                          LinkAccounts *content = [TKJson
                                                   deserializeMessageOfClass:[LinkAccounts class]
                                                   fromJSON:notification.content.payload];
                          [member linkAccounts:content.bankAuthorization
                                     onSuccess:^(NSArray<TKAccount *> * accountList) {
                                         //Success
                                         accounts = accountList;
                                         
                                     }
                                       onError:^(NSError *e) {
                                           if ([e.domain isEqualToString: kTokenErrorDomain]
                                               && e.code == kTKErrorUserCancelled) {
                                               // User Cancelled.
                                           } else if ([e.domain isEqualToString:kTokenAccountLinkingErrorDomain]
                                                      && e.code == AccountLinkingStatus_FailureBankAuthorizationRequired) {
                                               // Wait for the link accounts notification to complete the whole process
                                               finish = YES;
                                           } else {
                                               // Something went wrong.
                                               @throw [NSException exceptionWithName:@"InitiateAccountLinkingException"
                                                                              reason:[e localizedFailureReason]
                                                                            userInfo:[e userInfo]];
                                           }
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
                    }
     ];
    // bank authorization notification loop done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (accounts.count > 0);
    }];
}

- (void)testGetAccounts {
    OauthBankAuthorization *auth = [self createBankAuthorization:self.payer];
    __block int accountLinked = false;
    [self.payer linkAccounts:auth.bankId accessToken:auth.accessToken onSuccess:^(NSArray<TKAccount *> *accounts) {
        accountLinked = true;
    } onError:^(NSError *e) {
        // Something went wrong.
        @throw [NSException exceptionWithName:@"LinkAccountException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    [self runUntilTrue:^ {
        return accountLinked;
    }];
    
    TKMember *member = self.payer;
    NSMutableDictionary<NSString*, NSNumber*> *sums = [NSMutableDictionary dictionaryWithCapacity:10];
    
    // account loop begin snippet to include in docs
    [member getAccounts:^(NSArray<TKAccount *> *accounts) {
        for (TKAccount *a in accounts) {
            [a getBalance:^(TKBalance *b) {
                sums[b.available.currency] = @([sums[b.available.currency] floatValue] + [b.available.value floatValue]);
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
        return (sums.count > 0);
    }];
}

- (void)testGetTransactions {
    TransferEndpoint *destination = [TransferEndpoint message];
    destination.account.token.accountId = self.payeeAccount.id;
    destination.account.token.memberId = self.payee.id;
    __block NSString *transactionId = nil;
    
    // generate some activity: create+endorse+redeem some transfer tokens
    __block int transactionCount = 0;
    for (int count = 0; count < 5; count++) {
        NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.00"];
        amount = [amount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithMantissa:count
                                                                                 exponent:0
                                                                               isNegative:NO]];
        TransferTokenBuilder *builder = [self.payer createTransferToken:amount currency:@"EUR"];
        builder.accountId = self.payerAccount.id;
        builder.toMemberId = self.payer.id;
        builder.destinations = @[destination];
        Token *transferToken = [builder execute];
        [self.payer endorseToken:transferToken
                         withKey:Key_Level_Standard
                       onSuccess:^(TokenOperationResult *result) {
                           [self.payer redeemToken:result.token
                                         onSuccess:^(Transfer *transfer) {
                                             transactionId = transfer.transactionId;
                                             transactionCount = transactionCount + 1;
                                         } onError: ^(NSError *e) {
                                             // Something went wrong.
                                             @throw [NSException exceptionWithName:@"EndorseTokenException"
                                                                            reason:[e localizedFailureReason]
                                                                          userInfo:[e userInfo]];
                                         }];
                       } onError: ^(NSError *e) {
                           // Something went wrong.
                           @throw [NSException exceptionWithName:@"RedeemTokenException"
                                                          reason:[e localizedFailureReason]
                                                        userInfo:[e userInfo]];
                       }];
    }
    [self runUntilTrue:^ {
        return (transactionCount == 5);
    }];
    
    TKMember *payer = self.payer;
    TKAccount *payerAccount = self.payerAccount;
    
    __block int displayed = 0;
    void (^displayMoney)(NSString*, NSString*) = ^(NSString *cur, NSString *val) {
        // ignores inputs, but makes examples look purposeful
        displayed++;
    };
    
    // getTransactionsOffset begin snippet to include in docs
    [payer getTransactionsOffset:NULL // NULL: get first "page" of results
                           limit:10
                      forAccount:payerAccount.id
                         withKey:Key_Level_Low
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
                  withKey:Key_Level_Low
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
