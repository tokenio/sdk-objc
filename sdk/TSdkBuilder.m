//
//  TokenClientBuilder.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSdkBuilder.h"
#import "TSdk.h"

@implementation TSdkBuilder

- (id)init {
    self = [super init];

    if (self) {
        self.host = @"dev.api.token.io";
        self.port = 9000;
    }

    return self;
}

- (TSdk *)build {
    return [[TSdk alloc] initWithHost:self.host port:self.port];
}

@end