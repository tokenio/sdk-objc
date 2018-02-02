//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKAccountSync.h"
#import "TKMemberSync.h"
#import "TKMember.h"
#import "TKRpcSyncCall.h"
#import "TKAccount.h"


@implementation TKMemberSync

+ (TKMemberSync *)member:(TKMember *)delegate {
    return [[TKMemberSync alloc] initWithDelegate:delegate];
}

- (id)initWithDelegate:(TKMember *)delegate {
    self = [super init];
    if (self) {
        _async = delegate;
    }
    return self;
}

- (NSString *)id {
    return self.async.id;
}

- (Alias *)firstAlias {
    return self.async.firstAlias;
}

- (NSArray<Key *> *)keys {
    return self.async.keys;
}

- (NSArray<Alias *> *)aliases {
    return self.async.aliases;
}

- (void)useAccessToken:(NSString *)accessTokenId {
    [self.async useAccessToken:accessTokenId];
}

- (void)clearAccessToken {
    [self.async clearAccessToken];
}

- (void)approveKey:(Key *)key {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async approveKey:key
                     onSuccess:^{
                         call.onSuccess(nil);
                     }
                       onError:call.onError];
    }];
}

- (void)approveKeys:(NSArray<Key *> *)keys {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async approveKeys:keys
                      onSuccess:^{
                          call.onSuccess(nil);
                      }
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

- (void)removeKeys:(NSArray<NSString *> *)keyIds {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeKeys:keyIds
                     onSuccess:^{ call.onSuccess(nil); }
                       onError:call.onError];
    }];
}

- (NSString *)resendAliasVerification:(Alias *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async resendAliasVerification:alias
                                  onSuccess:call.onSuccess
                                    onError:call.onError];
    }];
}

- (NSArray<Alias *> *)getAliases {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAliases:call.onSuccess
                     onError:call.onError];
    }];
}

- (void)addAlias:(Alias *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async addAlias:alias
                   onSuccess:^{ call.onSuccess(nil); }
                     onError:call.onError];
    }];
}

- (void)addAliases:(NSArray<Alias *> *)aliases {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async addAliases:aliases
                       onSuccess:^{ call.onSuccess(nil); }
                         onError:call.onError];
    }];
}

- (void)removeAlias:(Alias *)alias {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeAlias:alias
                      onSuccess:^{ call.onSuccess(nil); }
                        onError:call.onError];
    }];
}

- (void)removeAliases:(NSArray<Alias *> *)aliases {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async removeAliases:aliases
                       onSuccess:^{ call.onSuccess(nil); }
                         onError:call.onError];
    }];
}

- (Subscriber *)subscribeToNotifications:(NSString *)handler
                     handlerInstructions:(NSMutableDictionary<NSString *,NSString *> *)handlerInstructions {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async subscribeToNotifications:handler
                         handlerInstructions:handlerInstructions
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

- (PagedArray<Notification *> *)getNotificationsOffset:(NSString *)offset
                                                 limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getNotificationsOffset:offset
                                     limit:limit
                                 onSuccess:call.onSuccess
                                   onError:call.onError];
    }];
}

- (Notification *)getNotification:(NSString *)NotificationId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getNotification:NotificationId
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

- (NSArray<TKAccountSync *> *)linkBank:(NSString *)bankId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async linkBank:bankId
                   onSuccess:^(NSArray<TKAccount *> *accounts) {
                       call.onSuccess([self _asyncToSync:accounts]);
                   }
                     onError:call.onError];
    }];
}

- (NSArray<TKAccountSync *> *)linkAccounts:(BankAuthorization *)bankAuthorization {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async linkAccounts:bankAuthorization
                       onSuccess:
         ^(NSArray<TKAccount *> *accounts) {
             call.onSuccess([self _asyncToSync:accounts]);
         }
                         onError:call.onError];
    }];
}

- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async unlinkAccounts:accountIds
                         onSuccess:^{ call.onSuccess(nil); }
                           onError:call.onError];
    }];
}

- (NSArray<TKAccountSync *> *)getAccounts {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
         getAccounts:
         ^(NSArray<TKAccount *> *accounts) {
             call.onSuccess([self _asyncToSync:accounts]);
         }
         onError:call.onError];
    }];
}

- (TKAccountSync *)getAccount:(NSString *)accountId {
    TKRpcSyncCall<TKAccountSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
         getAccount:accountId
         onSuccess:
         ^(TKAccount *account) {
             TKAccountSync* syncAccount = [TKAccountSync account:account];
             call.onSuccess(syncAccount);
         }
         onError:call.onError];
    }];
}

- (TKAccountSync *)getDefaultAccount {
    TKRpcSyncCall<TKAccountSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
         getDefaultAccount:^(TKAccount *account) {
             TKAccountSync* syncAccount = [TKAccountSync account:account];
             call.onSuccess(syncAccount);
         }
         onError:call.onError];
    }];
}

