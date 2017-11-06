//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <objc/NSObject.h>
#import "TKTypedef.h"
#import "Transferinstructions.pbobjc.h"

@class TransferEndpoint;
@class Alias;

@interface TransferTokenBuilder : NSObject

@property (readwrite) TKMember *member;
@property (readwrite) NSString *fromMemberId;
@property (readwrite) NSString *currency;
@property (readwrite) double lifetimeAmount;
@property (readwrite) double chargeAmount;
@property (readwrite) NSString *accountId;
@property (readwrite) BankAuthorization *bankAuthorization;
@property (readwrite) int64_t expiresAtMs;
@property (readwrite) int64_t effectiveAtMs;
@property (readwrite) Alias *redeemerAlias;
@property (readwrite) NSString* redeemerMemberId;
@property (readwrite) Alias *fromAlias;
@property (readwrite) Alias *toAlias;
@property (readwrite) NSString *toMemberId;
@property (readwrite) NSString *descr;
@property (readwrite) Pricing *pricing;
@property (readwrite) PurposeOfPayment purposeOfPayment;
@property (readwrite) NSArray<TransferEndpoint*> *destinations;
@property (readwrite) NSArray<Attachment*> *attachments;
@property (readwrite) NSString *refId;

/**
 * Initializes the transfer token builder.
 *
 * @param member the payer of the token
 * @param lifetimeAmount the total lifetime amount of the token
 * @param currency the currency of the token
 * @return transfer token builder
 */
- (id)init:(TKMember *)member
    lifetimeAmount:(double)lifetimeAmount
          currency:(NSString*)currency;

/**
 * Executes the request, creating the token. Throws error if external authorization is required.
 *
 * @return transfer token and external authorization details
 */
- (Token *)execute;

/**
 * Executes the request, creating the token, async.
 *
 * @param onSuccess invoked on success
 * @param OnAuthRequired invoked on external authorization required
 * @param onError invoked on error
 */
- (void)executeAsync:(OnSuccessWithToken)onSuccess
      OnAuthRequired:(OnAuthRequired)OnAuthRequired
             onError:(OnError)onError;

@end
