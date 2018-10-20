//
//  TKMemberRecoveryManager.m
//  sdk
//
//  Created by Sibin Lu on 10/20/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKMemberRecoveryManager.h"
#import "TKClient.h"
#import "TKUnauthenticatedClient.h"
#import "TKCrypto.h"
#import "TKLocalizer.h"
#import "TKError.h"

@implementation TKMemberRecoveryManager {
    TKUnauthenticatedClient *unauthenticatedClient;
    id<TKCryptoEngineFactory> cryptoEngineFactory;
    TKBrowserFactory browserFactory;
    GatewayService *gateway;
    int timeoutMs;
    NSString *developerKey;
    NSString *languageCode;
    TKRpcErrorHandler *errorHandler;
    TKCrypto *crypto;
    MemberRecoveryOperation *recoveryOperation;
    Member *member;
    TokenCluster *tokenCluster;
}

- (id)initWithGateway:(GatewayService *)gateway_
         tokenCluster:(TokenCluster *)tokenCluster_
            timeoutMs:(int)timeoutMs_
         developerKey:(NSString *)developerKey_
         languageCode:(NSString *)languageCode_
         errorHandler:(TKRpcErrorHandler *)errorHandler_
               crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory_
       browserFactory:(TKBrowserFactory)browserFactory_ {
    self = [super init];
    if (self) {
        gateway = gateway_;
        tokenCluster = tokenCluster_;
        timeoutMs = timeoutMs_;
        developerKey = [developerKey_ copy];
        languageCode = [languageCode_ copy];
        errorHandler = errorHandler_;
        unauthenticatedClient = [[TKUnauthenticatedClient alloc]
                                 initWithGateway:gateway
                                 timeoutMs:timeoutMs
                                 developerKey:developerKey
                                 languageCode:languageCode
                                 errorHandler:errorHandler];
        cryptoEngineFactory = cryptoEngineFactory_;
        browserFactory = browserFactory_;
        
        crypto = nil;
        recoveryOperation = nil;
        member = nil;
    }
    return self;
}

- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError {
    crypto = nil;
    recoveryOperation = nil;
    member = nil;
    
    [unauthenticatedClient
     beginMemberRecovery:alias
     onSuccess:onSuccess
     onError:onError];
}

- (void)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    if (crypto == nil) {
        crypto = [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
        [crypto generateKeys];
    }
    
    Key *key = [crypto getKeyInfo:Key_Level_Privileged
                           reason:TKLocalizedString(
                                                    @"Signature_Reason_RecoverMember",
                                                    @"Approve to recover a Token member account")
                          onError:onError];
    if (!key) {
        return;
    }
    [unauthenticatedClient
     getMemberRecoveryOperation:verificationId
     code:code
     privilegedKey:key
     onSuccess:^(MemberRecoveryOperation *op) {
         self->recoveryOperation = op;
         onSuccess();
     }
     onError:^(NSError* error) {
         onError(error);
     }];
}

- (void)completeMemberRecovery:(Alias *)alias
                      memberId:(NSString *)memberId
                verificationId:(NSString *)verificationId
                          code:(NSString *)code
                     onSuccess:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError {
    
    if (crypto == nil) {
        onError([NSError
                 errorFromErrorCode:kTKErrorInvalidRecoveryProcess
                 details:@"Please call verifyRecoveryCode before completeRecovery"]
                );
        return;
    }
    
    if (recoveryOperation == nil) {
        onError([NSError
                 errorFromErrorCode:kTKErrorInvalidRecoveryProcess
                 details:@"Please call verifyRecoveryCode before completeRecovery"]
                );
        return;
    }
    
    NSString *reason = TKLocalizedString(
                         @"Signature_Reason_RecoverMember",
                         @"Approve to recover a Token member account");
    NSArray<Key *> *keys = [crypto getKeyInfos:reason
                                       onError:onError];
    if (!keys) {
        return;
    }
    
    NSMutableArray<MemberOperation *> *operations = [NSMutableArray array];
    MemberOperation *recoverOp = [MemberOperation message];
    recoverOp.recover = recoveryOperation;
    [operations addObject:recoverOp];

    for (Key *key in keys) {
        MemberOperation *addKey = [MemberOperation message];
        addKey.addKey.key = key;
        [operations addObject:addKey];
    }
    
    if (!member) {
        [unauthenticatedClient
         updateMember:memberId
         crypto:crypto
         prevHash:recoveryOperation.authorization.prevHash
         operations:operations
         metadataArray:[NSArray array]
         reason:reason
         onSuccess:^(Member *member_) {
             self->member = member_;
             [self _recoverAlias:alias
                        memberId:memberId
                  verificationId:verificationId
                            code:code
                       onSuccess:onSuccess
                         onError:onError];
             
         } onError:onError];
    }
    else {
        // Retries without updating member again.
        [self _recoverAlias:alias
                   memberId:memberId
             verificationId:verificationId
                       code:code
                  onSuccess:onSuccess
                    onError:onError];
    }
}

#pragma mark - Private

- (void)_recoverAlias:(Alias *)alias
             memberId:(NSString *)memberId
       verificationId:(NSString *)verificationId
                 code:(NSString *)code
            onSuccess:(OnSuccessWithTKMember)onSuccess
              onError:(OnError)onError {
    [unauthenticatedClient
     recoverAlias:verificationId
     code:code
     onSuccess:^{
         TKClient *client = [[TKClient alloc]
                             initWithGateway:self->gateway
                             crypto:self->crypto
                             timeoutMs:self->timeoutMs
                             developerKey:self->developerKey
                             languageCode:self->languageCode
                             memberId:memberId
                             errorHandler:self->errorHandler];
         onSuccess([TKMember
                    member:self->member
                    tokenCluster:self->tokenCluster
                    useClient:client
                    useBrowserFactory:self->browserFactory
                    aliases:[NSMutableArray arrayWithObject:alias]]);
     } onError:onError];
}

@end
