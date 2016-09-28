// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: gateway/gateway.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Account;
@class Address;
@class InformationToken;
@class Member;
@class MemberUpdate;
@class Money;
@class Payment;
@class PaymentPayload;
@class PaymentToken;
@class Signature;
@class Token;
@class Transaction;
GPB_ENUM_FWD_DECLARE(Platform);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - GatewayRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface GatewayRoot : GPBRootObject
@end

#pragma mark - CreateMemberRequest

typedef GPB_ENUM(CreateMemberRequest_FieldNumber) {
  CreateMemberRequest_FieldNumber_Nonce = 1,
};

@interface CreateMemberRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *nonce;

@end

#pragma mark - CreateMemberResponse

typedef GPB_ENUM(CreateMemberResponse_FieldNumber) {
  CreateMemberResponse_FieldNumber_MemberId = 1,
};

@interface CreateMemberResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@end

#pragma mark - UpdateMemberRequest

typedef GPB_ENUM(UpdateMemberRequest_FieldNumber) {
  UpdateMemberRequest_FieldNumber_Update = 1,
  UpdateMemberRequest_FieldNumber_Signature = 2,
};

@interface UpdateMemberRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) MemberUpdate *update;
/// Test to see if @c update has been set.
@property(nonatomic, readwrite) BOOL hasUpdate;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - UpdateMemberResponse

typedef GPB_ENUM(UpdateMemberResponse_FieldNumber) {
  UpdateMemberResponse_FieldNumber_Member = 1,
};

@interface UpdateMemberResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Member *member;
/// Test to see if @c member has been set.
@property(nonatomic, readwrite) BOOL hasMember;

@end

#pragma mark - GetMemberRequest

@interface GetMemberRequest : GPBMessage

@end

#pragma mark - GetMemberResponse

typedef GPB_ENUM(GetMemberResponse_FieldNumber) {
  GetMemberResponse_FieldNumber_Member = 1,
};

@interface GetMemberResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Member *member;
/// Test to see if @c member has been set.
@property(nonatomic, readwrite) BOOL hasMember;

@end

#pragma mark - CreateAddressRequest

typedef GPB_ENUM(CreateAddressRequest_FieldNumber) {
  CreateAddressRequest_FieldNumber_Name = 1,
  CreateAddressRequest_FieldNumber_Data_p = 2,
  CreateAddressRequest_FieldNumber_Signature = 3,
};

@interface CreateAddressRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *data_p;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - CreateAddressResponse

typedef GPB_ENUM(CreateAddressResponse_FieldNumber) {
  CreateAddressResponse_FieldNumber_Address = 1,
};

@interface CreateAddressResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/// Test to see if @c address has been set.
@property(nonatomic, readwrite) BOOL hasAddress;

@end

#pragma mark - GetAddressRequest

typedef GPB_ENUM(GetAddressRequest_FieldNumber) {
  GetAddressRequest_FieldNumber_AddressId = 1,
};

@interface GetAddressRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *addressId;

@end

#pragma mark - GetAddressResponse

typedef GPB_ENUM(GetAddressResponse_FieldNumber) {
  GetAddressResponse_FieldNumber_Address = 1,
};

@interface GetAddressResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/// Test to see if @c address has been set.
@property(nonatomic, readwrite) BOOL hasAddress;

@end

#pragma mark - GetAddressesRequest

@interface GetAddressesRequest : GPBMessage

@end

#pragma mark - GetAddressesResponse

typedef GPB_ENUM(GetAddressesResponse_FieldNumber) {
  GetAddressesResponse_FieldNumber_AddressesArray = 1,
};

@interface GetAddressesResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Address*> *addressesArray;
/// The number of items in @c addressesArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger addressesArray_Count;

@end

#pragma mark - DeleteAddressRequest

typedef GPB_ENUM(DeleteAddressRequest_FieldNumber) {
  DeleteAddressRequest_FieldNumber_AddressId = 1,
};

@interface DeleteAddressRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *addressId;

@end

#pragma mark - DeleteAddressResponse

@interface DeleteAddressResponse : GPBMessage

@end

#pragma mark - SetPreferenceRequest

typedef GPB_ENUM(SetPreferenceRequest_FieldNumber) {
  SetPreferenceRequest_FieldNumber_Preference = 1,
};

@interface SetPreferenceRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *preference;

@end

#pragma mark - SetPreferenceResponse

@interface SetPreferenceResponse : GPBMessage

@end

#pragma mark - GetPreferenceRequest

@interface GetPreferenceRequest : GPBMessage

@end

#pragma mark - GetPreferenceResponse

