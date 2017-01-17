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
                    bankId:(NSString *)bankId
                  bankName:(NSString *)bankName
       accountLinkPayloads:(NSArray<SealedMessage*> *)accountLinkPayloads {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccounts:username
                                bankId:bankId
                              bankName:bankName
                   accountLinkPayloads:accountLinkPayloads
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
                             bankId:(NSString *)bankId
                           bankName:(NSString *)bankName
                accountLinkPayloads:(NSArray<SealedMessage *> *)accountLinkPayloads
                            keyName:(NSString *)keyName
                                key:(Key *)key {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccountsAndAddKey:username
                                         bankId:bankId
                                       bankName:bankName
                            accountLinkPayloads:accountLinkPayloads
                                        keyName:keyName
                                            key:key
                                      onSuccess:^(void) {
                                          call.onSuccess(nil);
                                      }
                                        onError:call.onError];
    }];
}




@end
