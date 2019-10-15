//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+ChannelCredentials.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"

#import "DeviceInfo.h"
#import "NotifyResult.h"
#import "TKClient.h"
#import "TKHasher.h"
#import "TKLocalizer.h"
#import "TKMember.h"
#import "TKRpcErrorHandler.h"
#import "TKUnauthenticatedClient.h"
#import "TokenClient.h"
#import "TokenClientBuilder.h"

@implementation TokenClient {
    TokenCluster *tokenCluster;
    GatewayService *gateway;
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    int timeoutMs;
    NSString *developerKey;
    NSString *languageCode;
    TKRpcErrorHandler *errorHandler;
    TKUnauthenticatedClient *unauthenticatedClient;
    TKBrowserFactory browserFactory;
}

+ (TokenClientBuilder *)builder {
    return [[TokenClientBuilder alloc] init];
}

+ (TokenClientBuilder *)sandboxBuilder {
    TokenClientBuilder *builder = [[TokenClientBuilder alloc] init];
    builder.tokenCluster = [TokenCluster sandbox];
    builder.port = 443;
    builder.useSsl = YES;
    return builder;
}

- (id)initWithTokenCluster:(TokenCluster *)tokenCluster_
                      port:(int)port
                 timeoutMs:(int)timeout
              developerKey:(NSString *)developerKey_
              languageCode:(NSString *)languageCode_
                    crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory_
            browserFactory:(TKBrowserFactory)browserFactory_
                    useSsl:(BOOL)useSsl
                 certsPath:(NSString *)certsPath
    globalRpcErrorCallback:(OnError)globalRpcErrorCallback_ {
    self = [super init];
    
    if (self) {
        tokenCluster = tokenCluster_;
        
        NSString *address = [NSString stringWithFormat:@"%@:%d", tokenCluster.envUrl, port];

        if (!useSsl) {
            [GRPCCall useInsecureConnectionsForHost:address];
        }
        if (certsPath) {
            NSError *error = nil;
            NSString *certs = [NSString stringWithContentsOfFile:certsPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];
            if (error) {
                @throw error;
            }
            
            [GRPCCall setTLSPEMRootCerts:certs forHost:address error:&error];
            if (error) {
                @throw error;
            }
        }

        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];

        gateway = [GatewayService serviceWithHost:address];
        errorHandler = [[TKRpcErrorHandler alloc] initWithGlobalRpcErrorCallback:globalRpcErrorCallback_];
        cryptoEngineFactory = cryptoEngineFactory_;
        timeoutMs = timeout;
        if (developerKey_) {
            developerKey = [developerKey_ copy];
        } else {
            developerKey = @"4qY7lqQw8NOl9gng0ZHgT4xdiDqxqoGVutuZwrUYQsI";
        }
        browserFactory = browserFactory_;
        languageCode = [languageCode_ copy];
        unauthenticatedClient = [[TKUnauthenticatedClient alloc]
                                 initWithGateway:gateway
                                 timeoutMs:timeoutMs
                                 developerKey:developerKey
                                 languageCode:languageCode
                                 errorHandler:errorHandler];
    }
    
    return self;
}

- (void)createMember:(Alias *)alias
           onSuccess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError {
    Alias *tokenAgent = [Alias message];
    tokenAgent.value = @"token.io";
    tokenAgent.type = Alias_Type_Domain;
    [unauthenticatedClient
     getTokenMember:tokenAgent
     onSuccess:^(TokenMember* tokenMember) {
         if (tokenMember && tokenMember.id_p && ![tokenMember.id_p isEqualToString:@""]) {
             [self->unauthenticatedClient
              createMemberId:^(NSString *memberId) {
                  [self _addKeysAndAlias:memberId
                                   alias:alias
                   memberRecoveryAgentId:tokenMember.id_p
                               onSuccess:onSuccess
                                 onError:onError];
              }
              onError:onError];
         }
         else {
             onError([NSError errorWithDomain:@"io.grpc"
                                         code:GRPCErrorCodeNotFound
                                     userInfo:nil]);
         }
     }
     onError:onError];
}

