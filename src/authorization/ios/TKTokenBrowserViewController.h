//
//  TKTokenBrowserViewController.h
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "TKBrowser.h"

@class TKTokenBrowserViewController;

/**
 * Protocol for all the event handlings in TKTokenBrowserViewController
 */
@protocol TKTokenBrowserViewControllerDelegate <WKNavigationDelegate>
@required
- (void)browserViewControllerCancelCallback:(TKTokenBrowserViewController *)browserViewController;
@end

/**
 * TKTokenBrowser's UI implementation.
 */
@interface TKTokenBrowserViewController : UIViewController

- (id)initWithDelegate: (id<TKTokenBrowserViewControllerDelegate>)delegate;

/**
 * The web view will load the url.
 * @param url The url to load
 */
- (void)loadUrl:(NSString *)url;
@end
