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

@implementation TransferTokenBuilder

- (id)init:(TKMember *)member
    lifetimeAmount:(double)lifetimeAmount
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
            onAuthRequired:^(ExternalAuthorizationDetails *details) {
                NSError *error = [NSError errorFromExternalAuthorizationDetails:details];
                call.onError(error);
            }
                   onError:call.onError];
    }];
}

- (void)executeAsync:(OnSuccessWithToken)onSuccess
      onAuthRequired:(OnAuthRequired)onAuthRequired
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
    payload.transfer.lifetimeAmount = [NSString stringWithFormat:@"%g", self.lifetimeAmount];
    payload.transfer.amount = [NSString stringWithFormat:@"%g", self.chargeAmount];
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
        payload.transfer.instructions.source.account.tokenAuthorization.authorization = self.bankAuthorization;
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

    [[self.member getClient] createTransferToken:payload
                                       onSuccess:onSuccess
                                  onAuthRequired:onAuthRequired
                                         onError:onError];
}

@end
