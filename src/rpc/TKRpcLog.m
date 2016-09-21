//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <GPBMessage.h>

#import "TKRpcLog.h"


void RpcLogStart(GPBMessage *request) {
   NSLog(@"RPC << %@", request);
}

void RpcLogError(NSError *error) {
   NSLog(@"RPC >> ERROR: %@", error);
}

void RpcLogCompleted(GPBMessage *response) {
   NSLog(@"RPC >> %@", response);
}
