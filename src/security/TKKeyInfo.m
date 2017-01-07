//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKKeyInfo.h"
#import "TKUtil.h"


@implementation TKKeyInfo

+ (TKKeyInfo *)keyInfoWithType:(TKKeyType)type publicKey:(NSData *)pk {
    return [[TKKeyInfo alloc] initWithType:type publicKey:pk];
}

- (id)initWithType:(TKKeyType)type publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _type = type;
        _publicKey = pk;
    }

    return self;
}

- (NSString *)id {
    return [TKUtil idForData:self.publicKey];
}

- (NSString *)publicKeyStr {
    return [TKUtil base64EncodeData:self.publicKey];
}

@end