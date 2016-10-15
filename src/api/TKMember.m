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

- (void)approveKey:(TKSecretKey *)key
             level:(Key_Level)level{
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async approveKey:key
                         level:level
                     onSuccess:^{ call.onSuccess(nil); }
                       onError:call.onError];
    }];
}

- (void)removeKey:(NSString *)keyId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeKey:keyId
                    onSuccess:^{ call.onSuccess(nil); }
                      onError:call.onError];
    }];
}

- (void)addAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async addAlias:alias
                   onSuccess:^{ call.onSuccess(nil); }
                     onError:call.onError];
    }];
}

- (void)removeAlias:(NSString *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeAlias:alias
                      onSuccess:^{ call.onSuccess(nil); }
                        onError:call.onError];
    }];
}

- (Subscriber *)subscribeToNotifications:(NSString *)provider
                                  target:(NSString *)target
                                platform:(Platform)platform {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async subscribeToNotifications:provider
                                      target:target
                                    platform:platform
                                   onSuccess:call.onSuccess
                                     onError:call.onError];
    }];
}

- (NSArray<Subscriber *> *)getSubscribers {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getSubscribers:call.onSuccess
                           onError:call.onError];
    }];
}

- (Subscriber *)getSubscriber:(NSString *)subscriberId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getSubscriber:subscriberId
                        onSuccess:call.onSuccess
                          onError:call.onError];
    }];
}

- (void)unsubscribeFromNotifications:(NSString *)subscriberId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async unsubscribeFromNotifications:subscriberId
                                       onSuccess:^{ call.onSuccess(nil); }
                                         onError:call.onError];
    }];
}





- (NSArray<TKAccount*> *)linkAccounts:(NSString *)bankId
                          withPayload:(NSString *)payload {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async linkAccounts:bankId
                     withPayload:payload
                       onSuccess:
         ^(NSArray<TKAccountAsync *> *accounts) {
             call.onSuccess([self _asyncToSync:accounts]);
         }
                         onError:call.onError];
    }];
}

- (NSArray<TKAccount *> *)getAccounts {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
         getAccounts:
         ^(NSArray<TKAccountAsync *> *accounts) {
             call.onSuccess([self _asyncToSync:accounts]);
         }
         onError:call.onError];
    }];
}

- (TKAccount *)getAccount:(NSString *)accountId {
    TKRpcSyncCall<TKAccount *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
         getAccount:accountId
         onSuccess:
         ^(TKAccountAsync *account) {
             call.onSuccess(account.sync);
         }
         onError:call.onError];
    }];
}

- (Transfer *)getTransfer:(NSString *)transferId {
    TKRpcSyncCall<Transfer *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransfer:transferId
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (NSArray<Transfer *> *)getTransfersOffset:(int)offset
                                      limit:(int)limit {
    return [self getTransfersOffset:offset
                              limit:limit
                            tokenId:nil];
}

- (NSArray<Transfer *> *)getTransfersOffset:(int)offset
                                      limit:(int)limit
                                    tokenId:(NSString *)tokenId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransfersOffset:offset
                                 limit:limit
                               tokenId:tokenId
                             onSuccess:call.onSuccess
                               onError:call.onError];
    }];
}

- (Address *)addAddressWithName:(NSString *)name
                       withData:(NSString *)data {
    TKRpcSyncCall<Address *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async addAddressWithName:name
                              withData:data
                             onSuccess:call.onSuccess
                               onError:call.onError];
    }];
}

- (Address *)getAddressWithId:(NSString *)addressId {
    TKRpcSyncCall<Address *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAddressWithId:addressId
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

- (void)deleteAddressWithId:(NSString *)addressId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async deleteAddressWithId:addressId
                              onSuccess:^{ call.onSuccess(nil); }
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
                                onSuccess:call.onSuccess
                                  onError:call.onError];
    }];
}

- (Token *)getToken:(NSString *)tokenId {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getToken:tokenId
                   onSuccess:call.onSuccess
                     onError:call.onError];
    }];
}

- (NSArray<Token *> *)getTransferTokensOffset:(int)offset
                                        limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransferTokensOffset:offset
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

- (Token *)cancelToken:(Token *)token {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async cancelToken:token
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (Transfer *)createTransfer:(Token *)token {
    return [self createTransfer:token
                         amount:nil
                       currency:nil];
}

- (Transfer *)createTransfer:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency {
    TKRpcSyncCall<Transfer *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createTransfer:token
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
