//
//  Created by Maxim Khutornenko on 11/10/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccessTokenBuilder.h"

@implementation AccessTokenBuilder {
    TokenPayload * payload;
    NSMutableSet<AccessBody_Resource *> * resources;
    NSString *tokenRequestId;
}

+ (AccessTokenBuilder *)create:(Alias *)toAlias {
    return [[AccessTokenBuilder alloc] initWithToAlias:toAlias];
}

+ (AccessTokenBuilder *)createWithToId:(NSString *)toId {
    return [[AccessTokenBuilder alloc] initWithToId:toId];
}

+ (AccessTokenBuilder *)fromPayload:(TokenPayload *)payloadToInitFrom {
    return [[AccessTokenBuilder alloc] initWithPayload:payloadToInitFrom];
}

+ (AccessTokenBuilder *)fromTokenRequest:(TokenRequest *)tokenRequest {
    return [[AccessTokenBuilder alloc] initWithTokenRequest:tokenRequest];
}

- (id)initWithToAlias:(Alias *)toAlias {
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.refId = [TKUtil nonce];
        payload.to.alias = toAlias;
        resources = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)initWithToId:(NSString *)toId {
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.refId = [TKUtil nonce];
        payload.to.id_p = toId;
        resources = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)initWithPayload:(TokenPayload *)payloadToInitFrom {
    self = [super init];
    if (self) {
        payload = [payloadToInitFrom copy];
        [payload.access clear];
        payload.refId = [TKUtil nonce];
        resources = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)initWithTokenRequest:(TokenRequest *)tokenRequest{
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.refId = [TKUtil nonce];
        payload.from = tokenRequest.requestOptions.from;
        payload.to = tokenRequest.requestPayload.to;
        payload.actingAs = tokenRequest.requestPayload.actingAs;
        payload.description_p = tokenRequest.requestPayload.description;
        payload.receiptRequested = tokenRequest.requestOptions.receiptRequested;
        resources = [[NSMutableSet alloc] init];
        tokenRequestId = tokenRequest.id_p;
    }
    return self;
}

- (void)from:(NSString *)memberId {
    TokenMember *payer = [TokenMember message];
    payer.id_p = memberId;
    payload.from = payer;
}

- (void)forAddress:(NSString *)addressId {
    AccessBody_Resource_Address *address = [AccessBody_Resource_Address message];
    address.addressId = addressId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.address = address;
    [resources addObject:resource];
}

- (void)forAccount:(NSString *)accountId {
    AccessBody_Resource_Account *account = [AccessBody_Resource_Account message];
    account.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.account = account;
    [resources addObject:resource];
}

- (void)forAccountTransactions:(NSString *)accountId {
    AccessBody_Resource_AccountTransactions *transactions = [AccessBody_Resource_AccountTransactions message];
    transactions.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.transactions = transactions;
    [resources addObject:resource];
}

- (void)forAccountBalances:(NSString *)accountId {
    AccessBody_Resource_AccountBalance *balance = [AccessBody_Resource_AccountBalance message];
    balance.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.balance = balance;
    [resources addObject:resource];
}

- (void)forTransferDestinations:(NSString *)accountId {
    AccessBody_Resource_TransferDestinations *transferDestinations =[AccessBody_Resource_TransferDestinations message];
    transferDestinations.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.transferDestinations = transferDestinations;
    [resources addObject:resource];
}

- (void)forFundsConfirmation:(NSString *)accountId {
    AccessBody_Resource_FundsConfirmation *fundsConfirmation =[AccessBody_Resource_FundsConfirmation message];
    fundsConfirmation.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.fundsConfirmation = fundsConfirmation;
    [resources addObject:resource];
}

- (void)actingAs:(ActingAs *)actingAs {
    payload.actingAs = actingAs;
}

- (TokenPayload *)toTokenPayload {
    [payload.access.resourcesArray addObjectsFromArray:[resources allObjects]];
    return payload;
}

- (NSString *)tokenRequestId {
    return tokenRequestId;
}
@end
