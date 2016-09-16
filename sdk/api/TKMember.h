//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#ifndef TokenMember_h
#define TokenMember_h

#import <Foundation/Foundation.h>
#import "TKTypedef.h"


@class TKSecretKey;
@class Member;
@class TKClient;


@interface TKMember : NSObject

@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

+ (TKMember *)member:(Member *)member secretKey:(TKSecretKey *)key useClient:(TKClient *)client;

- (void)approveKey:(TKSecretKey *)key;

- (void)approveKeyAsync:(TKSecretKey *)key
                onSucess:(OnSuccess)onSuccess
                 onError:(OnError)onError;

- (void)removeKey:(NSString *)keyId;

- (void)removeKeyAsync:(NSString *)keyId
              onSucess:(OnSuccess)onSuccess
               onError:(OnError)onError;

- (void)addAlias:(NSString *)alias;

- (void)addAliasAsync:(NSString *)alias
             onSucess:(OnSuccess)onSuccess
              onError:(OnError)onError;

- (void)removeAlias:(NSString *)alias;

- (void)removeAliasAsync:(NSString *)alias
             onSucess:(OnSuccess)onSuccess
              onError:(OnError)onError;

@end

#endif