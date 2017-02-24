//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GPBMessage;

void RpcLogStart(GPBMessage *request);
void RpcLogError(NSError *error);
void RpcLogErrorDetails(NSString *message);
void RpcLogCompleted(GPBMessage *response);

