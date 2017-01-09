//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKKeyInfo.h"
#import "TKUtil.h"


@implementation TKKeyInfo

+ (TKKeyInfo *)keyInfoWithId:(NSString *)id type:(TKKeyType)type publicKey:(NSData *)pk {
    return [[TKKeyInfo alloc] initWithId:id type:type publicKey:pk];
}

- (id)initWithId:(NSString *)id type:(TKKeyType)type publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _type = type;
        _publicKey = pk;
        _id = id;
    }

    return self;
}

- (NSString *)publicKeyStr {
    return [TKUtil base64EncodeData:self.publicKey];
}

@end