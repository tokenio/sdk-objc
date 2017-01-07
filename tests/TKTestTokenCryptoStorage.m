//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTestTokenCryptoStorage.h"
#import "TKTokenSecretKey.h"


@implementation TKTestTokenCryptoStorage {
    NSMutableDictionary<NSString*, TKTokenSecretKey*> *allKeys;
    NSMutableDictionary<NSNumber*, NSString*> *currentKeys;
}

- (id)init {
    self = [super init];
    if (self) {
        allKeys = [NSMutableDictionary dictionary];
        currentKeys = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addKey:(TKTokenSecretKey *)key ofType:(TKKeyType)type {
    [allKeys setObject:key forKey:key.id];
    [currentKeys setObject:key.id forKey:@(type)];
}

- (TKTokenSecretKey *)lookupKeyById:(NSString *)id {
    TKTokenSecretKey *key = [allKeys objectForKey:id];
    if (!key) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find key with id: %@", id];
    }
    return key;
}

- (TKTokenSecretKey *)lookupKeyByType:(TKKeyType)type {
    NSString *id = [currentKeys objectForKey:@(type)];
    if (!id) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find key of type: %d", type];
    }
    return [self lookupKeyById:id];
}

@end