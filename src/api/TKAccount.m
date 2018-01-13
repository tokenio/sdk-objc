//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "Account.pbobjc.h"
#import "Money.pbobjc.h"

#import "TKMemberSync.h"
#import "TKClient.h"
#import "TKAccount.h"
#import "TKAccountSync.h"


@implementation TKAccount {
    Account *account;
    TKClient *client;
}

+ (TKAccount *)account:(Account *)account of:(TKMemberSync *)member useClient:(TKClient *)client {
    return [[TKAccount alloc] initWithAccount:account of:member useClient:client];
}

- (id)initWithAccount:(Account *)account_ of:(TKMemberSync *)member useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        account = account_;
        client = client_;
        _member = member;
    }

    return self;
}

- (TKAccountSync *)sync {
    return [TKAccountSync account:self];
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

- (void)getBalance:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError {
    
    [self.member.async getBalance:account.id_p
                          withKey:Key_Level_Low
                        onSuccess:onSuccess
                          onError:onError];
}

- (void)getTransaction:(NSString *)transactionId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    [self.member.async getTransaction:transactionId
                           forAccount:account.id_p
                              withKey:Key_Level_Low
                            onSuccess:onSuccess
                              onError:onError];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
    return [self.member.async getTransactionsOffset:offset
                                              limit:limit
                                         forAccount:account.id_p
                                            withKey:Key_Level_Low
                                          onSuccess:onSuccess
                                            onError:onError];
}

@end
