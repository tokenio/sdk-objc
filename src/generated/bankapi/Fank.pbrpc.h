#import "bankapi/Fank.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "google/api/Annotations.pbobjc.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Notification.pbobjc.h"


NS_ASSUME_NONNULL_BEGIN

@protocol FankFankService <NSObject>

#pragma mark AddClient(AddClientRequest) returns (AddClientResponse)

- (void)addClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetClient(GetClientRequest) returns (GetClientResponse)

- (void)getClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddAccount(AddAccountRequest) returns (AddAccountResponse)

- (void)addAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

- (void)getAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

- (void)getAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AuthorizeLinkAccounts(AuthorizeLinkAccountsRequest) returns (AccountLinkingPayloads)

- (void)authorizeLinkAccountsWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(AccountLinkingPayloads *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAuthorizeLinkAccountsWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(AccountLinkingPayloads *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AuthorizeLinkAccountsGet(AuthorizeLinkAccountsRequest) returns (AccountLinkingPayloads)

- (void)authorizeLinkAccountsGetWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(AccountLinkingPayloads *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAuthorizeLinkAccountsGetWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(AccountLinkingPayloads *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

/**
 * 
 * Used by clients to make sure that notifications were routed and correctly delivered to
 * the fank. This is mainly for testing the flow where a notification is sent through a bank
 * instead of straight to devices.
 * 
 */
- (void)getNotificationWithRequest:(FankGetNotificationRequest *)request handler:(void(^)(FankGetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * 
 * Used by clients to make sure that notifications were routed and correctly delivered to
 * the fank. This is mainly for testing the flow where a notification is sent through a bank
 * instead of straight to devices.
 * 
 */
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(FankGetNotificationRequest *)request handler:(void(^)(FankGetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

- (void)getNotificationsWithRequest:(FankGetNotificationsRequest *)request handler:(void(^)(FankGetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(FankGetNotificationsRequest *)request handler:(void(^)(FankGetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBankBalance(GetBankBalanceRequest) returns (GetBankBalanceResponse)

/**
 * 
 * Retruns a list of bank balances netted by counterparty and the balance currency.
 * The balance is based on unsettled transactions for the current busness day.
 * 
 */
- (void)getBankBalanceWithRequest:(FankGetBankBalanceRequest *)request handler:(void(^)(FankGetBankBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * 
 * Retruns a list of bank balances netted by counterparty and the balance currency.
 * The balance is based on unsettled transactions for the current busness day.
 * 
 */
- (GRPCProtoCall *)RPCToGetBankBalanceWithRequest:(FankGetBankBalanceRequest *)request handler:(void(^)(FankGetBankBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBankTransactions(GetBankTransactionsRequest) returns (GetBankTransactionsResponse)

/**
 * 
 * Returns a list of unsettled transactions originated from the given bank (from-bank-id).
 * The conterparty parameter allows for filtering of the result
 * to include transactions targeting a particular counterparty (to-bank-id).
 * 
 */
- (void)getBankTransactionsWithRequest:(FankGetBankTransactionsRequest *)request handler:(void(^)(FankGetBankTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * 
 * Returns a list of unsettled transactions originated from the given bank (from-bank-id).
 * The conterparty parameter allows for filtering of the result
 * to include transactions targeting a particular counterparty (to-bank-id).
 * 
 */
- (GRPCProtoCall *)RPCToGetBankTransactionsWithRequest:(FankGetBankTransactionsRequest *)request handler:(void(^)(FankGetBankTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SettleTransactions(SettleTransactionsRequest) returns (SettleTransactionsResponse)

/**
 * 
 * Performs a net settlement operation of all unsetlled transactions in the ledger.
 * 
 */
- (void)settleTransactionsWithRequest:(FankSettleTransactionsRequest *)request handler:(void(^)(FankSettleTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * 
 * Performs a net settlement operation of all unsetlled transactions in the ledger.
 * 
 */
- (GRPCProtoCall *)RPCToSettleTransactionsWithRequest:(FankSettleTransactionsRequest *)request handler:(void(^)(FankSettleTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface FankFankService : GRPCProtoService<FankFankService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
