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
    NSMutableDictionary *customErrorLookup;
}

- (id)initWithGlobalRpcErrorCallback:(OnError)globalRpcErrorCallback_ {
    self = [super init];
    if (self) {
        globalRpcErrorCallback = globalRpcErrorCallback_;
        customErrorLookup = [@{
                @"unsupported-client-version":
                [NSError
                        errorFromErrorCode:kTKErrorSdkVersionMismatch
                                   details:TKLocalizedString(
                                           @"Sdk_Version_Mismatch",
                                           @"Please upgrade your app to the latest version")]} mutableCopy];
    }
    return self;
}

- (void)handle:(OnError)onError
     withError:(NSError *)error {

    RpcLogError(error);
    if (error.domain && [error.domain isEqualToString:@"io.grpc"]) {
        NSError *mappedError = error;
        NSDictionary *headers = error.userInfo[@"io.grpc.HeadersKey"];
        if (headers) {
            NSString *tokenError = headers[@"token-error"];
            NSString *tokenErrorDetails = headers[@"token-error-details"];

            if (tokenError) {
                NSError *customError = customErrorLookup[tokenError];
                if (customError) {
                    // Invoke global on error callback first.
                    if (globalRpcErrorCallback) {
                        globalRpcErrorCallback(customError);
                    }
                    mappedError = customError;
                }
            }

            if (tokenErrorDetails) {
                RpcLogErrorDetails(tokenErrorDetails);
            }
        }

        // Invoke RPC call private callback now.
        onError(mappedError);
    } else {
        onError(error);
    }
}

@end