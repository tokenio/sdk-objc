//
//  TKHasher.m
//  TokenSdk
//
//  Created by Colin Man on 7/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>

#import "gateway/Gateway.pbrpc.h"

#import "Base58.h"
#import "TKHasher.h"

@implementation TKHasher

+ (NSData *)hashData:(NSData *)input {
    unsigned char* output_buf = malloc(CC_SHA256_DIGEST_LENGTH);
    
    CC_SHA256(input.bytes, (CC_LONG) input.length, output_buf);
    
    NSData *output = [NSData dataWithBytes:output_buf length:CC_SHA256_DIGEST_LENGTH];
    free(output_buf);
    
    return output;
}

+ (NSData *)hashString:(NSString *)input
{
    const char* input_cstr = [input UTF8String];
    return [TKHasher hashData:[NSData dataWithBytes:input_cstr length:strlen(input_cstr)]];
}

+ (NSString *)serializeReadable:(NSData *)data {
    return[[NSString alloc] initWithData: [TKHasher encodeBase58:data] encoding:NSUTF8StringEncoding];
}

+ (NSString *)hashAlias:(Alias *)alias {
    if (alias.type == Alias_Type_Username) {
        return alias.value;
    }
    // TODO(PR-998): Revert this change
    return alias.value;
    //    return [TKHasher serializeReadable: [TKHasher hashData:alias.data]];
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
