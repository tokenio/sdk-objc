//
//  TKTestExpectation.m
//  TokenSdk
//
//  Created by Sibin Lu on 2/5/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import "TKTestExpectation.h"

@implementation TKTestExpectation

- (void)fulfill {
    [super fulfill];
    _isFulfilled = YES;
}
@end
