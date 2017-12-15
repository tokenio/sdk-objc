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
 * Initialize with TKBrowserCreationBlock. If the block is nil or invalid, the engine will
 * use TKTokenBrowser instead.
 */
- (id)initWithBrowserCreationBlock:(TKBrowserCreationBlock)browserCreationBlock;

/**
 * Authorizes the external authorization details.
 * @param details the external authorization details to authorizes
 * @param onSuccess invoked on success with bank authorization
 * @param onError invoked on error
 */
- (void)authorizedWithExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details
                                         onSuccess:(OnSuccessWithBankAuthorization)onSuccess
                                           onError:(OnError)onError;

/**
 * Revoking the authorization engine will dismiss the browser. Revoke is necessary after
 * authorizedWithExternalAuthorizationDetails. This method enhance the flexibility to control the browser.
 */
- (void)revoke;

@end
