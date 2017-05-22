//
//  TKLogManager.h
//  TokenSdk
//
//  Created by Vadim on 12/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  TKLogVerbose(...)         if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logVerbose:)]) { \
                                    [[TKLogManager shared].logDelegate logVerbose:__VA_ARGS__]; \
                                } \
                                if (![TKLogManager shared].muteNSLog) { \
                                    NSLog(__VA_ARGS__); \
                                }

#define  TKLogDebug(...)       if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logDebug:)]) { \
                                    [[TKLogManager shared].logDelegate logDebug:__VA_ARGS__]; \
                                } \
                                if (![TKLogManager shared].muteNSLog) { \
                                    NSLog(__VA_ARGS__); \
                                }                                

#define  TKLogInfo(...)       if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logInfo:)]) { \
                                    [[TKLogManager shared].logDelegate logInfo:__VA_ARGS__]; \
                                } \
                                if (![TKLogManager shared].muteNSLog) { \
                                    NSLog(__VA_ARGS__); \
                                }

#define  TKLogWarning(...)       if ([[TKLogManager shared].logDelegate respondsToSelector:@selector(logWarning:)]) { \
                                    [[TKLogManager shared].logDelegate logWarning:__VA_ARGS__]; \
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
- (void)logVerbose:(NSString*)format, ...;
- (void)logDebug:(NSString*)format, ...;
- (void)logInfo:(NSString*)format, ...;
- (void)logWarning:(NSString*)format, ...;
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


