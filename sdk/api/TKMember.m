//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <protos/Security.pbobjc.h>
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

@end