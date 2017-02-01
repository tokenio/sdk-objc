//
//  TKLocalizer.m
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKLocalizer.h"

@implementation TKLocalizer

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static TKLocalizer* sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (NSString*)localizedStringForKey:(NSString *)key {
    if (_stringsFile != nil) {
        NSString* mainBundleCustomTableString = [NSBundle.mainBundle localizedStringForKey:key value:@"" table:_stringsFile];
        if (![mainBundleCustomTableString isEqualToString:key]) {
            return mainBundleCustomTableString;
        }
    }

    NSString* mainBundleString = [NSBundle.mainBundle localizedStringForKey:key value:@"" table:nil];
    if (![mainBundleString isEqualToString:key]) {
        return mainBundleString;
    }
    
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle localizedStringForKey:key value:@"" table:nil];
}

@end
