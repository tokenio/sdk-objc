//
// Created by Maxim Khutornenko on 2/22/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//

#import "TKRpcErrorHandler.h"
#import "TKRpcLog.h"
#import "TKLocalizer.h"
#import "TKError.h"


@implementation TKRpcErrorHandler {
    OnError globalRpcErrorCallback;
}

- (id)initWithGlobalRpcErrorCallback:(OnError) globalRpcErrorCallback_ {
    self = [super init];
    if (self) {
        globalRpcErrorCallback = globalRpcErrorCallback_;
    }
    return self;
}

- (void)handle:(OnError) onError
     withError:(NSError *) error {

    RpcLogError(error);
    if (error.domain && [error.domain isEqualToString:@"io.grpc"]) {
        NSError *mappedError = [NSError
                errorFromErrorCode:kTKErrorSdkVersionMismatch
                           details:TKLocalizedString(
                                   @"Sdk_Version_Mismatch",
                                   @"Please upgrade your app to the latest version")];

        // Invoke global on error callback first.
        if (globalRpcErrorCallback) {
            globalRpcErrorCallback(mappedError);
        }

        // Invoke RPC call private callback now.
        onError(mappedError);
    } else {
        onError(error);
    }
}

@end