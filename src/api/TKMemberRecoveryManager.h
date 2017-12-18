//
//  Created by Sibin Lu on 10/20/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"
#import "TkBrowser.h"

@class GatewayService;
@class TKRpcErrorHandler;
@class TKUnauthenticatedClient;
@protocol TKCryptoEngineFactory;

/**
 * Use this class to manage member recovery process. All the member recovery methods shall
 * be called by the same TKMemberRecoveryManager instance.
 */
@interface TKMemberRecoveryManager : NSObject

/**
 * Initializes the member recovery manager.
 *
 * @param cryptoEngineFactory crypto module to use
 * @return the member recovery manager
 */
- (id)initWithGateway:(GatewayService *)gateway
            timeoutMs:(int)timeoutMs
         developerKey:(NSString *)developerKey
         errorHandler:(TKRpcErrorHandler *)errorHandler
               crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory
       browserFactory:(TKBrowserFactory)browserFactory;

/**
 * Begins member account recovery process by contacting alias. The verification message will
 * be sent if the alias is valid. All the member recovery methods shall be called by the same
 * TKMemberRecoveryManager instance.
 *
 * @param aliasValue alias value to recover
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)beginMemberRecovery:(NSString *)aliasValue
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError;

/**
 * Verifies member recovery code after beginMemberRecovery is successful. All the member recovery
 * methods shall be called by the same TKMemberRecoveryManager instance.
 *
 * @param code code from verification message
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)verifyMemberRecoveryCode:(NSString *)code
                       onSuccess:(OnSuccessWithBoolean)onSuccess
                         onError:(OnError)onError;

/**
 * Completes member recovery process after verifyMemberRecoveryCode is successful. Uploads member's
 * public keys from this device to Token directory. All the member recovery methods shall be called
 * by the same TKMemberRecoveryManager instance.
 *
 * @param onSuccess invoked if successful with TkMember
 * @param onError invoked if failed
 */
- (void)completeMemberRecovery:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError;
@end
