//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKRpcSyncCall.h"
#import "TKAccount.h"


@implementation TKAccountSync

+ (TKAccountSync *)account:(TKAccount *)delegate {
    return [[TKAccountSync alloc] initWithDelegate:delegate];
}

- (id)initWithDelegate:(TKAccount *)delegate_ {
    self = [super init];
    if (self) {
        _async = delegate_;
    }
    return self;
}

- (NSString *)id {
    return self.async.id;
}

- (NSString *)name {
    return self.async.name;
}

- (NSString *)bankId {
    return self.async.bankId;
}

- (TKMemberSync *)member {
    return self.async.member;
}

- (Money *)getBalance {
    TKRpcSyncCall<Money *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBalance:call.onSuccess onError:call.onError];
    }];
}

- (Transaction *)getTransaction:(NSString *)transactionId {
    TKRpcSyncCall<Transaction *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransaction:transactionId
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
}

- (PagedArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                               limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransactionsOffset:offset
                                    limit:limit
                                onSuccess:call.onSuccess
                                  onError:call.onError];
    }];
}

@end
