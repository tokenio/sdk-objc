//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKSignature.h"


@implementation TKSignature

+ (TKSignature *)signature:(NSString *)signature
                signedWith:(Key *)key {
    return [[TKSignature alloc] initWithSignature:signature
                                       signedWith:key];
}

- (id)initWithSignature:(NSString *)signature
             signedWith:(Key  *)key {
    self = [super init];

    if (self) {
        _value = signature;
        _key = key;
    }

    return self;
}

@end