- (void)createMember:(Alias *)alias
       recoveryAgent:(NSString *)recoveryAgent
           onSuccess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError {
    [self->unauthenticatedClient
     createMemberId:^(NSString *memberId) {
         [self _addKeysAndAlias:memberId
                          alias:alias
          memberRecoveryAgentId:recoveryAgent
                      onSuccess:onSuccess
                        onError:onError];
     }
     onError:onError];
}

- (void)provisionDevice:(Alias *)alias
              onSuccess:(OnSuccessWithDeviceInfo)onSuccess
                onError:(OnError)onError {
    [unauthenticatedClient getMemberId:alias
              onSuccess:^(NSString *memberId) {
                  if (memberId) {
                      TKCrypto *crypto = [self createCrypto:memberId];
                      NSArray<Key *> *keys = [crypto generateKeys];
                      onSuccess([DeviceInfo deviceInfo:memberId keys:keys]);
                  } else {
                      onError([NSError errorWithDomain:@"io.grpc"
                                                  code:GRPCErrorCodeNotFound
                                              userInfo:nil]);
                  }
              }
                onError:onError];
}

- (void)aliasExists:(Alias *)alias
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    [unauthenticatedClient getMemberId:alias
                             onSuccess:^(NSString *memberId) {
                                 onSuccess([memberId length] != 0);
                             }
                               onError:onError];
}

- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError {
    [unauthenticatedClient getMemberId:alias
                             onSuccess:onSuccess
                               onError:onError];
}

- (void)getTokenMember:(Alias *)alias
             onSuccess:(OnSuccessWithTokenMember)onSuccess
               onError:(OnError)onError {
    [unauthenticatedClient getTokenMember:alias
                                onSuccess:onSuccess
                                  onError:onError];
}

- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithTKMember)onSuccess
          onError:(OnError)onError {
    [unauthenticatedClient getMember:memberId
                           onSuccess:^(Member *member) {
                               TKCrypto *crypto = [self createCrypto:memberId];
                               TKClient *client = [[TKClient alloc] initWithGateway:self->gateway
                                                                             crypto:crypto
                                                                          timeoutMs:self->timeoutMs
                                                                       developerKey:self->developerKey
                                                                       languageCode:self->languageCode
                                                                           memberId:memberId
                                                                       errorHandler:self->errorHandler];
                               
                               // Request alias for the member
                               [client getAliases:^(NSArray<Alias *> *aliases) {
                                   onSuccess([TKMember member:member
                                                 tokenCluster:self->tokenCluster
                                                    useClient:client
                                            useBrowserFactory:self->browserFactory
                                                      aliases:[NSMutableArray arrayWithArray:aliases]]);
                                   
                               } onError:onError];
                           }
                             onError:onError];
}

- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
       onSuccess:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    [self getBanks:bankIds
            search:search
           country:country
              page:page
           perPage:perPage
              sort:sort
          provider:provider
      bankFeatures:nil
         onSuccess:onSuccess
           onError:onError];
}

- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
    bankFeatures:(BankFilter_BankFeatures *)bankFeatures
       onSuccess:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    [unauthenticatedClient getBanks:bankIds
                             search:search
                            country:country
                               page:page
                            perPage:perPage
                               sort:sort
                           provider:provider
                       bankFeatures:bankFeatures
                          onSuccess:onSuccess
                            onError:onError];
}

- (void)getBanksCountries:(NSString *)provider
                onSuccess:(OnSuccessWithStrings)onSuccess
                  onError:(OnError)onError {
    [unauthenticatedClient getBanksCountries:provider
                                   onSuccess:onSuccess
                                     onError:onError];
}

