//
//  TKLogManager.m
//  TokenSdk
//
//  Created by Vadim on 12/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKLogManager.h"

@implementation TKLogManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static TKLogManager* sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

+ (instancetype)logManagerWithDelegate:(id<TKExternalLoggerDelegate>)delegate muteNSLog:(bool)muteNSLog {
    TKLogManager* logManager = [TKLogManager shared];
    logManager.logDelegate = delegate;
    logManager.muteNSLog = muteNSLog;
    
    return logManager;
}

@end
