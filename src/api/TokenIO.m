//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKMember.h"
#import "TokenIO.h"
#import "TokenIOBuilder.h"
#import "TokenIOAsync.h"
#import "TKSecretKey.h"
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
                         onError: call.onError];
    }];
}

- (BOOL)usernameExists:(NSString *)username {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self.async usernameExists:username
                      onSuccess:^(BOOL exists) { call.onSuccess([NSNumber numberWithBool:exists]); }
                        onError:call.onError];
    }];
    return [result boolValue];
}

- (TKMember *)loginMember:(NSString *)memberId secretKey:(TKSecretKey *)secretKey {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async
                loginMember:memberId
                  secretKey:secretKey
                   onSucess:^(TKMemberAsync *member) { call.onSuccess(member.sync); }
                    onError:call.onError
        ];
    }];
}

- (void)notifyLinkAccounts:(NSString * )username
                    bankId:(NSString *)bankId
       accountsLinkPayload:(NSString *) accountsLinkPayload {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccounts:username
                                bankId:bankId
                   accountsLinkPayload:accountsLinkPayload
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyAddKey:(NSString * )username
           publicKey:(NSString *)publicKey
                name:(NSString *)name {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyAddKey:username
                       publicKey:publicKey
                            name:name
                             onSuccess:^(void) {call.onSuccess(nil);}
                               onError:call.onError
         ];
    }];
}

- (void)notifyLinkAccountsAndAddKey:(NSString * )username
                             bankId:(NSString *)bankId
                accountsLinkPayload:(NSString *) accountsLinkPayload
                          publicKey:(NSString *)publicKey
                               name:(NSString *)name {
    TKRpcSyncCall<TKMember *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyLinkAccountsAndAddKey:username
                          bankId:bankId
             accountsLinkPayload:accountsLinkPayload
                       publicKey:publicKey
                            name:name
                       onSuccess:^(void) {call.onSuccess(nil);}
                         onError:call.onError
         ];
    }];
}




@end
