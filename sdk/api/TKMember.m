//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKMemberAsync.h"
#import "TKSecretKey.h"
#import "TKRpcSyncCall.h"
#import "TKAccountAsync.h"


@implementation TKMember

+ (TKMember *)member:(TKMemberAsync *)delegate {
    return [[TKMember alloc] initWithDelegate:delegate];
}

- (id)initWithDelegate:(TKMemberAsync *)delegate {
    self = [super init];
    if (self) {
        _async = delegate;
    }
    return self;
}

- (NSString *)id {
    return self.async.id;
}

- (NSString *)firstAlias {
    return self.async.firstAlias;
}

- (NSArray<NSString *> *)publicKeys {
    return self.async.publicKeys;
}

- (NSArray<NSString *> *)aliases {
    return self.async.aliases;
}

- (TKSecretKey *)key {
    return self.async.key;
}

- (void)approveKey:(TKSecretKey *)key {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async approveKey:key
                      onSucess:^{
                          call.onSuccess(nil);
                      }
                       onError:call.onError];
    }];
}

- (void)removeKey:(NSString *)keyId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeKey:keyId
                     onSucess:^{
                         call.onSuccess(nil);
                     }
                      onError:call.onError];
    }];
}

- (void)addAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async addAlias:alias
                    onSucess:
                            ^{
                                call.onSuccess(nil);
                            }
                     onError:call.onError];
    }];
}

- (void)removeAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeAlias:alias
                       onSucess:^{ call.onSuccess(nil); }
                        onError:call.onError];
    }];
}

- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                          withPayload:(NSData *)payload {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async linkAccounts:bankId
                     withPayload:payload
                        onSucess:
                                ^(NSArray<TKAccountAsync *> *accounts) {
                                    NSMutableArray<TKAccount *> *sync = [NSMutableArray array];
                                    for (TKAccountAsync *a in accounts) {
                                        [sync addObject:a.sync];
                                    }
                                    call.onSuccess(sync);
                                }
                         onError:call.onError];
    }];
}

- (NSArray<TKAccount *> *)lookupAccounts {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
                lookupAccounts:
                        ^(NSArray<TKAccountAsync *> *accounts) {
                            NSMutableArray<TKAccount *> *sync = [NSMutableArray array];
                            for (TKAccountAsync *a in accounts) {
                                [sync addObject:a.sync];
                            }
                            call.onSuccess(sync);
                        }
                       onError:call.onError];
    }];
}

- (Payment *)lookupPayment:(NSString *)paymentId {
    TKRpcSyncCall<Payment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupPayment:paymentId
                        onSuccess:call.onSuccess
                          onError:call.onError];
    }];
}

- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit {
    return [self lookupPaymentsOffset:offset
                                limit:limit
                              tokenId:nil];
}

- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit
                                     tokenId:(NSString *)tokenId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupPaymentsOffset:offset
                                   limit:limit
                                 tokenId:tokenId
                               onSuccess:call.onSuccess
                                 onError:call.onError];
    }];
}

@end