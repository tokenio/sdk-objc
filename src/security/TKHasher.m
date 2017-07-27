//
//  TKHasher.m
//  TokenSdk
//
//  Created by Colin Man on 7/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>

#import "Base58.h"
#import "TKHasher.h"

@implementation TKHasher

+ (NSData *)sha256:(NSString *)input
{
    const char* input_cstr = [input UTF8String];
    unsigned char* output_buf = malloc(CC_SHA256_DIGEST_LENGTH);

    CC_SHA256(input_cstr, (CC_LONG) strlen(input_cstr), output_buf);

    NSData *output = [NSData dataWithBytes:output_buf length:CC_SHA256_DIGEST_LENGTH];
    free(output_buf);

    return output;
}

+ (NSString *)serializedSha256:(NSString *)input {
    return [[NSString alloc] initWithData: [TKHasher encodeBase58:[TKHasher sha256:input]] encoding:NSUTF8StringEncoding];
}

+ (NSData *)encodeBase58:(NSData *)data {
    char *output_bytes = malloc(data.length * 4);
    size_t output_len = data.length * 4;

    bool success = b58enc(output_bytes, &output_len, data.bytes, data.length);
    if (!success) {
        return nil;
    }

    NSData *output = [NSData dataWithBytes:output_bytes length:output_len - 1]; // -1 for null terminator
    free(output_bytes);
    return output;
}

@end
