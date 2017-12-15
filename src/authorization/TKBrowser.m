//
//  TKBrowser.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKBrowser.h"

@implementation TKBrowser

- (id)initWithBrowserDelegate:(id<TKBrowserDelegate>)delegate {
    self = [super init];
    
    if (self) {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - override methods

- (void) loadUrl:(NSString *)url {}

- (void) dismiss {}

@end
