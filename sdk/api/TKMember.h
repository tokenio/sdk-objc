//
/**/// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"


@class TKSecretKey;
@class Member;
@class TKClient;
@class TKMemberAsync;


@interface TKMember : NSObject

@property (readonly, retain) TKMemberAsync *async;
@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

+ (TKMember *)member:(TKMemberAsync *)delegate;

- (void)approveKey:(TKSecretKey *)key;

- (void)removeKey:(NSString *)keyId;

- (void)addAlias:(NSString *)alias;

- (void)removeAlias:(NSString *)alias;

- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                          withPayload:(NSData *)payload;

- (NSArray<TKAccount *> *)lookupAccounts;

- (Payment *)lookupPayment:(NSString *)paymentId;

- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit;

- (NSArray<Payment *> *)lookupPaymentsOffset:(int)offset
                                       limit:(int)limit
                                     tokenId:(NSString *)tokenId;

@end
