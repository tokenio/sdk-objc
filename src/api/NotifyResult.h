//
//  NotifyResult.h
//  TokenSdk
//
//  Created by Sibin Lu on 8/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int32_t, NotifyStatus);
@interface NotifyResult : NSObject

+ (NotifyResult *)createWithNotifyStatus:(NotifyStatus)notifyStatus notificationId:(NSString *)notificationId;

@property (nonatomic, readonly) NotifyStatus notifyStatus;
@property (nonatomic, readonly) NSString *notificationId;

@end
