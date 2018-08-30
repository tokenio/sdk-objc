//
//  TokenRequestResult.m
//  TokenSdk
//
//  Created by Sibin Lu on 8/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import "TokenRequestResult.h"
#import "gateway/Gateway.pbrpc.h"

@implementation TokenRequestResult

+ (TokenRequestResult *)createWithTokenId:(NSString *)tokenId signature:(Signature *)signature {
    return [[TokenRequestResult alloc] initWithTokenId:tokenId signature:signature];
}

- (id)initWithTokenId:(NSString *)tokenId signature:(Signature *)signature {
    self = [super init];
    if (self) {
        _tokenId = [tokenId copy];
        _signature = signature;
    }
    return self;
}

@end