- (void)setDefaultAccount:(NSString *)accountId {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async setDefaultAccount:accountId
                            onSuccess:^{ call.onSuccess(nil); }
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

- (PagedArray<Transfer *> *)getTransfersOffset:(NSString *)offset
                                         limit:(int)limit {
    return [self getTransfersOffset:offset
                              limit:limit
                            tokenId:nil];
}

- (PagedArray<Transfer *> *)getTransfersOffset:(NSString *)offset
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

- (AddressRecord *)addAddress:(Address *)address
                     withName:(NSString *)name {
    TKRpcSyncCall<AddressRecord *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async addAddress:address
                      withName:name
                     onSuccess:call.onSuccess
                       onError:call.onError];
    }];
}

- (AddressRecord *)getAddressWithId:(NSString *)addressId {
    TKRpcSyncCall<AddressRecord *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAddressWithId:addressId
                           onSuccess:call.onSuccess
                             onError:call.onError];
    }];
}

- (NSArray<AddressRecord *> *)getAddresses {
    TKRpcSyncCall<NSArray<AddressRecord *> *> *call = [TKRpcSyncCall create];
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

- (TransferTokenBuilder *)createTransferToken:(double)amount
                                     currency:(NSString *)currency {
    return [self.async createTransferToken:amount currency:currency];
}

- (Token *)createAccessToken:(AccessTokenConfig *)accessTokenConfig {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createAccessToken:accessTokenConfig
                            onSuccess:call.onSuccess
                              onError:call.onError];
    }];
}

- (TokenOperationResult *)replaceAccessToken:(Token *)tokenToCancel
                           accessTokenConfig:(AccessTokenConfig *)accessTokenConfig {
    TKRpcSyncCall<TokenOperationResult *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async replaceAccessToken:tokenToCancel
                     accessTokenConfig:accessTokenConfig
                             onSuccess:call.onSuccess
                               onError:call.onError];
    }];
}

- (TokenOperationResult *)replaceAndEndorseAccessToken:(Token *)tokenToCancel
                                     accessTokenConfig:(AccessTokenConfig *)accessTokenConfig {
    TKRpcSyncCall<TokenOperationResult *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async replaceAndEndorseAccessToken:tokenToCancel
                               accessTokenConfig:accessTokenConfig
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

- (PagedArray<Token *> *)getTransferTokensOffset:(NSString *)offset
                                           limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransferTokensOffset:offset
                                      limit:limit
                                  onSuccess:call.onSuccess
                                    onError:call.onError];
    }];
}

- (PagedArray<Token *> *)getAccessTokensOffset:(NSString *)offset
                                         limit:(int)limit {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getAccessTokensOffset:offset
                                    limit:limit
                                onSuccess:call.onSuccess
                                  onError:call.onError];
    }];
}

- (TokenOperationResult *)endorseToken:(Token *)token withKey:(Key_Level)keyLevel {
    TKRpcSyncCall<TokenOperationResult *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async endorseToken:token
                         withKey:keyLevel
                       onSuccess:call.onSuccess
                         onError:call.onError];
    }];
}

- (TokenOperationResult *)cancelToken:(Token *)token {
    TKRpcSyncCall<TokenOperationResult *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async cancelToken:token
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (Transfer *)redeemToken:(Token *)token {
    return [self redeemToken:token
                         amount:nil
                       currency:nil
                    description:nil];
}

- (Transfer *)redeemToken:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency
                 description:(NSString *)description {
    TKRpcSyncCall<Transfer *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async redeemToken:token
                            amount:amount
                          currency:currency
                       description:description
                       destination:nil
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
}

- (Transfer *)redeemToken:(Token *)token
                      amount:(NSNumber *)amount
                    currency:(NSString *)currency
                 description:(NSString *)description
                 destination:(TransferEndpoint *)destination {
    TKRpcSyncCall<Transfer *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async redeemToken:token
                            amount:amount
                          currency:currency
                       description:description
                       destination:destination
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
}


- (Transaction *)getTransaction:(NSString *)transactionId
                     forAccount:(NSString *)accountId
                        withKey:(Key_Level)keyLevel {
    TKRpcSyncCall<Transaction *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransaction:transactionId
                        forAccount:accountId
                           withKey:keyLevel
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
}

- (PagedArray<Transaction *> *)getTransactionsOffset:(NSString *)offset
                                               limit:(int)limit
                                          forAccount:(NSString *)accountId
                                             withKey:(Key_Level)keyLevel {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTransactionsOffset:offset
                                    limit:limit
                               forAccount:accountId
                                  withKey:keyLevel
                                onSuccess:call.onSuccess
                                  onError:call.onError];
    }];
}

- (Attachment *)createBlob:(NSString *)ownerId
                  withType:(NSString *)type
                  withName:(NSString *)name
                  withData:(NSData * )data {
    TKRpcSyncCall<Attachment *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createBlob:ownerId
                      withType:type
                      withName:name
                      withData:data
                     onSuccess:call.onSuccess
                       onError:call.onError];
    }];
}

