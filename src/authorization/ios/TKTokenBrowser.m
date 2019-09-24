//
//  TKTokenBrowser.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
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
        
        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        
        if (topController == nil) {
            [self.delegate browserWillCancel:nil];
        }
        
        [topController presentViewController:browserViewController
                                    animated:true
                                  completion:^{
                                      [self->browserViewController loadUrl:url];
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

- (void)webView:(WKWebView *)webView
didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if (error.code >= 400) {
        // Error code 102 is the result of not passing redirect URL through so we can ignore that
        [self.delegate browserWillCancel:error];
        [browserViewController dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if (error.code >= 400) {
        // Error code 102 is the result of not passing redirect URL through so we can ignore that
        [self.delegate browserWillCancel:error];
        [browserViewController dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([self.delegate shouldStartLoadWithRequest:navigationAction.request]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
@end
