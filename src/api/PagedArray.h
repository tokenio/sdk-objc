//
// Created by Maxim Khutornenko on 12/2/16.
// Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Wraps results returned from the offset/limit enabled methods.
 */
@interface PagedArray<T> : NSObject {
    NSArray<T> *pagedItems;
    NSString *pageOffset;
}

/**
 * Creates a new instance with paged items and offset.
 *
 * @param items returned items
 * @param offset returned offset
 */
- (id)initWith:(NSArray<T> *)items
        offset:(NSString *)offset;

@property (readonly, retain) NSArray<T> *items;
@property (readonly, retain) NSString *offset;

@end
