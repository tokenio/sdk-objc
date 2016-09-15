//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKMember.h"
#import "TKSecretKey.h"


@implementation TKMember {
}

+(TKMember *)memberWithId:(NSString *)id secretKey:(TKSecretKey *)key {
    return [[TKMember alloc] initWithId:id secretKey:key];
}

-(id)initWithId:(NSString *)id secretKey:(TKSecretKey *)key {
    self = [super init];

    if (self) {
        _id = id;
        _key = key;
    }

    return self;
}

@end