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

+ (TokenRequestPayload *)accessTokenRequestPayload:(TKMember *)to;

+ (TokenRequestPayload *)transferTokenRequestPayload:(TKMember *)to;

+ (TokenRequestOptions *)tokenRequestOptions:(TKMember *)from;

+ (ReceiptContact *)receiptContact:(NSString *)email;

+ (DeviceMetadata *)deviceMetadata;

+ (Key *)lowKey:(NSString *) memberId;

@end
