//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Protobuf/GPBMessage.h>

#import "TKRpcLog.h"
#import "TKLogManager.h"

void RpcLogStart(GPBMessage *request) {
    TKLogDebug(@"RPC << %@", request)
}

void RpcLogError(NSError *error) {
    TKLogError(@"RPC >> ERROR: %@", error)
}

void RpcLogErrorDetails(NSString *message) {
    TKLogError(@"RPC >> ERROR DETAILS: %@", message);
}

void RpcLogCompleted(GPBMessage *response) {
    TKLogDebug(@"RPC >> %@", response)
}
