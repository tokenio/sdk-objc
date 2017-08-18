//
//  TKHasher.m
//  TokenSdk
//
//  Created by Colin Man on 7/25/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>
#import <Protobuf/GPBMessage.h>

#import "gateway/Gateway.pbrpc.h"

#import "Base58.h"
#import "TKJson.h"
#import "TKHasher.h"

@implementation TKHasher

+ (NSData *)hashData:(NSData *)input {
    unsigned char* output_buf = malloc(CC_SHA256_DIGEST_LENGTH);
    
    CC_SHA256(input.bytes, (CC_LONG) input.length, output_buf);
    
    NSData *output = [NSData dataWithBytes:output_buf length:CC_SHA256_DIGEST_LENGTH];
    free(output_buf);
    
    return output;
}

+ (NSString *)hashString:(NSString *)input {
    const char* input_cstr = [input UTF8String];
    return [TKHasher serializeReadable:[TKHasher hashData:[NSData dataWithBytes:input_cstr length:strlen(input_cstr)]]];
}

+ (NSString *)hashMessage:(GPBMessage *)message {
    return [TKHasher hashString:[TKJson serialize:message]];
}

+ (NSString *)hashAlias:(Alias *)alias {
    if (alias.type == Alias_Type_Username) {
        return alias.value;
    }
    return [TKHasher hashMessage:alias];
}

+ (NSString *)serializeReadable:(NSData *)data {
    return[[NSString alloc] initWithData: [TKHasher encodeBase58:data] encoding:NSUTF8StringEncoding];
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
