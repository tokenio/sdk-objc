//
//  Created by Maxim Khutornenko on 11/10/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Token.pbobjc.h"
#import "TKUtil.h"

/**
 * Helps building an access token payload.
 */
@interface AccessTokenConfig : NSObject {
    TokenPayload * payload;
    NSMutableArray<AccessBody_Resource *> * resources;
}

/**
 * Creates a new instance from an existing token payload.
 *
 * @param payloadToInitFrom token payload to initialize the config from
 */
- (id)initWithPayload:(TokenPayload *)payloadToInitFrom;

/**
 * Creates a new instance with a provided redeemer username (the 'payload.to' field).
 *
 * @param redeemerUsername username of the token redeemer
 */
- (id)initWithRedeemer:(NSString *)redeemerUsername;

/**
 * Sets 'from' field on the payload.
 *
 * @param memberId token member ID to set
 */
- (void)from:(NSString *)memberId;

/**
 * Grants access to all addresses.
 */
- (void)forAllAddresses;

/**
 * Grants access to a given addressId.
 *
 * @param addressId address to grant access to
 */
- (void)forAddress:(NSString *)addressId;

/**
 * Grants access to all accounts.
 */
- (void)forAllAccounts;

/**
 * Grants access to a given accountId.
 *
 * @param accountId account to grant access to
 */
- (void)forAccount:(NSString *)accountId;

/**
 * Grants access to all transactions.
 */
- (void)forAllTransactions;

/**
 * Grants access to a given account transactions.
 *
 * @param accountId account to grant access to transactions
 */
- (void)forAccountTransactions:(NSString *)accountId;

/**
 * Grants access to all balances.
 */
- (void)forAllBalances;

/**
 * Grants access to a given account balances.
 * 
 * @param accountId account to grant access to balances
 */
- (void)forAccountBalances:(NSString *)accountId;

/**
 * Grants access to ALL resources (aka wildcard permissions).
 */
- (void)forAll;

/**
 * Converts configuration to TokenPayload object.
 *
 * @return TokenPayload object
 */
- (TokenPayload *)toTokenPayload;

@end
