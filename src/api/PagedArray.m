//
//  Created by Maxim Khutornenko on 11/10/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PagedArray.h"

@implementation PagedArray
- (id)initWith:(NSArray<id> *)items
        offset:(NSString *)offset {
    self = [super init];
    if (self) {
        pagedItems = items;
        pageOffset = offset;
    }
    return self;
}

- (NSArray<id> *)items {
    return pagedItems;
}

- (NSString *)offset {
    return pageOffset;
}

@end
