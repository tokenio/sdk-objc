//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"

@class Account;
@class TKMember;
@class TKClient;
@class Token;
@class Payment;
@class TKAccountAsync;


@interface TKAccount : NSObject

@property (atomic, readonly) TKAccountAsync *async;
@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccount *)account:(TKAccountAsync *)delegate;

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency;

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description;

- (Token *)lookupToken:(NSString *)tokenId;

- (NSArray<Token *> *)lookupTokensOffset:(int)i limit:(int)limit;

- (Token *)endorseToken:(Token *)token;

- (Token *)declineToken:(Token *)token;

- (Token *)revokeToken:(Token *)token;

- (Payment *)redeemToken:(Token *)token;

- (Payment *)redeemToken:(Token *)token
                  amount:(NSNumber *)amount
                currency:(NSString *)currency;

- (Money *)lookupBalance;

- (Transaction *)lookupTransaction:(NSString *)transactionId;

- (NSArray<Payment *> *)lookupTransactionsOffset:(int)offset
                                           limit:(int)limit;

@end