typedef GPB_ENUM(GetPreferenceResponse_FieldNumber) {
  GetPreferenceResponse_FieldNumber_Preference = 1,
};

@interface GetPreferenceResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *preference;

@end

#pragma mark - SubscribeDeviceRequest

typedef GPB_ENUM(SubscribeDeviceRequest_FieldNumber) {
  SubscribeDeviceRequest_FieldNumber_Provider = 1,
  SubscribeDeviceRequest_FieldNumber_NotificationUri = 2,
  SubscribeDeviceRequest_FieldNumber_Platform = 3,
  SubscribeDeviceRequest_FieldNumber_TagsArray = 4,
};

@interface SubscribeDeviceRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *provider;

/// device_id
@property(nonatomic, readwrite, copy, null_resettable) NSString *notificationUri;

@property(nonatomic, readwrite) enum Platform platform;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/// The number of items in @c tagsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

@end

/// Fetches the raw value of a @c SubscribeDeviceRequest's @c platform property, even
/// if the value was not defined by the enum at the time the code was generated.
int32_t SubscribeDeviceRequest_Platform_RawValue(SubscribeDeviceRequest *message);
/// Sets the raw value of an @c SubscribeDeviceRequest's @c platform property, allowing
/// it to be set to a value that was not defined by the enum at the time the code
/// was generated.
void SetSubscribeDeviceRequest_Platform_RawValue(SubscribeDeviceRequest *message, int32_t value);

#pragma mark - SubscribeDeviceResponse

@interface SubscribeDeviceResponse : GPBMessage

@end

#pragma mark - UnsubscribeDeviceRequest

typedef GPB_ENUM(UnsubscribeDeviceRequest_FieldNumber) {
  UnsubscribeDeviceRequest_FieldNumber_Provider = 1,
  UnsubscribeDeviceRequest_FieldNumber_NotificationUri = 2,
};

@interface UnsubscribeDeviceRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *provider;

@property(nonatomic, readwrite, copy, null_resettable) NSString *notificationUri;

@end

#pragma mark - UnsubscribeDeviceResponse

@interface UnsubscribeDeviceResponse : GPBMessage

@end

#pragma mark - NotifyLinkAccountsRequest

typedef GPB_ENUM(NotifyLinkAccountsRequest_FieldNumber) {
  NotifyLinkAccountsRequest_FieldNumber_Alias = 1,
  NotifyLinkAccountsRequest_FieldNumber_BankId = 2,
  NotifyLinkAccountsRequest_FieldNumber_AccountLinkPayload = 3,
};

/// Notify existing subscribers that a bank linking payload has been created
@interface NotifyLinkAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *alias;

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountLinkPayload
@property(nonatomic, readwrite, copy, null_resettable) NSData *accountLinkPayload;

@end

#pragma mark - NotifyLinkAccountsResponse

@interface NotifyLinkAccountsResponse : GPBMessage

@end

#pragma mark - NotifyAddKeyRequest

typedef GPB_ENUM(NotifyAddKeyRequest_FieldNumber) {
  NotifyAddKeyRequest_FieldNumber_PublicKey = 1,
  NotifyAddKeyRequest_FieldNumber_TagsArray = 2,
};

@interface NotifyAddKeyRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *publicKey;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/// The number of items in @c tagsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

@end

#pragma mark - NotifyAddKeyResponse

@interface NotifyAddKeyResponse : GPBMessage

@end

#pragma mark - LinkAccountRequest

typedef GPB_ENUM(LinkAccountRequest_FieldNumber) {
  LinkAccountRequest_FieldNumber_BankId = 1,
  LinkAccountRequest_FieldNumber_AccountLinkPayload = 2,
};

@interface LinkAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountLinkPayload
@property(nonatomic, readwrite, copy, null_resettable) NSData *accountLinkPayload;

@end

#pragma mark - LinkAccountResponse

typedef GPB_ENUM(LinkAccountResponse_FieldNumber) {
  LinkAccountResponse_FieldNumber_AccountsArray = 1,
};

@interface LinkAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Account*> *accountsArray;
/// The number of items in @c accountsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger accountsArray_Count;

@end

#pragma mark - LookupAccountRequest

typedef GPB_ENUM(LookupAccountRequest_FieldNumber) {
  LookupAccountRequest_FieldNumber_AccountId = 1,
};

@interface LookupAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - LookupAccountResponse

typedef GPB_ENUM(LookupAccountResponse_FieldNumber) {
  LookupAccountResponse_FieldNumber_Account = 1,
};

@interface LookupAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Account *account;
/// Test to see if @c account has been set.
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - LookupAccountsRequest

@interface LookupAccountsRequest : GPBMessage

@end

