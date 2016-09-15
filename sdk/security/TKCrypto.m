//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "ed25519.h"

#import "TKCrypto.h"
#import "TKSecretKey.h"
#import "GPBMessage.h"


@implementation TKCrypto

+(NSString *)sign:(GPBMessage *)message usingKey:(TKSecretKey *)key {
    unsigned char seed[32];
    if (ed25519_create_seed(seed)) {
        [NSException raise:NSInternalInconsistencyException format:@"Could not initialize random number generator"];
    }

    return @"signature-123"; // TODO(alexey): Fix me.
}

+(TKSecretKey *)generateKey {
   NSString *privateKey = @"private-key"; // TODO(alexey): Fix me.
   NSString *publicKey = @"public-key"; // TODO(alexey): Fix me.
   return [TKSecretKey withPrivateKey:privateKey publicKey:publicKey];
}

@end