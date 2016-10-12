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

@class AccessToken;
@class AccessToken_Payload;
@class Account;
@class Address;
@class Member;
@class MemberUpdate;
@class Money;
@class Page;
@class Payment;
@class PaymentPayload;
@class PaymentToken;
@class PaymentToken_Payload;
@class Signature;
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
  UpdateMemberRequest_FieldNumber_UpdateSignature = 2,
};

@interface UpdateMemberRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) MemberUpdate *update;
/// Test to see if @c update has been set.
@property(nonatomic, readwrite) BOOL hasUpdate;

@property(nonatomic, readwrite, strong, null_resettable) Signature *updateSignature;
/// Test to see if @c updateSignature has been set.
@property(nonatomic, readwrite) BOOL hasUpdateSignature;

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

#pragma mark - AliasExistsRequest

typedef GPB_ENUM(AliasExistsRequest_FieldNumber) {
  AliasExistsRequest_FieldNumber_Alias = 1,
};

@interface AliasExistsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *alias;

@end

#pragma mark - AliasExistsResponse

typedef GPB_ENUM(AliasExistsResponse_FieldNumber) {
  AliasExistsResponse_FieldNumber_Exists = 1,
};

@interface AliasExistsResponse : GPBMessage

@property(nonatomic, readwrite) BOOL exists;

@end

#pragma mark - AddAddressRequest

typedef GPB_ENUM(AddAddressRequest_FieldNumber) {
  AddAddressRequest_FieldNumber_Name = 1,
  AddAddressRequest_FieldNumber_Data_p = 2,
  AddAddressRequest_FieldNumber_DataSignature = 3,
};

@interface AddAddressRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *data_p;

@property(nonatomic, readwrite, strong, null_resettable) Signature *dataSignature;
/// Test to see if @c dataSignature has been set.
@property(nonatomic, readwrite) BOOL hasDataSignature;

@end

#pragma mark - AddAddressResponse

typedef GPB_ENUM(AddAddressResponse_FieldNumber) {
  AddAddressResponse_FieldNumber_Address = 1,
};

@interface AddAddressResponse : GPBMessage

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
  NotifyLinkAccountsRequest_FieldNumber_AccountsLinkPayload = 3,
};

/// Notify existing subscribers that a bank linking payload has been created
@interface NotifyLinkAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *alias;

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountsLinkPayload
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountsLinkPayload;

@end

#pragma mark - NotifyLinkAccountsResponse

@interface NotifyLinkAccountsResponse : GPBMessage

@end

#pragma mark - NotifyAddKeyRequest

typedef GPB_ENUM(NotifyAddKeyRequest_FieldNumber) {
  NotifyAddKeyRequest_FieldNumber_Alias = 1,
  NotifyAddKeyRequest_FieldNumber_PublicKey = 2,
  NotifyAddKeyRequest_FieldNumber_TagsArray = 3,
};

@interface NotifyAddKeyRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *alias;

@property(nonatomic, readwrite, copy, null_resettable) NSString *publicKey;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/// The number of items in @c tagsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

@end

#pragma mark - NotifyAddKeyResponse

@interface NotifyAddKeyResponse : GPBMessage

@end

#pragma mark - NotifyLinkAccountsAndAddKeyRequest

typedef GPB_ENUM(NotifyLinkAccountsAndAddKeyRequest_FieldNumber) {
  NotifyLinkAccountsAndAddKeyRequest_FieldNumber_Alias = 1,
  NotifyLinkAccountsAndAddKeyRequest_FieldNumber_BankId = 2,
  NotifyLinkAccountsAndAddKeyRequest_FieldNumber_AccountsLinkPayload = 3,
  NotifyLinkAccountsAndAddKeyRequest_FieldNumber_PublicKey = 4,
  NotifyLinkAccountsAndAddKeyRequest_FieldNumber_TagsArray = 5,
};

