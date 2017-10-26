//
//  TKError.h
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenSdk.h"

/*
 * Generic token error.
 */
static NSString *const kTokenErrorDomain = @"io.tokensdk";
/*
 * Token error from TransferTokenStatus.
 */
static NSString *const kTokenTransferErrorDomain = @"io.tokensdk.transfer";
/*
 * Token error from TransactionStatus.
 */
static NSString *const kTokenTransactionErrorDomain = @"io.tokensdk.transaction";

/*
 * Errors detail encapsulated by
 */
static NSString *const TKEncapsulatedErrorKey = @"TKEncapsulatedErrorKey";

typedef enum {
    /* The operation was cancelled by user (like cancelling out of Touch ID prompt). */
    kTKErrorUserCancelled = 101,
    
    /* The operation was failed to identify the user (like failure of Touch ID prompt). */
    kTKErrorUserInvalid = 102,
    
    /* Private key couldn't be retrieved from key storage */
    kTKErrorKeyNotFound = 103,

    /* Raised when an SDK version is no longer supported by the server */
    kTKErrorSdkVersionMismatch = 104,
    
    /* Raised when developer key is invalid */
    kTKErrorInvalidDeveloperKey = 105,
    
    /* Raised when recovery process is invalid */
    kTKErrorInvalidRecoveryProcess = 106,
} TKErrorCode;


@interface NSError (TokenSdk)

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details;
+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details encapsulatedError:(NSError *)error;
+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status;
+ (instancetype)errorFromTransactionStatus:(TransactionStatus)status;

@end
