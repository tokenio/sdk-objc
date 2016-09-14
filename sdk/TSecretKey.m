//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TSecretKey.h"
#import "TUtil.h"


@implementation TSecretKey

+ (TSecretKey *)withPrivateKey:(NSString *)sk publicKey:(NSString *)pk {
    return [[TSecretKey alloc] initWithPrivateKey:sk publicKey:pk];
}

- (id)initWithPrivateKey:(NSString *)sk publicKey:(NSString *)pk {
    self = [super init];

    if (self) {
        _privateKey = sk;
        _publicKey = pk;
        _id = [TUtil idForString:pk];
    }

    return self;
}

@end