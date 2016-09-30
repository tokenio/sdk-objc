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
                      onSucess:^{ call.onSuccess(nil); }
                       onError:call.onError];
    }];
}

- (void)removeKey:(NSString *)keyId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeKey:keyId
                     onSucess:^{ call.onSuccess(nil); }
                      onError:call.onError];
    }];
}

- (void)addAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async addAlias:alias
                    onSucess:^{ call.onSuccess(nil); }
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
                                    call.onSuccess([self _asyncToSync:accounts]);
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
                            call.onSuccess([self _asyncToSync:accounts]);
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

- (Address *)createAddressName:(NSString *)name
                      withData:(NSString *)data {
    TKRpcSyncCall<Address *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createAddressName:name
                             withData:data
                            onSuccess:call.onSuccess
                              onError:call.onError];
    }];
}

- (Address *)getAddressById:(NSString *)addressId {
    TKRpcSyncCall<Address *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAddressById:addressId
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
}

- (NSArray<Address *> *)getAddresses {
    TKRpcSyncCall<NSArray<Address *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAddresses:call.onSuccess
                         onError:call.onError];
    }];
}

- (void)deleteAddressById:(NSString *)addressId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async deleteAddressById:addressId
                             onSucess:^{ call.onSuccess(nil); }
                              onError:call.onError];
    }];
}

- (void)setPreferences:(NSString *)preferences {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async setPreferences:preferences
                          onSucess:^{ call.onSuccess(nil); }
                           onError:call.onError];
    }];
}

- (NSString *)getPreferences {
    TKRpcSyncCall<NSString *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPreferences:call.onSuccess
                           onError:call.onError];
    }];
}

- (Token *)createTokenForAccount:(NSString *)accountId
                          amount:(double)amount
                        currency:(NSString *)currency {
    return [self createTokenForAccount:accountId
                                amount:amount
                              currency:currency
                         redeemerAlias:nil
                           description:nil];
}

- (Token *)createTokenForAccount:(NSString *)accountId
                          amount:(double)amount
                        currency:(NSString *)currency
                   redeemerAlias:(NSString *)redeemerAlias
                     description:(NSString *)description {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createTokenForAccount:accountId
                                   amount:amount
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

#pragma mark private

- (NSArray<TKAccount *> *)_asyncToSync:(NSArray<TKAccountAsync *> *)accounts {
    NSMutableArray<TKAccount *> *sync = [NSMutableArray array];
    for (TKAccountAsync *a in accounts) {
        [sync addObject:a.sync];
    }
    return sync;
}

@end