/// Notify existing subscribers that a bank linking payload has been created
///, as well as request a key to be added
@interface NotifyLinkAccountsAndAddKeyRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *alias;

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountsLinkPayload
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountsLinkPayload;

@property(nonatomic, readwrite, copy, null_resettable) NSString *publicKey;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/// The number of items in @c tagsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

@end

#pragma mark - NotifyLinkAccountsAndAddKeyResponse

@interface NotifyLinkAccountsAndAddKeyResponse : GPBMessage

@end

#pragma mark - LinkAccountsRequest

typedef GPB_ENUM(LinkAccountsRequest_FieldNumber) {
  LinkAccountsRequest_FieldNumber_BankId = 1,
  LinkAccountsRequest_FieldNumber_AccountsLinkPayload = 2,
};

@interface LinkAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountsLinkPayload
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountsLinkPayload;

@end

#pragma mark - LinkAccountsResponse

typedef GPB_ENUM(LinkAccountsResponse_FieldNumber) {
  LinkAccountsResponse_FieldNumber_AccountsArray = 1,
};

@interface LinkAccountsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Account*> *accountsArray;
/// The number of items in @c accountsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger accountsArray_Count;

@end

#pragma mark - GetAccountRequest

typedef GPB_ENUM(GetAccountRequest_FieldNumber) {
  GetAccountRequest_FieldNumber_AccountId = 1,
};

@interface GetAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - GetAccountResponse

typedef GPB_ENUM(GetAccountResponse_FieldNumber) {
  GetAccountResponse_FieldNumber_Account = 1,
};

@interface GetAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Account *account;
/// Test to see if @c account has been set.
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - GetAccountsRequest

@interface GetAccountsRequest : GPBMessage

@end

#pragma mark - GetAccountsResponse

typedef GPB_ENUM(GetAccountsResponse_FieldNumber) {
  GetAccountsResponse_FieldNumber_AccountsArray = 1,
};

@interface GetAccountsResponse : GPBMessage

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

#pragma mark - GetBalanceRequest

typedef GPB_ENUM(GetBalanceRequest_FieldNumber) {
  GetBalanceRequest_FieldNumber_AccountId = 1,
};

@interface GetBalanceRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - GetBalanceResponse

typedef GPB_ENUM(GetBalanceResponse_FieldNumber) {
  GetBalanceResponse_FieldNumber_Current = 1,
  GetBalanceResponse_FieldNumber_Available = 2,
};

@interface GetBalanceResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Money *current;
/// Test to see if @c current has been set.
@property(nonatomic, readwrite) BOOL hasCurrent;

@property(nonatomic, readwrite, strong, null_resettable) Money *available;
/// Test to see if @c available has been set.
@property(nonatomic, readwrite) BOOL hasAvailable;

@end

#pragma mark - GetTransactionRequest

typedef GPB_ENUM(GetTransactionRequest_FieldNumber) {
  GetTransactionRequest_FieldNumber_AccountId = 1,
  GetTransactionRequest_FieldNumber_TransactionId = 2,
};

@interface GetTransactionRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *transactionId;

@end

#pragma mark - GetTransactionResponse

typedef GPB_ENUM(GetTransactionResponse_FieldNumber) {
  GetTransactionResponse_FieldNumber_Transaction = 1,
};

@interface GetTransactionResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Transaction *transaction;
/// Test to see if @c transaction has been set.
@property(nonatomic, readwrite) BOOL hasTransaction;

@end

#pragma mark - GetTransactionsRequest

typedef GPB_ENUM(GetTransactionsRequest_FieldNumber) {
  GetTransactionsRequest_FieldNumber_AccountId = 1,
  GetTransactionsRequest_FieldNumber_Page = 2,
};

@interface GetTransactionsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

#pragma mark - GetTransactionsResponse

