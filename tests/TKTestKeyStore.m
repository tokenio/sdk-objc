//
// Created by Alexey Kalinichenko on 1/7/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKTestKeyStore.h"
#import "TKTokenSecretKey.h"
#import "TKTestMemberKeys.h"


@implementation TKTestKeyStore {
    NSMutableDictionary<NSString *, TKTestMemberKeys *> *keys;
}

- (id)init {
    self = [super init];
    if (self) {
        keys = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addKey:(TKTokenSecretKey *)key forMember:(NSString *)memberId {
    TKTestMemberKeys *memberKeys = [keys objectForKey:memberId];
    if (!memberKeys) {
        memberKeys = [[TKTestMemberKeys alloc] init];
        [keys setObject:memberKeys forKey:memberId];
    }
    [memberKeys addKey:key];
}

- (TKTokenSecretKey *)lookupKeyById:(NSString *)id forMember:(NSString *)memberId {
    TKTestMemberKeys *memberKeys = [keys objectForKey:memberId];
    if (!memberKeys) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find keys for member: %@", memberId];
    }
    return [memberKeys lookupKeyById:id];
}

- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)keyLevel forMember:(NSString *)memberId {
    TKTestMemberKeys *memberKeys = [keys objectForKey:memberId];
    if (!memberKeys) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Can not find keys for member: %@", memberId];
    }
    return [memberKeys lookupKeyByLevel:keyLevel];
}

@end