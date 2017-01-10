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
#import "TokenIO.h"
#import "TKClient.h"
#import "TKMemberAsync.h"


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

- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client usernameExists:username
              onSuccess:onSuccess
                onError:onError];
}

- (void)loginMember:(NSString *)memberId
           onSucess:(OnSuccessWithTKMemberAsync)onSuccess
            onError:(OnError)onError {
    TKCrypto *crypto = [self createCrypto:memberId];
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

- (void)notifyAddKey:(NSString * )username
           publicKey:(NSString *)publicKey
                name:(NSString *) name
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client notifyAddKey:username
               publicKey:publicKey
                    name:name
                     onSuccess:onSuccess
                       onError:onError];
}


- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads
                          publicKey:(NSString *)publicKey
                               name:(NSString *)name
                          onSuccess:(OnSuccess)onSuccess
                            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc]
            initWithGateway:gateway
                  timeoutMs:timeoutMs];
    [client notifyLinkAccountsAndAddKey:username
                                 bankId:bankId
                               bankName:bankName
                    accountLinkPayloads:accountLinkPayloads
                              publicKey:publicKey
                                   name:name
                              onSuccess:onSuccess
                                onError:onError];
}


#pragma mark private

- (TKCrypto *)createCrypto:(NSString *)memberId {
    return [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
}

// username can be nil. In this case only add the key.
- (void)_addKeysAndUsername:(TKUnauthenticatedClient *)client
                   memberId:(NSString *)memberId
                   username:(NSString *)username
                  onSuccess:(void (^)(TKMemberAsync *))onSuccess
                    onError:(OnError)onError {
    TKCrypto *crypto = [self createCrypto:memberId];
    [client
            createKeys:memberId
                crypto:crypto
             onSuccess:
                     ^(Member *member) {
                         TKClient *authenticated = [[TKClient alloc]
                                 initWithGateway:gateway
                                          crypto:crypto
                                       timeoutMs:timeoutMs
                                        memberId:memberId];
                         if (username != nil) {
                             [authenticated addUsername:username
                                                     to:member
                                              onSuccess:
                                                      ^(Member *m) {
                                                          TKClient *newClient = [[TKClient alloc]
                                                                  initWithGateway:gateway
                                                                           crypto:crypto
                                                                        timeoutMs:timeoutMs
                                                                         memberId:memberId];
                                                          onSuccess([TKMemberAsync
                                                                  member:m
                                                               useClient:newClient]);
                                                      }
                                                onError:onError];
                         } else {
                             onSuccess([TKMemberAsync
                                     member:member
                                  useClient:authenticated]);
                         }
                     }
               onError:onError];
}

@end
