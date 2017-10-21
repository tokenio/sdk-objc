//
//  Created by Sibin Lu on 10/20/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"

@class TKUnauthenticatedClient;
@protocol TKCryptoEngineFactory;
@class GatewayService;
@class TKRpcErrorHandler;

/**
 * Use this class to manage recovery process.
 */
@interface TKRecoveryManager : NSObject

/**
 * Initializes the recovery manager.
 *
 * @param unauthenticatedClient unauthenticatedClient for recovery process
 * @param cryptoEngineFactory crypto module to use
 * @return the recovery manager
 */
- (id)initWithGateway:(GatewayService *)gateway
            timeoutMs:(int)timeoutMs
         developerKey:(NSString *)developerKey
         errorHandler:(TKRpcErrorHandler *)errorHandler
               crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory;

/**
 * Begins recovery process for an alias. The verification message will be sent if the alias is valid.
 *
 * @param aliasValue alias value to recover
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)beginRecovery:(NSString *)aliasValue
            onSuccess:(OnSuccess)onSuccess
              onError:(OnError)onError;

/**
 * Verifies recovery code after beginRecovery is successful.
 *
 * @param code code from verification message
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)verifyRecoveryCode:(NSString *)code
                 onSuccess:(OnSuccessWithBoolean)onSuccess
                   onError:(OnError)onError;

/**
 * Completes recovery process after verifyRecoveryCode is successful.
 *
 * @param onSuccess invoked if successful with TkMember
 * @param onError invoked if failed
 */
- (void)completeRecovery:(OnSuccessWithTKMember)onSuccess
                 onError:(OnError)onError;
@end
