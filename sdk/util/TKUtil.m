//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "TKUtil.h"


@implementation TKUtil

+ (NSString *)nonce {
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)base64EncodeData:(NSData *)data {
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return base64String;
}

+ (NSString *)idForString:(NSString *)string {
    return [TKUtil idForBytes:[string cStringUsingEncoding:NSASCIIStringEncoding]];
}

+ (NSString *)idForBytes:(const char *)buffer {
    NSData *keyData=[NSData dataWithBytes:buffer length:strlen(buffer)];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);

    NSData *data = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    return [self base64EncodeData:data];
}

@end