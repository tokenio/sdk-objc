//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKMemberSync.h"
#import "TokenIOSync.h"
#import "TokenIOBuilder.h"
#import "TokenIO.h"
#import "TKRpcSyncCall.h"
#import "TKMember.h"
#import "DeviceInfo.h"


@implementation TokenIOSync

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

+ (TokenIOBuilder *)sandboxBuilder {
    TokenIOBuilder *builder = [[TokenIOBuilder alloc] init];
    builder.host = @"api-grpc.sandbox.token.io";
    builder.port = 443;
    builder.useSsl = YES;
    return builder;
}

- (id)initWithDelegate:(TokenIO *)delegate {
    self = [super init];
    if (self) {
        _async = delegate;
    }
    return self;
}

- (TKMemberSync *)createMember:(Alias *)alias {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createMember:alias
                        onSuccess:^(TKMember *member) {
                            TKMemberSync* memberSync = [TKMemberSync member:member];
                            call.onSuccess(memberSync);
                        }
                         onError:call.onError];
    }];
}

- (DeviceInfo *)provisionDevice:(Alias *)alias {
    TKRpcSyncCall<DeviceInfo *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async provisionDevice:alias
                          onSuccess:^(DeviceInfo *deviceInfo) {
                              call.onSuccess(deviceInfo);
                          }
                            onError:call.onError];
    }];
}

- (BOOL)aliasExists:(Alias *)alias {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self.async aliasExists:alias
                      onSuccess:^(BOOL exists) { call.onSuccess(@(exists)); }
                        onError:call.onError];
    }];
    return [result boolValue];
}

- (NSString *)getMemberId:(Alias *)alias {
    TKRpcSyncCall<NSString *> *call = [TKRpcSyncCall create];
    NSString *result = [call run:^{
        [self.async getMemberId:alias
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
    return result;
}

- (TokenMember *)getTokenMember:(Alias *)alias {
    TKRpcSyncCall<TokenMember *> *call = [TKRpcSyncCall create];
    TokenMember *result = [call run:^{
        [self.async getTokenMember:alias
                      onSuccess:call.onSuccess
                        onError:call.onError];
    }];
    return result;
}

- (TKMemberSync *)getMember:(NSString *)memberId {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getMember:memberId
                       onSuccess:^(TKMember *member) {
                           TKMemberSync* memberSync = [TKMemberSync member:member];
                           call.onSuccess(memberSync);
                       }
                        onError:call.onError
        ];
    }];
}

- (void)notifyPaymentRequest:(TokenPayload *)token {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyPaymentRequest:token
                               onSuccess:^(void) {call.onSuccess(nil);}
                                 onError:call.onError
         ];
    }];
}

- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization{
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccounts:alias
                         authorization:authorization
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyAddKey:(Alias *)alias
             keyName:(NSString *)keyName
                 key:(Key *)key {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyAddKey:alias
                         keyName:keyName
                             key:key
                       onSuccess:^(void) {
                           call.onSuccess(nil);
                       }
                         onError:call.onError];
    }];
}

- (void)notifyLinkAccountsAndAddKey:(Alias *)alias
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccountsAndAddKey:alias
                                  authorization:authorization
                                        keyName:keyName
                                            key:key
                                      onSuccess:^(void) {
                                          call.onSuccess(nil);
                                      }
                                        onError:call.onError];
    }];
}

#pragma mark - Member Recovery

- (void)beginMemberRecovery:(NSString *)aliasValue {
    TKRpcSyncCall<NSObject *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async beginMemberRecovery:aliasValue
                              onSuccess:^() {
                                  call.onSuccess(nil);
                              } onError:call.onError];
    }];
}


- (BOOL)verifyMemberRecoveryCode:(NSString *)code {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self.async verifyMemberRecoveryCode:code
                                   onSuccess:^(BOOL correct) {
                                       call.onSuccess(@(correct));
                                   }
                                     onError:call.onError];
    }];
    return [result boolValue];
}


- (TKMemberSync *)completeMemberRecovery {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async completeMemberRecovery:^(TKMember *member) {
            TKMemberSync* memberSync = [TKMemberSync member:member];
            call.onSuccess(memberSync);
        }
                                   onError:call.onError];
    }];
}
@end
