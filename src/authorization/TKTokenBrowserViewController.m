//
//  TKTokenBrowserViewController.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKTokenBrowserViewController.h"
#import "TKTokenBrowser.h"

@interface TKTokenBrowserViewController () <UIWebViewDelegate>{
    id<TKTokenBrowserViewControllerDelegate> delegate;
    IBOutlet UIWebView *webview;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UILabel *urlLabel;
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
    
    webview.delegate = self;
    [spinner startAnimating];
}

- (void)loadUrl:(NSString *)url {
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    urlLabel.text = request.URL.host;
    [webview loadRequest:request];
}

- (IBAction)dismiss {
    [delegate browserViewControllerDidClickCancelButton: self];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [delegate webView:webView didFailLoadWithError:error];
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return [delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // TODO: Remove this js after the problem fix on bank-demo
    NSString *jsRemoveYobleeTopRightCloseButton = @"var element = document.getElementsByClassName('yodlee-font-icon svg_close close-modal-window closeIcon right hide-for-mobile-only')[0];  element.style.display = 'none';";
    [webView stringByEvaluatingJavaScriptFromString:jsRemoveYobleeTopRightCloseButton];
    
    [spinner stopAnimating];
    [spinner setHidden:YES];
    
    [delegate webViewDidFinishLoad:webView];
}
@end