#pragma mark - LookupAccountsResponse

typedef GPB_ENUM(LookupAccountsResponse_FieldNumber) {
  LookupAccountsResponse_FieldNumber_AccountsArray = 1,
};

@interface LookupAccountsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Account*> *accountsArray;
/// The number of items in @c accountsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger accountsArray_Count;

@end

#pragma mark - SetAccountNameRequest

typedef GPB_ENUM(SetAccountNameRequest_FieldNumber) {
  SetAccountNameRequest_FieldNumber_AccountId = 1,
  SetAccountNameRequest_FieldNumber_Name = 2,
};

@interface SetAccountNameRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@end

#pragma mark - SetAccountNameResponse

typedef GPB_ENUM(SetAccountNameResponse_FieldNumber) {
  SetAccountNameResponse_FieldNumber_Account = 1,
};

@interface SetAccountNameResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Account *account;
/// Test to see if @c account has been set.
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - LookupBalanceRequest

typedef GPB_ENUM(LookupBalanceRequest_FieldNumber) {
  LookupBalanceRequest_FieldNumber_AccountId = 1,
};

@interface LookupBalanceRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - LookupBalanceResponse

typedef GPB_ENUM(LookupBalanceResponse_FieldNumber) {
  LookupBalanceResponse_FieldNumber_Current = 1,
  LookupBalanceResponse_FieldNumber_Available = 2,
};

@interface LookupBalanceResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Money *current;
/// Test to see if @c current has been set.
@property(nonatomic, readwrite) BOOL hasCurrent;

@property(nonatomic, readwrite, strong, null_resettable) Money *available;
/// Test to see if @c available has been set.
@property(nonatomic, readwrite) BOOL hasAvailable;

@end

#pragma mark - LookupTransactionRequest

typedef GPB_ENUM(LookupTransactionRequest_FieldNumber) {
  LookupTransactionRequest_FieldNumber_AccountId = 1,
  LookupTransactionRequest_FieldNumber_TransactionId = 2,
};

@interface LookupTransactionRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *transactionId;

@end

#pragma mark - LookupTransactionResponse

typedef GPB_ENUM(LookupTransactionResponse_FieldNumber) {
  LookupTransactionResponse_FieldNumber_Transaction = 1,
};

@interface LookupTransactionResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Transaction *transaction;
/// Test to see if @c transaction has been set.
@property(nonatomic, readwrite) BOOL hasTransaction;

@end

#pragma mark - LookupTransactionsRequest

typedef GPB_ENUM(LookupTransactionsRequest_FieldNumber) {
  LookupTransactionsRequest_FieldNumber_AccountId = 1,
  LookupTransactionsRequest_FieldNumber_Offset = 2,
  LookupTransactionsRequest_FieldNumber_Limit = 3,
};

@interface LookupTransactionsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

/// Optional token offset, used for paging.
@property(nonatomic, readwrite) int32_t offset;

/// Optional token limit, used for paging.
@property(nonatomic, readwrite) int32_t limit;

@end

#pragma mark - LookupTransactionsResponse

typedef GPB_ENUM(LookupTransactionsResponse_FieldNumber) {
  LookupTransactionsResponse_FieldNumber_TransactionsArray = 1,
};

@interface LookupTransactionsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Transaction*> *transactionsArray;
/// The number of items in @c transactionsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger transactionsArray_Count;

@end

#pragma mark - CreatePaymentTokenRequest

typedef GPB_ENUM(CreatePaymentTokenRequest_FieldNumber) {
  CreatePaymentTokenRequest_FieldNumber_Token = 1,
};

@interface CreatePaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CreatePaymentTokenResponse

typedef GPB_ENUM(CreatePaymentTokenResponse_FieldNumber) {
  CreatePaymentTokenResponse_FieldNumber_Token = 1,
};

@interface CreatePaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CreateInformationTokenRequest

typedef GPB_ENUM(CreateInformationTokenRequest_FieldNumber) {
  CreateInformationTokenRequest_FieldNumber_Token = 1,
};

@interface CreateInformationTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) InformationToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CreateInformationTokenResponse

typedef GPB_ENUM(CreateInformationTokenResponse_FieldNumber) {
  CreateInformationTokenResponse_FieldNumber_Token = 1,
};

@interface CreateInformationTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - LookupTokenRequest

typedef GPB_ENUM(LookupTokenRequest_FieldNumber) {
  LookupTokenRequest_FieldNumber_TokenId = 2,
};

@interface LookupTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@end

#pragma mark - LookupTokenResponse

typedef GPB_ENUM(LookupTokenResponse_FieldNumber) {
  LookupTokenResponse_FieldNumber_Token = 1,
};

