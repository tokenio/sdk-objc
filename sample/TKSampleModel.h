//
//  TKSampleModel.h
//  TokenSdk
//
//  Created by Sibin Lu on 11/16/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenSdk.h"

@interface TKSampleModel : NSObject

+ (TokenPayload *)aispEndrosePayload:(TKMember *)from to:(TKMember *)to;

+ (TokenPayload *)pispEndrosePayload:(TKMember *)from to:(TKMember *)to;

+ (ReceiptContact *)receiptContact:(NSString *)email;

+ (DeviceMetadata *)deviceMetadata;

+ (Key *)lowKey:(NSString *) memberId;

@end
