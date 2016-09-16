//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class TKMember;
@class TKClient;


@interface TKAccount : NSObject

@property (atomic, readonly) TKMember *member;
@property (atomic, readonly) NSString *id;
@property (atomic, readonly) NSString *name;

+ (TKAccount *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client;

@end