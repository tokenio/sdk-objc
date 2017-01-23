//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTokenCryptoEngineFactory.h"
#import "TKTokenCryptoEngine.h"


@implementation TKTokenCryptoEngineFactory {
    id<TKKeyStore> storage;
}

+ (id<TKCryptoEngineFactory>)factoryWithStore:(id<TKKeyStore>)storage {
    return [[TKTokenCryptoEngineFactory alloc] initWithStorage:storage];
}

- (id)initWithStorage:(id<TKKeyStore>)storage_ {
    self = [super init];

    if (self) {
        storage = storage_;
    }

    return self;
}

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId {
    return [[TKTokenCryptoEngine alloc] initForMember:memberId useKeyStore:storage];
}

@end