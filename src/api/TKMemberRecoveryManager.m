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
    GatewayService *gateway;
    int timeoutMs;
    NSString *developerKey;
    TKRpcErrorHandler *errorHandler;
    
    NSString *verificationId;
    NSString *code;
    NSString *memberId;
    TKCrypto *crypto;
    Alias *alias;
    MemberRecoveryOperation *recoveryOperation;
    Member *member;
}

- (id)initWithGateway:(GatewayService *)gateway_
            timeoutMs:(int)timeoutMs_
         developerKey:(NSString *)developerKey_
         errorHandler:(TKRpcErrorHandler *)errorHandler_
               crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory_ {
    self = [super init];
    if (self) {
        gateway = gateway_;
        timeoutMs = timeoutMs_;
        developerKey = developerKey_;
        errorHandler = errorHandler_;
        unauthenticatedClient = [[TKUnauthenticatedClient alloc]
                                 initWithGateway:gateway
                                 timeoutMs:timeoutMs
                                 developerKey:developerKey
                                 errorHandler:errorHandler];
        cryptoEngineFactory = cryptoEngineFactory_;
        
        verificationId = nil;
        code = nil;
        memberId = nil;
        crypto = nil;
        alias = nil;
        recoveryOperation = nil;
        member = nil;
    }
    return self;
}

- (void)beginMemberRecovery:(NSString *)aliasValue
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError {
    verificationId = nil;
    code = nil;
    memberId = nil;
    crypto = nil;
    recoveryOperation = nil;
    member = nil;
    alias = [Alias message];
    alias.value = aliasValue;
    alias.type = Alias_Type_Unknown;
    
    [unauthenticatedClient
     getTokenMember:alias
     onSuccess:^(TokenMember *tokenMember) {
         alias = tokenMember.alias;
         memberId = tokenMember.id_p;
         
         [unauthenticatedClient
          beginMemberRecovery:alias
          onSuccess:^(NSString *verificationId_) {
              verificationId = verificationId_;
              
              //Generate keys for later recovery process
              crypto = [[TKCrypto alloc] initWithEngine:[cryptoEngineFactory createEngine:memberId]];
              [crypto generateKeys];
              
              onSuccess();
          }
          onError:onError];
     }
     onError:onError];
}

- (void)verifyMemberRecoveryCode:(NSString *)code
                       onSuccess:(OnSuccessWithBoolean)onSuccess
                         onError:(OnError)onError {
    
    if (crypto == nil) {
        onError([NSError
                 errorFromErrorCode:kTKErrorInvalidRecoveryProcess
                 details:@"Please call beginRecovery before verifyRecoveryCode"]
                );
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
         recoveryOperation = op;
         onSuccess(true);
     }
     onError:^(NSError* error) {
         if (error.domain == kGRPCErrorDomain && error.code == 5) {
             // The code is invalid. But the request shall be marked as success.
             onSuccess(false);
         }
         else {
             onError(error);
         }
     }];
}

- (void)completeMemberRecovery:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError {
    
    if (crypto == nil) {
        onError([NSError
                 errorFromErrorCode:kTKErrorInvalidRecoveryProcess
                 details:@"Please call beginRecovery before completeRecovery"]
                );
    }
    
    if (recoveryOperation == nil) {
        onError([NSError
                 errorFromErrorCode:kTKErrorInvalidRecoveryProcess
                 details:@"Please call verifyRecoveryCode before completeRecovery"]
                );
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
         onSuccess:^(Member *member_){
             member = member_;
             [self verifyAlias:onSuccess onError:onError];
             
         } onError:onError];
    }
    else {
        // Retries without updating member again.
        [self verifyAlias:onSuccess onError:onError];
    }
}

#pragma mark - Private

- (void)verifyAlias:(OnSuccessWithTKMember)onSuccess
            onError:(OnError)onError {
    [unauthenticatedClient
     recoverAlias:verificationId
     code:code
     onSuccess:^{
         TKClient *client = [[TKClient alloc]
                             initWithGateway:gateway
                             crypto:crypto
                             timeoutMs:timeoutMs
                             developerKey:developerKey
                             memberId:memberId
                             errorHandler:errorHandler];
         onSuccess([TKMember
                    member:member
                    useClient:client
                    aliases:[NSMutableArray arrayWithObject:alias]]);
     } onError:onError];
}

@end
