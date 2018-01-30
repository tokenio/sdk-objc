//
//  TKAuthorizationEngine.h
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"
#import "Token.pbobjc.h"
#import "TKBrowser.h"

/**
 * Authorization Engine handles all the external authorization details in sdk.
 */
@interface TKAuthorizationEngine : NSObject <TKBrowserDelegate>
/**
 * Initialize with TKBrowserFactory and ExternalAuthorizationDetails. Each external authorization
 * shall have their own authorization engine instance.
 */
- (id)initWithBrowserFactory:(TKBrowserFactory)browserFactory
ExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details;

/**
 * Authorizes for the external authorization.
 * An regular expression error means the external authorization details object is invalid.
 * @param onSuccess invoked on success with bank authorization
 * @param onError invoked on error (Cancellation is a kind of error)
 */
- (void)authorizeOnSuccess:(OnSuccessWithBankAuthorization)onSuccess
                   onError:(OnError)onError;

/**
 * Closing the authorization engine will dismiss the browser. it is necessary to close the
 * auth engine after authorizeOnSuccess:onError:. This method enhance the flexibility to control
 * the browser.
 */
- (void)close;

@end
