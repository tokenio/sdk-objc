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

- (void)subscribeDevice:(NSString *)provider
        notificationUri:(NSString *)notificationUri
               platform:(Platform)platform
                   tags:(NSMutableArray<NSString*> *)tags {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async subscribeDevice:provider
                    notificationUri:notificationUri
                           platform:platform
                               tags:tags
                          onSuccess:^{ call.onSuccess(nil); }
                            onError:call.onError];
    }];
}


- (void)unsubscribeDevice:(NSString *)provider
        notificationUri:(NSString *)notificationUri {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async unsubscribeDevice:provider
                    notificationUri:notificationUri
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
                        onSucess:
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

- (Payment *)getPayment:(NSString *)paymentId {
    TKRpcSyncCall<Payment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPayment:paymentId
                        onSuccess:call.onSuccess
                          onError:call.onError];
    }];
}

- (NSArray<Payment *> *)getPaymentsOffset:(int)offset
                                       limit:(int)limit {
    return [self getPaymentsOffset:offset
                                limit:limit
                              tokenId:nil];
}

- (NSArray<Payment *> *)getPaymentsOffset:(int)offset
                                       limit:(int)limit
                                     tokenId:(NSString *)tokenId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPaymentsOffset:offset
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
                               onSucess:^{ call.onSuccess(nil); }
                                onError:call.onError];
    }];
}

- (PaymentToken *)createPaymentTokenForAccount:(NSString *)accountId
                                        amount:(double)amount
                                      currency:(NSString *)currency {
    return [self createPaymentTokenForAccount:accountId
                                       amount:amount
                                     currency:currency
                                redeemerAlias:nil
                                  description:nil];
}

- (PaymentToken *)createPaymentTokenForAccount:(NSString *)accountId
                                        amount:(double)amount
                                      currency:(NSString *)currency
                                 redeemerAlias:(NSString *)redeemerAlias
                                   description:(NSString *)description {
    TKRpcSyncCall<PaymentToken *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createPaymentTokenForAccount:accountId
                                          amount:amount
                                        currency:currency
                                   redeemerAlias:redeemerAlias
                                     description:description
                                        onSucess:call.onSuccess
                                         onError:call.onError];
    }];
}

- (PaymentToken *)getPaymentToken:(NSString *)tokenId {
    TKRpcSyncCall<PaymentToken *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPaymentToken:tokenId
                              onSucess:call.onSuccess
                               onError:call.onError];
    }];
}

- (NSArray<PaymentToken *> *)getPaymentTokensOffset:(int)offset
                                                 limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPaymentTokensOffset:offset
                                        limit:limit
                                    onSuccess:call.onSuccess
                                      onError:call.onError];
    }];
}

- (PaymentToken *)endorsePaymentToken:(PaymentToken *)token {
    TKRpcSyncCall<PaymentToken *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async endorsePaymentToken:token
                              onSuccess:call.onSuccess
                                onError:call.onError];
    }];
}

- (PaymentToken *)cancelPaymentToken:(PaymentToken *)token {
    TKRpcSyncCall<PaymentToken *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async cancelPaymentToken:token
                             onSuccess:call.onSuccess
                               onError:call.onError];
    }];
}

- (Payment *)redeemPaymentToken:(PaymentToken *)token {
    return [self redeemPaymentToken:token
                             amount:nil
                           currency:nil];
}

- (Payment *)redeemPaymentToken:(PaymentToken *)token
                         amount:(NSNumber *)amount
                       currency:(NSString *)currency {
    TKRpcSyncCall<Payment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async redeemPaymentToken:token
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