@interface LookupTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - LookupTokensRequest

typedef GPB_ENUM(LookupTokensRequest_FieldNumber) {
  LookupTokensRequest_FieldNumber_Offset = 1,
  LookupTokensRequest_FieldNumber_Limit = 2,
};

@interface LookupTokensRequest : GPBMessage

/// Optional token offset, used for paging.
@property(nonatomic, readwrite) int32_t offset;

/// Optional token limit, used for paging.
@property(nonatomic, readwrite) int32_t limit;

@end

#pragma mark - LookupTokensResponse

typedef GPB_ENUM(LookupTokensResponse_FieldNumber) {
  LookupTokensResponse_FieldNumber_TokensArray = 1,
};

@interface LookupTokensResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Token*> *tokensArray;
/// The number of items in @c tokensArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tokensArray_Count;

@end

#pragma mark - EndorseTokenRequest

typedef GPB_ENUM(EndorseTokenRequest_FieldNumber) {
  EndorseTokenRequest_FieldNumber_TokenId = 1,
  EndorseTokenRequest_FieldNumber_Signature = 2,
};

@interface EndorseTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - EndorseTokenResponse

typedef GPB_ENUM(EndorseTokenResponse_FieldNumber) {
  EndorseTokenResponse_FieldNumber_Token = 1,
};

@interface EndorseTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - DeclineTokenRequest

typedef GPB_ENUM(DeclineTokenRequest_FieldNumber) {
  DeclineTokenRequest_FieldNumber_TokenId = 1,
  DeclineTokenRequest_FieldNumber_Signature = 2,
};

@interface DeclineTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - DeclineTokenResponse

typedef GPB_ENUM(DeclineTokenResponse_FieldNumber) {
  DeclineTokenResponse_FieldNumber_Token = 1,
};

@interface DeclineTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - RevokeTokenRequest

typedef GPB_ENUM(RevokeTokenRequest_FieldNumber) {
  RevokeTokenRequest_FieldNumber_TokenId = 1,
  RevokeTokenRequest_FieldNumber_Signature = 2,
};

@interface RevokeTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - RevokeTokenResponse

typedef GPB_ENUM(RevokeTokenResponse_FieldNumber) {
  RevokeTokenResponse_FieldNumber_Token = 1,
};

@interface RevokeTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - RedeemPaymentTokenRequest

typedef GPB_ENUM(RedeemPaymentTokenRequest_FieldNumber) {
  RedeemPaymentTokenRequest_FieldNumber_Payload = 1,
  RedeemPaymentTokenRequest_FieldNumber_Signature = 2,
};

@interface RedeemPaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentPayload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - RedeemPaymentTokenResponse

typedef GPB_ENUM(RedeemPaymentTokenResponse_FieldNumber) {
  RedeemPaymentTokenResponse_FieldNumber_Payment = 1,
};

@interface RedeemPaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Payment *payment;
/// Test to see if @c payment has been set.
@property(nonatomic, readwrite) BOOL hasPayment;

@end

#pragma mark - LookupPaymentRequest

typedef GPB_ENUM(LookupPaymentRequest_FieldNumber) {
  LookupPaymentRequest_FieldNumber_PaymentId = 1,
};

@interface LookupPaymentRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentId;

@end

#pragma mark - LookupPaymentResponse

typedef GPB_ENUM(LookupPaymentResponse_FieldNumber) {
  LookupPaymentResponse_FieldNumber_Payment = 1,
};

@interface LookupPaymentResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Payment *payment;
/// Test to see if @c payment has been set.
@property(nonatomic, readwrite) BOOL hasPayment;

@end

#pragma mark - LookupPaymentsRequest

typedef GPB_ENUM(LookupPaymentsRequest_FieldNumber) {
  LookupPaymentsRequest_FieldNumber_TokenId = 1,
  LookupPaymentsRequest_FieldNumber_Offset = 2,
  LookupPaymentsRequest_FieldNumber_Limit = 3,
};

@interface LookupPaymentsRequest : GPBMessage

/// Optional token_id to filter payments by.
@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

/// Optional token offset, used for paging.
@property(nonatomic, readwrite) int32_t offset;

/// Optional token limit, used for paging.
@property(nonatomic, readwrite) int32_t limit;

@end

#pragma mark - LookupPaymentsResponse

typedef GPB_ENUM(LookupPaymentsResponse_FieldNumber) {
  LookupPaymentsResponse_FieldNumber_PaymentsArray = 1,
};

@interface LookupPaymentsResponse : GPBMessage

/// List of payments.
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Payment*> *paymentsArray;
/// The number of items in @c paymentsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger paymentsArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