- (void)notifyPaymentRequest:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    if ([token.refId length] == 0) {
        token.refId = [TKUtil nonce];
    }
    [unauthenticatedClient notifyPaymentRequest:token
                                      onSuccess:onSuccess
                                        onError:onError];
}

- (void)notifyAddKey:(Alias *)alias
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    [unauthenticatedClient notifyAddKey:alias
                                   keys:keys
                         deviceMetadata:deviceMetadata
                              onSuccess:onSuccess
                                onError:onError];
}

-(void)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                              keys:(NSArray<Key *> *)keys
                    deviceMetadata:(DeviceMetadata *)deviceMetadata
                           contact:(ReceiptContact *)contact
                         onSuccess:(OnSuccessWithNotifyResult)onSuccess
                           onError:(OnError)onError {
    AddKey *addKey = [AddKey message];
    addKey.keysArray = [NSMutableArray arrayWithArray:keys];
    addKey.deviceMetadata = deviceMetadata;
    [unauthenticatedClient notifyCreateAndEndorseToken:tokenRequestId
                                                addkey:addKey
                                               contact:contact
                                             onSuccess:onSuccess
                                               onError:onError];
}

/**
 * Invalidate a notification.
 *
 * @param notificationId notification id to invalidate
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)invalidateNotification:(NSString *)notificationId
                     onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                       onError:(OnError)onError {
    [unauthenticatedClient invalidateNotification:notificationId
                                        onSuccess:onSuccess
                                          onError:onError];
}

/**
 * Get the token request result based on a token's tokenRequestId.
 *
 * @param tokenRequestId token request id
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)getTokenRequestResult:(NSString *)tokenRequestId
                    onSuccess:(OnSuccessWithTokenRequestResult)onSuccess
                      onError:(OnError)onError {
    [unauthenticatedClient getTokenRequestResult:tokenRequestId
                                       onSuccess:onSuccess
                                         onError:onError];
}

#pragma mark - Member Recovery

- (void)beginRecovery:(Alias *)alias
            onSuccess:(OnSuccessWithString)onSuccess
              onError:(OnError)onError {
    [unauthenticatedClient beginRecovery:alias onSuccess:onSuccess onError:onError];
}

- (void)createRecoveryAuthorization:(NSString *)memberId
                                key:(Key *)privilegedKey
                          onSuccess:(OnSuccessWithMemberRecoveryOperationAuthorization)onSuccess
                            onError:(OnError)onError {
    [unauthenticatedClient createRecoveryAuthorization:memberId key:privilegedKey onSuccess:onSuccess onError:onError];
}

- (void)completeRecovery:(NSString *)memberId
      recoveryOperations:(NSArray<MemberRecoveryOperation *> *)recoveryOperations
           privilegedKey:(Key *)privilegedKey
                  crypto:(TKCrypto *)crypto
               onSuccess:(OnSuccessWithTKMember)onSuccess
                 onError:(OnError)onError {
    [unauthenticatedClient completeRecovery:memberId
                         recoveryOperations:recoveryOperations
                              privilegedKey:privilegedKey
                                     crypto:crypto
                                  onSuccess:^(Member *member) {
                                  TKClient *client = [[TKClient alloc]
                                                      initWithGateway:self->gateway
                                                      crypto:crypto
                                                      timeoutMs:self->timeoutMs
                                                      developerKey:self->developerKey
                                                      languageCode:self->languageCode
                                                      memberId:memberId
                                                      errorHandler:self->errorHandler];
                                  onSuccess([TKMember
                                             member:member
                                             tokenCluster:self->tokenCluster
                                             useClient:client
                                             useBrowserFactory:self->browserFactory
                                             aliases:[NSMutableArray array]]);
                              } onError:onError];
}

- (void)completeRecoveryWithDefaultRule:(NSString *)memberId
                         verificationId:(NSString *)verificationId
                                   code:(NSString *)code
                                 crypto:(TKCrypto *)crypto
                              onSuccess:(OnSuccessWithTKMember)onSuccess
                                onError:(OnError)onError {
    [unauthenticatedClient completeRecoveryWithDefaultRule:memberId
                                            verificationId:verificationId
                                                      code:code
                                                    crypto:crypto
                                                 onSuccess:^(Member *member) {
                                                     TKClient *client = [[TKClient alloc]
                                                                         initWithGateway:self->gateway
                                                                         crypto:crypto
                                                                         timeoutMs:self->timeoutMs
                                                                         developerKey:self->developerKey
                                                                         languageCode:self->languageCode
                                                                         memberId:memberId
                                                                         errorHandler:self->errorHandler];
                                                     onSuccess([TKMember
                                                                member:member
                                                                tokenCluster:self->tokenCluster
                                                                useClient:client
                                                                useBrowserFactory:self->browserFactory
                                                                aliases:[NSMutableArray array]]);
                                                 } onError:onError];
}

- (void)getRecoveryAuthorization:(NSString *)verificationId
                            code:(NSString *)code
                   privilegedKey:(Key *)privilegedKey
                       onSuccess:(OnSuccessWithMemberRecoveryOperation)onSuccess
                         onError:(OnError)onError {
    [unauthenticatedClient getRecoveryAuthorization:verificationId
                                               code:code
                                      privilegedKey:privilegedKey
                                          onSuccess:onSuccess
                                            onError:onError];
}

- (TKCrypto *)createCrypto:(NSString *)memberId {
    return [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
}

#pragma mark - private

// alias can be nil. In this case only add the key.
- (void)_addKeysAndAlias:(NSString *)memberId
                   alias:(Alias *)alias
   memberRecoveryAgentId:(NSString *)agentId
               onSuccess:(void (^)(TKMember *))onSuccess
                 onError:(OnError)onError {
    TKCrypto *crypto = [self createCrypto:memberId];
    NSArray<Key *> *keys = [crypto generateKeys];

    NSMutableArray<MemberOperation *> *operations = [NSMutableArray array];
    NSMutableArray<MemberOperationMetadata *> *metadataArray = [NSMutableArray array];
    for (Key *key in keys) {
        MemberOperation *addKey = [MemberOperation message];
        addKey.addKey.key = key;
        [operations addObject:addKey];
    }

    MemberOperation *addAlias = [MemberOperation message];
    Alias *normalized = [TKUtil normalizeAlias:alias];

    addAlias.addAlias.aliasHash = [TKHasher hashAlias:normalized];
    addAlias.addAlias.realm = normalized.realm;
    [operations addObject:addAlias];

    MemberOperation *recoverOp = [MemberOperation message];
    recoverOp.recoveryRules.recoveryRule.primaryAgent = agentId;
    [operations addObject:recoverOp];
    
    MemberOperationMetadata *metadata = [MemberOperationMetadata message];
    metadata.addAliasMetadata.alias = normalized;
    metadata.addAliasMetadata.aliasHash = [TKHasher hashAlias:normalized];
    [metadataArray addObject:metadata];
    
    [unauthenticatedClient createMember:memberId
                                 crypto:crypto
                             operations:operations
                          metadataArray:metadataArray
                              onSuccess:^(Member *member) {
                                  TKClient *client = [[TKClient alloc]
                                                      initWithGateway:self->gateway
                                                      crypto:crypto
                                                      timeoutMs:self->timeoutMs
                                                      developerKey:self->developerKey
                                                      languageCode:self->languageCode
                                                      memberId:memberId
                                                      errorHandler:self->errorHandler];
                                  onSuccess([TKMember
                                             member:member
                                             tokenCluster:self->tokenCluster
                                             useClient:client
                                             useBrowserFactory:self->browserFactory
                                             aliases:[NSMutableArray arrayWithObject:normalized]]);
                              }
                                onError:onError];
}
@end
