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

+ (TKTokenSecretKey *)keyWithLevel:(Key_Level)level
                        privateKey:(NSData *)sk
                         publicKey:(NSData *)pk
                        expiration:(long long) expiresAtMs {
    return [[TKTokenSecretKey alloc] initWithLevel:level privateKey:sk publicKey:pk expiration:expiresAtMs];
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

- (id)initWithLevel:(Key_Level)level
         privateKey:(NSData *)sk
          publicKey:(NSData *)pk
         expiration:(long long)expiresAtMs{
    self = [super init];
    
    if (self) {
        _level = level;
        _privateKey = sk;
        _publicKey = pk;
        _expiresAtMs = expiresAtMs;
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
    key.publicKey = [TKUtil base64UrlEncodeData:self.publicKey];
    key.expiresAtMs = self.expiresAtMs;
    return key;
}

@end
