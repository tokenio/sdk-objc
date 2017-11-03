//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>

#import "gateway/Gateway.pbrpc.h"

#import "Transferinstructions.pbobjc.h"
#import "TKAccountSync.h"
#import "TKHasher.h"
#import "TKMemberSync.h"
#import "TKMember.h"
#import "TKClient.h"


@implementation TKMember {
    TKClient *client;
    Member *member;
    NSMutableArray<Alias *> *aliases;
}

+ (TKMember *)member:(Member *)member
           useClient:(TKClient *)client
             aliases:(NSMutableArray<Alias *> *) aliases_ {
    return [[TKMember alloc] initWithMember:member
                                  useClient:client
                                    aliases:aliases_];
}

- (id)initWithMember:(Member *)member_
           useClient:(TKClient *)client_
             aliases:(NSMutableArray<Alias *> *) aliases_ {
    self = [super init];
    
    if (self) {
        member = member_;
        client = client_;
        aliases = aliases_;
    }
    
    return self;
}

- (NSString *)id {
    return member.id_p;
}

- (TKClient *)getClient {
    NSLog(@"%@", client);
    return client;
}

- (Alias *)firstAlias {
    return aliases.count > 0 ? aliases[0] : nil;
}

- (NSArray<Key *> *)keys {
    NSMutableArray<Key *> *result = [NSMutableArray array];
    for (Key *key in member.keysArray) {
        [result addObject:key];
    }
    return result;
}

- (NSArray<Alias *> *)aliases {
    return [NSArray arrayWithArray:aliases];
}

- (void)useAccessToken:(NSString *)accessTokenId {
    [client useAccessToken:accessTokenId];
}

- (void)clearAccessToken {
    [client clearAccessToken];
}

- (void)approveKey:(Key *)key
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError {
    [self approveKeys:@[key]
            onSuccess:onSuccess
            onError:onError];
}

- (void)approveKeys:(NSArray<Key *> *)keys
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray<MemberOperation *> *addKeys = [NSMutableArray array];
    for (Key *key in keys) {
        MemberOperation *addKey = [MemberOperation message];
        addKey.addKey.key = key;
        [addKeys addObject:addKey];
    }
    [client updateMember:retainedMember
              operations:[addKeys copy]
               onSuccess:
                       ^(Member *m) {
                           [retainedMember clear];
                           [retainedMember mergeFrom:m];
                           onSuccess();
                       }
                 onError:onError];
}

- (void)removeKey:(NSString *)keyId
        onSuccess:(OnSuccess)onSuccess
          onError:(OnError)onError {
    [self removeKeys:@[keyId]
           onSuccess:onSuccess
             onError:onError];
}

- (void)removeKeys:(NSArray<NSString *> *)keyIds
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray<MemberOperation *> *removeKeys = [NSMutableArray array];
    for (NSString *keyId in keyIds) {
        MemberOperation *removeKey = [MemberOperation message];
        removeKey.removeKey.keyId = keyId;
        [removeKeys addObject:removeKey];
    }
    [client updateMember:retainedMember
              operations:[removeKeys copy]
               onSuccess:^(Member *m) {
                   [retainedMember clear];
                   [retainedMember mergeFrom:m];
                   onSuccess();
               }
                 onError:onError];
}

- (void)resendAliasVerification:(Alias *)alias
                      onSuccess:(OnSuccessWithString)onSuccess
                        onError:(OnError)onError {
    [client resendAliasVerification:self.id
                              alias:alias
                          onSuccess:onSuccess
                            onError:onError];
}

- (void)getAliases:(OnSuccessWithAliases)onSuccess
           onError:(OnError)onError {
    [client getAliases:^(NSArray<Alias *> *aliasArray) {
        aliases = [NSMutableArray arrayWithArray: aliasArray];
        onSuccess(aliasArray);
    }
               onError:onError];
}

- (void)addAlias:(Alias *)alias
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError {
    [self addAliases:@[alias]
           onSuccess:onSuccess
             onError:onError];
}

