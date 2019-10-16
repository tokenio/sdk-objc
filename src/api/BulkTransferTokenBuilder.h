//
//  BulkTransferTokenBuilder.h
//  TokenSdk
//
//  Created by Sibin Lu on 10/15/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenProto.h"

@class ActingAs;
@class Alias;
@class TKMember;
@class TransferEndpoint;

/**
 * Helper class that builds bulk transfer token.
*/
@interface BulkTransferTokenBuilder : NSObject

/// Expiration time in ms since 1970.
@property (nonatomic) int64_t expiresAtMs;

/// Effective time in ms since 1970.
@property (nonatomic) int64_t effectiveAtMs;

// The time after which endorse is no longer possible.
@property (nonatomic) int64_t endorseUntilMs;

/// Description.
@property (nonatomic) NSString *descr;

/// a transfer source.
@property (nonatomic) TransferEndpoint *source;

/// Account ID from which to pay.
@property (nonatomic) NSString *accountId;

/// Payer, specified by Alias.
@property (nonatomic) Alias *fromAlias;

/// Payee, specified by Alias.
@property (nonatomic) Alias *toAlias;

/// Payee, specified by Member ID.
@property (nonatomic) NSString *toMemberId;

/// Specify reference ID. If not set, the Token system chooses a random one.
@property (nonatomic) NSString *refId;

/// Set entity redeemer is acting on behalf of.
@property (nonatomic) ActingAs *actingAs;

/// If receipt is requested. Default to false.
@property (nonatomic) BOOL receiptRequested;

/// Set the token request ID.
@property (nonatomic) NSString *tokenRequestId;

/**
 * Initializes the transfer token builder.
 *
 * @param member payer of the token
 * @param transfers list of transfers
 * @param totalAmount total amount irrespective of currency. Used for redundancy check.
 * @param source source account for all transfer
 */
- (id)init:(TKMember *)member
 transfers:(NSArray<BulkTransferBody_Transfer *> *)transfers
totalAmount:(NSDecimalNumber *)totalAmount
    source:(TransferEndpoint *)source;

/**
 * Initializes the transfer token builder.
 *
 * @param member the payer of the token
 * @param tokenRequest token request
 */
- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest;

/**
* Builds the token payload.
*/
- (TokenPayload *)buildPayload;

@end
