//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Account.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "TKAccount.h"
#import "TKClient.h"
#import "TKError.h"
#import "TKMember.h"
#import "TKOauthEngine.h"
#import "TKLogManager.h"
#import "TKRpcSyncCall.h"
#import "TokenClient.h"
#import "TransferTokenBuilder.h"

@implementation TransferTokenBuilder

- (id)init:(TKMember *)member lifetimeAmount:(NSDecimalNumber *)lifetimeAmount currency:(NSString*)currency {
    self = [super init];
    if (self) {
        _member = member;
        _lifetimeAmount = lifetimeAmount;
        _currency = currency;
    }
    return self;
}

- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest {
    self = [super init];
    if (self) {
        _member = member;
        _refId = tokenRequest.requestPayload.refId;
        if (tokenRequest.requestOptions.from.hasAlias) {
            _fromAlias = tokenRequest.requestOptions.from.alias;
        }
        self.fromMemberId = tokenRequest.requestOptions.from.id_p;
        if (tokenRequest.requestPayload.to.hasAlias) {
            _toAlias = tokenRequest.requestPayload.to.alias;
        }
        _toMemberId = tokenRequest.requestPayload.to.id_p;
        _descr = tokenRequest.requestPayload.description_p;
        _receiptRequested = tokenRequest.requestOptions.receiptRequested;
        
        TokenRequestPayload_TransferBody *transfer = tokenRequest.requestPayload.transferBody;
        
        NSString *requestLifeTimeAmount = transfer.lifetimeAmount;
        if (requestLifeTimeAmount && requestLifeTimeAmount.length > 0) {
            _lifetimeAmount = [NSDecimalNumber decimalNumberWithString:requestLifeTimeAmount];
        }
        _currency = transfer.currency;
        NSString *requestChargeAmounnt = transfer.amount;
        if (requestChargeAmounnt && requestChargeAmounnt.length > 0) {
            _lifetimeAmount = [NSDecimalNumber decimalNumberWithString:requestChargeAmounnt];
        }
        if (transfer.hasInstructions && (transfer.instructions.transferDestinationsArray.count > 0)) {
            _transferDestinations = transfer.instructions.transferDestinationsArray;
        } else {
            _destinations = transfer.destinationsArray;
        }
        
        if (tokenRequest.requestPayload.hasActingAs && tokenRequest.requestPayload.actingAs.displayName.length > 0) {
            _actingAs = tokenRequest.requestPayload.actingAs;
        }
        _tokenRequestId = tokenRequest.id_p;

        if (tokenRequest.requestPayload.transferBody.executionDate
            && ![tokenRequest.requestPayload.transferBody.executionDate isEqualToString:@""]) {
            _executionDate = tokenRequest.requestPayload.transferBody.executionDate;
        }
    }
    return self;
}

- (id)init:(TKMember *)member tokenPayload:(TokenPayload *)tokenPayload {
    self = [super init];
    if (self) {
        _member = member;
        _lifetimeAmount = [NSDecimalNumber decimalNumberWithString:tokenPayload.transfer.lifetimeAmount];
        _chargeAmount = [NSDecimalNumber decimalNumberWithString:tokenPayload.transfer.amount];
        _currency = tokenPayload.transfer.currency;
        
        if (![tokenPayload.from.id_p isEqual:@""]) {
            _fromMemberId = tokenPayload.from.id_p;
        }
        if (tokenPayload.from.hasAlias && ![tokenPayload.from.alias.value isEqual:@""]) {
            _fromAlias = tokenPayload.from.alias;
        }
        
        if (![tokenPayload.to.id_p isEqual:@""]) {
            _toMemberId = tokenPayload.to.id_p;
        }
        if (tokenPayload.to.hasAlias & ![tokenPayload.to.alias.value isEqual:@""]) {
            _toAlias = tokenPayload.to.alias;
        }
        
        _refId = tokenPayload.refId;
        _accountId = tokenPayload.transfer.instructions.source.account.token.accountId;
        _expiresAtMs = tokenPayload.expiresAtMs;
        _effectiveAtMs = tokenPayload.expiresAtMs;
        _descr = tokenPayload.description_p;
        
        if (tokenPayload.transfer.instructions.transferDestinationsArray.count > 0) {
            _transferDestinations = tokenPayload.transfer.instructions.transferDestinationsArray;
        }
        if (tokenPayload.transfer.instructions.destinationsArray.count > 0) {
            _destinations = tokenPayload.transfer.instructions.destinationsArray;
        }
        
        if (tokenPayload.hasActingAs) {
            _actingAs = tokenPayload.actingAs;
        }
        _receiptRequested = tokenPayload.receiptRequested;
        
        if (tokenPayload.tokenRequestId && ![tokenPayload.tokenRequestId isEqualToString:@""]) {
            _tokenRequestId = tokenPayload.tokenRequestId;
        }
        if (tokenPayload.transfer.executionDate && ![tokenPayload.transfer.executionDate isEqualToString:@""]) {
            _executionDate = tokenPayload.transfer.executionDate;
        }
    }
    return self;
}

