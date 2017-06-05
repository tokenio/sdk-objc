//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <objc/NSObject.h>
#import "TKTypedef.h"

@class TransferEndpoint;

@interface TransferTokenBuilder : NSObject

@property (readwrite) TKMemberAsync *member;
@property (readwrite) NSString *fromMemberId;
@property (readwrite) NSString *currency;
@property (readwrite) double lifetimeAmount;
@property (readwrite) double chargeAmount;
@property (readwrite) NSString *accountId;
@property (readwrite) BankAuthorization *bankAuthorization;
@property (readwrite) long expiresAtMs;
@property (readwrite) long effectiveAtMs;
@property (readwrite) NSString* redeemerUsername;
@property (readwrite) NSString* redeemerMemberId;
@property (readwrite) NSString* toUsername;
@property (readwrite) NSString* toMemberId;
@property (readwrite) NSString* descr;
@property (readwrite) NSArray<TransferEndpoint*> *destinations;
@property (readwrite) NSArray<Attachment*> *attachments;

- (id)init:(TKMemberAsync *)member
    lifetimeAmount:(double)lifetimeAmount
          currency:(NSString*)currency;

- (Token *)execute;

- (void)executeAsync:(OnSuccessWithToken)onSuccess
                onError:(OnError)onError;

@end
