//
//  Created by Maxim Khutornenko on 11/10/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccessTokenConfig.h"

@implementation AccessTokenConfig

+ (AccessTokenConfig *)create:(NSString *)redeemerUsername {
    return [[AccessTokenConfig alloc] initWithRedeemer:redeemerUsername];
}

+ (AccessTokenConfig *)fromPayload:(TokenPayload *)payloadToInitFrom {
    return [[AccessTokenConfig alloc] initWithPayload:payloadToInitFrom];
}

- (id)initWithRedeemer:(NSString *)redeemerUsername {
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.nonce = [TKUtil nonce];
        payload.to.username = redeemerUsername;
        resources = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)initWithPayload:(TokenPayload *)payloadToInitFrom {
    self = [super init];
    if (self) {
        payload = [payloadToInitFrom copy];
        [payload.access clear];
        payload.nonce = [TKUtil nonce];
        resources = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)from:(NSString *)memberId {
    TokenMember *payer = [TokenMember message];
    payer.id_p = memberId;
    payload.from = payer;
}

- (void)forAllAddresses {
    AccessBody_Resource_AllAddresses *addresses = [AccessBody_Resource_AllAddresses message];
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.allAddresses = addresses;
    [resources addObject:resource];
}

- (void)forAddress:(NSString *)addressId {
    AccessBody_Resource_Address *address = [AccessBody_Resource_Address message];
    address.addressId = addressId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.address = address;
    [resources addObject:resource];
}

- (void)forAllAccounts {
    AccessBody_Resource_AllAccounts *accounts = [AccessBody_Resource_AllAccounts message];
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.allAccounts = accounts;
    [resources addObject:resource];
}

- (void)forAccount:(NSString *)accountId {
    AccessBody_Resource_Account *account = [AccessBody_Resource_Account message];
    account.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.account = account;
    [resources addObject:resource];
}

- (void)forAllTransactions {
    AccessBody_Resource_AllAccountTransactions *transactions = [AccessBody_Resource_AllAccountTransactions message];
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.allTransactions = transactions;
    [resources addObject:resource];
}

- (void)forAccountTransactions:(NSString *)accountId {
    AccessBody_Resource_AccountTransactions *transactions = [AccessBody_Resource_AccountTransactions message];
    transactions.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.transactions = transactions;
    [resources addObject:resource];
}

- (void)forAllBalances {
    AccessBody_Resource_AllAccountBalances *balances = [AccessBody_Resource_AllAccountBalances message];
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.allBalances = balances;
    [resources addObject:resource];
}

- (void)forAccountBalances:(NSString *)accountId {
    AccessBody_Resource_AccountBalance *balance = [AccessBody_Resource_AccountBalance message];
    balance.accountId = accountId;
    AccessBody_Resource *resource = [AccessBody_Resource message];
    resource.balance = balance;
    [resources addObject:resource];
}

- (void)forAll {
    [self forAllAddresses];
    [self forAllAccounts];
    [self forAllBalances];
    [self forAllTransactions];
}

- (TokenPayload *)toTokenPayload {
    [payload.access.resourcesArray addObjectsFromArray:[resources allObjects]];
    return payload;
}
@end