- (TokenPayload *)buildPayload {
    TokenMember *payer = [TokenMember message];
    if (self.fromMemberId && ![self.fromMemberId isEqualToString:@""]) {
        payer.id_p = self.fromMemberId;
        if (self.fromAlias && ![self.fromAlias.value isEqual:@""]) {
            payer.alias = self.fromAlias;
        }
    } else {
        payer.id_p = self.member.id;
    }
    
    TokenPayload *payload = [TokenPayload message];
    payload.version = @"1.0";
    payload.from = payer;
    payload.transfer.lifetimeAmount = [self.lifetimeAmount stringValue];
    if (self.chargeAmount && ![self.chargeAmount isEqual:NSDecimalNumber.notANumber]) {
        payload.transfer.amount = [self.chargeAmount stringValue];
    }
    payload.transfer.currency = self.currency;
    
    if (self.refId) {
        payload.refId = self.refId;
    } else {
        TKLogWarning(@"refId is not set. A random ID will be used.")
        payload.refId = [TKUtil nonce];
    }
    
    if (self.accountId) {
        payload.transfer.instructions.source.account.token.memberId = payer.id_p;
        payload.transfer.instructions.source.account.token.accountId = self.accountId;
    }
    
    if (self.authorization) {
        payload.transfer.instructions.source.account.custom.bankId = self.authorization.bankId;
        payload.transfer.instructions.source.account.custom.payload = self.authorization.accessToken;
    }
    
    if (self.toAlias && ![self.toAlias.value isEqual:@""]) {
        payload.to.alias = self.toAlias;
    }
    
    if (self.toMemberId  && ![self.toMemberId isEqual:@""]) {
        payload.to.id_p = self.toMemberId;
    }
    
    if (self.expiresAtMs) {
        payload.expiresAtMs = self.expiresAtMs;
    }
    
    if (self.effectiveAtMs) {
        payload.effectiveAtMs = self.effectiveAtMs;
    }
    
    if (self.descr) {
        payload.description_p = self.descr;
    }
    
    if (self.transferDestinations && (self.transferDestinations.count > 0)) {
        [payload.transfer.instructions.transferDestinationsArray addObjectsFromArray:self.transferDestinations];
    }
    else if (self.destinations) {
        [payload.transfer.instructions.destinationsArray addObjectsFromArray:self.destinations];
    }
    
    if (self.attachments) {
        [payload.transfer.attachmentsArray addObjectsFromArray:self.attachments];
    }
    
    if (self.purposeCode) {
        payload.transfer.instructions.metadata.purposeCode = self.purposeCode;
    }
    
    if (self.actingAs) {
        payload.actingAs = self.actingAs;
    }
    
    payload.receiptRequested = self.receiptRequested;
    if (self.tokenRequestId) {
        payload.tokenRequestId = self.tokenRequestId;
    }

    if (self.executionDate && ![self.executionDate isEqualToString:@""]) {
        payload.transfer.executionDate = self.executionDate;
    }
    
    return payload;
}

- (Token *)execute {
    TKRpcSyncCall<Token *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [self executeAsync:call.onSuccess
                   onError:call.onError];
    }];
}

- (void)executeAsync:(OnSuccessWithToken)onSuccess
             onError:(OnError)onError {
    if (!self.accountId && !self.authorization) {
        @throw [NSException
                exceptionWithName:@"InvalidTokenException"
                reason:@"No source account found on token"
                userInfo:nil];
    }

    TokenPayload *payload = [self buildPayload];
    [[self.member getClient]
     createTransferToken:payload
     tokenRequestId:self.tokenRequestId
     onSuccess:onSuccess
     onAuthRequired:^(ExternalAuthorizationDetails *details) {
         [self.member
          getAccount:self.accountId
          onSuccess:^(TKAccount *account) {
              TKOauthEngine *authEngine =
              [[TKOauthEngine alloc] initWithTokenCluster:self.member.tokenCluster
                                           BrowserFactory:self.member.browserFactory
                                                      url:details.authorizationURL];
              [authEngine
               authorizeOnSuccess:^(NSString *accessToken) {
                   payload.transfer.instructions.source.account.custom.bankId = account.bankId;
                   payload.transfer.instructions.source.account.custom.payload = accessToken;
                   
                   [[self.member getClient]
                    createTransferToken:payload
                    tokenRequestId:self.tokenRequestId
                    onSuccess:onSuccess
                    onAuthRequired:^(ExternalAuthorizationDetails *details) {
                        /* We tried using the authorization we received,
                         but bank apparently wants other authorization, so fail. */
                        onError([NSError
                                 errorFromTransferTokenStatus:
                                 TransferTokenStatus_FailureExternalAuthorizationRequired]);
                    }
                    onError:onError];
                   
                   [authEngine close];
               } onError:^(NSError *error) {
                   onError(error);
                   [authEngine close];
               }];
          }
          onError:onError];
     }
     onError:onError];
}
@end
