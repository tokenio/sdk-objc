#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "gateway/Gateway.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class AddAddressRequest;
@class AddAddressResponse;
@class AddTrustedBeneficiaryRequest;
@class AddTrustedBeneficiaryResponse;
@class ApplyScaRequest;
@class ApplyScaResponse;
@class BeginRecoveryRequest;
@class BeginRecoveryResponse;
@class CancelTokenRequest;
@class CancelTokenResponse;
@class CompleteRecoveryRequest;
@class CompleteRecoveryResponse;
@class CompleteVerificationRequest;
@class CompleteVerificationResponse;
@class ConfirmFundsRequest;
@class ConfirmFundsResponse;
@class CreateAccessTokenRequest;
@class CreateAccessTokenResponse;
@class CreateBlobRequest;
@class CreateBlobResponse;
@class CreateCustomizationRequest;
@class CreateCustomizationResponse;
@class CreateKeychainRequest;
@class CreateKeychainResponse;
@class CreateMemberRequest;
@class CreateMemberResponse;
@class CreateTestBankAccountRequest;
@class CreateTestBankAccountResponse;
@class CreateTokenRequest;
@class CreateTokenResponse;
@class CreateTransferRequest;
@class CreateTransferResponse;
@class CreateTransferTokenRequest;
@class CreateTransferTokenResponse;
@class DeleteAddressRequest;
@class DeleteAddressResponse;
@class DeleteMemberRequest;
@class DeleteMemberResponse;
@class EndorseTokenRequest;
@class EndorseTokenResponse;
@class GetAccountRequest;
@class GetAccountResponse;
@class GetAccountsRequest;
@class GetAccountsResponse;
@class GetActiveAccessTokenRequest;
@class GetActiveAccessTokenResponse;
@class GetAddressRequest;
@class GetAddressResponse;
@class GetAddressesRequest;
@class GetAddressesResponse;
@class GetAliasesRequest;
@class GetAliasesResponse;
@class GetAuthRequestPayloadRequest;
@class GetAuthRequestPayloadResponse;
@class GetBalanceRequest;
@class GetBalanceResponse;
@class GetBalancesRequest;
@class GetBalancesResponse;
@class GetBankInfoRequest;
@class GetBankInfoResponse;
@class GetBanksCountriesRequest;
@class GetBanksCountriesResponse;
@class GetBanksRequest;
@class GetBanksResponse;
@class GetBlobRequest;
@class GetBlobResponse;
@class GetConsentRequest;
@class GetConsentResponse;
@class GetConsentsRequest;
@class GetConsentsResponse;
@class GetDefaultAccountRequest;
@class GetDefaultAccountResponse;
@class GetDefaultAgentRequest;
@class GetDefaultAgentResponse;
@class GetKeychainsRequest;
@class GetKeychainsResponse;
@class GetMemberInfoRequest;
@class GetMemberInfoResponse;
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
@class GetReceiptContactRequest;
@class GetReceiptContactResponse;
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
@class GetTokenRequestResultRequest;
@class GetTokenRequestResultResponse;
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
@class GetTrustedBeneficiariesRequest;
@class GetTrustedBeneficiariesResponse;
@class InvalidateNotificationRequest;
@class InvalidateNotificationResponse;
@class LinkAccountsOauthRequest;
@class LinkAccountsOauthResponse;
@class LinkAccountsRequest;
@class LinkAccountsResponse;
@class NormalizeAliasRequest;
@class NormalizeAliasResponse;
@class NotifyRequest;
@class NotifyResponse;
@class PrepareTokenRequest;
@class PrepareTokenResponse;
@class RemoveTrustedBeneficiaryRequest;
@class RemoveTrustedBeneficiaryResponse;
@class ReplaceTokenRequest;
@class ReplaceTokenResponse;
@class RequestTransferRequest;
@class RequestTransferResponse;
@class ResolveAliasRequest;
@class ResolveAliasResponse;
@class ResolveTransferDestinationsRequest;
@class ResolveTransferDestinationsResponse;
@class RetrieveTokenRequestRequest;
@class RetrieveTokenRequestResponse;
@class RetryVerificationRequest;
@class RetryVerificationResponse;
@class SetAppCallbackUrlRequest;
@class SetAppCallbackUrlResponse;
@class SetDefaultAccountRequest;
@class SetDefaultAccountResponse;
@class SetProfilePictureRequest;
@class SetProfilePictureResponse;
@class SetProfileRequest;
@class SetProfileResponse;
@class SetReceiptContactRequest;
@class SetReceiptContactResponse;
@class SignTokenRequestStateRequest;
@class SignTokenRequestStateResponse;
@class StoreTokenRequestRequest;
@class StoreTokenRequestResponse;
@class SubscribeToNotificationsRequest;
@class SubscribeToNotificationsResponse;
@class TriggerCreateAndEndorseTokenNotificationRequest;
@class TriggerCreateAndEndorseTokenNotificationResponse;
@class TriggerEndorseAndAddKeyNotificationRequest;
@class TriggerEndorseAndAddKeyNotificationResponse;
@class TriggerStepUpNotificationRequest;
@class TriggerStepUpNotificationResponse;
@class UnlinkAccountsRequest;
@class UnlinkAccountsResponse;
@class UnsubscribeFromNotificationsRequest;
@class UnsubscribeFromNotificationsResponse;
@class UpdateKeychainInfoRequest;
@class UpdateKeychainInfoResponse;
@class UpdateMemberRequest;
@class UpdateMemberResponse;
@class UpdateTokenRequestRequest;
@class UpdateTokenRequestResponse;
@class VerifyAffiliateRequest;
@class VerifyAffiliateResponse;
@class VerifyAliasRequest;
@class VerifyAliasResponse;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import "google/api/Annotations.pbobjc.h"
  #import "Account.pbobjc.h"
  #import "Address.pbobjc.h"
  #import "Bankinfo.pbobjc.h"
  #import "Banklink.pbobjc.h"
  #import "Blob.pbobjc.h"
  #import "Consent.pbobjc.h"
  #import "Member.pbobjc.h"
  #import "Money.pbobjc.h"
  #import "Notification.pbobjc.h"
  #import "Security.pbobjc.h"
  #import "Subscriber.pbobjc.h"
  #import "Token.pbobjc.h"
  #import "Transaction.pbobjc.h"
  #import "Transfer.pbobjc.h"
  #import "Alias.pbobjc.h"
  #import "Transferinstructions.pbobjc.h"
  #import "extensions/Field.pbobjc.h"
  #import "extensions/Service.pbobjc.h"
