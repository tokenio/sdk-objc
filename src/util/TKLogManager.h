//
//  TKLogManager.h
//  TokenSdk
//
//  Created by Vadim on 12/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  TKLogInfo(...)         if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logInfo:)]) { \
                                    [[TKLogManager shared].logDelegate logInfo:__VA_ARGS__]; \
                                } \
                                if (![TKLogManager shared].muteNSLog) { \
                                    NSLog(__VA_ARGS__); \
                                }

#define  TKLogError(...)       if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logError:)]) { \
                                    [[TKLogManager shared].logDelegate logError:__VA_ARGS__]; \
                                } \
                                if (![TKLogManager shared].muteNSLog) { \
                                    NSLog(__VA_ARGS__); \
                                }



/**
 * External Logger Protocol.
 * If API Client prefers its own method for logging instead of standard NSLog used by SDK (e.g. log to a file or any other destination)
 * it should provide a delegate object confirming to this protocol
 */
@protocol TKExternalLoggerDelegate <NSObject>

@optional
- (void)logInfo:(NSString*)format, ...;
- (void)logError:(NSString*)format, ...;
@end

@interface TKLogManager : NSObject

/**
 * Returns shared instance of the log Manager.
 *
 * @param delegate external logger delegate
 * @param muteNSLog if TRUE SDK will suppress all NSLogs
 * @return instance of TKLogManager
 */
+ (instancetype)logManagerWithDelegate:(id<TKExternalLoggerDelegate>)delegate muteNSLog:(bool)muteNSLog;
+ (instancetype)shared;

@property (weak) id<TKExternalLoggerDelegate>logDelegate;
@property bool muteNSLog;

@end


