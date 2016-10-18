//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"
#import "Money.pbobjc.h"

#import "TKMember.h"
#import "TKClient.h"
#import "TKUtil.h"
#import "TKAccountAsync.h"
#import "TKAccount.h"


@implementation TKAccountAsync {
    Account *account;
    TKClient *client;
}

+ (TKAccountAsync *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client {
    return [[TKAccountAsync alloc] initWithAccount:account of:member useClient:client];
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

- (TKAccount *)sync {
    return [TKAccount account:self];
}

- (NSString *)id {
    return account.id_p;
}

- (NSString *)name {
    return account.name;
}

- (void)getBalance:(OnSuccessWithMoney)onSuccess
           onError:(OnError)onError {
    [client getBalance:account.id_p
             onSuccess:onSuccess
               onError:onError];
}

- (void)getTransaction:(NSString *)transactionId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    [client getTransaction:transactionId
                forAccount:account.id_p
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
    return [client getTransactionsOffset:offset
                                   limit:limit
                              forAccount:account.id_p
                               onSuccess:onSuccess
                                 onError:onError];
}

@end
