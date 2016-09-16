//
// Created by Alexey Kalinichenko on 9/14/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTypedef.h"

@class Member;
@class GatewayService;
@class TKSecretKey;
@class PaymentToken;


/**
 * An authenticated RPC client that is used to talk to Token gateway. The
 * class is a thin wrapper on top of gRPC generated client. Makes the API
 * easier to use.
 */
@interface TKClient : NSObject

/**
 * @param gateway gateway gRPC client
 * @param key secret key to use for authentication
 * @return newly created client
 */
- (id)initWithGateway:(GatewayService *)gateway
             memberId:(NSString *)memberId
            secretKey:(TKSecretKey *)key;

/**
 * Looks up member information for the current user. The user is defined by
 * the key used for authentication.
 *
 * @return member information
 */
- (void)getMember:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError;

/**
 * Adds an alias for a given user.
 *
 * @param member member to add the alias to
 * @param alias new unique alias to add
 * @return member information
 */
- (void)addAlias:(NSString *)alias
              to:(Member *)member
       onSuccess:(OnSuccessWithMember)onSuccess
         onError:(OnError)onError;


/**
 * Removes an alias for a given user.
 *
 * @param member member to remove the alias to
 * @param alias alias to remove
 * @return member information
 */
- (void)removeAlias:(NSString *)alias
               from:(Member *)member
          onSuccess:(OnSuccessWithMember)onSuccess
            onError:(OnError)onError;

/**
 * Adds a public key to the list of approved keys for the specified member.
 *
 * @param key key to add
 * @param member member to add the key to
 * @param level key level
 */
- (void)addKey:(TKSecretKey *)key
            to:(Member *)member
         level:(NSUInteger)level
     onSuccess:(OnSuccessWithMember)onSuccess
       onError:(OnError)onError;

/**
 * Removes a public key from the list of approved keys for the specified member.
 *
 * @param key key to remove
 * @param member member to remove the key for
 */
- (void)removeKey:(NSString *)keyId
             from:(Member *)member
        onSuccess:(OnSuccessWithMember)onSuccess
          onError:(OnError)onError;

/**
 * Links a funding bank account to Token.
 *
 * @param bankId bank id
 * @param accountLinkPayload account link authorization payload generated
 *                           by the bank
 */
- (void)linkAccounts:(NSString *)bankId
             payload:(NSData *)accountLinkPayload
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Looks up linked member accounts.
 */
- (void)lookupAccounts:(OnSuccessWithAccounts)onSuccess
               onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param redeemerAlias redeemer alias
 * @param description payment description, optional
 */
- (void)createPaymentToken:(PaymentToken *)paymentToken
                    onSuccess:(OnSuccessWithToken)onSuccess
                      onError:(OnError)onError;

/**
 * Looks up an existing token.
 *
 * @param tokenId token id
 */
- (void)lookupToken:(NSString *)tokenId
                 onSuccess:(OnSuccessWithToken)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up token owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (void)lookupTokens:(int)offset
               limit:(int)limit
           onSuccess:(OnSuccessWithTokens)onSuccess
             onError:(OnError)onError;

/**
 * Endorses a token.
 *
 * @param token token to endorse
 */
- (void)endorseToken:(Token *)token
           onSuccess:(OnSuccessWithToken)success
             onError:(OnError)error;

/**
 * Declines a token.
 *
 * @param token token to endorse
 */
- (void)declineToken:(Token *)token
           onSuccess:(OnSuccessWithToken)success
             onError:(OnError)error;

/**
 * Revokes a token.
 *
 * @param token token to endorse
 */
- (void)revokeToken:(Token *)token
           onSuccess:(OnSuccessWithToken)success
             onError:(OnError)error;

@end