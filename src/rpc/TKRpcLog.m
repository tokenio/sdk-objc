//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>

#import "TKRpcLog.h"
#import "TKLogManager.h"

void RpcLogStart(GPBMessage *request) {
    TKLogInfo(@"RPC << %@", request)
}

void RpcLogError(NSError *error) {
    TKLogError(@"RPC >> ERROR: %@", error)
}

void RpcLogCompleted(GPBMessage *response) {
    TKLogInfo(@"RPC >> %@", response)
}
