//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"
#import "TKMemberSync.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKUnauthenticatedClient.h"
#import "TKHasher.h"
#import "TKClient.h"
#import "DeviceInfo.h"
#import "TKRpcErrorHandler.h"


@implementation TokenIO {
    GatewayService *gateway;
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    int timeoutMs;
    TKRpcErrorHandler *errorHandler;
}

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

- (id)initWithHost:(NSString *)host
              port:(int)port
         timeoutMs:(int)timeout
            crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory_
            useSsl:(BOOL)useSsl
globalRpcErrorCallback:(OnError)globalRpcErrorCallback_ {
    self = [super init];
    
    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];

        if (!useSsl) {
            [GRPCCall useInsecureConnectionsForHost:address];
        }
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];

        gateway = [GatewayService serviceWithHost:address];
        errorHandler = [[TKRpcErrorHandler alloc] initWithGlobalRpcErrorCallback:globalRpcErrorCallback_];
        cryptoEngineFactory = cryptoEngineFactory_;
        timeoutMs = timeout;
    }
    
    return self;
}

- (void)createMember:(Alias *)alias
            onSucess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client createMemberId:
                    ^(NSString *memberId) {
                        [self _addKeysAndAlias:client
                                      memberId:memberId
                                         alias:alias
                                     onSuccess:onSuccess
                                       onError:onError];
                    }
                   onError:onError];
}

- (void)provisionDevice:(Alias *)alias
              onSuccess:(OnSuccessWithDeviceInfo)onSuccess
                onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client getMemberId:alias
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
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client getMemberId:alias
              onSuccess:^(NSString *memberId) { onSuccess([memberId length] != 0); }
                onError:onError];
}

- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError;{
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
                                       initWithGateway:gateway
                                       timeoutMs:timeoutMs
                                       errorHandler:errorHandler];
    [client getMemberId:alias
              onSuccess:onSuccess
                onError:onError];
}

- (void)loginMember:(NSString *)memberId
           onSucess:(OnSuccessWithTKMember)onSuccess
            onError:(OnError)onError {
    TKUnauthenticatedClient *unauthenticatedClient = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [unauthenticatedClient getMember:memberId
                           onSuccess:^(Member *member) {
                               TKCrypto *crypto = [self _createCrypto:memberId];
                               TKClient *client = [[TKClient alloc] initWithGateway:gateway
                                                                             crypto:crypto
                                                                          timeoutMs:timeoutMs
                                                                           memberId:memberId
                                                                       errorHandler:errorHandler];
                               
                               // Request alias for the member
                               [client getAliases:^(NSArray<Alias *> *aliases) {
                                   onSuccess([TKMember member:member
                                                    useClient:client
                                                      aliases:[NSMutableArray arrayWithArray:aliases]]);
                                   
                               } onError:onError];
                           }
                             onError:onError];
}

- (void)notifyPaymentRequest:(Alias *)alias
                       token:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    if ([token.refId length] == 0) {
        token.refId = [TKUtil nonce];
    }
    [client notifyPaymentRequest:alias
                           token:token
                       onSuccess:onSuccess
                         onError:onError];
}

- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client notifyLinkAccounts:alias
                 authorization:authorization
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)notifyAddKey:(Alias *)alias
             keyName:(NSString *)keyName
                 key:(Key *)key
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client notifyAddKey:alias
                 keyName:keyName
                     key:key
               onSuccess:onSuccess
                 onError:onError];
}

- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs
               errorHandler:errorHandler];
    [client notifyLinkAccountsAndAddKey:alias
                          authorization:authorization
                                keyName:keyName
                                    key:key
                              onSuccess:onSuccess
                                onError:onError];
}

#pragma mark private

- (TKCrypto *)_createCrypto:(NSString *)memberId {
    return [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
}

// alias can be nil. In this case only add the key.
- (void)_addKeysAndAlias:(TKUnauthenticatedClient *)client
                memberId:(NSString *)memberId
                   alias:(Alias *)alias
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
    
    MemberOperationMetadata *metadata = [MemberOperationMetadata message];
    metadata.addAliasMetadata.alias = alias;
    metadata.addAliasMetadata.aliasHash = [TKHasher hashAlias:alias];
    [metadataArray addObject:metadata];
    
    [client createMember:memberId
                  crypto:crypto
              operations:operations
           metadataArray:metadataArray
               onSuccess:^(Member *member) {
                   TKClient *newClient = [[TKClient alloc]
                           initWithGateway:gateway
                                    crypto:crypto
                                 timeoutMs:timeoutMs
                                  memberId:memberId
                              errorHandler:errorHandler];
                   onSuccess([TKMember
                              member:member
                           useClient:newClient
                             aliases:[NSMutableArray arrayWithObject:alias]]);
               }
                 onError:onError];
}

@end
