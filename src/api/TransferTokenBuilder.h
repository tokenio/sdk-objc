//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <objc/NSObject.h>
#import "TKTypedef.h"
#import "Transferinstructions.pbobjc.h"

@class TransferEndpoint;
@class Alias;
@class ActingAs;

/**
 * Helper class that builds Transfer Tokens.
 */
@interface TransferTokenBuilder : NSObject

/// Member, normally set by `create`.
@property (nonatomic) TKMember *member;

/// Specify member ID of payer account.
@property (nonatomic) NSString *fromMemberId;

/// Currency string, normally set by `create`.
@property (nonatomic) NSString *currency;

/// Transfer amount, normally set by `create`.
@property (nonatomic) NSDecimalNumber *lifetimeAmount;

/**
 * Specify how much redeemer can redeem each time.
 * For example, to enable 12x 10€ payments, set lifetimeAmount to 120,
 * chargeAmount to 10.
 */
@property (nonatomic) NSDecimalNumber *chargeAmount;

/// Account ID from which to pay.
@property (nonatomic) NSString *accountId;

/// One-time authorization for payment.
@property (nonatomic) OauthBankAuthorization *authorization;

/// Expiration time in ms since 1970.
@property (nonatomic) int64_t expiresAtMs;

/// Effective-at time in ms since 1970.
@property (nonatomic) int64_t effectiveAtMs;

/// Redeemer, specified by alias.
@property (nonatomic) Alias *redeemerAlias DEPRECATED_ATTRIBUTE;

/// Redeemer, specified by Member ID.
@property (nonatomic) NSString* redeemerMemberId DEPRECATED_ATTRIBUTE;

/// Payer, specified by Alias.
@property (nonatomic) Alias *fromAlias;

/// Payee, specified by Alias.
@property (nonatomic) Alias *toAlias;

/// Payee, specified by Member ID.
@property (nonatomic) NSString *toMemberId;

/// Description.
@property (nonatomic) NSString *descr;

/// Purpose code. Refer to ISO 20022 external code sets.
@property (nonatomic) NSString *purposeCode;

/// Destination bank accounts.
@property (nonatomic) NSArray<TransferDestination *> *transferDestinations;

/// Deprecated. Use transferDestinations instead.
@property (nonatomic) NSArray<TransferEndpoint *> *destinations DEPRECATED_ATTRIBUTE;

/// Attachment "files".
@property (nonatomic) NSArray<Attachment *> *attachments;

/// Specify reference ID. If not set, the Token system chooses a random one.
@property (nonatomic) NSString *refId;

/// Set entity redeemer is acting on behalf of.
@property (nonatomic) ActingAs *actingAs;

/// If receipt is requested. Default to false.
@property (nonatomic) BOOL receiptRequested;

/// Set the token request ID.
@property (nonatomic) NSString *tokenRequestId;

/// End date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
@property (nonatomic) NSString *executionDate;

/**
 * Initializes the transfer token builder.
 *
 * @param member the payer of the token
 * @param lifetimeAmount the total lifetime amount of the token
 * @param currency the currency of the token
 * @return transfer token builder
 */
- (id)init:(TKMember *)member lifetimeAmount:(NSDecimalNumber *)lifetimeAmount currency:(NSString *)currency;

/**
 * Initializes the transfer token builder.
 *
 * @param member the payer of the token
 * @param tokenRequest token request
 * @return transfer token builder
 */
- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest;

/**
 * Initializes the transfer token builder.
 *
 * @param member the payer of the token
 * @param tokenPayload token payload
 * @return transfer token builder
 */
- (id)init:(TKMember *)member tokenPayload:(TokenPayload *)tokenPayload;

/**
 * Builds the token payload.
 */
- (TokenPayload *)buildPayload;

/**
 * Executes the request, creating the token. Throws error if external authorization is required.
 *
 * @return transfer token
 */
- (Token *)execute __deprecated_msg("Use the new token flow instead. see PrepareToken methods in Member");

/**
 * Executes the request, creating the token, async.
 *
 * @param onSuccess invoked on success
 * @param onError invoked on error
 */
- (void)executeAsync:(OnSuccessWithToken)onSuccess onError:(OnError)onError
__deprecated_msg("Use the new token flow instead. see PrepareToken methods in Member");
@end
