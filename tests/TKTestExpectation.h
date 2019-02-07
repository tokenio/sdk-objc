//
//  TKTestExpectation.h
//  TokenSdk
//
//  Created by Sibin Lu on 2/5/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTestExpectation : XCTestExpectation
@property (readonly) BOOL isFulfilled;
@end

NS_ASSUME_NONNULL_END
