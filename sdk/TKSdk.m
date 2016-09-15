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
#import "TKSdk.h"
#import "TKSdkBuilder.h"
#import "TKUnauthenticatedClient.h"
#import "TKClient.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"

@implementation TKSdk {
    GatewayService *gateway;
}

+ (TKSdkBuilder *)builder {
    return [[TKSdkBuilder alloc] init];
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

- (TKMember *)createMember {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    __block TKMember *member;
    __block NSError *error;

    [self
            createMemberAsync:^(TKMember *m) {
                member = m;
                dispatch_semaphore_signal(done);
            }
            onError:^(NSError *e) {
                error = e;
                dispatch_semaphore_signal(done);
            }];

    dispatch_semaphore_wait(done, DISPATCH_TIME_FOREVER);
    if (error) {
        @throw [NSException
                exceptionWithName:error.localizedDescription
                           reason:error.localizedFailureReason
                         userInfo:error.userInfo];
    }
    return member;
}

- (void)createMemberAsync:(void(^)(TKMember *))onSuccess onError:(void(^)(NSError *))onError {
    TKUnauthenticatedClient *client = [[TKUnauthenticatedClient alloc] initWithGateway:gateway];
    TKSecretKey *secretKey = [TKCrypto generateKey];

    [client
            createMemberId:^(NSString *memberId) {
                NSLog(@"Member ID: %@", memberId);
                [client addFirstKey:secretKey
                          forMember:memberId
                          onSuccess:^(Member *member) {
                              NSLog(@"Member: %@", member);
                              onSuccess([TKMember memberWithId:memberId secretKey:secretKey]);
                          }
                            onError:onError];
            }
            onError:onError];
}

- (TKMember *)loginMember:(NSString *)memberId secretKey:(TKSecretKey *)secretKey {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    __block TKMember *member;
    __block NSError *error;

    [self
            loginMemberAsync:memberId
                   secretKey:secretKey
                    onSucess:^(TKMember *m) {
                        member = m;
                        dispatch_semaphore_signal(done);
                    }
                     onError:^(NSError *e) {
                         error = e;
                         dispatch_semaphore_signal(done);
                     }];

    dispatch_semaphore_wait(done, DISPATCH_TIME_FOREVER);

    if (error) {
        @throw [NSException
                exceptionWithName:error.localizedDescription
                           reason:error.localizedFailureReason
                         userInfo:error.userInfo];
    }

    return member;
}

- (void)loginMemberAsync:(NSString *)memberId
               secretKey:(TKSecretKey *)key
                onSucess:(void(^)(TKMember *member))onSuccess
                 onError:(void(^)(NSError *))onError {

    TKClient *client = [[TKClient alloc] initWithGateway:gateway secretKey:key];
    [client
            getMember:memberId
            onSuccess:^(Member *member) {
                NSLog(@"Member: %@", member);
                onSuccess([TKMember memberWithId:memberId secretKey:key]);
            }
              onError: onError];
}

@end
