//
//  TKError.h
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /* The operation was cancelled by user (like cancelling out of Touch ID prompt). */
    kTKErrorUserCancelled = 101,
    
    /* Private key couldn't be retrieved from key storage */
    kTKErrorKeyNotFound = 102,
} TKErrorCode;


@interface NSError (TokenSdk)

+ (instancetype)errorFromErrorCode:(TKErrorCode)errorCode details:(NSString*)details;

@end
