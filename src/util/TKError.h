//
//  TKError.h
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenSdk.h"

static NSString* kTokenErrorDomain = @"io.tokensdk";

typedef enum {
    /* The operation was cancelled by user (like cancelling out of Touch ID prompt). */
    kTKErrorUserCancelled = 101,
    
    /* Private key couldn't be retrieved from key storage */
    kTKErrorKeyNotFound = 102,

    /* Raised when an SDK version is no longer supported by the server */
    kTKErrorSdkVersionMismatch = 103,
} TKErrorCode;


@interface NSError (TokenSdk)

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString*)details;
+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status;
+ (instancetype)errorFromTransactionStatus:(TransactionStatus)status;

@end
