//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "gateway/Gateway.pbrpc.h"

#import "TKUnauthenticatedClient.h"

#import "TKError.h"
#import "TKRpcLog.h"
#import "TKRpc.h"
#import "TKSignature.h"
#import "TKLocalizer.h"
#import "TKRpcErrorHandler.h"
#import "TKHasher.h"
#import "TKUtil.h"
#import "NotifyResult.h"
#import "TokenRequestResult.h"

@implementation TKUnauthenticatedClient {
    GatewayService *gateway;
    TKRpc *rpc;
    TKRpcErrorHandler *errorHandler;
}

- (id)initWithGateway:(GatewayService *)gateway_
            timeoutMs:(int)timeoutMs_
         developerKey:(NSString *)developerKey_
         languageCode:(NSString *)languageCode_
         errorHandler:(TKRpcErrorHandler *) errorHandler_ {
    self = [super init];
    
    if (self) {
        gateway = gateway_;
        errorHandler = errorHandler_;
        rpc = [[TKRpc alloc] initWithTimeoutMs:timeoutMs_
                                  developerKey:developerKey_
                                  languageCode:languageCode_];
    }
    
    return self;
}

- (void)createMemberId:(void(^)(NSString *memberId))onSuccess
               onError:(void(^)(NSError *))onError {
    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = [TKUtil nonce];
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCreateMemberWithRequest:request
                                   handler:^(CreateMemberResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.memberId);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getMemberId:(Alias *)alias
          onSuccess:(OnSuccessWithString)onSuccess
            onError:(OnError)onError {
    ResolveAliasRequest *request = [ResolveAliasRequest message];
    request.alias = alias;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToResolveAliasWithRequest:request
                                   handler:^(ResolveAliasResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.hasMember) {
                                               onSuccess(response.member.id_p);
                                           }
                                           else {
                                               onSuccess(nil);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getTokenMember:(Alias *)alias
             onSuccess:(OnSuccessWithTokenMember)onSuccess
               onError:(OnError)onError {
    ResolveAliasRequest *request = [ResolveAliasRequest message];
    request.alias = alias;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToResolveAliasWithRequest:request
                                   handler:^(ResolveAliasResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.hasMember) {
                                               onSuccess(response.member);
                                           }
                                           else {
                                               onSuccess(nil);
                                           }
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getMember:(NSString *)memberId
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError {
    GetMemberRequest *request = [GetMemberRequest message];
    request.memberId = memberId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetMemberWithRequest:request
                                   handler:^(GetMemberResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.member);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }
                                   ];
    
    [rpc execute:call request:request];
}

- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    [self createMember:memberId
                crypto:crypto
            operations:operations
         metadataArray:[NSArray array]
             onSuccess:onSuccess
               onError:onError];
}

- (void)createMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    [self updateMember:memberId
                crypto:crypto
              prevHash:nil
            operations:operations
         metadataArray:metadataArray
                reason:TKLocalizedString(
                                         @"Signature_Reason_CreateMember",
                                         @"Approve create a new Token member account")
             onSuccess:onSuccess
               onError:onError];
}

