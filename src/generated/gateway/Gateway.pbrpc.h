#import "gateway/Gateway.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "google/api/Annotations.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Notification.pbobjc.h"
#import "Security.pbobjc.h"
#import "Paging.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Subscriber.pbobjc.h"


NS_ASSUME_NONNULL_BEGIN

@protocol GatewayService <NSObject>

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member registration, key and alias mamangement.
 * 
 * 
 */
- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member registration, key and alias mamangement.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

- (void)updateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AliasExists(AliasExistsRequest) returns (AliasExistsResponse)

- (void)aliasExistsWithRequest:(AliasExistsRequest *)request handler:(void(^)(AliasExistsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAliasExistsWithRequest:(AliasExistsRequest *)request handler:(void(^)(AliasExistsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (void)addAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (GRPCProtoCall *)RPCToAddAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (void)subscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (GRPCProtoCall *)RPCToSubscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

- (void)getSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

- (void)getSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

- (void)unsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUnsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

- (void)notifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToNotifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (void)linkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToLinkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetAccountName(SetAccountNameRequest) returns (SetAccountNameResponse)

- (void)setAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Transfer Tokens.
 * 
 * 
 */
- (void)createTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Transfer Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransferToken(GetTransferTokenRequest) returns (GetTransferTokenResponse)

- (void)getTransferTokenWithRequest:(GetTransferTokenRequest *)request handler:(void(^)(GetTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransferTokenWithRequest:(GetTransferTokenRequest *)request handler:(void(^)(GetTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransferTokens(GetTransferTokensRequest) returns (GetTransferTokensResponse)

- (void)getTransferTokensWithRequest:(GetTransferTokensRequest *)request handler:(void(^)(GetTransferTokensResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransferTokensWithRequest:(GetTransferTokensRequest *)request handler:(void(^)(GetTransferTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorseTransferToken(EndorseTransferTokenRequest) returns (EndorseTransferTokenResponse)

- (void)endorseTransferTokenWithRequest:(EndorseTransferTokenRequest *)request handler:(void(^)(EndorseTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEndorseTransferTokenWithRequest:(EndorseTransferTokenRequest *)request handler:(void(^)(EndorseTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CancelTransferToken(CancelTransferTokenRequest) returns (CancelTransferTokenResponse)

- (void)cancelTransferTokenWithRequest:(CancelTransferTokenRequest *)request handler:(void(^)(CancelTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCancelTransferTokenWithRequest:(CancelTransferTokenRequest *)request handler:(void(^)(CancelTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Access Tokens.
 * 
 * 
 */
- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Access Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccessToken(GetAccessTokenRequest) returns (GetAccessTokenResponse)

- (void)getAccessTokenWithRequest:(GetAccessTokenRequest *)request handler:(void(^)(GetAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccessTokenWithRequest:(GetAccessTokenRequest *)request handler:(void(^)(GetAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccessTokens(GetAccessTokensRequest) returns (GetAccessTokensResponse)

- (void)getAccessTokensWithRequest:(GetAccessTokensRequest *)request handler:(void(^)(GetAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccessTokensWithRequest:(GetAccessTokensRequest *)request handler:(void(^)(GetAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorseAccessToken(EndorseAccessTokenRequest) returns (EndorseAccessTokenResponse)

- (void)endorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEndorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CancelAccessToken(CancelAccessTokenRequest) returns (CancelAccessTokenResponse)

- (void)cancelAccessTokenWithRequest:(CancelAccessTokenRequest *)request handler:(void(^)(CancelAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCancelAccessTokenWithRequest:(CancelAccessTokenRequest *)request handler:(void(^)(CancelAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RedeemTransferToken(RedeemTransferTokenRequest) returns (RedeemTransferTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 */
- (void)redeemTransferTokenWithRequest:(RedeemTransferTokenRequest *)request handler:(void(^)(RedeemTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToRedeemTransferTokenWithRequest:(RedeemTransferTokenRequest *)request handler:(void(^)(RedeemTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface GatewayService : GRPCProtoService<GatewayService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