typedef GPB_ENUM(GetTransactionsResponse_FieldNumber) {
  GetTransactionsResponse_FieldNumber_TransactionsArray = 1,
  GetTransactionsResponse_FieldNumber_Offset = 2,
};

@interface GetTransactionsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Transaction*> *transactionsArray;
/// The number of items in @c transactionsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger transactionsArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

@end

#pragma mark - CreatePaymentTokenRequest

typedef GPB_ENUM(CreatePaymentTokenRequest_FieldNumber) {
  CreatePaymentTokenRequest_FieldNumber_Payload = 1,
};

@interface CreatePaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken_Payload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@end

#pragma mark - CreatePaymentTokenResponse

typedef GPB_ENUM(CreatePaymentTokenResponse_FieldNumber) {
  CreatePaymentTokenResponse_FieldNumber_Token = 1,
};

@interface CreatePaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetPaymentTokenRequest

typedef GPB_ENUM(GetPaymentTokenRequest_FieldNumber) {
  GetPaymentTokenRequest_FieldNumber_TokenId = 2,
};

@interface GetPaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@end

#pragma mark - GetPaymentTokenResponse

typedef GPB_ENUM(GetPaymentTokenResponse_FieldNumber) {
  GetPaymentTokenResponse_FieldNumber_Token = 1,
};

@interface GetPaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetPaymentTokensRequest

typedef GPB_ENUM(GetPaymentTokensRequest_FieldNumber) {
  GetPaymentTokensRequest_FieldNumber_Page = 1,
};

@interface GetPaymentTokensRequest : GPBMessage

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

#pragma mark - GetPaymentTokensResponse

typedef GPB_ENUM(GetPaymentTokensResponse_FieldNumber) {
  GetPaymentTokensResponse_FieldNumber_TokensArray = 1,
  GetPaymentTokensResponse_FieldNumber_Offset = 2,
};

@interface GetPaymentTokensResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<PaymentToken*> *tokensArray;
/// The number of items in @c tokensArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tokensArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

@end

#pragma mark - EndorsePaymentTokenRequest

typedef GPB_ENUM(EndorsePaymentTokenRequest_FieldNumber) {
  EndorsePaymentTokenRequest_FieldNumber_TokenId = 1,
  EndorsePaymentTokenRequest_FieldNumber_Signature = 2,
};

@interface EndorsePaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - EndorsePaymentTokenResponse

typedef GPB_ENUM(EndorsePaymentTokenResponse_FieldNumber) {
  EndorsePaymentTokenResponse_FieldNumber_Token = 1,
};

@interface EndorsePaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CancelPaymentTokenRequest

typedef GPB_ENUM(CancelPaymentTokenRequest_FieldNumber) {
  CancelPaymentTokenRequest_FieldNumber_TokenId = 1,
  CancelPaymentTokenRequest_FieldNumber_Signature = 2,
};

@interface CancelPaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - CancelPaymentTokenResponse

typedef GPB_ENUM(CancelPaymentTokenResponse_FieldNumber) {
  CancelPaymentTokenResponse_FieldNumber_Token = 1,
};

@interface CancelPaymentTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CreateAccessTokenRequest

typedef GPB_ENUM(CreateAccessTokenRequest_FieldNumber) {
  CreateAccessTokenRequest_FieldNumber_Payload = 1,
};

@interface CreateAccessTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AccessToken_Payload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@end

#pragma mark - CreateAccessTokenResponse

typedef GPB_ENUM(CreateAccessTokenResponse_FieldNumber) {
  CreateAccessTokenResponse_FieldNumber_Token = 1,
};

@interface CreateAccessTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AccessToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetAccessTokenRequest

typedef GPB_ENUM(GetAccessTokenRequest_FieldNumber) {
  GetAccessTokenRequest_FieldNumber_TokenId = 2,
};

@interface GetAccessTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@end

#pragma mark - GetAccessTokenResponse

typedef GPB_ENUM(GetAccessTokenResponse_FieldNumber) {
  GetAccessTokenResponse_FieldNumber_Token = 1,
};