- (void)addAliases:(NSArray<Alias *> *)toAddAliases
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray<MemberOperation *> *addAliasOps = [NSMutableArray array];
    NSMutableArray<MemberOperationMetadata *> *metadataArray = [NSMutableArray array];
    for (Alias *alias in toAddAliases) {
        MemberOperation *addAlias = [MemberOperation message];
        addAlias.addAlias.aliasHash = [TKHasher hashAlias:alias];
        [addAliasOps addObject:addAlias];
        
        MemberOperationMetadata *metadata = [MemberOperationMetadata message];
        metadata.addAliasMetadata.alias = alias;
        metadata.addAliasMetadata.aliasHash = [TKHasher hashAlias:alias];
        [metadataArray addObject:metadata];
    }
    [client updateMember:retainedMember
              operations:[addAliasOps copy]
           metadataArray:metadataArray
               onSuccess:^(Member *m) {
                   [aliases addObjectsFromArray:toAddAliases];
                   [retainedMember clear];
                   [retainedMember mergeFrom:m];
                   onSuccess();
               }
                 onError:onError];
}

- (void)removeAlias:(Alias *)alias
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError {
    [self removeAliases:@[alias]
                onSuccess:onSuccess
                  onError:onError];
}

- (void)removeAliases:(NSArray<Alias *> *)toRemoveAliases
            onSuccess:(OnSuccess)onSuccess
              onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray *removeAliasOps = [NSMutableArray array];
    for (Alias *alias in toRemoveAliases) {
        MemberOperation *removeAlias = [MemberOperation message];
        removeAlias.removeAlias.aliasHash = [TKHasher hashAlias:alias];
        [removeAliasOps addObject:removeAlias];
    }
    [client updateMember:retainedMember
              operations:[removeAliasOps copy]
               onSuccess:^(Member *m) {
                   [aliases removeObjectsInArray:toRemoveAliases];
                   [retainedMember clear];
                   [retainedMember mergeFrom:m];
                   onSuccess();
               }
                 onError:onError];
}

- (void)subscribeToNotifications:(NSString *)handler
             handlerInstructions:(NSMutableDictionary<NSString *,NSString *> *)handlerInstructions
                       onSuccess:(OnSuccessWithSubscriber)onSuccess
                         onError:(OnError)onError {
    [client subscribeToNotifications:handler
                 handlerInstructions:handlerInstructions
                           onSuccess:onSuccess
                             onError:onError];
}

- (void)getSubscribers:(OnSuccessWithSubscribers)onSuccess
               onError:(OnError)onError {
    [client getSubscribers:onSuccess
                   onError:onError];
}

- (void)getSubscriber:(NSString *)subscriberId
            onSuccess:(OnSuccessWithSubscriber)onSuccess
              onError:(OnError)onError {
    [client getSubscriber:subscriberId
                onSuccess:onSuccess
                  onError:onError];
}

- (void)getNotificationsOffset:(NSString *)offset
                         limit:(int)limit
                     onSuccess:(OnSuccessWithNotifications)onSuccess
                       onError:(OnError)onError {
    [client getNotifications:offset
                       limit:limit
                   onSuccess:onSuccess
                     onError:onError];
}