- (Blob *)getBlob:(NSString *)blobId {
    TKRpcSyncCall<Blob *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBlob:blobId
                  onSuccess:call.onSuccess
                    onError:call.onError];
    }];
}

- (Blob *)getTokenBlob:(NSString *)tokenId
            withBlobId:(NSString *)blobId {
    TKRpcSyncCall<Blob *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getTokenBlob:tokenId
                      withBlobId:blobId
                       onSuccess:call.onSuccess
                         onError:call.onError];
    }];
}

- (TKBalance *)getBalance:(NSString *)accountId
                  withKey:(Key_Level)keyLevel {
    TKRpcSyncCall<TKBalance *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBalance:accountId
                       withKey:keyLevel
                     onSuccess:call.onSuccess
                       onError:call.onError];
    }];
}

- (NSDictionary<NSString *,TKBalance *> *)getBalances:(NSArray<NSString *> *)accountIds
                              withKey:(Key_Level)keyLevel {
    TKRpcSyncCall<NSDictionary<NSString *,TKBalance *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBalances:accountIds
                        withKey:keyLevel
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
}

- (NSArray<Bank *> *)getBanks {
    TKRpcSyncCall<NSArray<Bank *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBanks:call.onSuccess
                     onError:call.onError];
    }];

}

- (BankInfo *)getBankInfo:(NSString *)bankId {
    TKRpcSyncCall<BankInfo *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBankInfo:bankId
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];

}

- (BankAuthorization *)createTestBankAccount:(Money *)balance {
    TKRpcSyncCall<BankAuthorization *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createTestBankAccount:balance
                                onSuccess:call.onSuccess
                                  onError:call.onError];
    }];
}

- (Profile *)getProfile:(NSString *)ownerId{
    TKRpcSyncCall<Profile *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getProfile:ownerId
                     onSuccess:call.onSuccess
                       onError:call.onError];
    }];
}

- (Profile *)setProfile:(Profile *)profile{
    TKRpcSyncCall<Profile *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async setProfile:profile
                     onSuccess:call.onSuccess
                       onError:call.onError];
    }];
}

- (Blob *)getProfilePicture:(NSString *)ownerId
                       size:(ProfilePictureSize) size {
    TKRpcSyncCall<Blob *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getProfilePicture:ownerId
                                 size:size
                            onSuccess:call.onSuccess
                              onError:call.onError];
    }];
}

- (void)setProfilePicture:(NSString *)ownerId
                 withType:(NSString *)type
                 withName:(NSString *)name
                 withData:(NSData *)data {
    TKRpcSyncCall<id> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async setProfilePicture:ownerId
                             withType:type
                             withName:name
                             withData:data
                            onSuccess:^{ call.onSuccess(nil); }
                              onError:call.onError];
         
    }];
}

- (NSArray<Device *> *)getPairedDevices {
    TKRpcSyncCall<NSArray<Device *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getPairedDevices:call.onSuccess
                             onError:call.onError];
    }];
}

- (NotifyStatus)triggerStepUpNotification:(NSString *)tokenId {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    
    NSNumber *statusNumber = [call run:^{
        [self.async triggerStepUpNotification:tokenId
                                    onSuccess:^(NotifyStatus status){
                                        call.onSuccess([NSNumber numberWithInt:status]);
                                    }
                                      onError:call.onError];
    }];
    
    return [statusNumber intValue];
}
    
- (NotifyStatus)triggerBalanceStepUpNotification:(NSArray<NSString *> *)accountIds {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    
    NSNumber *statusNumber = [call run:^{
        [self.async triggerBalanceStepUpNotification:accountIds
                                           onSuccess:^(NotifyStatus status){
                                               call.onSuccess([NSNumber numberWithInt:status]);
                                           }
                                             onError:call.onError];
    }];
    
    return [statusNumber intValue];
}

- (NotifyStatus)triggerTransactionStepUpNotification:(NSString *)transactionId
                                           accountID:(NSString *)accountId {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    
    NSNumber *statusNumber = [call run:^{
        [self.async triggerTransactionStepUpNotification:transactionId
                                               accountID:accountId
                                               onSuccess:^(NotifyStatus status){
                                                   call.onSuccess([NSNumber numberWithInt:status]);
                                               }
                                                 onError:call.onError];
    }];
    
    return [statusNumber intValue];
}

#pragma mark private

- (NSArray<TKAccountSync *> *)_asyncToSync:(NSArray<TKAccount *> *)asyncAccounts {
    NSMutableArray<TKAccountSync *> *syncAccounts = [NSMutableArray array];
    for (TKAccount *asyncAccount in asyncAccounts) {
        TKAccountSync* syncAccount = [TKAccountSync account:asyncAccount];
        [syncAccounts addObject:syncAccount];
    }
    return syncAccounts;
}

@end
