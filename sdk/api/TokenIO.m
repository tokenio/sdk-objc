//
//  Token.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"

#import "TKMember.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TKUnauthenticatedClient.h"
#import "TKClient.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcSyncCall.h"

@implementation TokenIO {
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

- (TKMember *)createMember:(NSString *)alias {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self createMemberAsync:alias
                       onSucess:call.onSuccess
                        onError:call.onError];
    }];
}

- (void)createMemberAsync:(NSString *)alias
                 onSucess:(void(^)(TKMember *member))onSuccess
                  onError:(void(^)(NSError *))onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
    TKSecretKey *key = [TKCrypto generateKey];

    [client
            createMemberId:^(NSString *memberId) {
                [client
                        addFirstKey:key
                          forMember:memberId
                          onSuccess:
                                  ^(Member *member) {
                                      TKClient *auth = [[TKClient alloc] initWithGateway:gateway
                                                                                  memberId:memberId
                                                                                 secretKey:key];
                                      [auth addAlias:alias
                                                  to:member
                                           onSuccess:
                                                   ^(Member *memberWithAlias) {
                                                       onSuccess([TKMember member:memberWithAlias
                                                                        secretKey:key
                                                                        useClient:auth]);
                                                   }
                                              onError: onError];
                                  }
                            onError:onError];
            }
            onError:onError];
}

- (TKMember *)loginMember:(NSString *)memberId secretKey:(TKSecretKey *)secretKey {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self
                loginMemberAsync:memberId
                       secretKey:secretKey
                        onSucess:call.onSuccess
                         onError:call.onError
        ];
    }];
}

- (void)loginMemberAsync:(NSString *)memberId
               secretKey:(TKSecretKey *)key
                onSucess:(void(^)(TKMember *member))onSuccess
                 onError:(void(^)(NSError *))onError {

    TKClient *client = [[TKClient alloc] initWithGateway:gateway
                                                memberId:memberId
                                               secretKey:key];
    [client
            getMember:
                    ^(Member *member) {
                        onSuccess([TKMember member:member secretKey:key useClient:client]);
                    }
              onError:onError];
}

@end
