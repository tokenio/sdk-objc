//
//  TKLocalizer.h
//  TokenSdk
//
//  Created by Vadim on 2/1/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TKLocalizedString(key, comment) [[TKLocalizer shared] localizedStringForKey:(key)]

@interface TKLocalizer : NSObject

@property NSString* stringsFile;

+ (instancetype)shared;
- (NSString *)localizedStringForKey:(NSString *)key;

@end
