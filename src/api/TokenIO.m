//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKMember.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TokenIOAsync.h"
#import "TKRpcSyncCall.h"
#import "TKMemberAsync.h"
#import "DeviceInfo.h"


@implementation TokenIO

+ (TokenIOBuilder *)builder {
    return [[TokenIOBuilder alloc] init];
}

- (id)initWithDelegate:(TokenIOAsync *)delegate {
    self = [super init];
    if (self) {
        _async = delegate;
    }
    return self;
}

- (TKMember *)createMember:(NSString *)username {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async createMember:username
                        onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
                         onError:call.onError];
    }];
}

- (DeviceInfo *)provisionDevice:(NSString *)username {
    TKRpcSyncCall<DeviceInfo *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async provisionDevice:username
                          onSuccess:^(DeviceInfo *deviceInfo) {
                              call.onSuccess(deviceInfo);
                          }
                            onError:call.onError];
    }];
}

- (BOOL)usernameExists:(NSString *)username {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self.async usernameExists:username
                      onSuccess:^(BOOL exists) { call.onSuccess(@(exists)); }
                        onError:call.onError];
    }];
    return [result boolValue];
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

- (void)notifyLinkAccounts:(NSString *)username
             authorization:(BankAuthorization *)authorization{
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccounts:username
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
        [self.async notifyAddKey:username
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
        [self.async notifyLinkAccountsAndAddKey:username
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
