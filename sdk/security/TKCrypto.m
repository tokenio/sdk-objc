//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKCrypto.h"
#import "TKSecretKey.h"
#import "GPBMessage.h"


@implementation TKCrypto

+(NSString *)sign:(GPBMessage *)message usingKey:(TKSecretKey *)key {
    return @"signature-123"; // TODO(alexey): Fix me.
}

+(TKSecretKey *)generateKey {
   NSString *privateKey = @"private-key"; // TODO(alexey): Fix me.
   NSString *publicKey = @"public-key"; // TODO(alexey): Fix me.
   return [TKSecretKey withPrivateKey:privateKey publicKey:publicKey];
}

@end