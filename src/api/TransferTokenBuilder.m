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
#import "TKRpcSyncCall.h"
#import "TokenIOSync.h"
#import "TokenIO.h"
#import "TransferTokenBuilder.h"

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
    if (!self.accountId && !self.authorization) {
        @throw [NSException
         exceptionWithName:@"InvalidTokenException"
                    reason:@"No source account found on token"
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
    
    if (self.authorization) {
        payload.transfer.instructions.source.account.custom.bankId = self.authorization.bankId;
        payload.transfer.instructions.source.account.custom.payload = self.authorization.accessToken;
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
    
    if (self.purposeOfPayment) {
        payload.transfer.instructions.metadata.transferPurpose = self.purposeOfPayment;
    }
    
    if (self.actingAs) {
        payload.actingAs = self.actingAs;
    }

    payload.receiptRequested = self.receiptRequested;
    
    [[self.member getClient]
     createTransferToken:payload
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
