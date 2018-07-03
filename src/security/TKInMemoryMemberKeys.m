//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKInMemoryMemberKeys.h"
#import "TKInMemoryKeyStore.h"
#import "TKTokenSecretKey.h"


@implementation TKInMemoryMemberKeys {
    NSMutableDictionary<NSString*, TKTokenSecretKey*> *keys;
}

- (id)init {
    self = [super init];
    if (self) {
        keys = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addKey:(TKTokenSecretKey *)key {
    if ([TKInMemoryMemberKeys isExpired: key]) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Key: %@ has expired", key.id];
    }
    [keys setObject:key forKey:key.id];
}

- (TKTokenSecretKey *)lookupKeyById:(NSString *)id {
    TKTokenSecretKey *key = [keys objectForKey:id];
    if (!key) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find key with id: %@", id];
    }
    if ([TKInMemoryMemberKeys isExpired: key]) {
        [NSException
         raise:NSInvalidArgumentException
         format:@"Key with id: %@ has expired", id];
    }
    return key;
}

- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)keyLevel {
    for (NSString* keyId in keys) {
        TKTokenSecretKey *key = [keys objectForKey:keyId];
        if (key.level == keyLevel && ![TKInMemoryMemberKeys isExpired: key]) {
            return key;
        }
    }
    [NSException
     raise:NSInvalidArgumentException
     format:@"Can not find key of level: %d", keyLevel];
    return nil;
}

+ (bool) isExpired:(TKTokenSecretKey *)key {
    return key.expiresAtMs && key.expiresAtMs.longLongValue <
    (long long) ([[NSDate date] timeIntervalSince1970] * 1000);
}

@end
