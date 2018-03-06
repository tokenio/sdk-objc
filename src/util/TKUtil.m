//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "TKUtil.h"


@implementation TKUtil

+ (NSString *)tokenSdkVersion {
    return @"1.0.86";
}

+ (NSString *)nonce {
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)base64EncodeBytes:(const char *)bytes length:(NSUInteger)length {
    return [self base64EncodeData:[NSData dataWithBytes:bytes length:length]];
}

+ (NSString *)base64UrlEncodeBytes:(const char *)bytes length:(NSUInteger)length {
    return [self base64UrlEncodeData:[NSData dataWithBytes:bytes length:length]];
}

+ (NSString *)base64EncodeData:(NSData *)data {
    return [self base64EncodeData:data padding:false];
}

+ (NSString *)base64UrlEncodeData:(NSData *)data {
    return [self base64UrlEncodeData:data padding:false];
}

+ (NSString *)base64EncodeData:(NSData *)data padding:(bool)padding {
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    if (!padding) {
        base64String = [base64String stringByReplacingOccurrencesOfString:@"=" withString:@""];
    }
    return base64String;
}

+ (NSString *)base64UrlEncodeData:(NSData *)data padding:(bool)padding {
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    if (!padding) {
        base64String = [base64String stringByReplacingOccurrencesOfString:@"=" withString:@""];
    }
    return base64String;
}

+ (NSData *)base64DecodeString:(NSString *)base64String {
    NSString *copy = base64String;

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

+ (NSData *)base64UrlDecodeString:(NSString *)base64String {
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
    CC_SHA256(data.bytes, (int) data.length, digest);

    NSData *shaData = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *shaString = [self base64UrlEncodeData:shaData];
    return [shaString substringToIndex:16];
}

+ (NSString *)snakeCaseToCamelCase:(NSString *)input {
    NSArray *components = [input componentsSeparatedByString:@"_"];
    NSMutableString *camelCaseString = [NSMutableString string];
    [components enumerateObjectsUsingBlock:^(NSString *component, NSUInteger idx, BOOL *stop) {
        [camelCaseString appendString:(idx == 0 ? component : [component capitalizedString])];
    }];
    return [camelCaseString copy];
}

+ (NSString *)camelCaseToSnakeCase:(NSString *)input {
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSUInteger idx = 0; idx < [input length]; idx += 1) {
        unichar c = [input characterAtIndex:idx];
        if ([uppercase characterIsMember:c]) {
            [output appendFormat:@"_%@", [[NSString stringWithCharacters:&c length:1] lowercaseString]];
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;}

@end
