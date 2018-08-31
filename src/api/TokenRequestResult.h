//
//  TokenRequestResult.h
//  TokenSdk
//
//  Created by Sibin Lu on 8/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Signature;

@interface TokenRequestResult : NSObject

+ (TokenRequestResult *)createWithTokenId:(NSString *)tokenId signature:(Signature *)signature;

@property (nonatomic, readonly) NSString *tokenId;
@property (nonatomic, readonly) Signature *signature;

@end
