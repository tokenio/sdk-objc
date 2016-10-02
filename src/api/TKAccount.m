//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKRpcSyncCall.h"
#import "TKAccountAsync.h"


@implementation TKAccount

+ (TKAccount *)account:(TKAccountAsync *)delegate {
    return [[TKAccount alloc] initWithDelegate:delegate];
}

- (id)initWithDelegate:(TKAccountAsync *)delegate_ {
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

- (TKMember *)member {
    return self.async.member;
}

- (Money *)lookupBalance {
    TKRpcSyncCall<Money *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupBalance:call.onSuccess onError:call.onError];
    }];
}

- (Transaction *)lookupTransaction:(NSString *)transactionId {
    TKRpcSyncCall<Transaction *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupTransaction:transactionId
                            onSuccess:call.onSuccess
                              onError:call.onError];
    }];
}

- (NSArray<Transaction *> *)lookupTransactionsOffset:(int)offset
                                               limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupTransactionsOffset:offset
                                       limit:limit
                                   onSuccess:call.onSuccess
                                     onError:call.onError];
    }];
}

@end
