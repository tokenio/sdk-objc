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

#import "TMember.h"
#import "TSdk.h"
#import "TSdkBuilder.h"
#import "TUnauthenticatedClient.h"
#import "TClient.h"
#import "TSecretKey.h"
#import "TCrypto.h"

@implementation TSdk {
    GatewayService *gateway;
}

+ (TSdkBuilder *)builder {
    return [[TSdkBuilder alloc] init];
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

- (TMember *)createMember {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    __block TMember *member;
    __block NSError *error;

    [self
            createMemberAsync:^(TMember *m) {
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

- (void)createMemberAsync:(void(^)(TMember *))onSuccess onError:(void(^)(NSError *))onError {
    TUnauthenticatedClient *client = [[TUnauthenticatedClient alloc] initWithGateway:gateway];
    TSecretKey *secretKey = [TCrypto generateKey];

    [client
            createMemberId:^(NSString *memberId) {
                NSLog(@"Member ID: %@", memberId);
                [client addFirstKey:secretKey
                          forMember:memberId
                          onSuccess:^(Member *member) {
                              NSLog(@"Member: %@", member);
                              onSuccess([TMember memberWithId:memberId secretKey:secretKey]);
                          }
                            onError:onError];
            }
            onError:onError];
}

- (TMember *)loginMember:(NSString *)memberId secretKey:(TSecretKey *)secretKey {
    dispatch_semaphore_t done = dispatch_semaphore_create(0);
    __block TMember *member;
    __block NSError *error;

    [self
            loginMemberAsync:memberId
                   secretKey:secretKey
                    onSucess:^(TMember *m) {
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
               secretKey:(TSecretKey *)key
                onSucess:(void(^)(TMember *member))onSuccess
                 onError:(void(^)(NSError *))onError {

    TClient *client = [[TClient alloc] initWithGateway:gateway secretKey:key];
    [client
            getMember:memberId
            onSuccess:^(Member *member) {
                NSLog(@"Member: %@", member);
                onSuccess([TMember memberWithId:memberId secretKey:key]);
            }
              onError: onError];
}

@end
