//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>
#import "gateway/Gateway.pbrpc.h"

#import "TKAccountSync.h"
#import "TKAuthorizationEngine.h"
#import "TKClient.h"
#import "TKError.h"
#import "TKHasher.h"
#import "TKLocalizer.h"
#import "TKMember.h"
#import "TKMemberSync.h"
#import "TKOauthEngine.h"
#import "Transferinstructions.pbobjc.h"

@implementation TKMember {
    TokenCluster *tokenCluster;
    TKClient *client;
    Member *member;
    NSMutableArray<Alias *> *aliases;
}

+ (TKMember *)member:(Member *)member
        tokenCluster:(TokenCluster *)tokenCluster
           useClient:(TKClient *)client
   useBrowserFactory:(TKBrowserFactory)browserFactory_
             aliases:(NSMutableArray<Alias *> *) aliases_ {
    return [[TKMember alloc] initWithMember:member
                               tokenCluster:tokenCluster
                                  useClient:client
                          useBrowserFactory:browserFactory_
                                    aliases:aliases_];
}

- (id)initWithMember:(Member *)member_
        tokenCluster:(TokenCluster *)tokenCluster_
           useClient:(TKClient *)client_
   useBrowserFactory:(TKBrowserFactory)browserFactory_
             aliases:(NSMutableArray<Alias *> *) aliases_ {
    self = [super init];
    
    if (self) {
        tokenCluster = tokenCluster_;
        member = member_;
        client = client_;
        aliases = aliases_;
        _browserFactory = browserFactory_;
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

- (NSArray<Alias *> *)aliases {
    return [NSArray arrayWithArray:aliases];
}


- (void)useAccessToken:(NSString *)accessTokenId {
    [client useAccessToken:accessTokenId];
}

- (void)clearAccessToken {
    [client clearAccessToken];
}

- (void)getKeys:(OnSuccessWithKeys)onSuccess
        onError:(OnError)onError {
    [client getMember:self.id
            onSuccess:^(Member * _Nonnull m) {
                [self->member clear];
                [self->member mergeFrom:m];
                onSuccess(self->member.keysArray);
            } onError:onError];
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

- (void)removeNonStoredKeys:(OnSuccess)onSuccess
                    onError:(OnError)onError {
    NSString *reason = TKLocalizedString(@"Signature_Reason_UpdateMember",
                                         @"Authorise your Token account change");

    NSArray<Key *> *storedKeys = [[client getCrypto] getKeyInfos:reason onError:onError];
    if (!storedKeys) {
        return;
    }
    
    NSMutableSet<NSString *> *(^block)(NSArray<Key *> *) = ^(NSArray<Key *> * keys) {
        NSMutableSet<NSString *> *keyIds = [NSMutableSet setWithCapacity:keys.count];
        [keys enumerateObjectsUsingBlock:^(Key *key, NSUInteger idx, BOOL *stop) {
            [keyIds addObject:key.id_p];
        }];
        return keyIds;
    };
    
    NSMutableSet<NSString *> * storedKeyIds = block(storedKeys);
    
    __weak typeof(TKMember *) weakSelf = self;
    [client getMember:self.id
            onSuccess:^(Member * _Nonnull member) {
                NSMutableSet<NSString *> *keyIds = block([member keysArray]);
                [keyIds minusSet:storedKeyIds];
                if ([keyIds count] == 0) {
                    onSuccess();
                }
                else {
                    [weakSelf removeKeys:[keyIds allObjects] onSuccess:onSuccess onError:onError];
                }
                
            } onError:onError];
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
        self->aliases = [NSMutableArray arrayWithArray: aliasArray];
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
        NSString *partnerId = retainedMember.partnerId;
        if ([partnerId length] != 0) {
            // Realm must equal member's partner ID if affiliated
            if ([alias.realm length] != 0 && ![alias.realm isEqualToString:partnerId]) {
                onError([NSError
                         errorFromErrorCode:kTKErrorInvalidRealm
                         details:@"Alias realm must equal the affiliated partnerId"]);
                return;
            }
            alias.realm = partnerId;
        }

        MemberOperation *addAlias = [MemberOperation message];
        addAlias.addAlias.aliasHash = [TKHasher hashAlias:alias];
        addAlias.addAlias.realm = alias.realm;
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
                   [self->aliases addObjectsFromArray:toAddAliases];
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
                   [self->aliases removeObjectsInArray:toRemoveAliases];
                   [retainedMember clear];
                   [retainedMember mergeFrom:m];
                   onSuccess();
               }
                 onError:onError];
}

- (void)deleteMember:(OnSuccess)onSuccess
             onError:(OnError)onError {
    [client deleteMember:member onSuccess:onSuccess onError:onError];
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

- (void)initiateAccountLinking:(NSString *)bankId
                     onSuccess:(OnSuccessWithTKAccounts)onSuccess
                       onError:(OnError)onError {
    [client getBankInfo:bankId
              onSuccess:^(BankInfo *info) {
                  // The authorization engine will be revoked after the accounts are linked.
                  TKOauthEngine *authEngine =
                  [[TKOauthEngine alloc] initWithTokenCluster:self->tokenCluster
                                               BrowserFactory:self.browserFactory
                                                          url:info.bankLinkingUri];
                
                  [authEngine
                   authorizeOnSuccess:^(NSString *accessToken) {
                       [self->client linkAccounts:bankId
                                      accessToken:accessToken
                                        onSuccess:^(NSArray<Account *> *accounts) {
                                            onSuccess([self _mapAccounts:accounts]);
                                            [authEngine close];
                                        } onError:^(NSError *error) {
                                            onError(error);
                                            [authEngine close];
                                        }];
                   } onError:^(NSError *error) {
                       onError(error);
                       [authEngine close];
                   }];
              }
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

- (TransferTokenBuilder *)createTransferToken:(NSDecimalNumber *)amount
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

- (void)getActiveAccessToken:(NSString *)toMemberId
       onSuccess:(OnSuccessWithToken)onSuccess
         onError:(OnError)onError {
    [client getActiveAccessToken:toMemberId
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
             amount:(NSDecimalNumber *)amount
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
               withKey:(Key_Level)keyLevel
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError {
    [client
     getTransaction:transactionId
     forAccount:accountId
     withKey:keyLevel
     onSuccess:onSuccess
     onError:^(NSError *error){
         if ([error.domain isEqualToString:kTokenRequestErrorDomain]
             && error.code == RequestStatus_MoreSignaturesNeeded
             && keyLevel == Key_Level_Low) {
             // Request again with Key_Level_Standard if more signatures are needed
             [self->client
              getTransaction:transactionId
              forAccount:accountId
              withKey:Key_Level_Standard
              onSuccess:onSuccess
              onError:onError];
         }
         else {
             onError(error);
         }
     }];
}

- (void)getTransactionsOffset:(NSString *)offset
                        limit:(int)limit
                   forAccount:(NSString *)accountId
                      withKey:(Key_Level)keyLevel
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError {
   [client
    getTransactionsOffset:offset
    limit:limit
    forAccount:accountId
    withKey:keyLevel
    onSuccess:onSuccess
    onError:^(NSError *error){
        if ([error.domain isEqualToString:kTokenRequestErrorDomain]
            && error.code == RequestStatus_MoreSignaturesNeeded
            && keyLevel == Key_Level_Low) {
            // Request again with Key_Level_Standard if more signatures are needed
            [self->client
             getTransactionsOffset:offset
             limit:limit
             forAccount:accountId
             withKey:Key_Level_Standard
             onSuccess:onSuccess
             onError:onError];
        }
        else {
            onError(error);
        }
    }];
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
           withKey:(Key_Level)keyLevel
         onSuccess:(OnSuccessWithTKBalance)onSuccess
           onError:(OnError)onError {
    [client
     getBalance:accountId
     withKey:keyLevel
     onSuccess:onSuccess
     onError:^(NSError *error){
         if ([error.domain isEqualToString:kTokenRequestErrorDomain]
             && error.code == RequestStatus_MoreSignaturesNeeded
             && keyLevel == Key_Level_Low) {
             // Request again with Key_Level_Standard if more signatures are needed
             [self->client
              getBalance:accountId
              withKey:Key_Level_Standard
              onSuccess:onSuccess
              onError:onError];
         }
         else {
             onError(error);
         }
     }];
}

- (void)getBalances:(NSArray<NSString *> *)accountIds
            withKey:(Key_Level)keyLevel
          onSuccess:(OnSuccessWithTKBalances)onSuccess
            onError:(OnError)onError {
    [client
     getBalances:accountIds
     withKey:keyLevel
     onSuccess:onSuccess
     onError:^(NSError *error){
         if ([error.domain isEqualToString:kTokenRequestErrorDomain]
             && error.code == RequestStatus_MoreSignaturesNeeded
             && keyLevel == Key_Level_Low) {
             // Request again with Key_Level_Standard if more signatures are needed
             [self->client
              getBalances:accountIds
              withKey:Key_Level_Standard
              onSuccess:onSuccess
              onError:onError];
         }
         else {
             onError(error);
         }
     }];
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

- (void)getPairedDevices:(OnSuccessWithPairedDevices)onSuccess
                 onError:(OnError)onError {
    [client getPairedDevices:onSuccess
                     onError:onError];
}

- (void)triggerStepUpNotification:(NSString *)tokenId
                        onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                          onError:(OnError)onError {
    [client triggerStepUpNotification:tokenId
                            onSuccess:onSuccess
                              onError:onError];
}


- (void)triggerBalanceStepUpNotification:(NSArray<NSString *> *)accountIds
                                   onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                 onError:(OnError)onError {
    [client triggerBalanceStepUpNotification:accountIds
                                   onSuccess:onSuccess
                                     onError:onError];
}

- (void)triggerTransactionStepUpNotification:(NSString *)transactionId
                                   accountID:(NSString *)accountId
                                   onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                                     onError:(OnError)onError {
    [client triggerTransactionStepUpNotification:transactionId
                                       accountID:accountId
                                       onSuccess:onSuccess
                                         onError:onError];
}

- (void)ApplySca:(NSArray<NSString *> *)accountIds
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError {
    [client ApplySca:accountIds
           onSuccess:onSuccess
             onError:onError];
}

- (void)signTokenRequestState:(NSString *)tokenRequestId
                      tokenId:(NSString *)tokenId
                        state:(NSString *)state
                    onSuccess:(OnSuccessWithSignature)onSuccess
                      onError:(OnError)onError {
    [client signTokenRequestState:tokenRequestId
                          tokenId:tokenId
                            state:state
                        onSuccess:onSuccess
                          onError:onError];
}

- (void)storeTokenRequest:(TokenPayload *)tokenPayload
                  options:(NSDictionary<NSString*, NSString*> *)options
                onSuccess:(OnSuccessWithString)onSuccess
                  onError:(OnError)onError {
    [client storeTokenRequest:tokenPayload
                      options:options
                    onSuccess:onSuccess
                      onError:onError];
}

- (void)setReceiptContact:(ReceiptContact *)receiptContact
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError {
    [client setReceiptContact:receiptContact onSuccess:onSuccess onError:onError];
}

- (void)getReceiptContact:(OnSuccessWithReceiptContact)onSuccess
                  onError:(OnError)onError {
    [client getReceiptContact:onSuccess onError:onError];
}

- (void)addTrustedBeneficiary:(NSString *)memberId
                    onSuccess:(OnSuccess)onSuccess
                      onError:(OnError)onError {
    TrustedBeneficiary_Payload *payload = [TrustedBeneficiary_Payload message];
    payload.memberId = memberId;
    payload.nonce = [TKUtil nonce];
    [client addTrustedBeneficiary:payload onSuccess:onSuccess onError:onError];
}

- (void)removeTrustedBeneficiary:(NSString *)memberId
                       onSuccess:(OnSuccess)onSuccess
                         onError:(OnError)onError {
    TrustedBeneficiary_Payload *payload = [TrustedBeneficiary_Payload message];
    payload.memberId = memberId;
    payload.nonce = [TKUtil nonce];
    [client removeTrustedBeneficiary:payload onSuccess:onSuccess onError:onError];
}

- (void)getTrustedBeneficiaries:(OnSuccessWithTrustedBeneficiaries)onSuccess
                        onError:(OnError)onError {
    [client getTrustedBeneficiaries:onSuccess onError:onError];
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
