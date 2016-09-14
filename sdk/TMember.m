//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TMember.h"
#import "TSecretKey.h"


@implementation TMember {
}

+(TMember *)memberWithId:(NSString *)id secretKey:(TSecretKey *)key {
    return [[TMember alloc] initWithId:id secretKey:key];
}

-(id)initWithId:(NSString *)id secretKey:(TSecretKey *)key {
    self = [super init];

    if (self) {
        _id = id;
        _key = key;
    }

    return self;
}

@end