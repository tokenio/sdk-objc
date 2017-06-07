//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TransferTokenBuilder.h"
#import "TokenIO.h"
#import "TokenIOAsync.h"
#import "TKClient.h"
#import "TKMemberAsync.h"
#import "Transferinstructions.pbobjc.h"
#import "Account.pbobjc.h"
#import "TKRpcSyncCall.h"

@implementation TransferTokenBuilder

- (id)init:(TKMemberAsync *)member
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
    
    if (!self.redeemerMemberId && !self.redeemerUsername) {
         @throw [NSException
         exceptionWithName:@"InvalidTokenException"
                    reason:@"No redeemer found on token"
                  userInfo:nil];       
    }
    
    TokenMember *payer = [TokenMember message];

    payer.id_p = [self.member id];
    
    TokenPayload *payload = [TokenPayload message];
    payload.version = @"1.0";
    payload.nonce = [TKUtil nonce];
    payload.from = payer;
    payload.transfer.lifetimeAmount = [NSString stringWithFormat:@"%g", self.lifetimeAmount];
    payload.transfer.amount = [NSString stringWithFormat:@"%g", self.chargeAmount];
    payload.transfer.currency = self.currency;
    
    if (self.accountId) {
        payload.transfer.instructions.source.account.token.memberId = [self.member id];
        payload.transfer.instructions.source.account.token.accountId = self.accountId;
    }
    
    if (self.bankAuthorization) {
        payload.transfer.instructions.source.account.tokenAuthorization.authorization = self.bankAuthorization;
    }
    
    if (self.redeemerUsername) {
        payload.transfer.redeemer.username = self.redeemerUsername;
    }
    
    if (self.redeemerMemberId) {
        payload.transfer.redeemer.id_p = self.redeemerMemberId;
    }
    
    if (self.toUsername) {
        payload.to.username = self.toUsername;
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
        payload.transfer.instructions.transferPurpose = self.purposeOfPayment;
    }
    
    [[self.member getClient] createToken:payload
                            onSuccess:^(Token *token) {
                                onSuccess(token);
                            }
                              onError:onError];
}

@end
