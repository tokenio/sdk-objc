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
@class PaymentToken_Payload;
@class PaymentPayload;


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
- (void)addKey:(NSString *)newPublicKey
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
             payload:(NSString *)accountLinkPayload
           onSuccess:(OnSuccessWithAccounts)onSuccess
             onError:(OnError)onError;

/**
 * Looks up linked member accounts.
 */
- (void)getAccounts:(OnSuccessWithAccounts)onSuccess
               onError:(OnError)onError;

/**
 * Looks up a linked member account.
 */
- (void)getAccount:(NSString *)accountId
          onSuccess:(OnSuccessWithAccount)onSuccess
               onError:(OnError)onError;

/**
 * Creates a new payment token.
 *
 * @param payload payment token payload
 */
- (void)createPaymentToken:(PaymentToken_Payload *)payload
                 onSuccess:(OnSuccessWithPaymentToken)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up an existing token.
 *
 * @param tokenId token id
 */
- (void)getPaymentToken:(NSString *)tokenId
              onSuccess:(OnSuccessWithPaymentToken)onSuccess
                onError:(OnError)onError;

/**
 * Looks up token owned by the member.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 */
- (void)getPaymentTokens:(int)offset
                   limit:(int)limit
               onSuccess:(OnSuccessWithPaymentTokens)onSuccess
                    onError:(OnError)onError;

/**
 * Endorses a payment token.
 *
 * @param token token to endorse
 */
- (void)endorsePaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)success
                    onError:(OnError)error;

/**
 * Cancels a payment token.
 *
 * @param token token to endorse
 */
- (void)cancelPaymentToken:(PaymentToken *)token
                  onSuccess:(OnSuccessWithPaymentToken)success
                    onError:(OnError)error;

/**
 * Redeems a payment token.
 *
 * @param payment payment parameters, such as amount, currency, etc
 */
- (void)redeemPaymentToken:(PaymentPayload *)payload
                 onSuccess:(OnSuccessWithPayment)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up a token payment by id.
 *
 * @param paymentId payment id
 */
- (void)getPayment:(NSString *)paymentId
         onSuccess:(OnSuccessWithPayment)onSuccess
           onError:(OnError)onError;

/**
 * Looks up existing token payments.
 *
 * @param offset offset to start at
 * @param limit max number of records to return
 * @param tokenId optional token id to restrict the search
 */
- (void)getPaymentsOffset:(int)offset
                    limit:(int)limit
                  tokenId:(NSString *)tokenId
                onSuccess:(OnSuccessWithPayments)onSuccess
                  onError:(OnError)onError;

/**
 * Looks up account balance.
 *
 * @param accountId account id
 * @return account balance
 */
- (void)getBalance:(NSString *)accountId
         onSuccess:(OnSuccessWithMoney)onSuccess
           onError:(OnError)onError;

/**
 * Looks up an existing transaction. Doesn't have to be a transaction for a token payment.
 *
 * @param accountId ID of the account
 * @param transactionId ID of the transaction
 * @return transaction record
 */
- (void)getTransaction:(NSString *)transactionId
            forAccount:(NSString *)accountId
             onSuccess:(OnSuccessWithTransaction)onSuccess
               onError:(OnError)onError;

/**
 * Looks up existing transactions. This is a full list of transactions with token payments
 * being a subset.
 *
 * @param accountId ID of the account
 * @param offset offset to start at
 * @param limit max number of records to return
 * @return transaction record
 */
- (void)getTransactionsOffset:(NSString *)accountId
                       offset:(int)offset
                        limit:(int)limit
                    onSuccess:(OnSuccessWithTransactions)onSuccess
                      onError:(OnError)onError;

/**
 * Creates a new member address
 *
 * @param name the name of the address
 * @param data the address json
 * @return an address record created
 */
- (void)addAddressWithName:(NSString *)name
                  withData:(NSString *)data
                 onSuccess:(OnSuccessWithAddress)onSuccess
                   onError:(OnError)onError;

/**
 * Looks up an address by id
 *
 * @param addressId the address id
 * @return an address record
 */
- (void)getAddressById:(NSString *)addressId
             onSuccess:(OnSuccessWithAddress)onSuccess
               onError:(OnError)onError;

/**
 * Looks up member addresses
 *
 * @return a list of addresses
 */
- (void)getAddresses:(OnSuccessWithAddresses)onSuccess
             onError:(OnError)onError;

/**
 * Deletes a member address by its id
 *
 * @param addressId the id of the address
 */
- (void)deleteAddressById:(NSString *)addressId
                onSuccess:(OnSuccess)onSuccess
                  onError:(OnError)onError;

@end