- (void)updateMember:(NSString *)memberId
              crypto:(TKCrypto *)crypto
            prevHash:(NSString *)prevHash
          operations:(NSArray<MemberOperation *> *)operations
       metadataArray:(NSArray<MemberOperationMetadata *> *)metadataArray
              reason:(NSString *)reason
           onSuccess:(OnSuccessWithMember)onSuccess
             onError:(OnError)onError {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = memberId;
    request.update.operationsArray = [NSMutableArray arrayWithArray:operations];
    if (prevHash) {
        request.update.prevHash = prevHash;
    }
    request.metadataArray = [NSMutableArray arrayWithArray:metadataArray];
    
    TKSignature *signature = [crypto sign:request.update
                                 usingKey:Key_Level_Privileged
                                   reason:reason
                                  onError:onError];
    if (!signature) {
        return;
    }
    
    request.updateSignature.memberId = memberId;
    request.updateSignature.keyId = signature.key.id_p;
    request.updateSignature.signature = signature.value;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToUpdateMemberWithRequest:request
                                   handler:^(UpdateMemberResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.member);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getBanks:(NSArray<NSString *> *)bankIds
          search:(NSString *)search
         country:(NSString *)country
            page:(int)page
         perPage:(int)perPage
            sort:(NSString *)sort
        provider:(NSString *)provider
    bankFeatures:(NSDictionary<NSString *, NSString *> *)bankFeatures
       onSuccess:(OnSuccessWithBanks)onSuccess
         onError:(OnError)onError {
    GetBanksRequest *request = [GetBanksRequest message];
    request.filter.idsArray = [NSMutableArray arrayWithArray:bankIds];
    request.filter.search = search;
    request.filter.country = country;
    request.page = page;
    request.perPage = perPage;
    request.sort = sort;
    request.filter.provider = provider;
    request.filter.requiresBankFeatures = bankFeatures;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBanksWithRequest:request
                                   handler:
                                   ^(GetBanksResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.banksArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [rpc execute:call request:request];
}

- (void)getBanksCountries:(NSString *)provider
                onSuccess:(OnSuccessWithStrings)onSuccess
                  onError:(OnError)onError {
    GetBanksCountriesRequest *request = [GetBanksCountriesRequest message];
    request.filter.provider = provider;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetBanksCountriesWithRequest:request
                                   handler:
                                   ^(GetBanksCountriesResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.countriesArray);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    
    [rpc execute:call request:request];
}

- (void)notifyPaymentRequest:(TokenPayload *)token
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError {
    RequestTransferRequest *request = [RequestTransferRequest message];
    request.tokenPayload = token;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToRequestTransferWithRequest:request
                                   handler:^(RequestTransferResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)notifyAddKey:(Alias *)alias
                keys:(NSArray<Key *> *)keys
      deviceMetadata:(DeviceMetadata *)deviceMetadata
           onSuccess:(OnSuccess)onSuccess
             onError:(OnError)onError {
    NotifyRequest *request = [NotifyRequest message];
    request.alias = alias;
    request.body.addKey.keysArray = [NSMutableArray arrayWithArray:keys];
    request.body.addKey.deviceMetadata = deviceMetadata;
    
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToNotifyWithRequest:request
                                   handler:^(NotifyResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess();
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

-(void)notifyCreateAndEndorseToken:(NSString *)tokenRequestId
                            addkey:(AddKey *)addKey
                           contact:(ReceiptContact *)contact
                         onSuccess:(OnSuccessWithNotifyResult)onSuccess
                           onError:(OnError)onError {
    TriggerCreateAndEndorseTokenNotificationRequest *request = [TriggerCreateAndEndorseTokenNotificationRequest message];
    request.tokenRequestId = tokenRequestId;
    request.addKey = addKey;
    request.contact = contact;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToTriggerCreateAndEndorseTokenNotificationWithRequest:request
                                   handler:^(TriggerCreateAndEndorseTokenNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess([NotifyResult createWithNotifyStatus:response.status
                                                                           notificationId:response.notificationId]);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)invalidateNotification:(NSString *)notificationId
                     onSuccess:(OnSuccessWithNotifyStatus)onSuccess
                       onError:(OnError)onError {
    InvalidateNotificationRequest *request = [InvalidateNotificationRequest message];
    request.notificationId = notificationId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToInvalidateNotificationWithRequest:request
                                   handler:^(InvalidateNotificationResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.status);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)getTokenRequestResult:(NSString *)tokenRequestId
                    onSuccess:(OnSuccessWithTokenRequestResult)onSuccess
                      onError:(OnError)onError {
    GetTokenRequestResultRequest *request = [GetTokenRequestResultRequest message];
    request.tokenRequestId = tokenRequestId;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToGetTokenRequestResultWithRequest:request
                                   handler:^(GetTokenRequestResultResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess([TokenRequestResult createWithTokenId:response.tokenId
                                                                                 signature:response.signature]);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

#pragma mark - Member Recovery

- (void)beginRecovery:(Alias *)alias
            onSuccess:(OnSuccessWithString)onSuccess
              onError:(OnError)onError {
    BeginRecoveryRequest *request = [BeginRecoveryRequest message];
    request.alias = alias;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToBeginRecoveryWithRequest: request
                                   handler:^(BeginRecoveryResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           onSuccess(response.verificationId);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}

- (void)createRecoveryAuthorization:(NSString *)memberId
                                key:(Key *)privilegedKey
                          onSuccess:(OnSuccessWithMemberRecoveryOperationAuthorization)onSuccess
                            onError:(OnError)onError {
    [self getMember:memberId
          onSuccess:^(Member *member) {
              MemberRecoveryOperation_Authorization *authorization =
              [[MemberRecoveryOperation_Authorization alloc] init];
              authorization.memberId = memberId;
              authorization.prevHash = member.lastHash;
              authorization.memberKey = privilegedKey;
              onSuccess(authorization);
          } onError:onError];
}

- (void)completeRecovery:(NSString *)memberId
      recoveryOperations:(NSArray<MemberRecoveryOperation *> *)recoveryOperations
           privilegedKey:(Key *)privilegedKey
                  crypto:(TKCrypto *)crypto
               onSuccess:(OnSuccessWithMember)onSuccess
                 onError:(OnError)onError {
    NSMutableArray<MemberOperation *> *operations = [NSMutableArray array];
    for (MemberRecoveryOperation * recoveryOperation in recoveryOperations) {
        MemberOperation *operation = [[MemberOperation alloc] init];
        operation.recover = recoveryOperation;
        [operations addObject:operation];
    }
    
    // Adds AddKey operations.
    Key *standardKey = [crypto generateKey:Key_Level_Standard];
    Key *lowKey = [crypto generateKey:Key_Level_Low];
    
    if (!privilegedKey || !standardKey || !lowKey) {
        onError([NSError
                 errorFromErrorCode:kTKErrorKeyNotFound
                 details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
        return;
    }
    
    MemberOperation *addKeyPrivileged = [MemberOperation message];
    addKeyPrivileged.addKey.key = privilegedKey;
    [operations addObject:addKeyPrivileged];
    
    MemberOperation *addKeyStandard = [MemberOperation message];
    addKeyStandard.addKey.key = standardKey;
    [operations addObject:addKeyStandard];
    
    MemberOperation *addKeyLow = [MemberOperation message];
    addKeyLow.addKey.key = lowKey;
    [operations addObject:addKeyLow];
    
    NSString *reason = TKLocalizedString(@"Signature_Reason_RecoverMember",
                                         @"Approve to recover a Token member account");
    [self getMember:memberId
          onSuccess:^(Member *member) {
              [self updateMember:memberId
                          crypto:crypto
                        prevHash:member.lastHash
                      operations:operations
                   metadataArray:[NSArray array]
                          reason:reason
                       onSuccess:onSuccess
                         onError:onError];
          } onError:onError];
}

- (void)completeRecoveryWithDefaultRule:(NSString *)memberId
                         verificationId:(NSString *)verificationId
                                   code:(NSString *)code
                                 crypto:(TKCrypto *)crypto
                              onSuccess:(OnSuccessWithMember)onSuccess
                                onError:(OnError)onError {
    Key *privilegedKey = [crypto generateKey:Key_Level_Privileged];
    
    if (!privilegedKey) {
        onError([NSError
                 errorFromErrorCode:kTKErrorKeyNotFound
                 details:TKLocalizedString(@"Private_Key_Not_Found", @"Private Key Not Found")]);
        return;
    }
    
    [self getRecoveryAuthorization:verificationId
                              code:code
                     privilegedKey:privilegedKey
                         onSuccess:^(MemberRecoveryOperation *mro) {
                             [self completeRecovery:memberId
                                 recoveryOperations:[NSArray arrayWithObject:mro]
                                      privilegedKey:privilegedKey
                                             crypto:crypto
                                          onSuccess:onSuccess
                                            onError:onError];
                         } onError:onError];
}

- (void)getRecoveryAuthorization:(NSString *)verificationId
                            code:(NSString *)code
                   privilegedKey:(Key *)privilegedKey
                       onSuccess:(OnSuccessWithMemberRecoveryOperation)onSuccess
                         onError:(OnError)onError {
    CompleteRecoveryRequest *request = [CompleteRecoveryRequest message];
    request.verificationId = verificationId;
    request.code = code;
    request.key = privilegedKey;
    RpcLogStart(request);
    
    __block GRPCProtoCall *call = [gateway
                                   RPCToCompleteRecoveryWithRequest: request
                                   handler:^(CompleteRecoveryResponse *response, NSError *error) {
                                       if (response) {
                                           RpcLogCompletedWithMetaData(response, call);
                                           if (response.status != VerificationStatus_Success) {
                                               onError([NSError
                                                        errorFromVerificationStatus:response.status
                                                        userInfo:nil]);
                                               return;
                                           }
                                           onSuccess(response.recoveryEntry);
                                       } else {
                                           [self->errorHandler handle:onError withError:error];
                                       }
                                   }];
    [rpc execute:call request:request];
}
@end
