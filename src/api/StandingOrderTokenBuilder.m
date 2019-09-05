//
//  StandingOrderTokenBuilder.m
//  TokenSdk
//
//  Created by Sibin Lu on 9/4/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import "StandingOrderTokenBuilder.h"
#import "TKMember.h"
#import "TKLogManager.h"

@implementation StandingOrderTokenBuilder
- (id)init:(TKMember *)member
    amount:(NSDecimalNumber *)amount
  currency:(NSString *)currency
 frequency:(NSString *)frequency
 startDate:(NSString *)startDate
   endDate:(NSString * _Nullable)endDate {
    self = [super init];
    if (self) {
        _member = member;
        _amount = amount;
        _frequency = frequency;
        _startDate = startDate;
        _endDate = endDate;
    }
    return self;
}

- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest {
    self = [super init];
    if (self) {
        _member = member;
        if ([self isNotEmpty:tokenRequest.requestPayload.refId]) {
            _refId = tokenRequest.requestPayload.refId;
        }
        if ([self isNotEmpty:tokenRequest.requestOptions.from.alias.value]) {
            _fromAlias = tokenRequest.requestOptions.from.alias;
        }
        if ([self isNotEmpty:tokenRequest.requestPayload.to.alias.value]) {
            _toAlias = tokenRequest.requestPayload.to.alias;
        }
        if ([self isNotEmpty:tokenRequest.requestPayload.to.id_p]) {
            _toMemberId = tokenRequest.requestPayload.to.id_p;
        }
        if ([self isNotEmpty:tokenRequest.requestPayload.description_p]) {
            _descr = tokenRequest.requestPayload.description_p;
        }
        _receiptRequested = tokenRequest.requestOptions.receiptRequested;

        if ([self isNotEmpty:tokenRequest.id_p]) {
            _tokenRequestId = tokenRequest.id_p;
        }

        StandingOrderBody *body = tokenRequest.requestPayload.standingOrderBody;
        if ([self isNotEmpty:body.startDate]) {
            _startDate = body.startDate;
        }
        if ([self isNotEmpty:body.endDate]) {
            _endDate = body.endDate;
        }
        if ([self isNotEmpty:body.frequency]) {
            _frequency = body.frequency;
        }
        if ([self isNotEmpty:body.amount]) {
            _amount = [NSDecimalNumber decimalNumberWithString:body.amount];
        }
        if ([self isNotEmpty:body.currency]) {
            _currency = body.currency;
        }

        if (body.hasInstructions && (body.instructions.transferDestinationsArray.count > 0)) {
            _transferDestinations = body.instructions.transferDestinationsArray;
        }

        if (body.hasInstructions && (body.instructions.transferDestinationsArray.count > 0)) {
            _transferDestinations = body.instructions.transferDestinationsArray;
        }

        if (body.hasInstructions && body.instructions.hasMetadata) {
            _metadata = body.instructions.metadata;
        }

        if (tokenRequest.requestPayload.hasActingAs && tokenRequest.requestPayload.actingAs.displayName.length > 0) {
            _actingAs = tokenRequest.requestPayload.actingAs;
        }
    }
    return self;
}

/**
 * Builds the token payload.
 *
 */
- (TokenPayload *)buildPayload {
    TokenPayload *payload = [TokenPayload message];
    payload.version = @"1.0";
    payload.from.id_p = self.member.id;
    if (self.fromAlias && [self isNotEmpty:self.fromAlias.value]) {
        payload.from.alias = self.fromAlias;
    }
    if ([self isNotEmpty:self.toMemberId]) {
        payload.to.id_p = self.toMemberId;
    }
    if (self.toAlias && [self isNotEmpty:self.toAlias.value]) {
        payload.to.alias = self.toAlias;
    }
    payload.standingOrder.currency = self.currency;
    payload.standingOrder.amount = [self.amount stringValue];
    payload.standingOrder.frequency = self.frequency;
    payload.standingOrder.startDate = self.startDate;
    if ([self isNotEmpty:self.endDate]) {
        payload.standingOrder.endDate = self.endDate;
    }
    if (self.expiresAtMs > 0) {
        payload.expiresAtMs = self.expiresAtMs;
    }
    if (self.effectiveAtMs > 0) {
        payload.effectiveAtMs = self.effectiveAtMs;
    }
    if (self.endorseUntilMs > 0) {
        payload.endorseUntilMs = self.endorseUntilMs;
    }
    if ([self isNotEmpty:self.descr]) {
        payload.description_p = self.descr;
    }
    if (self.source) {
        payload.standingOrder.instructions.source = self.source;
    } else if (self.accountId) {
        payload.standingOrder.instructions.source.account.token.memberId = self.member.id;
        payload.standingOrder.instructions.source.account.token.accountId = self.accountId;
    }
    if (self.transferDestinations && (self.transferDestinations.count > 0)) {
        [payload.standingOrder.instructions.transferDestinationsArray addObjectsFromArray:self.transferDestinations];
    }
    if (self.metadata) {
        payload.standingOrder.instructions.metadata = self.metadata;
    }
    if (self.refId && ![self.refId isEqualToString:@""]) {
        payload.refId = self.refId;
    } else {
        TKLogWarning(@"refId is not set. A random ID will be used.")
        payload.refId = [TKUtil nonce];
    }
    if (self.actingAs) {
        payload.actingAs = self.actingAs;
    }
    payload.receiptRequested = self.receiptRequested;
    if (self.tokenRequestId) {
        payload.tokenRequestId = self.tokenRequestId;
    }

    return payload;
}

- (BOOL) isNotEmpty:(NSString *) string {
    return string && ![string isEqualToString:@""];
}
@end
