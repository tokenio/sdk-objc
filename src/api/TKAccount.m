//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"
#import "Money.pbobjc.h"

#import "TKAccount.h"
#import "TKClient.h"
#import "TKMember.h"

@implementation TKAccount {
    Account *account;
    TKClient *client;
}

+ (TKAccount *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client {
    return [[TKAccount alloc] initWithAccount:account of:member useClient:client];
}

- (id)initWithAccount:(Account *)account_ of:(TKMember *)member useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        account = account_;
        client = client_;
        _member = member;
    }

    return self;
}

- (NSString *)id {
    return account.id_p;
}

- (NSString *)name {
    return account.name;
}

- (NSString *)bankId {
    return account.bankId;
}

- (BOOL) isLocked {
    return account.isLocked;
}

- (BOOL) supportsSendPayment {
    return account.accountFeatures.supportsSendPayment;
}

- (BOOL) supportsReceivePayment {
    return account.accountFeatures.supportsReceivePayment;
}

- (BOOL) supportsInformation {
    return account.accountFeatures.supportsInformation;
}

- (BOOL) requiresExternalAuth {
    return account.accountFeatures.requiresExternalAuth;
}

- (AccountDetails *) accountDetails {
    return account.accountDetails;
}

- (AccountFeatures *)accountFeatures {
    return account.accountFeatures;
}

- (void)getBalance:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError {
    [self.member getBalance:account.id_p
                    withKey:Key_Level_Low
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)getTransaction:(NSString *)transactionId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    [self.member getTransaction:transactionId
                     forAccount:account.id_p
                        withKey:Key_Level_Low
                      onSuccess:onSuccess
                        onError:onError];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
    [self.member getTransactionsOffset:offset
                                 limit:limit
                            forAccount:account.id_p
                               withKey:Key_Level_Low
                             onSuccess:onSuccess
                               onError:onError];
}

@end
