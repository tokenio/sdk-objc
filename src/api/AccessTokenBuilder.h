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
@interface AccessTokenBuilder : NSObject 

/**
 * Creates a new instance with a provided grantee alias.
 *
 * @param toAlias alias of the token grantee.
 */
+ (AccessTokenBuilder *)create:(Alias *)toAlias;

/**
 * Creates a new instance with a provided grantee id.
 *
 * @param toId id of the token grantee
 */
+ (AccessTokenBuilder *)createWithToId:(NSString *)toId;

/**
 * Creates a new instance from an existing token payload.
 *
 * @param payloadToInitFrom token payload to initialize the config from
 */
+ (AccessTokenBuilder *)fromPayload:(TokenPayload *)payloadToInitFrom;

/**
 * Creates a new instance from a token request.
 *
 * @param tokenRequest token request
 */
+ (AccessTokenBuilder *)fromTokenRequest:(TokenRequest *)tokenRequest;

 /**
 * Creates a new instance with a provided grantee alias.
 *
 * @param toAlias alias of the token grantee
 */
- (id)initWithToAlias:(Alias *)toAlias;

/**
 * Creates a new instance from an existing token payload.
 *
 * @param payloadToInitFrom token payload to initialize the config from
 */
- (id)initWithPayload:(TokenPayload *)payloadToInitFrom;

/**
 * Creates a new instance from a token request.
 *
 * @param tokenRequest token request
 */
- (id)initWithTokenRequest:(TokenRequest *)tokenRequest;

/**
 * Sets 'from' field on the payload.
 *
 * @param memberId token member ID to set
 */
- (void)from:(NSString *)memberId;

/**
 * Grants access to a given addressId.
 *
 * @param addressId address to grant access to
 */
- (void)forAddress:(NSString *)addressId;

/**
 * Grants access to a given accountId.
 *
 * @param accountId account to grant access to
 */
- (void)forAccount:(NSString *)accountId;


/**
 * Grants access to a given account transactions.
 *
 * @param accountId account to grant access to transactions
 */
- (void)forAccountTransactions:(NSString *)accountId;

/**
 * Grants access to a given account balances.
 * 
 * @param accountId account to grant access to balances
 */
- (void)forAccountBalances:(NSString *)accountId;

/**
 * Set entity redeemer is acting on behalf of.
 *
 * @param actingAs entity redeemer is acting on behalf of.
 */
- (void)actingAs:(ActingAs *)actingAs;

/**
 * Converts configuration to TokenPayload object.
 *
 * @return TokenPayload object
 */
- (TokenPayload *)toTokenPayload;

/**
 * Returns corresponding token request id.
 *
 * @return token request id
 */
- (NSString *)tokenRequestId;
@end
