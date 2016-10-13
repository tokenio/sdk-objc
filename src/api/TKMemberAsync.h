//
// Created by Alexey Kalinichenko on 9/13/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKTypedef.h"
#import "Subscriber.pbobjc.h"
#import "Security.pbobjc.h"


@class TKSecretKey;
@class Member;
@class TKClient;



/**
 * Represents a Member in the Token system. Each member has an active secret
 * and public key pair that is used to perform authentication.
 * 
 * <p>
 * The class provides async API with `TKMember` providing a synchronous version.
 * `TKMember` instance can be obtained by calling `sync` method.
 * </p>
 */
@interface TKMemberAsync : NSObject

@property (readonly, retain) TKMember *sync;
@property (readonly, retain) NSString *id;
@property (readonly, retain) NSString *firstAlias;
@property (readonly, retain) NSArray<NSString*> *aliases;
@property (readonly, retain) NSArray<NSString*> *publicKeys;
@property (readonly, retain) TKSecretKey *key;

/**
 * Creates new member instance. The method is not meant to be invoked directly.
 * Use `TokenIO` or `TokenIOAsync` to obtain an instance of this class.
 */
+ (TKMemberAsync *)member:(Member *)member
                secretKey:(TKSecretKey *)key
                useClient:(TKClient *)client;

/**
 * Approves a public key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approveKey:(TKSecretKey *)key
             level:(Key_Level)level
         onSuccess:(OnSuccess)onSuccess
           onError:(OnError)onError;

/**
 * Approves a public key owned by this member. The key is added to the list
 * of valid keys for the member.
 *
 * @param key to add to the approved list
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)approvePublicKey:(NSString *)publicKey
                   level:(Key_Level)level
               onSuccess:(OnSuccess)onSuccess
                 onError:(OnError)onError;

/**
 * Removes a key owned by this member.
 *
 * @param keyId key ID of the key to remove
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeKey:(NSString *)keyId
        onSuccess:(OnSuccess)onSuccess
          onError:(OnError)onError;

/**
 * Adds a new alias for the member.
 *
 * @param alias alias, e.g. 'john', must be unique
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAlias:(NSString *)alias
       onSuccess:(OnSuccess)onSuccess
         onError:(OnError)onError;

/**
 * Removes an alias for the member.
 *
 * @param alias alias, e.g. 'john'
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)removeAlias:(NSString *)alias
          onSuccess:(OnSuccess)onSuccess
            onError:(OnError)onError;


/**
 * Subscribes a device to receive push notifications
 *
 * @param provider push notification provider (default @"Token")
 * @param target target to send push to (push token)
 * @param platform target platform for notification (e.g. Platform_Ios)
 */
- (void)subscribeToNotifications:(NSString *)provider
        target:(NSString *)target
               platform:(Platform)platform
              onSuccess:(OnSuccessWithSubscriber)onSuccess
                onError:(OnError)onError;

/**
 * Get all subscribers 
 *
 */
- (void)getSubscribers:(OnSuccessWithSubscribers)onSuccess
                             onError:(OnError)onError;

/**
 * Get a subscriber by Id
 *
 * @param subscriberId id of subscriber to get
 */
- (void)getSubscriber:(NSString *)subscriberId
                           onSuccess:(OnSuccessWithSubscriber)onSuccess
                             onError:(OnError)onError;

/**
 * Unsubscribes a device from push notifications
 *
 * @param subscriberId if of subscriber to remove
 */
- (void)unsubscribeFromNotifications:(NSString *)subscriberId
              onSuccess:(OnSuccess)onSuccess
                onError:(OnError)onError;


/**
 * Links a funding bank account to Token and returns it to the caller.
 *
 * @param bankId bank id
 * @param payload account link authorization payload generated
 *                by the bank
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)linkAccounts:(NSString *)bankId
         withPayload:(NSString *)payload
           onSuccess:(OnSuccessWithTKAccountsAsync)onSuccess
             onError:(OnError)onError;

/**
 * Looks up funding bank accounts linked to Token.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAccounts:(OnSuccessWithTKAccountsAsync)onSuccess
            onError:(OnError)onError;

/**
 * Looks up a funding bank account linked to Token.
 *
 * @param accountId account id
 */
- (void)getAccount:(NSString *)accountId
         onSuccess:(OnSuccessWithTKAccountAsync)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing token payment.
 *
 * @param paymentId ID of the payment record
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getPayment:(NSString *)paymentId
         onSuccess:(OnSuccessWithPayment)onSuccess
           onError:(OnError)onError;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                  tokenId:(NSString *)tokenId
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError;

/**
 * Creates a new member address.
 *
 * @param name the name of the address
 * @param address the address json
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)addAddressWithName:(NSString *)name
                  withData:(NSString *)data
                 onSuccess:(OnSuccessWithAddress)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up an address by id.
 *
 * @param addressId the address id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAddressWithId:(NSString *)addressId
               onSuccess:(OnSuccessWithAddress)onSuccess
                 onError:(OnError)onError;

/**
 * Looks up member addresses.
 *
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

/**
 * Deletes a member address by its id.
 *
 * @param addressId the id of the address
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)deleteAddressWithId:(NSString *)addressId
                  onSuccess:(OnSuccess)onSuccess
                    onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                           onSuccess:(OnSuccessWithPaymentToken)onSuccess
                             onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param accountId the funding account id
 * @param amount payment amount
 * @param currency currency code, e.g. "USD"
 * @param redeemer redeemer alias
 * @param description payment description, optional
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)createPaymentTokenForAccount:(NSString *)accountId
                              amount:(double)amount
                            currency:(NSString *)currency
                       redeemerAlias:(NSString *)redeemerAlias
                         description:(NSString *)description
                           onSuccess:(OnSuccessWithPaymentToken)onSuccess
                             onError:(OnError)onError;

/**
 * Looks up a existing payment token.
 *
 * @param tokenId token id
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getPaymentToken:(NSString *)tokenId
              onSuccess:(OnSuccessWithPaymentToken)onSuccess
                onError:(OnError)onError;

/**
 * Looks up payment tokens owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)getPaymentTokensOffset:(int)offset
                         limit:(int)limit
                     onSuccess:(OnSuccessWithPaymentTokens)onSuccess
                       onError:(OnError)onError;

/**
 * Endorses the payment token by signing it. The signature is persisted 
 * along with the token.
 *
 * @param token token to endorse
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)endorsePaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)onSuccess
                    onError:(OnError)onError;

/**
 * Cancels the payment token by signing it. The signature is persisted
 * along with the token.
 *
 * @param token token to cancel
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)cancelPaymentToken:(PaymentToken *)token
                 onSuccess:(OnSuccessWithPaymentToken)onSuccess
                   onError:(OnError)onError;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemPaymentToken:(PaymentToken *)token
                 onSuccess:(OnSuccessWithPayment)onSuccess
                   onError:(OnError)onError;

/**
 * Redeems a payment token.
 *
 * @param token payment token to redeem
 * @param amount payment amount
 * @param currency payment currency code, e.g. "EUR"
 * @param onSuccess callback invoked on success
 * @param onError callback invoked on error
 */
- (void)redeemPaymentToken:(PaymentToken *)token
                    amount:(NSNumber *)amount
                  currency:(NSString *)currency
                 onSuccess:(OnSuccessWithPayment)onSuccess
                   onError:(OnError)onError;

@end
