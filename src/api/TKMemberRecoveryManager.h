//
//  Created by Sibin Lu on 10/20/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"
#import "TKBrowser.h"
#import "TokenCluster.h"

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
         tokenCluster:(TokenCluster *)tokenCluster
            timeoutMs:(int)timeoutMs
         developerKey:(NSString *)developerKey
         languageCode:(NSString *)languageCode
         errorHandler:(TKRpcErrorHandler *)errorHandler
               crypto:(id<TKCryptoEngineFactory>)cryptoEngineFactory
       browserFactory:(TKBrowserFactory)browserFactory;

/**
 * Begins member account recovery process by contacting alias. The verification message will
 * be sent if the alias is valid. All the member recovery methods shall be called by the same
 * TKMemberRecoveryManager instance.
 *
 * @param alias alias to recover
 * @param onSuccess invoked if successful with verification Id
 * @param onError invoked if failed
 */

- (void)beginMemberRecovery:(Alias *)alias
                  onSuccess:(OnSuccessWithString)onSuccess
                    onError:(OnError)onError;

/**
 * Verifies member recovery code after beginMemberRecovery is successful. All the member recovery
 * methods shall be called by the same TKMemberRecoveryManager instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 * @param onSuccess invoked if successful
 * @param onError invoked if failed
 */
- (void)verifyMemberRecovery:(Alias *)alias
                    memberId:(NSString *)memberId
              verificationId:(NSString *)verificationId
                        code:(NSString *)code
                   onSuccess:(OnSuccess)onSuccess
                     onError:(OnError)onError;

/**
 * Completes member recovery process after verifyMemberRecoveryCode is successful. Uploads member's
 * public keys from this device to Token directory. All the member recovery methods shall be called
 * by the same TKMemberRecoveryManager instance.
 *
 * @param alias alias to recover
 * @param memberId memberId to recover
 * @param verificationId verification Id from beginMemberRecovery call
 * @param code code from verification message
 * @param onSuccess invoked if successful with TkMember
 * @param onError invoked if failed
 */
- (void)completeMemberRecovery:(Alias *)alias
                      memberId:(NSString *)memberId
                verificationId:(NSString *)verificationId
                          code:(NSString *)code
                     onSuccess:(OnSuccessWithTKMember)onSuccess
                       onError:(OnError)onError;
@end
