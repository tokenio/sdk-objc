//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"


@class TKSecretKey;
@class Member;
@class TKClient;


@interface TKMemberAsync : NSObject

@property (readonly, retain) TKMember *sync;
@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

+ (TKMemberAsync *)member:(Member *)member
                secretKey:(TKSecretKey *)key
                useClient:(TKClient *)client;

- (void)approveKey:(TKSecretKey *)key
          onSucess:(OnSuccess)onSuccess
           onError:(OnError)onError;

- (void)removeKey:(NSString *)keyId
         onSucess:(OnSuccess)onSuccess
          onError:(OnError)onError;

- (void)addAlias:(NSString *)alias
        onSucess:(OnSuccess)onSuccess
         onError:(OnError)onError;

- (void)removeAlias:(NSString *)alias
           onSucess:(OnSuccess)onSuccess
            onError:(OnError)onError;

- (void)linkAccounts:(NSString *)bankId
         withPayload:(NSData *)payload
            onSucess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError;

- (void)lookupAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
               onError:(OnError)onError;

- (void)lookupPayment:(NSString *)paymentId
            onSuccess:(OnSuccessWithPayment)onSuccess
              onError:(OnError)onError;

- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError;

- (void)lookupPaymentsOffset:(int)offset
                       limit:(int)limit
                     tokenId:(NSString *)tokenId
                   onSuccess:(OnSuccessWithPayments)onSuccess
                     onError:(OnError)onError;

- (void)createAddressName:(NSString *)name
                 withData:(NSString *)data
                onSuccess:(OnSuccessWithAddress)onSuccess
                  onError:(OnError)onError;

- (void)getAddressById:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError;

- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

- (void)deleteAddressById:(NSString *)addressId
                 onSucess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

- (void)setPreferences:(NSString *)preferences
              onSucess:(OnSuccess)onSuccess
               onError:(OnError)onError;

- (void)getPreferences:(OnSuccessWithPreferences)onSuccess
               onError:(OnError)onError;

@end
