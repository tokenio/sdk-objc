//
// Created by Alexey Kalinichenko on 1/19/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Key;


/**
 * Information about a device being provisioned.
 */
@interface DeviceInfo : NSObject

/**
 * @param memberId Token member id
 * @param keys device keys
 * @return device info
 */
+ (DeviceInfo *)deviceInfo:(NSString *)memberId keys:(NSArray<Key *> *)keys;

@property (nonatomic, readonly) NSString *memberId;
@property (nonatomic, readonly) NSArray<Key *> *keys;

@end
