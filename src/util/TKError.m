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

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString *)details encapsulatedError:(NSError *)error {
    return [NSError errorWithDomain:kTokenErrorDomain
                               code:errorCode
                           userInfo:@{ NSLocalizedDescriptionKey: details ,
                                       TKEncapsulatedErrorKey: error }];
}

+ (instancetype)errorFromTransferTokenStatus:(TransferTokenStatus)status {
    return [NSError errorWithDomain:kTokenTransferErrorDomain
                               code:status
                           userInfo:@{ NSLocalizedDescriptionKey:[NSString
                                           stringWithFormat:@"Failed to create token %d", status] }];
}

+ (instancetype)errorFromTransactionStatus:(TransactionStatus)status {
    return [NSError errorWithDomain:kTokenTransactionErrorDomain
                               code:status
                           userInfo:@{ NSLocalizedDescriptionKey:[NSString
                                                                  stringWithFormat:@"Failed to redeem token %d", status] }];
}

@end
