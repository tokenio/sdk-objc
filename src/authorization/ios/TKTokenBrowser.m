//
//  TKTokenBrowser.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKTokenBrowser.h"
#import "TKTokenBrowserViewController.h"

@interface TKTokenBrowser () <TKTokenBrowserViewControllerDelegate> {
    TKTokenBrowserViewController *browserViewController;
}
@end

@implementation TKTokenBrowser

#pragma mark - override methods

- (void) loadUrl:(NSString *)url {
    if (browserViewController == nil) {
        browserViewController = [[TKTokenBrowserViewController alloc] initWithDelegate:self];
        UIViewController* rootViewController =
        [UIApplication sharedApplication].keyWindow.rootViewController;
        
        if (rootViewController == nil) {
            [self.delegate browserWillCancel:nil];
        }
        
        [rootViewController presentViewController:browserViewController
                                         animated:true
                                       completion:^{
                                           [browserViewController loadUrl:url];
                                       }];
    } else {
        [browserViewController loadUrl:url];
    }
}

- (void)dismiss {
    [browserViewController dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - TKTokenBrowserViewControllerDelegate
- (void)browserViewControllerCancelCallback:(TKTokenBrowserViewController *)browserViewController {
    [self.delegate browserWillCancel:nil];
    [browserViewController dismissViewControllerAnimated:true completion:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code >= 400) {
        // Error code 102 is the result of not passing redirect URL through so we can ignore that
        [self.delegate browserWillCancel:error];
        [browserViewController dismissViewControllerAnimated:true completion:nil];
    }
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    return [self.delegate shouldStartLoadWithRequest:request];
}
@end
