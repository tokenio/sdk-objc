//
// Created by Alexey Kalinichenko on 1/6/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKKeyInfo.h"


@implementation TKKeyInfo

+ (TKKeyInfo *)keyInfoWithId:(NSString *)id
                       level:(Key_Level)level
                   algorithm:(Key_Algorithm)algorithm
                   publicKey:(NSData *)pk {
    return [[TKKeyInfo alloc] initWithId:id level:level algorithm:algorithm publicKey:pk];
}

- (id)initWithId:(NSString *)id
           level:(Key_Level)level
        algorithm:(Key_Algorithm)algorithm
       publicKey:(NSData *)pk {
    self = [super init];

    if (self) {
        _level = level;
        _algorithm = algorithm;
        _publicKey = pk;
        _id = id;
    }

    return self;
}

- (NSString *)publicKeyStr {
    return [TKUtil base64EncodeData:self.publicKey];
}

@end
