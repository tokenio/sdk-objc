//
//  NotifyResult.m
//  TokenSdk
//
//  Created by Sibin Lu on 8/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import "NotifyResult.h"
#import "gateway/Gateway.pbrpc.h"

@implementation NotifyResult

+ (NotifyResult *)createWithNotifyStatus:(NotifyStatus)notifyStatus notificationId:(NSString *)notificationId {
    return [[NotifyResult alloc] initWithNotifyStatus:notifyStatus notificationId:notificationId];
}

- (id)initWithNotifyStatus:(NotifyStatus)notifyStatus notificationId:(NSString *)notificationId {
    self = [super init];
    if (self) {
        _notifyStatus = notifyStatus;
        _notificationId = [notificationId copy];
    }
    return self;
}

@end
