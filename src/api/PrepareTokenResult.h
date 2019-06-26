//
//  PrepareTokenResult.h
//  TokenSdk
//
//  Created by Sibin Lu on 6/25/19.
//  Copyright © 2019 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenProto.h"

@interface PrepareTokenResult : NSObject
+ (PrepareTokenResult *)create:(TokenPayload *)tokenPayload policy:(Policy *)policy;

@property (nonatomic, readonly) TokenPayload *tokenPayload;
@property (nonatomic, readonly) Policy *policy;

@end
