//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TCrypto.h"
#import "TSecretKey.h"
#import "GPBMessage.h"


@implementation TCrypto

+(NSString *)sign:(GPBMessage *)message usingKey:(TSecretKey *)key {
    return @"signature-123"; // TODO(alexey): Fix me.
}

+(TSecretKey *)generateKey {
   NSString *privateKey = @"private-key"; // TODO(alexey): Fix me.
   NSString *publicKey = @"public-key"; // TODO(alexey): Fix me.
   return [TSecretKey withPrivateKey:privateKey publicKey:publicKey];
}

@end