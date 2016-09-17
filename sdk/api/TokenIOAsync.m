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

- (void)createMember:(NSString *)alias
            onSucess:(OnSuccessWithTKMember)onSuccess
             onError:(OnError)onError {
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

- (void)loginMember:(NSString *)memberId
          secretKey:(TKSecretKey *)key
           onSucess:(OnSuccessWithTKMember)onSuccess
            onError:(OnError)onError {

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
