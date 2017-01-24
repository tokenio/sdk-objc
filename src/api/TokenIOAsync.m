//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"
#import "TKMember.h"
#import "TokenIOAsync.h"
#import "TokenIOBuilder.h"
#import "TKUnauthenticatedClient.h"
#import "TKClient.h"
#import "DeviceInfo.h"


@implementation TokenIOAsync {
    GatewayService *gateway;
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    int timeoutMs;
}

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

- (id)initWithHost:(NSString *)host
              port:(int)port
         timeoutMs:(int)timeout
            crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory_
            useSsl:(BOOL)useSsl {
    self = [super init];
    
    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];
        
        if (!useSsl) {
            [GRPCCall useInsecureConnectionsForHost:address];
        }
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];

        gateway = [GatewayService serviceWithHost:address];
        cryptoEngineFactory = cryptoEngineFactory_;
        timeoutMs = timeout;
    }
    
    return self;
}

- (TokenIO *)sync {
    return [[TokenIO alloc] initWithDelegate:self];
}

- (void)createMember:(NSString *)username
            onSucess:(OnSuccessWithTKMemberAsync)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client createMemberId:
                    ^(NSString *memberId) {
                        [self _addKeysAndUsername:client
                                         memberId:memberId
                                         username:username
                                        onSuccess:onSuccess
                                          onError:onError];
                    }
                   onError:onError];
}

- (void)provisionDevice:(NSString *)username
              onSuccess:(OnSuccessWithDeviceInfo)onSuccess
                onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client getMemberId:username
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

- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client getMemberId:username
              onSuccess:^(NSString *memberId) { onSuccess([memberId length] != 0); }
                onError:onError];
}

- (void)loginMember:(NSString *)memberId
           onSucess:(OnSuccessWithTKMemberAsync)onSuccess
            onError:(OnError)onError {
    TKCrypto *crypto = [self _createCrypto:memberId];
    TKClient *client = [[TKClient alloc] initWithGateway:gateway
                                                  crypto:crypto
                                               timeoutMs:timeoutMs
                                                memberId:memberId];
    [client getMember: ^(Member *member) {
                onSuccess([TKMemberAsync
                        member:member
                     useClient:client]);
            }
              onError:onError];
}

- (void)notifyLinkAccounts:(NSString *)username
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads
                 onSuccess:(OnSuccess)onSuccess
                   onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client notifyLinkAccounts:username
                        bankId:bankId
                      bankName:bankName
           accountLinkPayloads:accountLinkPayloads
                     onSuccess:onSuccess
                       onError:onError];
}

- (void)notifyAddKey:(NSString *)username
             keyName:(NSString *)keyName
                 key:(Key *)key
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client notifyAddKey:username
                 keyName:keyName
                     key:key
               onSuccess:onSuccess
                 onError:onError];
}

- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
                            keyName:(NSString *)keyName
                                key:(Key *)key
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client notifyLinkAccountsAndAddKey:username
                                 bankId:bankId
                               bankName:bankName
                    accountLinkPayloads:accountLinkPayloads
                                keyName:keyName
                                    key:key
                              onSuccess:onSuccess
                                onError:onError];
}

#pragma mark private

- (TKCrypto *)_createCrypto:(NSString *)memberId {
    return [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
}

// username can be nil. In this case only add the key.
- (void)_addKeysAndUsername:(TKUnauthenticatedClient *)client
                   memberId:(NSString *)memberId
                   username:(NSString *)username
                  onSuccess:(void (^)(TKMemberAsync *))onSuccess
                    onError:(OnError)onError {
    TKCrypto *crypto = [self _createCrypto:memberId];
    NSArray<Key *> *keys = [crypto generateKeys];

    NSMutableArray<MemberOperation *> *operations = [NSMutableArray array];
    for (Key *key in keys) {
        MemberOperation *addKey = [MemberOperation message];
        addKey.addKey.key = key;
        [operations addObject:addKey];
    }

    MemberOperation *addUsername = [MemberOperation message];
    addUsername.addUsername.username = username;
    [operations addObject:addUsername];

    [client createMember:memberId
                  crypto:crypto
              operations:operations
               onSuccess:^(Member *member) {
                   TKClient *newClient = [[TKClient alloc]
                           initWithGateway:gateway
                                    crypto:crypto
                                 timeoutMs:timeoutMs
                                  memberId:memberId];
                   onSuccess([TKMemberAsync
                           member:member
                        useClient:newClient]);
               }
                 onError:onError];
}

@end
