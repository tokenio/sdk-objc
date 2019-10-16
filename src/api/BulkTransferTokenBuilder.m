//
//  BulkTransferTokenBuilder.m
//  TokenSdk
//
//  Created by Sibin Lu on 10/15/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import "BulkTransferTokenBuilder.h"
#import "TKLogManager.h"
#import "TKMember.h"
#import "TokenProto.h"

@interface BulkTransferTokenBuilder() {
    TokenPayload *payload;
}
@end

@implementation BulkTransferTokenBuilder

- (id)init:(TKMember *)member
 transfers:(NSArray<BulkTransferBody_Transfer *> *)transfers
totalAmount:(NSDecimalNumber *)totalAmount
    source:(TransferEndpoint *)source {
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.from.id_p = member.id;
        payload.from.alias = member.firstAlias;
        payload.bulkTransfer.transfersArray = [NSMutableArray arrayWithArray:transfers];
        payload.bulkTransfer.totalAmount = [totalAmount stringValue];
        payload.bulkTransfer.source = source;
    }
    return self;
}

- (id)init:(TKMember *)member tokenRequest:(TokenRequest *)tokenRequest {
    self = [super init];
    if (self) {
        payload = [TokenPayload message];
        payload.version = @"1.0";
        payload.from.id_p = member.id;
        payload.from.alias = member.firstAlias;
        payload.refId = tokenRequest.requestPayload.refId;
        payload.from = tokenRequest.requestOptions.from;
        payload.to = tokenRequest.requestPayload.to;
        payload.description_p = tokenRequest.requestPayload.description_p;
        payload.receiptRequested = tokenRequest.requestOptions.receiptRequested;
        payload.tokenRequestId = tokenRequest.id_p;
        payload.bulkTransfer = tokenRequest.requestPayload.bulkTransferBody;
        if (tokenRequest.requestPayload.hasActingAs && ![tokenRequest.requestPayload.actingAs.displayName isEqualToString:@""]) {
            payload.actingAs = tokenRequest.requestPayload.actingAs;
        }
    }
    return self;
}

- (TokenPayload *)buildPayload {
    if (!payload.refId || [payload.refId isEqualToString:@""]) {
        TKLogWarning(@"refId is not set. A random ID will be used.");
        payload.refId = [TKUtil nonce];
    }
    return payload;
}

- (int64_t)expiresAtMs {
    return payload.expiresAtMs;
}

- (void)setExpiresAtMs:(int64_t)expiresAtMs {
    payload.expiresAtMs = expiresAtMs;
}

- (int64_t)effectiveAtMs {
    return payload.effectiveAtMs;
}

- (void)setEffectiveAtMs:(int64_t)effectiveAtMs {
    payload.effectiveAtMs = effectiveAtMs;
}

- (int64_t)endorseUntilMs {
    return payload.endorseUntilMs;
}

- (void)setEndorseUntilMs:(int64_t)endorseUntilMs {
    payload.endorseUntilMs = endorseUntilMs;
}

- (NSString *)descr {
    return payload.description_p;
}

- (void)setDescr:(NSString *)descr {
    payload.description_p = descr;
}

- (TransferEndpoint *)source {
    return payload.bulkTransfer.source;
}

- (void)setSource:(TransferEndpoint *)source {
    payload.bulkTransfer.source = source;
}

- (NSString *)accountId {
    return payload.bulkTransfer.source.account.token.accountId;
}

- (void)setAccountId:(NSString *)accountId {
    payload.bulkTransfer.source.account.token.accountId = accountId;
    payload.bulkTransfer.source.account.token.memberId = payload.from.id_p;
}

- (Alias *)fromAlias {
    return payload.from.alias;
}

- (void)setFromAlias:(Alias *)fromAlias {
    payload.from.alias = fromAlias;
}

- (Alias *)toAlias {
    return payload.to.alias;
}

- (void)setToAlias:(Alias *)toAlias {
    payload.to.alias = toAlias;
}

- (NSString *)toMemberId {
    return payload.to.id_p;
}

- (void)setToMemberId:(NSString *)toMemberId {
    payload.to.id_p = toMemberId;
}

- (NSString *)refId {
    return payload.refId;
}

- (void)setRefId:(NSString *)refId {
    payload.refId = refId;
}

- (ActingAs *)actingAs {
    return payload.actingAs;
}

- (void)setActingAs:(ActingAs *)actingAs {
    if (actingAs && ![actingAs.displayName isEqualToString:@""]) {
        payload.actingAs = actingAs;
    }
}

- (BOOL)receiptRequested {
    return payload.receiptRequested;
}

- (void)setReceiptRequested:(BOOL)receiptRequested {
    payload.receiptRequested = receiptRequested;
}

- (NSString *)tokenRequestId {
    return payload.tokenRequestId;
}

- (void)setTokenRequestId:(NSString *)tokenRequestId {
    payload.tokenRequestId = tokenRequestId;
}
@end
