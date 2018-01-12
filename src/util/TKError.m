//
//  TKError.m
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKError.h"

@implementation NSError (TokenSdk)

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details {
    return [NSError errorWithDomain:kTokenErrorDomain
                               code:errorCode
                           userInfo:@{ NSLocalizedDescriptionKey: details }];
}

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode
                           details:(NSString *)details
                 encapsulatedError:(NSError *)error {
    return [NSError errorWithDomain:kTokenErrorDomain
                               code:errorCode
                           userInfo:@{ NSLocalizedDescriptionKey: details ,
                                       TKEncapsulatedErrorKey: error }];
}

+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status {
    NSString *description = [NSString stringWithFormat:@"Failed to create token %d", status];
    return [NSError errorWithDomain:kTokenTransferErrorDomain
                               code:status
                           userInfo:@{ NSLocalizedDescriptionKey: description }];
}

+ (instancetype)errorFromExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details {
    NSString *description = @"External authorization is required";
    NSString *eadUrlKey = @"ExternalAuthorizationDetails_URL";
    NSString *eadCompletionKey = @"ExternalAuthorizationDetails_CompletionPattern";
    return [NSError errorWithDomain:kTokenTransferErrorDomain
                               code:TransferTokenStatus_FailureExternalAuthorizationRequired
                           userInfo:@{ NSLocalizedDescriptionKey: description,
                                       eadUrlKey: details.URL,
                                       eadCompletionKey: details.completionPattern }];
}

+ (instancetype)errorFromTransactionStatus:(TransactionStatus)status {
    NSString *description = [NSString stringWithFormat:@"Failed with request status %d", status];
    return [NSError errorWithDomain:kTokenTransactionErrorDomain
                               code:status
                           userInfo:@{ NSLocalizedDescriptionKey: description }];
}
    
+ (instancetype)errorFromRequestStatus:(RequestStatus)status {
    NSString *description = [NSString stringWithFormat:@"Failed with request status %d", status];
    return [NSError errorWithDomain:kTokenRequestErrorDomain
                               code:status
                           userInfo:@{ NSLocalizedDescriptionKey: description }];
}

@end
