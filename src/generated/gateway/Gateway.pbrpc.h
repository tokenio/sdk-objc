#import "gateway/Gateway.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#if GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  @class AddAddressRequest;
  @class AddAddressResponse;
  @class BeginRecoveryRequest;
  @class BeginRecoveryResponse;
  @class CancelTokenRequest;
  @class CancelTokenResponse;
  @class CompleteRecoveryRequest;
  @class CompleteRecoveryResponse;
  @class CompleteVerificationRequest;
  @class CompleteVerificationResponse;
  @class CreateAccessTokenRequest;
  @class CreateAccessTokenResponse;
  @class CreateBlobRequest;
  @class CreateBlobResponse;
  @class CreateMemberRequest;
  @class CreateMemberResponse;
  @class CreateTestBankAccountRequest;
  @class CreateTestBankAccountResponse;
  @class CreateTransferRequest;
  @class CreateTransferResponse;
  @class CreateTransferTokenRequest;
  @class CreateTransferTokenResponse;
  @class DeleteAddressRequest;
  @class DeleteAddressResponse;
  @class EndorseTokenRequest;
  @class EndorseTokenResponse;
  @class GetAccountRequest;
  @class GetAccountResponse;
  @class GetAccountsRequest;
  @class GetAccountsResponse;
  @class GetAddressRequest;
  @class GetAddressResponse;
  @class GetAddressesRequest;
  @class GetAddressesResponse;
  @class GetAliasesRequest;
  @class GetAliasesResponse;
  @class GetBalanceRequest;
  @class GetBalanceResponse;
  @class GetBankInfoRequest;
  @class GetBankInfoResponse;
  @class GetBanksRequest;
  @class GetBanksResponse;
  @class GetBlobRequest;
  @class GetBlobResponse;
  @class GetDefaultAccountRequest;
  @class GetDefaultAccountResponse;
  @class GetDefaultAgentRequest;
  @class GetDefaultAgentResponse;
  @class GetMemberRequest;
  @class GetMemberResponse;
  @class GetNotificationRequest;
  @class GetNotificationResponse;
  @class GetNotificationsRequest;
  @class GetNotificationsResponse;
  @class GetPairedDevicesRequest;
  @class GetPairedDevicesResponse;
  @class GetProfilePictureRequest;
  @class GetProfilePictureResponse;
  @class GetProfileRequest;
  @class GetProfileResponse;
  @class GetSubscriberRequest;
  @class GetSubscriberResponse;
  @class GetSubscribersRequest;
  @class GetSubscribersResponse;
  @class GetTestBankNotificationRequest;
  @class GetTestBankNotificationResponse;
  @class GetTestBankNotificationsRequest;
  @class GetTestBankNotificationsResponse;
  @class GetTokenBlobRequest;
  @class GetTokenBlobResponse;
  @class GetTokenRequest;
  @class GetTokenResponse;
  @class GetTokensRequest;
  @class GetTokensResponse;
  @class GetTransactionRequest;
  @class GetTransactionResponse;
  @class GetTransactionsRequest;
  @class GetTransactionsResponse;
  @class GetTransferRequest;
  @class GetTransferResponse;
  @class GetTransfersRequest;
  @class GetTransfersResponse;
  @class LinkAccountsRequest;
  @class LinkAccountsResponse;
  @class NotifyRequest;
  @class NotifyResponse;
  @class ReplaceTokenRequest;
  @class ReplaceTokenResponse;
  @class RequestTransferRequest;
  @class RequestTransferResponse;
  @class ResolveAliasRequest;
  @class ResolveAliasResponse;
  @class RetryVerificationRequest;
  @class RetryVerificationResponse;
  @class SetDefaultAccountRequest;
  @class SetDefaultAccountResponse;
  @class SetProfilePictureRequest;
  @class SetProfilePictureResponse;
  @class SetProfileRequest;
  @class SetProfileResponse;
  @class SubscribeToNotificationsRequest;
  @class SubscribeToNotificationsResponse;
  @class UnlinkAccountsRequest;
  @class UnlinkAccountsResponse;
  @class UnsubscribeFromNotificationsRequest;
  @class UnsubscribeFromNotificationsResponse;
  @class UpdateMemberRequest;
  @class UpdateMemberResponse;
  @class VerifyAliasRequest;
  @class VerifyAliasResponse;
