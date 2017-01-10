//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTestTokenCryptoEngineFactory.h"
#import "TKTokenCryptoEngine.h"
#import "TKTokenCryptoStorage.h"
#import "TKTestTokenCryptoStorage.h"


@implementation TKTestTokenCryptoEngineFactory {
    NSMutableDictionary<NSString *, id<TKTokenCryptoStorage>> *perMemberStorage;
}

+ (id<TKCryptoEngineFactory>)factory {
    return [[TKTestTokenCryptoEngineFactory alloc] init];
}

- (id)init {
    self = [super init];

    if (self) {
        perMemberStorage = [NSMutableDictionary dictionary];
    }

    return self;
}

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId {
    id<TKTokenCryptoStorage> storage = [perMemberStorage objectForKey:memberId];
    if (!storage) {
        storage = [[TKTestTokenCryptoStorage alloc] init];
        [perMemberStorage setObject:storage forKey:memberId];
    }
    return [[TKTokenCryptoEngine alloc] initWithStorage:storage];
}

@end