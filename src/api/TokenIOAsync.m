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
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKMemberAsync.h"

@implementation TokenIOAsync {
    GatewayService *gateway;
}

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

- (id)initWithHost:(NSString *)host port:(int)port {
    self = [super init];
    
    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];
        
        [GRPCCall useInsecureConnectionsForHost:address];
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];
        
        gateway = [GatewayService serviceWithHost:address];
    }
    
    return self;
}

- (TokenIO *)sync {
    return [[TokenIO alloc] initWithDelegate:self];
}

- (void)createMember:(NSString *)username
            onSucess:(OnSuccessWithTKMemberAsync)onSuccess
             onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
    TKSecretKey *key = [TKCrypto generateKey];
    
    [client createMemberId:
     ^(NSString *memberId) {
         [self _addKeyAndUsername:client
                      memberId:memberId
                         username:username
                           key:key
                     onSuccess:onSuccess
                       onError:onError];
     }
                   onError:onError];
}

- (void)usernameExists:(NSString *)username
          onSuccess:(OnSuccessWithBoolean)onSuccess
            onError:(OnError)onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
    [client usernameExists:username
              onSuccess:onSuccess
                onError:onError];
}

- (void)loginMember:(NSString *)memberId
          secretKey:(TKSecretKey *)key
           onSucess:(OnSuccessWithTKMemberAsync)onSuccess
            onError:(OnError)onError {
    TKClient *client = [[TKClient alloc] initWithGateway:gateway
                                                memberId:memberId
                                               secretKey:key];
    [client getMember:
     ^(Member *member) {
         onSuccess([TKMemberAsync
                    member:member
                    secretKey:key
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
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
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
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
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
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
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

// username can be nil. In this case only add the key.
- (void)_addKeyAndUsername:(TKUnauthenticatedClient *)client
               memberId:(NSString *)memberId
                  username:(NSString *)username
                    key:(TKSecretKey *)key
              onSuccess:(void(^)(TKMemberAsync *))onSuccess
                onError:(OnError)onError {
    [client
     addFirstKey:key
     forMember:memberId
     onSuccess:
     ^(Member *member) {
         TKClient *authenticated = [[TKClient alloc]
                                    initWithGateway:gateway
                                    memberId:memberId
                                    secretKey:key];
         if (username != nil) {
             [authenticated addUsername:username
                                  to:member
                           onSuccess:
              ^(Member *m) {
                  TKClient *newClient = [[TKClient alloc]
                                         initWithGateway:gateway
                                         memberId:memberId
                                         secretKey:key];
                  onSuccess([TKMemberAsync
                             member:m
                             secretKey:key
                             useClient:newClient]);
              }
                             onError: onError];
         }
         else {
             onSuccess([TKMemberAsync
                        member:member
                        secretKey:key
                        useClient:authenticated]);
         }
     }
     onError:onError];
}

@end
