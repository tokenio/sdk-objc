//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKTokenSecretKey.h"
#import "TKUtil.h"
#import "TKKeyInfo.h"


@implementation TKTokenSecretKey

+ (TKTokenSecretKey *)keyWithLevel:(Key_Level)level privateKey:(NSData *)sk publicKey:(NSData *)pk {
    return [[TKTokenSecretKey alloc] initWithLevel:level privateKey:sk publicKey:pk];
}

- (id)initWithLevel:(Key_Level)level privateKey:(NSData *)sk publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _level = level;
        _privateKey = sk;
        _publicKey = pk;
    }

    return self;
}

- (NSString *)id {
    return [TKUtil idForData:self.publicKey];
}

- (TKKeyInfo *)keyInfo {
    return [TKKeyInfo
            keyInfoWithId:self.id
                    level:self.level
                algorithm:Key_Algorithm_Ed25519
                publicKey:self.publicKey];
}

@end