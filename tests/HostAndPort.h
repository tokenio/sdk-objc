//
// Created by Maxim Khutornenko on 2/22/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HostAndPort : NSObject
/**
 * Host part of the URL.
 */
@property NSString *host;

/**
 * Port part of the URL.
 */
@property int port;

@end