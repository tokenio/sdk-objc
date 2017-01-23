//
// Created by Alexey Kalinichenko on 1/20/2017.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "Security.pbobjc.h"

@class TKTokenSecretKey;


@interface TKTestMemberKeys : NSObject

- (void)addKey:(TKTokenSecretKey *)key;

- (TKTokenSecretKey *)lookupKeyById:(NSString *)id;

- (TKTokenSecretKey *)lookupKeyByLevel:(Key_Level)keyLevel;

@end
