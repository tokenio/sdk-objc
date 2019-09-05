//
//  StandingOrderTokenBuilder.h
//  TokenSdk
//
//  Created by Sibin Lu on 9/4/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenProto.h"

@class TKMember;

NS_ASSUME_NONNULL_BEGIN

/**
 * Helper class that builds standing order Tokens.
 */
@interface StandingOrderTokenBuilder : NSObject

/// Payer member of the token.
@property (nonatomic) TKMember *member;

/// Amount per charge of the standing order token
@property (nonatomic) NSDecimalNumber *amount;

/// Currency of the token.
@property (nonatomic) NSString *currency;

/// ISO 20022 code for the frequency of the standing order: DAIL, WEEK, TOWK, MNTH, TOMN, QUTR, SEMI, YEAR
@property (nonatomic) NSString *frequency;

/// Start date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
@property (nonatomic) NSString *startDate;

/// End date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
@property (nonatomic) NSString * _Nullable endDate;

/// Expiration time in ms since 1970.
@property (nonatomic) int64_t expiresAtMs;

/// Effective-at time in ms since 1970.
@property (nonatomic) int64_t effectiveAtMs;

// The time after which endorse is no longer possible.
@property (nonatomic) int64_t endorseUntilMs;

/// Description.
@property (nonatomic) NSString * _Nullable descr;

/// The transfer source.
@property (nonatomic) TransferEndpoint * _Nullable source;

/// A linked source account to the token. It is not required if you have set the source transfer endpoint.
@property (nonatomic) NSString * _Nullable accountId;

/// Transfer destinations.
@property (nonatomic) NSArray<TransferDestination *> * _Nullable transferDestinations;

/// Payer, specified by Alias.
@property (nonatomic) Alias * _Nullable fromAlias;

/// Payee, specified by Alias.
@property (nonatomic) Alias * _Nullable toAlias;

/// Payee, specified by Member ID.
@property (nonatomic) NSString * _Nullable toMemberId;

/// Specify reference ID. If not set, the Token system chooses a random one.
@property (nonatomic) NSString * _Nullable refId;

/// Entity payee is acting on behalf of.
@property (nonatomic) ActingAs * _Nullable actingAs;

/// If receipt is requested. Default to false.
@property (nonatomic) BOOL receiptRequested;

/// The token request ID.
@property (nonatomic) NSString * _Nullable tokenRequestId;

/// Transfer instruction metadata.
@property (nonatomic) TransferInstructions_Metadata * _Nullable metadata;

/**
 * Initializes the standing order token builder.
 *
 * @param member payer of the token
 * @param amount amount per charge of the standing order token
 * @param currency currency of the token
 * @param frequency ISO 20022 code for the frequency of the standing order:
 *                  DAIL, WEEK, TOWK, MNTH, TOMN, QUTR, SEMI, YEAR
 * @param startDate start date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
 * @param endDate end date of the standing order: ISO 8601 YYYY-MM-DD or YYYYMMDD
 */
- (id)init:(TKMember *)member
    amount:(NSDecimalNumber *)amount
  currency:(NSString *)currency
 frequency:(NSString *)frequency
 startDate:(NSString *)startDate
   endDate:(NSString * _Nullable)endDate;

/**
 * Initializes the standing order token builder.
 *
 * @param member the payer of the token
 * @param tokenRequest token request
 * @return transfer token builder
 */
- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest;

/**
 * Builds the token payload.
 *
 */
- (TokenPayload *)buildPayload;

@end

NS_ASSUME_NONNULL_END
