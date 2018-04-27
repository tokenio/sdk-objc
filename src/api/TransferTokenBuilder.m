//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TransferTokenBuilder.h"
#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TKClient.h"
#import "TKMember.h"
#import "Transferinstructions.pbobjc.h"
#import "Account.pbobjc.h"
#import "TKError.h"
#import "TKRpcSyncCall.h"
#import "TKAuthorizationEngine.h"

@implementation TransferTokenBuilder

- (id)init:(TKMember *)member
lifetimeAmount:(NSDecimalNumber *)lifetimeAmount
  currency:(NSString*)currency {
    
    self = [super init];
    if (self) {
        self.member = member;
        self.lifetimeAmount = lifetimeAmount;
        self.currency = currency;
    }
    
    return self;
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
    if (!self.accountId && !self.bankAuthorization) {
        @throw [NSException
         exceptionWithName:@"InvalidTokenException"
                    reason:@"No source account found on token"
                  userInfo:nil];
    }
    
    if (!self.redeemerMemberId && !self.redeemerAlias) {
         @throw [NSException
         exceptionWithName:@"InvalidTokenException"
                    reason:@"No redeemer found on token"
                  userInfo:nil];       
    }
    
    TokenMember *payer = [TokenMember message];

    payer.id_p = [self.member id];
    if (self.fromAlias) {
        payer.alias = self.fromAlias;
    }
    
    TokenPayload *payload = [TokenPayload message];
    payload.version = @"1.0";
    payload.from = payer;
    payload.transfer.lifetimeAmount = [self.lifetimeAmount stringValue];
    payload.transfer.amount = [self.chargeAmount stringValue];
    payload.transfer.currency = self.currency;
    
    if (self.refId) {
        payload.refId = self.refId;
    }
    else {
        payload.refId = [TKUtil nonce];
    }
    
    if (self.accountId) {
        payload.transfer.instructions.source.account.token.memberId = [self.member id];
        payload.transfer.instructions.source.account.token.accountId = self.accountId;
    }
    
    if (self.bankAuthorization) {
        payload.transfer.instructions.source.account.tokenAuthorization.authorization
        = self.bankAuthorization;
    }
    
    if (self.redeemerAlias) {
        payload.transfer.redeemer.alias = self.redeemerAlias;
    }
    
    if (self.redeemerMemberId) {
        payload.transfer.redeemer.id_p = self.redeemerMemberId;
    }
    
    if (self.toAlias) {
        payload.to.alias = self.toAlias;
    }
    
    if (self.toMemberId) {
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
    
    if (self.destinations) {
        [payload.transfer.instructions.destinationsArray addObjectsFromArray:self.destinations];
    }
    
    if (self.attachments) {
        [payload.transfer.attachmentsArray addObjectsFromArray:self.attachments];
    }
    
    if (self.pricing) {
        payload.transfer.pricing = self.pricing;
    }
    
    if (self.purposeOfPayment) {
        payload.transfer.instructions.metadata.transferPurpose = self.purposeOfPayment;
    }
    
    if (self.actingAs) {
        payload.actingAs = self.actingAs;
    }

    [[self.member getClient]
     createTransferToken:payload
     onSuccess:onSuccess
     onAuthRequired:^(ExternalAuthorizationDetails *details) {
         TKAuthorizationEngine *authEngine =
         [[TKAuthorizationEngine alloc] initWithBrowserFactory:self.member.browserFactory
                                  ExternalAuthorizationDetails:details];
         
         [authEngine
          authorizeOnSuccess:^(BankAuthorization *auth) {
              payload.transfer.instructions.source.account.tokenAuthorization.authorization = auth;
              
              [[self.member getClient]
               createTransferToken:payload
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
@end