- (void)getNotification:(NSString *)notificationId
              onSuccess:(OnSuccessWithNotification)onSuccess
                onError:(OnError)onError {
    [client getNotification:notificationId
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)unsubscribeFromNotifications:(NSString *)subscriberId
                           onSuccess:(OnSuccess)onSuccess
                             onError:(OnError)onError {
    [client unsubscribeFromNotifications:subscriberId
                               onSuccess:onSuccess
                                 onError:onError];
}


- (void)linkAccounts:(BankAuthorization *)bankAuthorization
           onSuccess:(OnSuccessWithTKAccounts)onSuccess
             onError:(OnError)onError {
    [client linkAccounts:bankAuthorization
               onSuccess:^(NSArray<Account *> *accounts) {
                   onSuccess([self _mapAccounts:accounts]);
               }
                 onError:onError];
}

- (void)unlinkAccounts:(NSArray<NSString *> *)accountIds
             onSuccess:(OnSuccess)onSuccess
               onError:(OnError)onError {
    [client unlinkAccounts:accountIds
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)getAccounts:(OnSuccessWithTKAccounts)onSuccess
            onError:(OnError)onError {
    [client getAccounts:^(NSArray<Account *> *accounts) {
        onSuccess([self _mapAccounts:accounts]);
    }
                onError:onError];
}

- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccount)onSuccess
           onError:(OnError)onError {
    [client getAccount:accountId
             onSuccess:^(Account * account) {
                 onSuccess([self _mapAccount:account]);
             }
               onError:onError];
}

- (void)getDefaultAccount:(OnSuccessWithTKAccount)onSuccess
                  onError:(OnError)onError {
    [client getDefaultAccount:member.id_p
                    onSuccess:^(Account * account) {
                        onSuccess([self _mapAccount:account]);
                    }
                      onError:onError];
}

- (void)setDefaultAccount:(NSString *)accountId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    [client setDefaultAccount:accountId
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)getTransfer:(NSString *)transferId
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError {
    [client getTransfer:transferId
              onSuccess:onSuccess
                onError:onError];
}

- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError {
    [self getTransfersOffset:offset
                       limit:limit
                     tokenId:nil
                   onSuccess:onSuccess
                     onError:onError];
}

- (void)getTransfersOffset:(NSString *)offset
                     limit:(int)limit
                   tokenId:(NSString *)tokenId
                 onSuccess:(OnSuccessWithTransfers)onSuccess
                   onError:(OnError)onError {
    [client getTransfersOffset:offset
                         limit:limit
                       tokenId:tokenId
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)addAddress:(Address *)address
          withName:(NSString *)name
         onSuccess:(OnSuccessWithAddress)onSuccess
           onError:(OnError)onError {
    [client addAddress:address
              withName:name
             onSuccess:onSuccess
               onError:onError];
}

- (void)getAddressWithId:(NSString *)addressId
               onSuccess:(OnSuccessWithAddress)onSuccess
                 onError:(OnError)onError {
    [client getAddressById:addressId
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError {
    [client getAddresses:onSuccess
                 onError:onError];
}

- (void)deleteAddressWithId:(NSString *)addressId
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError {
    [client deleteAddressById:addressId
                    onSuccess:onSuccess
                      onError:onError];
}

- (TransferTokenBuilder *)createTransferToken:(double)amount
                                     currency:(NSString *)currency {
    TransferTokenBuilder * builder = [TransferTokenBuilder alloc];
    return [builder init:self lifetimeAmount:amount currency:currency];
}

- (void)createAccessToken:(AccessTokenConfig *)accessTokenConfig
                onSuccess:(OnSuccessWithToken)onSuccess
                  onError:(OnError)onError {
    [accessTokenConfig from:self.id];
    [client createAccessToken:[accessTokenConfig toTokenPayload]
                    onSuccess:^(Token *token) { onSuccess(token); }
                      onError:onError];
}

- (void)replaceAccessToken:(Token *)tokenToCancel
         accessTokenConfig:(AccessTokenConfig *)accessTokenConfig
                 onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                   onError:(OnError)onError {
    [accessTokenConfig from:self.id];
    [client replaceToken:tokenToCancel
           tokenToCreate:[accessTokenConfig toTokenPayload]
               onSuccess:onSuccess
                 onError:onError];
}

- (void)replaceAndEndorseAccessToken:(Token *)tokenToCancel
                   accessTokenConfig:(AccessTokenConfig *)accessTokenConfig
                           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
                             onError:(OnError)onError {
    [accessTokenConfig from:self.id];
    [client replaceAndEndorseToken:tokenToCancel
                     tokenToCreate:[accessTokenConfig toTokenPayload]
                         onSuccess:onSuccess
                           onError:onError];
}

- (void)getToken:(NSString *)tokenId
       onSuccess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError {
    [client getToken:tokenId
           onSuccess:onSuccess
             onError:onError];
}

- (void)getTransferTokensOffset:(NSString *)offset
                          limit:(int)limit
                      onSuccess:(OnSuccessWithTokens)onSuccess
                        onError:(OnError)onError {
    [client getTokensOfType:GetTokensRequest_Type_Transfer
                     offset:offset
                      limit:limit
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)getAccessTokensOffset:(NSString *)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTokens)onSuccess
                      onError:(OnError)onError {
    [client getTokensOfType:GetTokensRequest_Type_Access
                     offset:offset
                      limit:limit
                  onSuccess:onSuccess
                    onError:onError];
}

- (void)endorseToken:(Token *)token
             withKey:(Key_Level)keyLevel
           onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
             onError:(OnError)onError {
    [client endorseToken:token
                 withKey:keyLevel
               onSuccess:onSuccess
                 onError:onError];
}

- (void)cancelToken:(Token *)token
          onSuccess:(OnSuccessWithTokenOperationResult)onSuccess
            onError:(OnError)onError {
    [client cancelToken:token
              onSuccess:onSuccess
                onError:onError];
}

- (void)redeemToken:(Token *)token
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError {
    [self redeemToken:token
               amount:nil
             currency:nil
          description:nil
          destination:nil
            onSuccess:onSuccess
              onError:onError];
}

- (void)redeemToken:(Token *)token
             amount:(NSNumber *)amount
           currency:(NSString *)currency
        description:(NSString *)description
        destination:(TransferEndpoint *)destination
          onSuccess:(OnSuccessWithTransfer)onSuccess
            onError:(OnError)onError {
    TransferPayload *payload = [TransferPayload message];
    payload.tokenId = token.id_p;
    payload.refId = [TKUtil nonce];
    
    if (amount) {
        payload.amount.value = [amount stringValue];
    }
    if (currency) {
        payload.amount.currency = currency;
    }
    if (description) {
        payload.description_p = description;
    }
    if (destination) {
        [payload.destinationsArray addObject:destination];
    }
    
    [client redeemToken:payload
              onSuccess:onSuccess
                onError:onError];
}

- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    [client getTransaction:transactionId
                forAccount:accountId
                 onSuccess:onSuccess
                   onError:onError];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
   [client getTransactionsOffset:offset
                           limit:limit
                      forAccount:accountId
                       onSuccess:onSuccess
                         onError:onError];
}

- (void)createBlob:(NSString *)ownerId
          withType:(NSString *)type
          withName:(NSString *)name
          withData:(NSData * )data
         onSuccess:(OnSuccessWithAttachment)onSuccess
           onError:(OnError)onError {
    [client createBlob:ownerId
              withType:type
              withName:name
              withData:data
             onSuccess:onSuccess
               onError:onError];
}

- (void)getBlob:(NSString *)blobId
      onSuccess:(OnSuccessWithBlob)onSuccess
        onError:(OnError)onError {
    [client getBlob:blobId
          onSuccess:onSuccess
            onError:onError];
}

- (void)getTokenBlob:(NSString *)tokenId
          withBlobId:(NSString *)blobId
           onSuccess:(OnSuccessWithBlob)onSuccess
             onError:(OnError)onError {
    [client getTokenBlob:tokenId
              withBlobId:blobId
               onSuccess:onSuccess
                 onError:onError];
}

- (void)getBalance:(NSString *)accountId
         onSuccess:(OnSuccessWithGetBalanceResponse)onSuccess
           onError:(OnError)onError {
    [client getBalance:accountId
             onSuccess:onSuccess
               onError:onError];
}

- (void)getBanks:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    [client getBanks:onSuccess
             onError:onError];
}

- (void)getBankInfo:(NSString *)bankId
          onSuccess:(OnSuccessWithBankInfo)onSuccess
            onError:(OnError)onError {
    [client getBankInfo:bankId
              onSuccess:onSuccess
                onError:onError];
}

- (void)createTestBankAccount:(Money *)balance
                    onSuccess:(OnSuccessWithBankAuthorization)onSuccess
                      onError:(OnError)onError {
    [client createTestBankAccount:balance
                        onSuccess:onSuccess
                          onError:onError];
}

- (void)getProfile:(NSString *)ownerId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError {
    [client getProfile:ownerId
             onSuccess:onSuccess
               onError:onError];
}

- (void)setProfile:(Profile *)profile
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError {
    [client setProfile:profile
             onSuccess:onSuccess
               onError:onError];
}

- (void)getProfilePicture:(NSString *)ownerId
                     size:(ProfilePictureSize)size
                onSuccess:(OnSuccessWithBlob)onSuccess
                  onError:(OnError)onError {
    [client getProfilePicture:ownerId
                         size:size
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)setProfilePicture:(NSString *)ownerId
                 withType:(NSString *)type
                 withName:(NSString *)name
                 withData:(NSData *)data
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    [client setProfilePicture:ownerId
                     withType:type
                     withName:name
                     withData:data
                    onSuccess:onSuccess
                      onError:onError];
}
#pragma mark private

- (NSArray<TKAccount *> *)_mapAccounts:(NSArray<Account *> *)accounts {
    NSMutableArray<TKAccount *> *result = [NSMutableArray array];
    for (Account *a in accounts) {
        TKAccount *tkAccount = [self _mapAccount:a];
        [result addObject:tkAccount];
    }
    return result;
}

- (TKAccount *)_mapAccount:(Account *)account {
    TKMemberSync *memberSync = [TKMemberSync member:self];
    return [TKAccount account:account of:memberSync useClient:client];
}

@end
