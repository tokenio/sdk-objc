//
//  TKBalance.h
//  TokenSdk
//
//  Created by Larry Hosken on 11/3/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.pbobjc.h"

@class Money;

/**
 * A bank account's balance.
 */
@interface TKBalance : NSObject

/// Current balance.
@property Money *current;

/// Available balance.
@property Money *available;

@end

