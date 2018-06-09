//
//  TKOauthEngine.h
//  TokenSdk
//
//  Created by Sibin Lu on 3/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"
#import "Token.pbobjc.h"
#import "TKBrowser.h"
#import "TokenCluster.h"

/**
 * OAuth Engine handles bank linking in sdk.
 */
@interface TKOauthEngine : NSObject <TKBrowserDelegate>
/**
 * Initialize with TKBrowserFactory and url.
 */
- (id)initWithTokenCluster:(TokenCluster *)tokenCluster
            BrowserFactory:(TKBrowserFactory)browserFactory
                       url:(NSString *)url;

/**
 * Authorizes for the bank access token.
 *
 * @param onSuccess invoked on success with bank access token
 * @param onError invoked on error (Cancellation is a kind of error)
 */
- (void)authorizeOnSuccess:(OnSuccessWithString)onSuccess
                   onError:(OnError)onError;

/**
 * Closing the authorization engine will dismiss the browser. it is necessary to close the
 * auth engine after authorizeOnSuccess:onError:. This method enhance the flexibility to control
 * the browser.
 */
- (void)close;

@end
