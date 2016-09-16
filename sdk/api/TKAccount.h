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


@interface TKAccount : NSObject

@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccount *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client;

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency;

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description;

- (void)asyncCreateTokenWithAmount:(double)amount
                          currency:(NSString *)currency
                          onSucess:(OnSuccessWithToken)onSuccess
                           onError:(OnError)onError;

- (void)asyncCreateTokenWithAmount:(double)amount
                             currency:(NSString *)currency
                        redeemerAlias:(NSString *)redeemerAlias
                          description:(NSString *)description
                             onSucess:(OnSuccessWithToken)onSuccess
                              onError:(OnError)onError;

- (Token *)lookupToken:(NSString *)tokenId;

- (void)asyncLookupToken:(NSString *)tokenId
                onSucess:(OnSuccessWithToken)onSuccess
                 onError:(OnError)onError;

- (NSArray<Token *> *)lookupTokensOffset:(int)i limit:(int)limit;

- (void)asyncLookupTokensOffset:(int)offset
                          limit:(int)limit
                      onSuccess:(OnSuccessWithTokens)onSuccess
                        onError:(OnError)onError;

- (Token *)endorseToken:(Token *)token;

- (void)asyncEndorseToken:(Token *)token
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

- (Token *)declineToken:(Token *)token;

- (void)asyncDeclineToken:(Token *)token
               onSuccess:(OnSuccessWithToken)onSuccess
                 onError:(OnError)onError;

- (Token *)revokeToken:(Token *)token;

- (void)asyncRevokeToken:(Token *)token
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError;

- (Payment *)redeemToken:(Token *)token;

- (Payment *)redeemToken:(Token *)token
                  amount:(NSNumber *)amount
                currency:(NSString *)currency;

- (void)asyncRedeemToken:(Token *)token
        onSuccess:(OnSuccessWithPayment)onSuccess
          onError:(OnError)onError;

- (void)asyncRedeemToken:(Token *)token
                  amount:(NSNumber *)amount
                currency:(NSString *)currency
               onSuccess:(OnSuccessWithPayment)onSuccess
                 onError:(OnError)onError;

@end