//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKSecretKey.h"
#import "TKUtil.h"


@implementation TKSecretKey

+ (TKSecretKey *)withPrivateKey:(NSString *)sk publicKey:(NSString *)pk {
    return [[TKSecretKey alloc] initWithPrivateKey:sk publicKey:pk];
}

- (id)initWithPrivateKey:(NSString *)sk publicKey:(NSString *)pk {
    self = [super init];

    if (self) {
        _privateKey = sk;
        _publicKey = pk;
        _id = [TKUtil idForString:pk];
    }

    return self;
}

@end