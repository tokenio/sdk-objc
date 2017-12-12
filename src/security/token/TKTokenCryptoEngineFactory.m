//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTokenCryptoEngineFactory.h"
#import "TKTokenCryptoEngine.h"


@implementation TKTokenCryptoEngineFactory {
    id<TKKeyStore> storage;
    BOOL useLocalAuthentication;
}

+ (id<TKCryptoEngineFactory>)factoryWithStore:(id<TKKeyStore>)storage
                       useLocalAuthentication:(BOOL)useLocalAuthentication {
    return [[TKTokenCryptoEngineFactory alloc] initWithStorage:storage
                                        useLocalAuthentication:useLocalAuthentication];
}

- (id)initWithStorage:(id<TKKeyStore>)storage_
useLocalAuthentication:(BOOL)useLocalAuthentication_ {
    self = [super init];

    if (self) {
        storage = storage_;
        useLocalAuthentication = useLocalAuthentication_;
    }

    return self;
}

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId {
    return [[TKTokenCryptoEngine alloc] initForMember:memberId
                                          useKeyStore:storage
                               useLocalAuthentication:useLocalAuthentication];
}

@end
