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
    if (error != nil) {
        return [NSError errorWithDomain:kTokenErrorDomain
                                   code:errorCode
                               userInfo:@{ NSLocalizedDescriptionKey: details ,
                                           TKEncapsulatedErrorKey: error }];
    } else {
        return [NSError errorWithDomain:kTokenErrorDomain
                                   code:errorCode
                               userInfo:@{ NSLocalizedDescriptionKey: details}];
    }
}

+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status {
    return [NSError
            errorWithDomain:kTokenTransferErrorDomain
            code:status
            userInfo:@{ NSLocalizedDescriptionKey:
                            [NSString stringWithFormat:@"Failed to create token %d", status] }];
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
    
+ (instancetype)errorFromRequestStatus:(RequestStatus)status
                              userInfo:(NSDictionary * _Nonnull)info {
    NSString *description = [NSString stringWithFormat:@"Failed with request status %d", status];
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithDictionary:info];
    [userinfo setObject:description forKey:NSLocalizedDescriptionKey];
    
    return [NSError errorWithDomain:kTokenRequestErrorDomain
                               code:status
                           userInfo:userinfo];
}

@end
