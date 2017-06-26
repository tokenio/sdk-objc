//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>

#import "gateway/Gateway.pbrpc.h"

#import "Transferinstructions.pbobjc.h"
#import "TKAccount.h"
#import "TKMember.h"
#import "TKMemberAsync.h"
#import "TKClient.h"


@implementation TKMemberAsync {
    TKClient *client;
    Member *member;
}

+ (TKMemberAsync *)member:(Member *)member
                useClient:(TKClient *)client {
    return [[TKMemberAsync alloc] initWithMember:member useClient:client];
}

- (id)initWithMember:(Member *)member_
           useClient:(TKClient *)client_ {
    self = [super init];
    
    if (self) {
        member = member_;
        client = client_;
    }
    
    return self;
}

- (TKMember *)sync {
    return [TKMember member:self];
}

- (NSString *)id {
    return member.id_p;
}

- (TKClient *)getClient {
    NSLog(@"%@", client);
    return client;
}

- (NSString *)firstUsername {
    return member.usernamesArray[0];
}

- (NSArray<NSString *> *)keys {
    NSMutableArray<NSString *> *result = [NSMutableArray array];
    for (Key *key in member.keysArray) {
        [result addObject:key];
    }
    return result;
}

- (NSArray<NSString *> *)usernames {
    return [member.usernamesArray copy];
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
               onSuccess:
                       ^(Member *m) {
                           [retainedMember clear];
                           [retainedMember mergeFrom:m];
                           onSuccess();
                       }
                 onError:onError];
}

- (void)addUsername:(NSString *)username
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError {
    [self addUsernames:@[username]
             onSuccess:onSuccess
               onError:onError];
}

- (void)addUsernames:(NSArray<NSString *> *)usernames
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray<MemberOperation *> *addUsernames = [NSMutableArray array];
    for (NSString *username in usernames) {
        MemberOperation *addUsername = [MemberOperation message];
        addUsername.addUsername.username = username;
        [addUsernames addObject:addUsername];
    }
    [client updateMember:retainedMember
              operations:[addUsernames copy]
               onSuccess:
                       ^(Member *m) {
                           [retainedMember clear];
                           [retainedMember mergeFrom:m];
                           onSuccess();
                       }
                 onError:onError];
}

- (void)removeUsername:(NSString *)username
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError {
    [self removeUsernames:@[username]
                onSuccess:onSuccess
                  onError:onError];
}

- (void)removeUsernames:(NSArray<NSString *> *)usernames
              onSuccess:(OnSuccess)onSuccess
                onError:(OnError)onError {
    __strong typeof(member) retainedMember = member;

    NSMutableArray *removeUsernames = [NSMutableArray array];
    for (NSString *username in usernames) {
        MemberOperation *removeUsername = [MemberOperation message];
        removeUsername.removeUsername.username = username;
        [removeUsernames addObject:removeUsername];
    }
    [client updateMember:retainedMember
              operations:[removeUsernames copy]
               onSuccess:
                       ^(Member *m) {
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
           onSuccess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError {
    [client linkAccounts:bankAuthorization
               onSuccess:
     ^(NSArray<Account *> *accounts) {
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

- (void)getAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
            onError:(OnError)onError {
    [client getAccounts:
     ^(NSArray<Account *> *accounts) {
         onSuccess([self _mapAccounts:accounts]);
     }
                onError:onError];
}

- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccountAsync)onSuccess
           onError:(OnError)onError {
    [client getAccount:accountId
             onSuccess:^(Account * account) {
                 onSuccess([self _mapAccount:account]);
             }
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
             onSuccess:(OnSuccessWithMoney)onSuccess
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

- (void)getProfile:(NSString *)targetMemberId
         onSuccess:(OnSuccessWithProfile)onSuccess
           onError:(OnError)onError {
    [client getProfile:targetMemberId
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

- (void)getProfilePicture:(NSString *)targetMemberId
                     size:(ProfilePictureSize)size
                onSuccess:(OnSuccessWithBlob)onSuccess
                  onError:(OnError)onError {
    [client getProfilePicture:targetMemberId
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

- (NSArray<TKAccountAsync *> *)_mapAccounts:(NSArray<Account *> *)accounts {
    NSMutableArray<TKAccountAsync *> *result = [NSMutableArray array];
    for (Account *a in accounts) {
        TKAccountAsync *tkAccount = [TKAccountAsync account:a of:self.sync useClient:client];
        [result addObject:tkAccount];
    }
    return result;
}

- (TKAccountAsync *)_mapAccount:(Account *)account {
    return [TKAccountAsync account:account of:self.sync useClient:client];
}

@end
