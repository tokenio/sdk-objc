//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+ChannelCredentials.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"
#import "TKMember.h"
#import "TKMemberSync.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKUnauthenticatedClient.h"
#import "TKHasher.h"
#import "TKClient.h"
#import "DeviceInfo.h"
#import "TKRpcErrorHandler.h"
#import "TKLocalizer.h"
#import "TKMemberRecoveryManager.h"

@implementation TokenIO {
    TokenCluster *tokenCluster;
    GatewayService *gateway;
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    int timeoutMs;
    NSString *developerKey;
    NSString *languageCode;
    TKRpcErrorHandler *errorHandler;
    TKUnauthenticatedClient *unauthenticatedClient;
    TKMemberRecoveryManager *memberRecoveryManager;
    TKBrowserFactory browserFactory;
}

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

+ (TokenIOBuilder *)sandboxBuilder {
    TokenIOBuilder *builder = [[TokenIOBuilder alloc] init];
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
    if (!developerKey_) {
        @throw [NSException exceptionWithName:@"NoDeveloperKeyException"
                                       reason:@"Please provide a developer key. Contact Token for more details."
                                     userInfo:nil];
    }
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
        developerKey = [developerKey_ copy];
        browserFactory = browserFactory_;
        languageCode = [languageCode_ copy];
        unauthenticatedClient = [[TKUnauthenticatedClient alloc]
                                 initWithGateway:gateway
                                 timeoutMs:timeoutMs
                                 developerKey:developerKey
                                 languageCode:languageCode
                                 errorHandler:errorHandler];
        memberRecoveryManager = [[TKMemberRecoveryManager alloc]
                                 initWithGateway:gateway
                                 tokenCluster:tokenCluster
                                 timeoutMs:timeoutMs
                                 developerKey:developerKey
                                 languageCode:languageCode
                                 errorHandler:errorHandler
                                 crypto:cryptoEngineFactory
                                 browserFactory:browserFactory];
        
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
             [unauthenticatedClient
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

- (void)provisionDevice:(Alias *)alias
              onSuccess:(OnSuccessWithDeviceInfo)onSuccess
                onError:(OnError)onError {
    [unauthenticatedClient getMemberId:alias
              onSuccess:^(NSString *memberId) {
                  if (memberId) {
                      TKCrypto *crypto = [self _createCrypto:memberId];
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

/**
 * Looks up token member for a given unknown alias.
 * Set alias Alias_Type_Unknown if the alias type is unknown
 *
 * @param alias alias to check
 * @param onSuccess invoked if successful; return token member if alias already exists, nil otherwise
 */
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
                               TKCrypto *crypto = [self _createCrypto:memberId];
                               TKClient *client = [[TKClient alloc] initWithGateway:gateway
                                                                             crypto:crypto
                                                                          timeoutMs:timeoutMs
                                                                       developerKey:developerKey
                                                                       languageCode:languageCode
                                                                           memberId:memberId
                                                                       errorHandler:errorHandler];
                               
                               // Request alias for the member
                               [client getAliases:^(NSArray<Alias *> *aliases) {
                                   onSuccess([TKMember member:member
                                                 tokenCluster:tokenCluster
                                                    useClient:client
                                            useBrowserFactory:browserFactory
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
    [unauthenticatedClient getBanks:bankIds
                             search:search
                            country:country
                               page:page
                            perPage:perPage
                               sort:sort
                           provider:provider
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

- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    [unauthenticatedClient notifyLinkAccounts:alias
                                authorization:authorization
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

- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    [unauthenticatedClient notifyLinkAccountsAndAddKey:alias
                                         authorization:authorization
                                               keyName:keyName
                                                   key:key
                                             onSuccess:onSuccess
                                               onError:onError];
}

#pragma mark - Member Recovery

- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError {
    [memberRecoveryManager beginMemberRecovery:alias
                                     onSuccess:onSuccess
                                       onError:onError];
}

- (void)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code
                   onSuccess:(OnSuccessWithBoolean)onSuccess
                     onError:(OnError)onError {
    [memberRecoveryManager verifyMemberRecovery:alias
                                       memberId:memberId
                                 verificationId:verificationId
                                           code:code
                                      onSuccess:onSuccess
                                        onError:onError];
}

- (void)completeMemberRecovery:(Alias *)alias
                      memberId:(NSString *)memberId
                verificationId:(NSString *)verificationId
                          code:(NSString *)code
                     onSuccess:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError {
    [memberRecoveryManager completeMemberRecovery:alias
                                         memberId:memberId
                                   verificationId:verificationId
                                             code:code
                                        onSuccess:onSuccess
                                          onError:onError];
}

#pragma mark - private

- (TKCrypto *)_createCrypto:(NSString *)memberId {
    return [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
}

// alias can be nil. In this case only add the key.
- (void)_addKeysAndAlias:(NSString *)memberId
                   alias:(Alias *)alias
   memberRecoveryAgentId:(NSString *)agentId
               onSuccess:(void (^)(TKMember *))onSuccess
                 onError:(OnError)onError {
    TKCrypto *crypto = [self _createCrypto:memberId];
    NSArray<Key *> *keys = [crypto generateKeys];

    NSMutableArray<MemberOperation *> *operations = [NSMutableArray array];
    NSMutableArray<MemberOperationMetadata *> *metadataArray = [NSMutableArray array];
    for (Key *key in keys) {
        MemberOperation *addKey = [MemberOperation message];
        addKey.addKey.key = key;
        [operations addObject:addKey];
    }

    MemberOperation *addAlias = [MemberOperation message];
    addAlias.addAlias.aliasHash = [TKHasher hashAlias:alias];
    [operations addObject:addAlias];

    MemberOperation *recoverOp = [MemberOperation message];
    recoverOp.recoveryRules.recoveryRule.primaryAgent = agentId;
    [operations addObject:recoverOp];
    
    MemberOperationMetadata *metadata = [MemberOperationMetadata message];
    metadata.addAliasMetadata.alias = alias;
    metadata.addAliasMetadata.aliasHash = [TKHasher hashAlias:alias];
    [metadataArray addObject:metadata];
    
    [unauthenticatedClient createMember:memberId
                                 crypto:crypto
                             operations:operations
                          metadataArray:metadataArray
                              onSuccess:^(Member *member) {
                                  TKClient *client = [[TKClient alloc]
                                                      initWithGateway:gateway
                                                      crypto:crypto
                                                      timeoutMs:timeoutMs
                                                      developerKey:developerKey
                                                      languageCode:languageCode
                                                      memberId:memberId
                                                      errorHandler:errorHandler];
                                  onSuccess([TKMember
                                             member:member
                                             tokenCluster:tokenCluster
                                             useClient:client
                                             useBrowserFactory:browserFactory
                                             aliases:[NSMutableArray arrayWithObject:alias]]);
                              }
                                onError:onError];
}

@end
