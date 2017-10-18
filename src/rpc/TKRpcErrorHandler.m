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
                                           @"Please upgrade your app to the latest version")],
                @"invalid-dev-key":
                [NSError
                         errorFromErrorCode:kTKErrorInvalidDeveloperKey
                                    details:TKLocalizedString(@"Invalid_Developer_Key",
                                                              @"Please provide valid developer key")]
                } mutableCopy];
    }
    return self;
}

- (void)handle:(OnError)onError
     withError:(NSError *)error {

    RpcLogError(error);
    if (error.domain && [error.domain isEqualToString:@"io.grpc"]) {
        NSError *mappedError = error;
        NSDictionary *trailers = error.userInfo[@"io.grpc.TrailersKey"];
        if (trailers) {
            NSString *tokenError = trailers[@"token-error"];
            NSString *tokenErrorDetails = trailers[@"token-error-details"];

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
