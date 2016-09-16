//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <ProtoRPC/ProtoRPC.h>
#import "TKClient.h"
#import "Member.pbobjc.h"
#import "gateway/Gateway.pbrpc.h"
#import "TKSecretKey.h"
#import "TKCrypto.h"
#import "TKRpcLog.h"
#import "Account.pbobjc.h"


NSString *const kTokenRealm = @"Token";
NSString *const kTokenScheme = @"Token-Ed25519-SHA512";


@implementation TKClient {
    GatewayService *gateway;
    NSString *memberId;
    TKSecretKey *key;
}

- (id)initWithGateway:(GatewayService *)gateway_
             memberId:(NSString *)memberId_
            secretKey:(TKSecretKey *)key_ {
    self = [super init];

    if (self) {
        gateway = gateway_;
        memberId = memberId_;
        key = key_;
    }

    return self;
}

- (void)getMember:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {

    GetMemberRequest *request = [GetMemberRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToGetMemberWithRequest:request
            handler:^(GetMemberResponse *response, NSError *error) {
                if (response) {
                    RpcLogCompleted(response);
                    onSuccess(response.member);
                } else {
                    RpcLogError(error);
                    onError(error);
                }
            }
    ];

    [self startCall:call withRequest:request];
}

- (void)addAlias:(NSString *)alias
              to:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {

    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addAlias.alias = alias;

    [self updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)removeAlias:(NSString *)alias
               from:(Member *)member
          onSuccess:(OnSuccessWithMember)onSuccess
            onError:(OnError)onError {

    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.removeAlias.alias = alias;

    [self updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)addKey:(TKSecretKey *)newKey
            to:(Member *)member
         level:(NSUInteger)level
     onSuccess:(OnSuccessWithMember)onSuccess
       onError:(OnError)onError {

    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.addKey.level = level;
    update.addKey.publicKey = newKey.publicKeyStr;

    [self updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)removeKey:(NSString *)keyId
             from:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {

    MemberUpdate *update = [MemberUpdate message];
    update.memberId = member.id_p;
    update.prevHash = member.lastHash;
    update.removeKey.keyId = keyId;

    [self updateMember:update onSuccess:onSuccess onError:onError];
}

- (void)linkAccounts:(NSString *)bankId
             payload:(NSData *)accountLinkPayload
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError {

    LinkAccountRequest *request = [LinkAccountRequest message];
    request.bankId = bankId;
    request.accountLinkPayload = accountLinkPayload;
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLinkAccountWithRequest:request
                                 handler:^(LinkAccountResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         onSuccess(response.accountsArray);
                                     } else {
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }
    ];

    [self startCall:call withRequest:request];
}

- (void)lookupAccounts:(OnSuccessWithAccounts)onSuccess
               onError:(OnError)onError {

    LookupAccountsRequest *request = [LookupAccountsRequest message];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToLookupAccountsWithRequest:request
                                   handler:^(LookupAccountsResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompleted(response);
                                           onSuccess(response.accountsArray);
                                       } else {
                                           RpcLogError(error);
                                           onError(error);
                                       }
                                   }
    ];

    [self startCall:call withRequest:request];
}

- (void)updateMember:(MemberUpdate *)update
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {

    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update = update;
    request.signature.keyId = key.id;
    request.signature.signature = [TKCrypto sign:request.update usingKey:key];
    RpcLogStart(request);

    GRPCProtoCall *call = [gateway
            RPCToUpdateMemberWithRequest:request
                                 handler:^(UpdateMemberResponse *response, NSError *error) {
                                     if (response) {
                                         RpcLogCompleted(response);
                                         onSuccess(response.member);
                                     } else {
                                         RpcLogError(error);
                                         onError(error);
                                     }
                                 }
    ];

    [self startCall:call withRequest:request];
}

- (void)startCall:(GRPCProtoCall *)call withRequest:(GPBMessage *)request {
    NSString *signature = [TKCrypto sign:request usingKey:key];

    call.requestHeaders[@"token-realm"] = kTokenRealm;
    call.requestHeaders[@"token-scheme"] = kTokenScheme;
    call.requestHeaders[@"token-member-id"] = memberId;
    call.requestHeaders[@"token-key-id"] = key.id;
    call.requestHeaders[@"token-signature"] = signature;

    [call start];
}

@end