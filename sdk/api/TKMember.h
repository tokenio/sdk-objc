//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#ifndef TokenMember_h
#define TokenMember_h

#import <Foundation/Foundation.h>

@class TKSecretKey;


@interface TKMember : NSObject

+(TKMember *)memberWithId:(NSString *)id secretKey:(TKSecretKey *)key;

@property (readonly, retain) NSString *id;
@property (readonly, retain) TKSecretKey *key;

@end

#endif