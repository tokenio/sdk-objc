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

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency {
    return [self createTokenWithAmount:amount
                              currency:currency
                         redeemerAlias:nil
                           description:nil];
}

- (Token *)createTokenWithAmount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createTokenWithAmount:amount
                                 currency:currency
                            redeemerAlias:redeemerAlias
                              description:description
                                 onSucess:call.onSuccess
                                  onError:call.onError];
    }];
}

- (Token *)lookupToken:(NSString *)tokenId {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupToken:tokenId
                       onSucess:call.onSuccess
                        onError:call.onError];
    }];
}

- (NSArray<Token *> *)lookupTokensOffset:(int)offset
                                   limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async lookupTokensOffset:offset
                                 limit:limit
                             onSuccess:call.onSuccess
                               onError:call.onError];
    }];
}

- (Token *)endorseToken:(Token *)token {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async endorseToken:token
                       onSuccess:call.onSuccess
                         onError:call.onError];
    }];
}

- (Token *)declineToken:(Token *)token {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async declineToken:token
                       onSuccess:call.onSuccess
                         onError:call.onError];
    }];
}

- (Token *)revokeToken:(Token *)token {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async revokeToken:token
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (Payment *)redeemToken:(Token *)token {
    return [self redeemToken:token
                      amount:nil
                    currency:nil];
}

- (Payment *)redeemToken:(Token *)token
                  amount:(NSNumber *)amount
                currency:(NSString *)currency {
    TKRpcSyncCall<Payment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async redeemToken:token
                         amount:amount
                       currency:currency
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
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