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


@implementation TokenIO (Sync)


- (TKMember *)createMember:(NSString *)username {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self createMember:username
                        onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
                         onError:call.onError];
    }];
}

- (DeviceInfo *)provisionDevice:(NSString *)username {
    TKRpcSyncCall<DeviceInfo *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self provisionDevice:username
                          onSuccess:^(DeviceInfo *deviceInfo) {
                              call.onSuccess(deviceInfo);
                          }
                            onError:call.onError];
    }];
}

- (BOOL)usernameExists:(NSString *)username {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self usernameExists:username
                      onSuccess:^(BOOL exists) { call.onSuccess(@(exists)); }
                        onError:call.onError];
    }];
    return [result boolValue];
}

- (NSString *)getMemberId:(NSString *)username {
    TKRpcSyncCall<NSString *> *call = [TKRpcSyncCall create];
    NSString *result = [call run:^{
        [self getMemberId:username
                         onSuccess:call.onSuccess
                           onError:call.onError];
    }];
    return result;
}


- (TKMember *)loginMember:(NSString *)memberId {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self
                loginMember:memberId
                   onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
                    onError:call.onError
        ];
    }];
}

- (void)notifyPaymentRequest:(NSString *)username
                       token:(TokenPayload *)token {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self notifyPaymentRequest:username
                                   token:token
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyLinkAccounts:(NSString *)username
             authorization:(BankAuthorization *)authorization{
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self notifyLinkAccounts:username
                         authorization:authorization
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyAddKey:(NSString *)username
             keyName:(NSString *)keyName
                 key:(Key *)key {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self notifyAddKey:username
                         keyName:keyName
                             key:key
                       onSuccess:^(void) {
                           call.onSuccess(nil);
                       }
                         onError:call.onError];
    }];
}

- (void)notifyLinkAccountsAndAddKey:(NSString *)username
                      authorization:(BankAuthorization *)authorization
                            keyName:(NSString *)keyName
                                key:(Key *)key {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self notifyLinkAccountsAndAddKey:username
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
