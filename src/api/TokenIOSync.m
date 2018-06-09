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
    builder.tokenCluster = [TokenCluster sandbox];
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

- (NSArray<Bank *> *)getBanks:(NSArray<NSString *> *)bankIds
                       search:(NSString *)search
                      country:(NSString *)country
                         page:(int)page
                      perPage:(int)perPage
                         sort:(NSString *)sort
                     provider:(NSString *)provider {
    TKRpcSyncCall<NSArray<Bank *> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async getBanks:bankIds
                      search:search
                     country:country
                        page:page
                     perPage:perPage
                        sort:sort
                    provider:provider
                   onSuccess:call.onSuccess
                     onError:call.onError];
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
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    [call run:^{
        [self.async notifyAddKey:alias
                            keys:keys
                  deviceMetadata:deviceMetadata
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

- (NSString* )beginMemberRecovery:(Alias *)alias {
    TKRpcSyncCall<NSString *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async beginMemberRecovery:alias
                              onSuccess:^(NSString *verificationId) {
                                  call.onSuccess(verificationId);
                              } onError:call.onError];
    }];
}


- (BOOL)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code {
    TKRpcSyncCall<NSNumber *> *call = [TKRpcSyncCall create];
    NSNumber *result = [call run:^{
        [self.async verifyMemberRecovery:alias
                                memberId:memberId
                          verificationId:verificationId
                                    code:code
                               onSuccess:^(BOOL correct) {
                                   call.onSuccess(@(correct));
                               }
                                 onError:call.onError];
    }];
    return [result boolValue];
}


- (TKMemberSync *)completeMemberRecovery:(Alias *)alias
                                memberId:(NSString *)memberId
                          verificationId:(NSString *)verificationId
                                    code:(NSString *)code; {
    TKRpcSyncCall<TKMemberSync *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self.async completeMemberRecovery:alias
                                  memberId:memberId
                            verificationId:verificationId
                                      code:code
                                 onSuccess:^(TKMember *member) {
                                     TKMemberSync* memberSync = [TKMemberSync member:member];
                                     call.onSuccess(memberSync);
                                 }
                                   onError:call.onError];
    }];
}
@end