@interface GetAccessTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AccessToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetAccessTokensRequest

typedef GPB_ENUM(GetAccessTokensRequest_FieldNumber) {
  GetAccessTokensRequest_FieldNumber_Page = 1,
};

@interface GetAccessTokensRequest : GPBMessage

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

#pragma mark - GetAccessTokensResponse

typedef GPB_ENUM(GetAccessTokensResponse_FieldNumber) {
  GetAccessTokensResponse_FieldNumber_TokensArray = 1,
  GetAccessTokensResponse_FieldNumber_Offset = 2,
};

@interface GetAccessTokensResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<AccessToken*> *tokensArray;
/// The number of items in @c tokensArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tokensArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

@end

#pragma mark - EndorseAccessTokenRequest

typedef GPB_ENUM(EndorseAccessTokenRequest_FieldNumber) {
  EndorseAccessTokenRequest_FieldNumber_TokenId = 1,
  EndorseAccessTokenRequest_FieldNumber_Signature = 2,
};

@interface EndorseAccessTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - EndorseAccessTokenResponse

typedef GPB_ENUM(EndorseAccessTokenResponse_FieldNumber) {
  EndorseAccessTokenResponse_FieldNumber_Token = 1,
};

@interface EndorseAccessTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AccessToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - CancelAccessTokenRequest

typedef GPB_ENUM(CancelAccessTokenRequest_FieldNumber) {
  CancelAccessTokenRequest_FieldNumber_TokenId = 1,
  CancelAccessTokenRequest_FieldNumber_Signature = 2,
};

@interface CancelAccessTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - CancelAccessTokenResponse

typedef GPB_ENUM(CancelAccessTokenResponse_FieldNumber) {
  CancelAccessTokenResponse_FieldNumber_Token = 1,
};

@interface CancelAccessTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AccessToken *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - RedeemPaymentTokenRequest

typedef GPB_ENUM(RedeemPaymentTokenRequest_FieldNumber) {
  RedeemPaymentTokenRequest_FieldNumber_Payload = 1,
  RedeemPaymentTokenRequest_FieldNumber_PayloadSignature = 2,
};

@interface RedeemPaymentTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) PaymentPayload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@property(nonatomic, readwrite, strong, null_resettable) Signature *payloadSignature;
/// Test to see if @c payloadSignature has been set.
@property(nonatomic, readwrite) BOOL hasPayloadSignature;

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

#pragma mark - GetPaymentRequest

typedef GPB_ENUM(GetPaymentRequest_FieldNumber) {
  GetPaymentRequest_FieldNumber_PaymentId = 1,
};

@interface GetPaymentRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentId;

@end

#pragma mark - GetPaymentResponse

typedef GPB_ENUM(GetPaymentResponse_FieldNumber) {
  GetPaymentResponse_FieldNumber_Payment = 1,
};

@interface GetPaymentResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Payment *payment;
/// Test to see if @c payment has been set.
@property(nonatomic, readwrite) BOOL hasPayment;

@end

#pragma mark - GetPaymentsRequest

typedef GPB_ENUM(GetPaymentsRequest_FieldNumber) {
  GetPaymentsRequest_FieldNumber_TokenId = 1,
  GetPaymentsRequest_FieldNumber_Page = 2,
};

@interface GetPaymentsRequest : GPBMessage

/// Optional token_id to filter payments by.
@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

#pragma mark - GetPaymentsResponse

typedef GPB_ENUM(GetPaymentsResponse_FieldNumber) {
  GetPaymentsResponse_FieldNumber_PaymentsArray = 1,
  GetPaymentsResponse_FieldNumber_Offset = 2,
};

@interface GetPaymentsResponse : GPBMessage

/// List of payments.
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Payment*> *paymentsArray;
/// The number of items in @c paymentsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger paymentsArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
