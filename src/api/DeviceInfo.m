//
// Created by Alexey Kalinichenko on 1/19/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "DeviceInfo.h"
#import "TokenSdk.h"
#import "TKTokenCryptoEngine.h"


@implementation DeviceInfo {
}

+ (DeviceInfo *)deviceInfo:(NSString *)memberId keys:(NSArray<Key *> *)keys {
    return [[DeviceInfo alloc] initWithMemberId:memberId keys:keys];
}

- (id)initWithMemberId:(NSString *)memberId keys:(NSArray<Key *> *)keys {
    self = [super init];

    if (self) {
        _memberId = memberId;
        _keys = keys;
    }

    return self;
}

@end