#else
  #import "google/api/Annotations.pbobjc.h"
  #import "Account.pbobjc.h"
  #import "Address.pbobjc.h"
  #import "Bankinfo.pbobjc.h"
  #import "Banklink.pbobjc.h"
  #import "Blob.pbobjc.h"
  #import "Member.pbobjc.h"
  #import "Money.pbobjc.h"
  #import "Notification.pbobjc.h"
  #import "Security.pbobjc.h"
  #import "Subscriber.pbobjc.h"
  #import "Token.pbobjc.h"
  #import "Transaction.pbobjc.h"
  #import "Transfer.pbobjc.h"
  #import "Alias.pbobjc.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@protocol GatewayService <NSObject>

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

- (void)updateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetProfile(SetProfileRequest) returns (SetProfileResponse)

- (void)setProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetProfile(GetProfileRequest) returns (GetProfileResponse)

- (void)getProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetProfilePicture(SetProfilePictureRequest) returns (SetProfilePictureResponse)

- (void)setProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetProfilePicture(GetProfilePictureRequest) returns (GetProfilePictureResponse)

- (void)getProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ResolveAlias(ResolveAliasRequest) returns (ResolveAliasResponse)

- (void)resolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToResolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAliases(GetAliasesRequest) returns (GetAliasesResponse)

- (void)getAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CompleteVerification(CompleteVerificationRequest) returns (CompleteVerificationResponse)

- (void)completeVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCompleteVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RetryVerification(RetryVerificationRequest) returns (RetryVerificationResponse)

- (void)retryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRetryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetPairedDevices(GetPairedDevicesRequest) returns (GetPairedDevicesResponse)

- (void)getPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark BeginRecovery(BeginRecoveryRequest) returns (BeginRecoveryResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 */
- (void)beginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 */
- (GRPCProtoCall *)RPCToBeginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CompleteRecovery(CompleteRecoveryRequest) returns (CompleteRecoveryResponse)

- (void)completeRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCompleteRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

- (void)verifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToVerifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetDefaultAgent(GetDefaultAgentRequest) returns (GetDefaultAgentResponse)

- (void)getDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler;


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


#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

- (void)getNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

- (void)getNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RequestTransfer(RequestTransferRequest) returns (RequestTransferResponse)

- (void)requestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRequestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler;


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


#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

- (void)unlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUnlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetDefaultAccount(GetDefaultAccountRequest) returns (GetDefaultAccountResponse)

- (void)getDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetDefaultAccount(SetDefaultAccountRequest) returns (SetDefaultAccountResponse)

- (void)setDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 */
- (void)createTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 */
- (GRPCProtoCall *)RPCToCreateTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTestBankNotification(GetTestBankNotificationRequest) returns (GetTestBankNotificationResponse)

- (void)getTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTestBankNotifications(GetTestBankNotificationsRequest) returns (GetTestBankNotificationsResponse)

- (void)getTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateBlob(CreateBlobRequest) returns (CreateBlobResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 */
- (void)createBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlob(GetBlobRequest) returns (GetBlobResponse)

- (void)getBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTokenBlob(GetTokenBlobRequest) returns (GetTokenBlobResponse)

- (void)getTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 */
- (void)createTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

- (void)getTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

- (void)getTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

- (void)endorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEndorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

- (void)cancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

- (void)replaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToReplaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 */
- (void)createTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBanks(GetBanksRequest) returns (GetBanksResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 */
- (void)getBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToGetBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

- (void)getBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler;


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
