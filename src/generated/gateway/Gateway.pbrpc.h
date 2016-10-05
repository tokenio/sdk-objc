#import "gateway/Gateway.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "google/api/Annotations.pbobjc.h"
#import "Account.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Security.pbobjc.h"
#import "Payment.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Device.pbobjc.h"


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


#pragma mark CreateAddress(CreateAddressRequest) returns (CreateAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (void)createAddressWithRequest:(CreateAddressRequest *)request handler:(void(^)(CreateAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateAddressWithRequest:(CreateAddressRequest *)request handler:(void(^)(CreateAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetPreference(SetPreferenceRequest) returns (SetPreferenceResponse)

- (void)setPreferenceWithRequest:(SetPreferenceRequest *)request handler:(void(^)(SetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetPreferenceWithRequest:(SetPreferenceRequest *)request handler:(void(^)(SetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetPreference(GetPreferenceRequest) returns (GetPreferenceResponse)

- (void)getPreferenceWithRequest:(GetPreferenceRequest *)request handler:(void(^)(GetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetPreferenceWithRequest:(GetPreferenceRequest *)request handler:(void(^)(GetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeDevice(SubscribeDeviceRequest) returns (SubscribeDeviceResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (void)subscribeDeviceWithRequest:(SubscribeDeviceRequest *)request handler:(void(^)(SubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (GRPCProtoCall *)RPCToSubscribeDeviceWithRequest:(SubscribeDeviceRequest *)request handler:(void(^)(SubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnsubscribeDevice(UnsubscribeDeviceRequest) returns (UnsubscribeDeviceResponse)

- (void)unsubscribeDeviceWithRequest:(UnsubscribeDeviceRequest *)request handler:(void(^)(UnsubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUnsubscribeDeviceWithRequest:(UnsubscribeDeviceRequest *)request handler:(void(^)(UnsubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark NotifyLinkAccounts(NotifyLinkAccountsRequest) returns (NotifyLinkAccountsResponse)

- (void)notifyLinkAccountsWithRequest:(NotifyLinkAccountsRequest *)request handler:(void(^)(NotifyLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToNotifyLinkAccountsWithRequest:(NotifyLinkAccountsRequest *)request handler:(void(^)(NotifyLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark NotifyAddKey(NotifyAddKeyRequest) returns (NotifyAddKeyResponse)

- (void)notifyAddKeyWithRequest:(NotifyAddKeyRequest *)request handler:(void(^)(NotifyAddKeyResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToNotifyAddKeyWithRequest:(NotifyAddKeyRequest *)request handler:(void(^)(NotifyAddKeyResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark NotifyLinkAccountsAndAddKey(NotifyLinkAccountsAndAddKeyRequest) returns (NotifyLinkAccountsAndAddKeyResponse)

- (void)notifyLinkAccountsAndAddKeyWithRequest:(NotifyLinkAccountsAndAddKeyRequest *)request handler:(void(^)(NotifyLinkAccountsAndAddKeyResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToNotifyLinkAccountsAndAddKeyWithRequest:(NotifyLinkAccountsAndAddKeyRequest *)request handler:(void(^)(NotifyLinkAccountsAndAddKeyResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LinkAccount(LinkAccountRequest) returns (LinkAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (void)linkAccountWithRequest:(LinkAccountRequest *)request handler:(void(^)(LinkAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToLinkAccountWithRequest:(LinkAccountRequest *)request handler:(void(^)(LinkAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupAccount(LookupAccountRequest) returns (LookupAccountResponse)

- (void)lookupAccountWithRequest:(LookupAccountRequest *)request handler:(void(^)(LookupAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupAccountWithRequest:(LookupAccountRequest *)request handler:(void(^)(LookupAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupAccounts(LookupAccountsRequest) returns (LookupAccountsResponse)

- (void)lookupAccountsWithRequest:(LookupAccountsRequest *)request handler:(void(^)(LookupAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupAccountsWithRequest:(LookupAccountsRequest *)request handler:(void(^)(LookupAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetAccountName(SetAccountNameRequest) returns (SetAccountNameResponse)

- (void)setAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupBalance(LookupBalanceRequest) returns (LookupBalanceResponse)

- (void)lookupBalanceWithRequest:(LookupBalanceRequest *)request handler:(void(^)(LookupBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupBalanceWithRequest:(LookupBalanceRequest *)request handler:(void(^)(LookupBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupTransaction(LookupTransactionRequest) returns (LookupTransactionResponse)

- (void)lookupTransactionWithRequest:(LookupTransactionRequest *)request handler:(void(^)(LookupTransactionResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupTransactionWithRequest:(LookupTransactionRequest *)request handler:(void(^)(LookupTransactionResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupTransactions(LookupTransactionsRequest) returns (LookupTransactionsResponse)

- (void)lookupTransactionsWithRequest:(LookupTransactionsRequest *)request handler:(void(^)(LookupTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupTransactionsWithRequest:(LookupTransactionsRequest *)request handler:(void(^)(LookupTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreatePaymentToken(CreatePaymentTokenRequest) returns (CreatePaymentTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Payment Tokens.
 * 
 * 
 */
- (void)createPaymentTokenWithRequest:(CreatePaymentTokenRequest *)request handler:(void(^)(CreatePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Payment Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreatePaymentTokenWithRequest:(CreatePaymentTokenRequest *)request handler:(void(^)(CreatePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupPaymentToken(LookupPaymentTokenRequest) returns (LookupPaymentTokenResponse)

- (void)lookupPaymentTokenWithRequest:(LookupPaymentTokenRequest *)request handler:(void(^)(LookupPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupPaymentTokenWithRequest:(LookupPaymentTokenRequest *)request handler:(void(^)(LookupPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupPaymentTokens(LookupPaymentTokensRequest) returns (LookupPaymentTokensResponse)

- (void)lookupPaymentTokensWithRequest:(LookupPaymentTokensRequest *)request handler:(void(^)(LookupPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupPaymentTokensWithRequest:(LookupPaymentTokensRequest *)request handler:(void(^)(LookupPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorsePaymentToken(EndorsePaymentTokenRequest) returns (EndorsePaymentTokenResponse)

- (void)endorsePaymentTokenWithRequest:(EndorsePaymentTokenRequest *)request handler:(void(^)(EndorsePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEndorsePaymentTokenWithRequest:(EndorsePaymentTokenRequest *)request handler:(void(^)(EndorsePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RevokePaymentToken(RevokePaymentTokenRequest) returns (RevokePaymentTokenResponse)

- (void)revokePaymentTokenWithRequest:(RevokePaymentTokenRequest *)request handler:(void(^)(RevokePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRevokePaymentTokenWithRequest:(RevokePaymentTokenRequest *)request handler:(void(^)(RevokePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeclinePaymentToken(DeclinePaymentTokenRequest) returns (DeclinePaymentTokenResponse)

- (void)declinePaymentTokenWithRequest:(DeclinePaymentTokenRequest *)request handler:(void(^)(DeclinePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToDeclinePaymentTokenWithRequest:(DeclinePaymentTokenRequest *)request handler:(void(^)(DeclinePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


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


#pragma mark LookupAccessToken(LookupAccessTokenRequest) returns (LookupAccessTokenResponse)

- (void)lookupAccessTokenWithRequest:(LookupAccessTokenRequest *)request handler:(void(^)(LookupAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupAccessTokenWithRequest:(LookupAccessTokenRequest *)request handler:(void(^)(LookupAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupAccessTokens(LookupAccessTokensRequest) returns (LookupAccessTokensResponse)

- (void)lookupAccessTokensWithRequest:(LookupAccessTokensRequest *)request handler:(void(^)(LookupAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupAccessTokensWithRequest:(LookupAccessTokensRequest *)request handler:(void(^)(LookupAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorseAccessToken(EndorseAccessTokenRequest) returns (EndorseAccessTokenResponse)

- (void)endorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEndorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RevokeAccessToken(RevokeAccessTokenRequest) returns (RevokeAccessTokenResponse)

- (void)revokeAccessTokenWithRequest:(RevokeAccessTokenRequest *)request handler:(void(^)(RevokeAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRevokeAccessTokenWithRequest:(RevokeAccessTokenRequest *)request handler:(void(^)(RevokeAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeclineAccessToken(DeclineAccessTokenRequest) returns (DeclineAccessTokenResponse)

- (void)declineAccessTokenWithRequest:(DeclineAccessTokenRequest *)request handler:(void(^)(DeclineAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToDeclineAccessTokenWithRequest:(DeclineAccessTokenRequest *)request handler:(void(^)(DeclineAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RedeemPaymentToken(RedeemPaymentTokenRequest) returns (RedeemPaymentTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Payments.
 * 
 * 
 */
- (void)redeemPaymentTokenWithRequest:(RedeemPaymentTokenRequest *)request handler:(void(^)(RedeemPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Payments.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToRedeemPaymentTokenWithRequest:(RedeemPaymentTokenRequest *)request handler:(void(^)(RedeemPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupPayment(LookupPaymentRequest) returns (LookupPaymentResponse)

- (void)lookupPaymentWithRequest:(LookupPaymentRequest *)request handler:(void(^)(LookupPaymentResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupPaymentWithRequest:(LookupPaymentRequest *)request handler:(void(^)(LookupPaymentResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupPayments(LookupPaymentsRequest) returns (LookupPaymentsResponse)

- (void)lookupPaymentsWithRequest:(LookupPaymentsRequest *)request handler:(void(^)(LookupPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLookupPaymentsWithRequest:(LookupPaymentsRequest *)request handler:(void(^)(LookupPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;


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
