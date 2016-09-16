//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <protos/Security.pbobjc.h>
#import "TKAccount.h"
#import "TKMember.h"
#import "TKSecretKey.h"
#import "Member.pbobjc.h"
#import "TKClient.h"
#import "TKRpcSyncCall.h"


@implementation TKMember {
    TKClient *client;
    Member *member;
}

+ (TKMember *)member:(Member *)member secretKey:(TKSecretKey *)key useClient:(TKClient *)client {
    return [[TKMember alloc] initWithMember:member secretKey:key useClient:client];
}

- (id)initWithMember:(Member *)member_ secretKey:(TKSecretKey *)key useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        _key = key;
        member = member_;
        client = client_;
    }

    return self;
}

- (NSString *)id {
    return member.id_p;
}

- (NSString *)firstAlias {
    return member.aliasesArray[0];
}

- (NSArray<NSString *> *)publicKeys {
    NSMutableArray<NSString *> *result = [NSMutableArray array];
    for (Key *key in member.keysArray) {
        [result addObject:key.publicKey];
    }
    return result;
}

- (NSArray<NSString *> *)aliases {
    return [member.aliasesArray copy];
}

- (void)approveKey:(TKSecretKey *)key {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self approveKeyAsync:key
                     onSucess:^{ call.onSuccess(nil); }
                      onError:call.onError];
    }];
}

- (void)approveKeyAsync:(TKSecretKey *)key
               onSucess:(OnSuccess)onSuccess
                onError:(OnError)onError {
    [client addKey:key
                to:member
             level:0
         onSuccess:
                 ^(Member *m) {
                     [member clear];
                     [member mergeFrom:m];
                     onSuccess();
                 }
           onError:onError];
}

- (void)removeKey:(NSString *)keyId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self removeKeyAsync:keyId
                    onSucess:^{ call.onSuccess(nil); }
                     onError:call.onError];
    }];
}

- (void)removeKeyAsync:(NSString *)keyId
               onSucess:(OnSuccess)onSuccess
                onError:(OnError)onError {
    [client removeKey:keyId
                 from:member
            onSuccess:
                    ^(Member *m) {
                        [member clear];
                        [member mergeFrom:m];
                        onSuccess();
                    }
              onError:onError];
}

- (void)addAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self addAliasAsync:alias
                   onSucess:^{ call.onSuccess(nil); }
                    onError:call.onError];
    }];
}

- (void)addAliasAsync:(NSString *)alias
              onSucess:(OnSuccess)onSuccess
               onError:(OnError)onError {
    [client addAlias:alias
                  to:member
           onSuccess:
                   ^(Member *m) {
                       [member clear];
                       [member mergeFrom:m];
                       onSuccess();
                   }
             onError:onError];
}

- (void)removeAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self removeAliasAsync:alias
                   onSucess:^{ call.onSuccess(nil); }
                    onError:call.onError];
    }];
}

- (void)removeAliasAsync:(NSString *)alias
             onSucess:(OnSuccess)onSuccess
              onError:(OnError)onError {
    [client removeAlias:alias
                 from:member
            onSuccess:
                    ^(Member *m) {
                        [member clear];
                        [member mergeFrom:m];
                        onSuccess();
                    }
              onError:onError];
}

- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
         withPayload:(NSData *)payload {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self linkAccountAsync:bankId
                   withPayload:payload
                      onSucess:call.onSuccess
                       onError:call.onError];
    }];
}

- (void)linkAccountAsync:(NSString *)bankId
             withPayload:(NSData *)payload
                onSucess:(OnSuccessWithTKAccounts)onSuccess
                 onError:(OnError)onError {
    [client linkAccounts:bankId
                 payload:payload
               onSuccess:
                       ^(NSArray<Account *> *accounts) {
                           onSuccess([self mapAccounts:accounts]);
                       }
                 onError:onError];
}

- (NSArray<TKAccount *> *)lookupAccounts {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self lookupAccounts:call.onSuccess
                     onError:call.onError];
    }];
}

- (void)lookupAccounts:(OnSuccessWithTKAccounts)onSuccess
                 onError:(OnError)onError {
    [client lookupAccounts:
                    ^(NSArray<Account *> *accounts) {
                        onSuccess([self mapAccounts:accounts]);
                    }
                   onError:onError];
}

- (Payment *)lookupPayment:(NSString *)paymentId {
    TKRpcSyncCall<Payment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self asyncLookupPayment:paymentId
                onSuccess:call.onSuccess
                     onError:call.onError];
    }];
}

- (void)asyncLookupPayment:(NSString *)paymentId
                 onSuccess:(OnSuccessWithPayment)onSuccess
                   onError:(OnError)onError {
    [client lookupPayment:paymentId
                onSuccess:onSuccess
                  onError:onError];
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
        [self asyncLookupPaymentsOffset:offset
                                  limit:limit
                                tokenId:tokenId
                              onSuccess:call.onSuccess
                                onError:call.onError];
    }];
}

- (void)asyncLookupPaymentsOffset:(int)offset
                            limit:(int)limit
                        onSuccess:(OnSuccessWithPayments)onSuccess
                          onError:(OnError)onError {
    [self asyncLookupPaymentsOffset:offset
                              limit:limit
                            tokenId:nil
                          onSuccess:onSuccess
                            onError:onError];
}

- (void)asyncLookupPaymentsOffset:(int)offset
                            limit:(int)limit
                          tokenId:(NSString *)tokenId
                        onSuccess:(OnSuccessWithPayments)onSuccess
                          onError:(OnError)onError {
    [client lookupPaymentsOffset:offset
                           limit:limit
                         tokenId:tokenId
                       onSuccess:onSuccess
                         onError:onError];
}

- (NSArray<TKAccount *> *)mapAccounts:(NSArray<Account *> *)accounts {
    NSMutableArray<TKAccount *> *result = [NSMutableArray array];
    for (Account *a in accounts) {
        TKAccount *tkAccount = [TKAccount account:a of:self useClient:client];
        [result addObject:tkAccount];
    }
    return result;
}

@end