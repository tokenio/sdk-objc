//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTestMemberKeys.h"
#import "TKTestKeyStore.h"
#import "TKTokenSecretKey.h"


@implementation TKTestMemberKeys {
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

- (void)addKey:(TKTokenSecretKey *)key {
    [allKeys setObject:key forKey:key.id];
    [currentKeys setObject:key.id forKey:@(key.level)];
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

- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)keyLevel {
    NSString *id = [currentKeys objectForKey:@(keyLevel)];
    if (!id) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find key of level: %d", keyLevel];
    }
    return [self lookupKeyById:id];
}

@end