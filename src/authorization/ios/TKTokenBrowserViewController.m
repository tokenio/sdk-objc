//
//  TKTokenBrowserViewController.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "TKTokenBrowserViewController.h"
#import "TKTokenBrowser.h"
#import "TKLocalizer.h"

@interface TKTokenBrowserViewController () <WKNavigationDelegate>{
    id<TKTokenBrowserViewControllerDelegate> delegate;
    /*
     * From iOS 11, a constraint error will be thrown when the keyboard pops up.
     * No way to 
     */
    WKWebView *webView;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UILabel *urlLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *backButton;
    // WKWebview is not supported in Nib until iOS 11.0.
    IBOutlet UIView *layoutView;
}
@end

@implementation TKTokenBrowserViewController

- (id)initWithDelegate: (id<TKTokenBrowserViewControllerDelegate>)delegate_ {
    NSBundle *podBundle = [NSBundle bundleForClass:[TKTokenBrowserViewController class]];
    self = [super initWithNibName:@"TKTokenBrowserViewController" bundle:podBundle];
    
    if (self) {
        delegate = delegate_;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Clears shared cookies
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    if (cookies != nil) {
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    titleLabel.text = TKLocalizedString( @"Authorization", nil);
    [backButton setTitle:TKLocalizedString( @"Back", nil)
                forState:UIControlStateNormal];

    [self createWebView];
    [spinner startAnimating];
}

- (void) createWebView {
    webView = [[WKWebView alloc] initWithFrame: CGRectZero];
    webView.translatesAutoresizingMaskIntoConstraints = false;

    [layoutView addSubview:webView];
    [[webView.leadingAnchor constraintEqualToAnchor:layoutView.leadingAnchor] setActive:true];
    [[webView.trailingAnchor constraintEqualToAnchor:layoutView.trailingAnchor] setActive:true];
    [[webView.topAnchor constraintEqualToAnchor:layoutView.topAnchor] setActive:true];
    [[webView.bottomAnchor constraintEqualToAnchor:layoutView.bottomAnchor] setActive:true];

    webView.navigationDelegate = self;
}

- (void)loadUrl:(NSString *)url {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    urlLabel.text = request.URL.host;
    [webView loadRequest:request];
}

- (IBAction)dismiss {
    [delegate browserViewControllerCancelCallback: self];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView
didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [delegate webView:webView didFailNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [delegate webView:webView didFailProvisionalNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [delegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [spinner stopAnimating];
    [spinner setHidden:YES];
}
@end
