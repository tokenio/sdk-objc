//
//  PrepareTokenResult.m
//  TokenSdk
//
//  Created by Sibin Lu on 6/25/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import "PrepareTokenResult.h"

@implementation PrepareTokenResult
+ (PrepareTokenResult *)create:(TokenPayload *)tokenPayload policy:(Policy *)policy {
    return [[PrepareTokenResult alloc] init:tokenPayload policy:policy];
}

- (id)init:(TokenPayload *)tokenPayload policy:(Policy *)policy {
    self = [super init];
    if (self) {
        _tokenPayload = tokenPayload;
        _policy = policy;
    }
    return self;
}
@end
