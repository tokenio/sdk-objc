//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKTokenSecretKey.h"
#import "TKUtil.h"


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

- (Key *)keyInfo {
    Key *key = [Key message];
    key.id_p = self.id;
    key.level = self.level;
    key.algorithm = Key_Algorithm_Ed25519;
    key.publicKey = [TKUtil base64EncodeData:self.publicKey];
    return key;
}

@end