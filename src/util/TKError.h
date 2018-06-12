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
 * Token error from TransactionStatus.
 */
static NSString *const kTokenRequestErrorDomain = @"io.tokensdk.request";

/*
 * Token error from AccountLinkingStatus.
 */
static NSString *const kTokenAccountLinkingErrorDomain = @"io.tokensdk.accountlinking";

/*
 * Token error from VerificationStatus.
 */
static NSString *const kTokenVerificationStatusErrorDomain = @"io.tokensdk.verification";

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
    
    /* Raised when Oauth access token not found */
    kTKErrorOauthAccessTokenNotFound = 107,
} TKErrorCode;


@interface NSError (TokenSdk)

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details;
+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details encapsulatedError:(NSError *)error;
+ (instancetype)errorFromExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details;
+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status;
+ (instancetype)errorFromTransactionStatus:(TransactionStatus)status;
+ (instancetype)errorFromRequestStatus:(RequestStatus)status userInfo:(NSDictionary *)info;
+ (instancetype)errorFromAccountLinkingStatus:(AccountLinkingStatus)status
                                     userInfo:(NSDictionary *)info;
+ (instancetype)errorFromVerificationStatus:(VerificationStatus)status
                                   userInfo:(NSDictionary *)info;

@end
