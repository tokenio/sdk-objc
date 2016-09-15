//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKSecretKey.h"
#import "TKUtil.h"


@implementation TKSecretKey

+ (TKSecretKey *)withPrivateKey:(NSData *)sk publicKey:(NSData *)pk {
    return [[TKSecretKey alloc] initWithPrivateKey:sk publicKey:pk];
}

- (id)initWithPrivateKey:(NSData *)sk publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _privateKey = sk;
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