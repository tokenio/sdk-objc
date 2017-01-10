//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKKeyInfo.h"
#import "TKUtil.h"


@implementation TKKeyInfo

+ (TKKeyInfo *)keyInfoWithId:(NSString *)id level:(Key_Level)level publicKey:(NSData *)pk {
    return [[TKKeyInfo alloc] initWithId:id level:level publicKey:pk];
}

- (id)initWithId:(NSString *)id level:(Key_Level)level publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _level = level;
        // TODO: Support multiple algorithms.
        _algorithm = Key_Algorithm_Ed25519;
        _publicKey = pk;
        _id = id;
    }

    return self;
}

- (NSString *)publicKeyStr {
    return [TKUtil base64EncodeData:self.publicKey];
}

@end
