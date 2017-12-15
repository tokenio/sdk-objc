//
//  TKBrowser.h
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKBrowser;

/**
 * TKAuthorizationEngine observes TKBrowser with this protocol
 */
@protocol TKBrowserDelegate
@required
/**
 * Return Yes if the browser shall load this request; Otherwise the browser will discard the request.
 */
- (BOOL) shouldStartLoadWithRequest:(NSURLRequest *)request;
/**
 * This method will be invoked when the authorization will cancel by browser.
 */
- (void) authenticationWillCancel:(NSError *)error;
@end

typedef TKBrowser * (^ TKBrowserCreationBlock)(id<TKBrowserDelegate>);

/**
 * The browser for external authorization. Whenever external authorization is required, the browser will be invoked by TKAuthorizationEngine.
 * To Use customized browsers:
 *    1. Defines subclass from TKBrowser
 *    2. Implements override methods.
 *    3. Sets customized TKBrowserCreationBlock in TokenIO.
 */
@interface TKBrowser : NSObject
@property (weak, nonatomic) id<TKBrowserDelegate> delegate;

- (id)initWithBrowserDelegate:(id<TKBrowserDelegate>)delegate;

#pragma mark - override methods
/**
 * The browser will load this url.
 * @param url the url to load
 */
- (void) loadUrl:(NSString *)url;

/**
 * Dismisses The browser.
 */
- (void) dismiss;

@end