#endif

@class GRPCProtoCall;
@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;


NS_ASSUME_NONNULL_BEGIN

@protocol GatewayService2 <NSObject>

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 */
- (GRPCUnaryProtoCall *)createMemberWithMessage:(CreateMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 */
- (GRPCUnaryProtoCall *)updateMemberWithMessage:(UpdateMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

/**
 * Get information about a member
 */
- (GRPCUnaryProtoCall *)getMemberWithMessage:(GetMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SetProfile(SetProfileRequest) returns (SetProfileResponse)

/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)setProfileWithMessage:(SetProfileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetProfile(GetProfileRequest) returns (GetProfileResponse)

/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)getProfileWithMessage:(GetProfileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SetProfilePicture(SetProfilePictureRequest) returns (SetProfilePictureResponse)

/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)setProfilePictureWithMessage:(SetProfilePictureRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetProfilePicture(GetProfilePictureRequest) returns (GetProfilePictureResponse)

/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)getProfilePictureWithMessage:(GetProfilePictureRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SetReceiptContact(SetReceiptContactRequest) returns (SetReceiptContactResponse)

/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (GRPCUnaryProtoCall *)setReceiptContactWithMessage:(SetReceiptContactRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetReceiptContact(GetReceiptContactRequest) returns (GetReceiptContactResponse)

/**
 * Get a member's email address for receipts
 */
- (GRPCUnaryProtoCall *)getReceiptContactWithMessage:(GetReceiptContactRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ResolveAlias(ResolveAliasRequest) returns (ResolveAliasResponse)

/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCUnaryProtoCall *)resolveAliasWithMessage:(ResolveAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAliases(GetAliasesRequest) returns (GetAliasesResponse)

/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCUnaryProtoCall *)getAliasesWithMessage:(GetAliasesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CompleteVerification(CompleteVerificationRequest) returns (CompleteVerificationResponse)

/**
 * Use a verification code
 */
- (GRPCUnaryProtoCall *)completeVerificationWithMessage:(CompleteVerificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RetryVerification(RetryVerificationRequest) returns (RetryVerificationResponse)

/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (GRPCUnaryProtoCall *)retryVerificationWithMessage:(RetryVerificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetPairedDevices(GetPairedDevicesRequest) returns (GetPairedDevicesResponse)

/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (GRPCUnaryProtoCall *)getPairedDevicesWithMessage:(GetPairedDevicesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DeleteMember(DeleteMemberRequest) returns (DeleteMemberResponse)

- (GRPCUnaryProtoCall *)deleteMemberWithMessage:(DeleteMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark NormalizeAlias(NormalizeAliasRequest) returns (NormalizeAliasResponse)

- (GRPCUnaryProtoCall *)normalizeAliasWithMessage:(NormalizeAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark VerifyAffiliate(VerifyAffiliateRequest) returns (VerifyAffiliateResponse)

- (GRPCUnaryProtoCall *)verifyAffiliateWithMessage:(VerifyAffiliateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SetAppCallbackUrl(SetAppCallbackUrlRequest) returns (SetAppCallbackUrlResponse)

- (GRPCUnaryProtoCall *)setAppCallbackUrlWithMessage:(SetAppCallbackUrlRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark BeginRecovery(BeginRecoveryRequest) returns (BeginRecoveryResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)beginRecoveryWithMessage:(BeginRecoveryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CompleteRecovery(CompleteRecoveryRequest) returns (CompleteRecoveryResponse)

/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)completeRecoveryWithMessage:(CompleteRecoveryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

/**
 * Verify an alias
 */
- (GRPCUnaryProtoCall *)verifyAliasWithMessage:(VerifyAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetDefaultAgent(GetDefaultAgentRequest) returns (GetDefaultAgentResponse)

/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)getDefaultAgentWithMessage:(GetDefaultAgentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)addAddressWithMessage:(AddAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)getAddressWithMessage:(GetAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)getAddressesWithMessage:(GetAddressesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)deleteAddressWithMessage:(DeleteAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddTrustedBeneficiary(AddTrustedBeneficiaryRequest) returns (AddTrustedBeneficiaryResponse)

/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)addTrustedBeneficiaryWithMessage:(AddTrustedBeneficiaryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveTrustedBeneficiary(RemoveTrustedBeneficiaryRequest) returns (RemoveTrustedBeneficiaryResponse)

/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)removeTrustedBeneficiaryWithMessage:(RemoveTrustedBeneficiaryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTrustedBeneficiaries(GetTrustedBeneficiariesRequest) returns (GetTrustedBeneficiariesResponse)

/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)getTrustedBeneficiariesWithMessage:(GetTrustedBeneficiariesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateCustomization(CreateCustomizationRequest) returns (CreateCustomizationResponse)

/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 */
- (GRPCUnaryProtoCall *)createCustomizationWithMessage:(CreateCustomizationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)subscribeToNotificationsWithMessage:(SubscribeToNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)getSubscribersWithMessage:(GetSubscribersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)getSubscriberWithMessage:(GetSubscriberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)unsubscribeFromNotificationsWithMessage:(UnsubscribeFromNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)notifyWithMessage:(NotifyRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCUnaryProtoCall *)getNotificationsWithMessage:(GetNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCUnaryProtoCall *)getNotificationWithMessage:(GetNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RequestTransfer(RequestTransferRequest) returns (RequestTransferResponse)

/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (GRPCUnaryProtoCall *)requestTransferWithMessage:(RequestTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark TriggerStepUpNotification(TriggerStepUpNotificationRequest) returns (TriggerStepUpNotificationResponse)

/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (GRPCUnaryProtoCall *)triggerStepUpNotificationWithMessage:(TriggerStepUpNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark TriggerEndorseAndAddKeyNotification(TriggerEndorseAndAddKeyNotificationRequest) returns (TriggerEndorseAndAddKeyNotificationResponse)

/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (GRPCUnaryProtoCall *)triggerEndorseAndAddKeyNotificationWithMessage:(TriggerEndorseAndAddKeyNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark TriggerCreateAndEndorseTokenNotification(TriggerCreateAndEndorseTokenNotificationRequest) returns (TriggerCreateAndEndorseTokenNotificationResponse)

/**
 * send create and endorse token notification
 */
- (GRPCUnaryProtoCall *)triggerCreateAndEndorseTokenNotificationWithMessage:(TriggerCreateAndEndorseTokenNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark InvalidateNotification(InvalidateNotificationRequest) returns (InvalidateNotificationResponse)

/**
 * send invalidate notification
 */
- (GRPCUnaryProtoCall *)invalidateNotificationWithMessage:(InvalidateNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)linkAccountsWithMessage:(LinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark LinkAccountsOauth(LinkAccountsOauthRequest) returns (LinkAccountsOauthResponse)

/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)linkAccountsOauthWithMessage:(LinkAccountsOauthRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)unlinkAccountsWithMessage:(UnlinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCUnaryProtoCall *)getAccountWithMessage:(GetAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCUnaryProtoCall *)getAccountsWithMessage:(GetAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (GRPCUnaryProtoCall *)getBalanceWithMessage:(GetBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBalances(GetBalancesRequest) returns (GetBalancesResponse)

- (GRPCUnaryProtoCall *)getBalancesWithMessage:(GetBalancesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCUnaryProtoCall *)getTransactionWithMessage:(GetTransactionRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCUnaryProtoCall *)getTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ApplySca(ApplyScaRequest) returns (ApplyScaResponse)

- (GRPCUnaryProtoCall *)applyScaWithMessage:(ApplyScaRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetDefaultAccount(GetDefaultAccountRequest) returns (GetDefaultAccountResponse)

/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCUnaryProtoCall *)getDefaultAccountWithMessage:(GetDefaultAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SetDefaultAccount(SetDefaultAccountRequest) returns (SetDefaultAccountResponse)

/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCUnaryProtoCall *)setDefaultAccountWithMessage:(SetDefaultAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ResolveTransferDestinations(ResolveTransferDestinationsRequest) returns (ResolveTransferDestinationsResponse)

/**
 * Get the resolved transfer destinations of the given account.
 */
- (GRPCUnaryProtoCall *)resolveTransferDestinationsWithMessage:(ResolveTransferDestinationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ConfirmFunds(ConfirmFundsRequest) returns (ConfirmFundsResponse)

/**
 * Confirm that the given account has sufficient funds to cover the charge.
 */
- (GRPCUnaryProtoCall *)confirmFundsWithMessage:(ConfirmFundsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)createTestBankAccountWithMessage:(CreateTestBankAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTestBankNotification(GetTestBankNotificationRequest) returns (GetTestBankNotificationResponse)

/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (GRPCUnaryProtoCall *)getTestBankNotificationWithMessage:(GetTestBankNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTestBankNotifications(GetTestBankNotificationsRequest) returns (GetTestBankNotificationsResponse)

/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (GRPCUnaryProtoCall *)getTestBankNotificationsWithMessage:(GetTestBankNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateBlob(CreateBlobRequest) returns (CreateBlobResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)createBlobWithMessage:(CreateBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBlob(GetBlobRequest) returns (GetBlobResponse)

/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)getBlobWithMessage:(GetBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTokenBlob(GetTokenBlobRequest) returns (GetTokenBlobResponse)

/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)getTokenBlobWithMessage:(GetTokenBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark StoreTokenRequest(StoreTokenRequestRequest) returns (StoreTokenRequestResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 */
- (GRPCUnaryProtoCall *)storeTokenRequestWithMessage:(StoreTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RetrieveTokenRequest(RetrieveTokenRequestRequest) returns (RetrieveTokenRequestResponse)

/**
 * Retrieve a Token Request
 */
- (GRPCUnaryProtoCall *)retrieveTokenRequestWithMessage:(RetrieveTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UpdateTokenRequest(UpdateTokenRequestRequest) returns (UpdateTokenRequestResponse)

- (GRPCUnaryProtoCall *)updateTokenRequestWithMessage:(UpdateTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark PrepareToken(PrepareTokenRequest) returns (PrepareTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 */
- (GRPCUnaryProtoCall *)prepareTokenWithMessage:(PrepareTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateToken(CreateTokenRequest) returns (CreateTokenResponse)

/**
 * Create a Token.
 */
- (GRPCUnaryProtoCall *)createTokenWithMessage:(CreateTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (GRPCUnaryProtoCall *)createTransferTokenWithMessage:(CreateTransferTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (GRPCUnaryProtoCall *)createAccessTokenWithMessage:(CreateAccessTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (GRPCUnaryProtoCall *)getTokenWithMessage:(GetTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetActiveAccessToken(GetActiveAccessTokenRequest) returns (GetActiveAccessTokenResponse)

/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (GRPCUnaryProtoCall *)getActiveAccessTokenWithMessage:(GetActiveAccessTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 */
- (GRPCUnaryProtoCall *)getTokensWithMessage:(GetTokensRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (GRPCUnaryProtoCall *)endorseTokenWithMessage:(EndorseTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (GRPCUnaryProtoCall *)cancelTokenWithMessage:(CancelTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 */
- (GRPCUnaryProtoCall *)replaceTokenWithMessage:(ReplaceTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SignTokenRequestState(SignTokenRequestStateRequest) returns (SignTokenRequestStateResponse)

/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (GRPCUnaryProtoCall *)signTokenRequestStateWithMessage:(SignTokenRequestStateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTokenRequestResult(GetTokenRequestResultRequest) returns (GetTokenRequestResultResponse)

/**
 * Get the token request result from the token request id
 */
- (GRPCUnaryProtoCall *)getTokenRequestResultWithMessage:(GetTokenRequestResultRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetAuthRequestPayload(GetAuthRequestPayloadRequest) returns (GetAuthRequestPayloadResponse)

/**
 * Gets a payload to sign
 */
- (GRPCUnaryProtoCall *)getAuthRequestPayloadWithMessage:(GetAuthRequestPayloadRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 */
- (GRPCUnaryProtoCall *)createTransferWithMessage:(CreateTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCUnaryProtoCall *)getTransferWithMessage:(GetTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCUnaryProtoCall *)getTransfersWithMessage:(GetTransfersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBanksCountries(GetBanksCountriesRequest) returns (GetBanksCountriesResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 */
- (GRPCUnaryProtoCall *)getBanksCountriesWithMessage:(GetBanksCountriesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBanks(GetBanksRequest) returns (GetBanksResponse)

/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)getBanksWithMessage:(GetBanksRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)getBankInfoWithMessage:(GetBankInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CreateKeychain(CreateKeychainRequest) returns (CreateKeychainResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 */
- (GRPCUnaryProtoCall *)createKeychainWithMessage:(CreateKeychainRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UpdateKeychainInfo(UpdateKeychainInfoRequest) returns (UpdateKeychainInfoResponse)

/**
 * Update a keychain's info.
 */
- (GRPCUnaryProtoCall *)updateKeychainInfoWithMessage:(UpdateKeychainInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetKeychains(GetKeychainsRequest) returns (GetKeychainsResponse)

/**
 * Get all the keychains of a member.
 */
- (GRPCUnaryProtoCall *)getKeychainsWithMessage:(GetKeychainsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetMemberInfo(GetMemberInfoRequest) returns (GetMemberInfoResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 */
- (GRPCUnaryProtoCall *)getMemberInfoWithMessage:(GetMemberInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetConsent(GetConsentRequest) returns (GetConsentResponse)

- (GRPCUnaryProtoCall *)getConsentWithMessage:(GetConsentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetConsents(GetConsentsRequest) returns (GetConsentsResponse)

- (GRPCUnaryProtoCall *)getConsentsWithMessage:(GetConsentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

@protocol GatewayService <NSObject>

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 */
- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 */
- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 */
- (void)updateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 */
- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

/**
 * Get information about a member
 */
- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get information about a member
 */
- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetProfile(SetProfileRequest) returns (SetProfileResponse)

/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (void)setProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToSetProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetProfile(GetProfileRequest) returns (GetProfileResponse)

/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (void)getProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToGetProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetProfilePicture(SetProfilePictureRequest) returns (SetProfilePictureResponse)

/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (void)setProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToSetProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetProfilePicture(GetProfilePictureRequest) returns (GetProfilePictureResponse)

/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (void)getProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToGetProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetReceiptContact(SetReceiptContactRequest) returns (SetReceiptContactResponse)

/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (void)setReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (GRPCProtoCall *)RPCToSetReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetReceiptContact(GetReceiptContactRequest) returns (GetReceiptContactResponse)

/**
 * Get a member's email address for receipts
 */
- (void)getReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get a member's email address for receipts
 */
- (GRPCProtoCall *)RPCToGetReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ResolveAlias(ResolveAliasRequest) returns (ResolveAliasResponse)

/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (void)resolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCProtoCall *)RPCToResolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAliases(GetAliasesRequest) returns (GetAliasesResponse)

/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (void)getAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCProtoCall *)RPCToGetAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CompleteVerification(CompleteVerificationRequest) returns (CompleteVerificationResponse)

/**
 * Use a verification code
 */
- (void)completeVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Use a verification code
 */
- (GRPCProtoCall *)RPCToCompleteVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RetryVerification(RetryVerificationRequest) returns (RetryVerificationResponse)

/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (void)retryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (GRPCProtoCall *)RPCToRetryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetPairedDevices(GetPairedDevicesRequest) returns (GetPairedDevicesResponse)

/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (void)getPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (GRPCProtoCall *)RPCToGetPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeleteMember(DeleteMemberRequest) returns (DeleteMemberResponse)

- (void)deleteMemberWithRequest:(DeleteMemberRequest *)request handler:(void(^)(DeleteMemberResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToDeleteMemberWithRequest:(DeleteMemberRequest *)request handler:(void(^)(DeleteMemberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark NormalizeAlias(NormalizeAliasRequest) returns (NormalizeAliasResponse)

- (void)normalizeAliasWithRequest:(NormalizeAliasRequest *)request handler:(void(^)(NormalizeAliasResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToNormalizeAliasWithRequest:(NormalizeAliasRequest *)request handler:(void(^)(NormalizeAliasResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VerifyAffiliate(VerifyAffiliateRequest) returns (VerifyAffiliateResponse)

- (void)verifyAffiliateWithRequest:(VerifyAffiliateRequest *)request handler:(void(^)(VerifyAffiliateResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToVerifyAffiliateWithRequest:(VerifyAffiliateRequest *)request handler:(void(^)(VerifyAffiliateResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetAppCallbackUrl(SetAppCallbackUrlRequest) returns (SetAppCallbackUrlResponse)

- (void)setAppCallbackUrlWithRequest:(SetAppCallbackUrlRequest *)request handler:(void(^)(SetAppCallbackUrlResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetAppCallbackUrlWithRequest:(SetAppCallbackUrlRequest *)request handler:(void(^)(SetAppCallbackUrlResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark BeginRecovery(BeginRecoveryRequest) returns (BeginRecoveryResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 */
- (void)beginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCProtoCall *)RPCToBeginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CompleteRecovery(CompleteRecoveryRequest) returns (CompleteRecoveryResponse)

/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (void)completeRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCProtoCall *)RPCToCompleteRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

/**
 * Verify an alias
 */
- (void)verifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Verify an alias
 */
- (GRPCProtoCall *)RPCToVerifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetDefaultAgent(GetDefaultAgentRequest) returns (GetDefaultAgentResponse)

/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (void)getDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCProtoCall *)RPCToGetDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 */
- (void)addAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToAddAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddTrustedBeneficiary(AddTrustedBeneficiaryRequest) returns (AddTrustedBeneficiaryResponse)

/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)addTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToAddTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveTrustedBeneficiary(RemoveTrustedBeneficiaryRequest) returns (RemoveTrustedBeneficiaryResponse)

/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)removeTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToRemoveTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTrustedBeneficiaries(GetTrustedBeneficiariesRequest) returns (GetTrustedBeneficiariesResponse)

/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)getTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToGetTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateCustomization(CreateCustomizationRequest) returns (CreateCustomizationResponse)

/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 */
- (void)createCustomizationWithRequest:(CreateCustomizationRequest *)request handler:(void(^)(CreateCustomizationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 */
- (GRPCProtoCall *)RPCToCreateCustomizationWithRequest:(CreateCustomizationRequest *)request handler:(void(^)(CreateCustomizationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 */
- (void)subscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToSubscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (void)getSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToGetSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (void)getSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToGetSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (void)unsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToUnsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (void)notifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToNotifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (void)getNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (void)getNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RequestTransfer(RequestTransferRequest) returns (RequestTransferResponse)

/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (void)requestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (GRPCProtoCall *)RPCToRequestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TriggerStepUpNotification(TriggerStepUpNotificationRequest) returns (TriggerStepUpNotificationResponse)

/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (void)triggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (GRPCProtoCall *)RPCToTriggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TriggerEndorseAndAddKeyNotification(TriggerEndorseAndAddKeyNotificationRequest) returns (TriggerEndorseAndAddKeyNotificationResponse)

/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (void)triggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (GRPCProtoCall *)RPCToTriggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TriggerCreateAndEndorseTokenNotification(TriggerCreateAndEndorseTokenNotificationRequest) returns (TriggerCreateAndEndorseTokenNotificationResponse)

/**
 * send create and endorse token notification
 */
- (void)triggerCreateAndEndorseTokenNotificationWithRequest:(TriggerCreateAndEndorseTokenNotificationRequest *)request handler:(void(^)(TriggerCreateAndEndorseTokenNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send create and endorse token notification
 */
- (GRPCProtoCall *)RPCToTriggerCreateAndEndorseTokenNotificationWithRequest:(TriggerCreateAndEndorseTokenNotificationRequest *)request handler:(void(^)(TriggerCreateAndEndorseTokenNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark InvalidateNotification(InvalidateNotificationRequest) returns (InvalidateNotificationResponse)

/**
 * send invalidate notification
 */
- (void)invalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * send invalidate notification
 */
- (GRPCProtoCall *)RPCToInvalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)linkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToLinkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LinkAccountsOauth(LinkAccountsOauthRequest) returns (LinkAccountsOauthResponse)

/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)linkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToLinkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)unlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToUnlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBalances(GetBalancesRequest) returns (GetBalancesResponse)

- (void)getBalancesWithRequest:(GetBalancesRequest *)request handler:(void(^)(GetBalancesResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBalancesWithRequest:(GetBalancesRequest *)request handler:(void(^)(GetBalancesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ApplySca(ApplyScaRequest) returns (ApplyScaResponse)

- (void)applyScaWithRequest:(ApplyScaRequest *)request handler:(void(^)(ApplyScaResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToApplyScaWithRequest:(ApplyScaRequest *)request handler:(void(^)(ApplyScaResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetDefaultAccount(GetDefaultAccountRequest) returns (GetDefaultAccountResponse)

/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (void)getDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCProtoCall *)RPCToGetDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SetDefaultAccount(SetDefaultAccountRequest) returns (SetDefaultAccountResponse)

/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (void)setDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCProtoCall *)RPCToSetDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ResolveTransferDestinations(ResolveTransferDestinationsRequest) returns (ResolveTransferDestinationsResponse)

/**
 * Get the resolved transfer destinations of the given account.
 */
- (void)resolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get the resolved transfer destinations of the given account.
 */
- (GRPCProtoCall *)RPCToResolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ConfirmFunds(ConfirmFundsRequest) returns (ConfirmFundsResponse)

/**
 * Confirm that the given account has sufficient funds to cover the charge.
 */
- (void)confirmFundsWithRequest:(ConfirmFundsRequest *)request handler:(void(^)(ConfirmFundsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Confirm that the given account has sufficient funds to cover the charge.
 */
- (GRPCProtoCall *)RPCToConfirmFundsWithRequest:(ConfirmFundsRequest *)request handler:(void(^)(ConfirmFundsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)createTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToCreateTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTestBankNotification(GetTestBankNotificationRequest) returns (GetTestBankNotificationResponse)

/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (void)getTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTestBankNotifications(GetTestBankNotificationsRequest) returns (GetTestBankNotificationsResponse)

/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (void)getTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateBlob(CreateBlobRequest) returns (CreateBlobResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (void)createBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCProtoCall *)RPCToCreateBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBlob(GetBlobRequest) returns (GetBlobResponse)

/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (void)getBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCProtoCall *)RPCToGetBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTokenBlob(GetTokenBlobRequest) returns (GetTokenBlobResponse)

/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (void)getTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCProtoCall *)RPCToGetTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark StoreTokenRequest(StoreTokenRequestRequest) returns (StoreTokenRequestResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 */
- (void)storeTokenRequestWithRequest:(StoreTokenRequestRequest *)request handler:(void(^)(StoreTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 */
- (GRPCProtoCall *)RPCToStoreTokenRequestWithRequest:(StoreTokenRequestRequest *)request handler:(void(^)(StoreTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RetrieveTokenRequest(RetrieveTokenRequestRequest) returns (RetrieveTokenRequestResponse)

/**
 * Retrieve a Token Request
 */
- (void)retrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Retrieve a Token Request
 */
- (GRPCProtoCall *)RPCToRetrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateTokenRequest(UpdateTokenRequestRequest) returns (UpdateTokenRequestResponse)

- (void)updateTokenRequestWithRequest:(UpdateTokenRequestRequest *)request handler:(void(^)(UpdateTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToUpdateTokenRequestWithRequest:(UpdateTokenRequestRequest *)request handler:(void(^)(UpdateTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark PrepareToken(PrepareTokenRequest) returns (PrepareTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 */
- (void)prepareTokenWithRequest:(PrepareTokenRequest *)request handler:(void(^)(PrepareTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 */
- (GRPCProtoCall *)RPCToPrepareTokenWithRequest:(PrepareTokenRequest *)request handler:(void(^)(PrepareTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateToken(CreateTokenRequest) returns (CreateTokenResponse)

/**
 * Create a Token.
 */
- (void)createTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Create a Token.
 */
- (GRPCProtoCall *)RPCToCreateTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (void)createTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (GRPCProtoCall *)RPCToCreateTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (void)getTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (GRPCProtoCall *)RPCToGetTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetActiveAccessToken(GetActiveAccessTokenRequest) returns (GetActiveAccessTokenResponse)

/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (void)getActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (GRPCProtoCall *)RPCToGetActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 */
- (void)getTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 */
- (GRPCProtoCall *)RPCToGetTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (void)endorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (GRPCProtoCall *)RPCToEndorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (void)cancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (GRPCProtoCall *)RPCToCancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 */
- (void)replaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 */
- (GRPCProtoCall *)RPCToReplaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SignTokenRequestState(SignTokenRequestStateRequest) returns (SignTokenRequestStateResponse)

/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (void)signTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (GRPCProtoCall *)RPCToSignTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTokenRequestResult(GetTokenRequestResultRequest) returns (GetTokenRequestResultResponse)

/**
 * Get the token request result from the token request id
 */
- (void)getTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get the token request result from the token request id
 */
- (GRPCProtoCall *)RPCToGetTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAuthRequestPayload(GetAuthRequestPayloadRequest) returns (GetAuthRequestPayloadResponse)

/**
 * Gets a payload to sign
 */
- (void)getAuthRequestPayloadWithRequest:(GetAuthRequestPayloadRequest *)request handler:(void(^)(GetAuthRequestPayloadResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Gets a payload to sign
 */
- (GRPCProtoCall *)RPCToGetAuthRequestPayloadWithRequest:(GetAuthRequestPayloadRequest *)request handler:(void(^)(GetAuthRequestPayloadResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 */
- (void)createTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 */
- (GRPCProtoCall *)RPCToCreateTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCProtoCall *)RPCToGetTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBanksCountries(GetBanksCountriesRequest) returns (GetBanksCountriesResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 */
- (void)getBanksCountriesWithRequest:(GetBanksCountriesRequest *)request handler:(void(^)(GetBanksCountriesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 */
- (GRPCProtoCall *)RPCToGetBanksCountriesWithRequest:(GetBanksCountriesRequest *)request handler:(void(^)(GetBanksCountriesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBanks(GetBanksRequest) returns (GetBanksResponse)

/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)getBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToGetBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)getBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToGetBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CreateKeychain(CreateKeychainRequest) returns (CreateKeychainResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 */
- (void)createKeychainWithRequest:(CreateKeychainRequest *)request handler:(void(^)(CreateKeychainResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 */
- (GRPCProtoCall *)RPCToCreateKeychainWithRequest:(CreateKeychainRequest *)request handler:(void(^)(CreateKeychainResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateKeychainInfo(UpdateKeychainInfoRequest) returns (UpdateKeychainInfoResponse)

/**
 * Update a keychain's info.
 */
- (void)updateKeychainInfoWithRequest:(UpdateKeychainInfoRequest *)request handler:(void(^)(UpdateKeychainInfoResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Update a keychain's info.
 */
- (GRPCProtoCall *)RPCToUpdateKeychainInfoWithRequest:(UpdateKeychainInfoRequest *)request handler:(void(^)(UpdateKeychainInfoResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetKeychains(GetKeychainsRequest) returns (GetKeychainsResponse)

/**
 * Get all the keychains of a member.
 */
- (void)getKeychainsWithRequest:(GetKeychainsRequest *)request handler:(void(^)(GetKeychainsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * Get all the keychains of a member.
 */
- (GRPCProtoCall *)RPCToGetKeychainsWithRequest:(GetKeychainsRequest *)request handler:(void(^)(GetKeychainsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetMemberInfo(GetMemberInfoRequest) returns (GetMemberInfoResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 */
- (void)getMemberInfoWithRequest:(GetMemberInfoRequest *)request handler:(void(^)(GetMemberInfoResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 */
- (GRPCProtoCall *)RPCToGetMemberInfoWithRequest:(GetMemberInfoRequest *)request handler:(void(^)(GetMemberInfoResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetConsent(GetConsentRequest) returns (GetConsentResponse)

- (void)getConsentWithRequest:(GetConsentRequest *)request handler:(void(^)(GetConsentResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetConsentWithRequest:(GetConsentRequest *)request handler:(void(^)(GetConsentResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetConsents(GetConsentsRequest) returns (GetConsentsResponse)

- (void)getConsentsWithRequest:(GetConsentsRequest *)request handler:(void(^)(GetConsentsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetConsentsWithRequest:(GetConsentsRequest *)request handler:(void(^)(GetConsentsResponse *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface GatewayService : GRPCProtoService<GatewayService, GatewayService2>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

