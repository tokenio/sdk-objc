//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKMember.h"
#import "TokenIOSync.h"
#import "TokenIOBuilder.h"
#import "TokenIO.h"
#import "TKRpcSyncCall.h"
#import "TKMemberAsync.h"
#import "DeviceInfo.h"


@implementation TokenIOSync

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

- (id)initWithDelegate:(TokenIO *)delegate {
    self = [super init];
    if (self) {
        _async = delegate;
    }
    return self;
}

- (TKMember *)createMember:(Alias *)alias {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createMember:alias
                        onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
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


- (TKMember *)loginMember:(NSString *)memberId {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
                loginMember:memberId
                   onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
                    onError:call.onError
        ];
    }];
}

- (void)notifyPaymentRequest:(Alias *)alias
                       token:(TokenPayload *)token {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyPaymentRequest:alias
                                   token:token
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyLinkAccounts:(Alias *)alias
             authorization:(BankAuthorization *)authorization{
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
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
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
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
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
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

@end
