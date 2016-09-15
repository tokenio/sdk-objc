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

+ (NSString *)base64EncodeBytes:(const char *)bytes length:(NSUInteger)length {
    return [self base64EncodeData:[NSData dataWithBytes:bytes length:length]];
}

+ (NSString *)base64EncodeData:(NSData *)data {
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return base64String;
}

+ (NSData *)base64DecodeString:(NSString *)base64String {
    NSString *copy = [base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    copy = [copy stringByReplacingOccurrencesOfString:@"-" withString:@"+"];

    int padding = copy.length % 4;
    if (padding > 0) {
        copy = [copy stringByPaddingToLength:copy.length + 4 - padding withString:@"=" startingAtIndex:0];
    }

    NSData *result = [[NSData alloc]
            initWithBase64EncodedString:copy
                                options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (result == nil) {
        [NSException
                raise:NSInvalidArgumentException
               format:@"Invalid Base64 string: %@", base64String];
    }

    return result;
}

+ (NSString *)idForString:(NSString *)string {
    return [self idForBytes:[string cStringUsingEncoding:NSASCIIStringEncoding]];
}

+ (NSString *)idForBytes:(const char *)buffer {
    return [self idForData:[NSData dataWithBytes:buffer length:strlen(buffer)]];
}

+ (NSString *)idForData:(NSData *)data {
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(data.bytes, data.length, digest);

    NSData *shaData = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *shaString = [self base64EncodeData:shaData];
    return [shaString substringToIndex:16];
}

@end