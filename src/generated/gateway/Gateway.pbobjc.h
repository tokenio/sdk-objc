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
@class AddressRecord;
@class Member;
@class MemberUpdate;
@class Money;
@class Notification;
@class Page;
@class Signature;
@class Subscriber;
@class Token;
@class TokenOperationResult;
@class TokenPayload;
@class Transaction;
@class Transfer;
@class Transfer_Payload;
GPB_ENUM_FWD_DECLARE(Platform);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum GetTokensRequest_Type

typedef GPB_ENUM(GetTokensRequest_Type) {
  /// Value used if any message's field encounters a value that is not defined
  /// by this enum. The message will also have C functions to get/set the rawValue
  /// of the field.
  GetTokensRequest_Type_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  GetTokensRequest_Type_Invalid = 0,
  GetTokensRequest_Type_Access = 1,
  GetTokensRequest_Type_Transfer = 2,
};

GPBEnumDescriptor *GetTokensRequest_Type_EnumDescriptor(void);

/// Checks to see if the given value is defined by the enum or was not known at
/// the time this source was generated.
BOOL GetTokensRequest_Type_IsValidValue(int32_t value);

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

#pragma mark - Page

typedef GPB_ENUM(Page_FieldNumber) {
  Page_FieldNumber_Offset = 1,
  Page_FieldNumber_Limit = 2,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////
/// Paging details.
@interface Page : GPBMessage

/// Opaque base-64 encoded offset for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

/// Max number of records to return.
@property(nonatomic, readwrite) int32_t limit;

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

#pragma mark - UsernameExistsRequest

typedef GPB_ENUM(UsernameExistsRequest_FieldNumber) {
  UsernameExistsRequest_FieldNumber_Username = 1,
};

@interface UsernameExistsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *username;

@end

#pragma mark - UsernameExistsResponse

typedef GPB_ENUM(UsernameExistsResponse_FieldNumber) {
  UsernameExistsResponse_FieldNumber_Exists = 1,
};

@interface UsernameExistsResponse : GPBMessage

@property(nonatomic, readwrite) BOOL exists;

@end

#pragma mark - AddAddressRequest

typedef GPB_ENUM(AddAddressRequest_FieldNumber) {
  AddAddressRequest_FieldNumber_Name = 1,
  AddAddressRequest_FieldNumber_Address = 2,
  AddAddressRequest_FieldNumber_AddressSignature = 3,
};

@interface AddAddressRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/// Test to see if @c address has been set.
@property(nonatomic, readwrite) BOOL hasAddress;

@property(nonatomic, readwrite, strong, null_resettable) Signature *addressSignature;
/// Test to see if @c addressSignature has been set.
@property(nonatomic, readwrite) BOOL hasAddressSignature;

@end

#pragma mark - AddAddressResponse

typedef GPB_ENUM(AddAddressResponse_FieldNumber) {
  AddAddressResponse_FieldNumber_Address = 1,
};

@interface AddAddressResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) AddressRecord *address;
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

@property(nonatomic, readwrite, strong, null_resettable) AddressRecord *address;
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

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<AddressRecord*> *addressesArray;
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

#pragma mark - SubscribeToNotificationsRequest

typedef GPB_ENUM(SubscribeToNotificationsRequest_FieldNumber) {
  SubscribeToNotificationsRequest_FieldNumber_Target = 1,
  SubscribeToNotificationsRequest_FieldNumber_Platform = 2,
};

@interface SubscribeToNotificationsRequest : GPBMessage

/// e.g push token
@property(nonatomic, readwrite, copy, null_resettable) NSString *target;

@property(nonatomic, readwrite) enum Platform platform;

@end

/// Fetches the raw value of a @c SubscribeToNotificationsRequest's @c platform property, even
/// if the value was not defined by the enum at the time the code was generated.
int32_t SubscribeToNotificationsRequest_Platform_RawValue(SubscribeToNotificationsRequest *message);
/// Sets the raw value of an @c SubscribeToNotificationsRequest's @c platform property, allowing
/// it to be set to a value that was not defined by the enum at the time the code
/// was generated.
void SetSubscribeToNotificationsRequest_Platform_RawValue(SubscribeToNotificationsRequest *message, int32_t value);

#pragma mark - SubscribeToNotificationsResponse

typedef GPB_ENUM(SubscribeToNotificationsResponse_FieldNumber) {
  SubscribeToNotificationsResponse_FieldNumber_Subscriber = 1,
};

@interface SubscribeToNotificationsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Subscriber *subscriber;
/// Test to see if @c subscriber has been set.
@property(nonatomic, readwrite) BOOL hasSubscriber;

@end

#pragma mark - GetSubscribersRequest

@interface GetSubscribersRequest : GPBMessage

@end

#pragma mark - GetSubscribersResponse

typedef GPB_ENUM(GetSubscribersResponse_FieldNumber) {
  GetSubscribersResponse_FieldNumber_SubscribersArray = 1,
};

@interface GetSubscribersResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Subscriber*> *subscribersArray;
/// The number of items in @c subscribersArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger subscribersArray_Count;

@end

#pragma mark - GetSubscriberRequest

typedef GPB_ENUM(GetSubscriberRequest_FieldNumber) {
  GetSubscriberRequest_FieldNumber_SubscriberId = 1,
};

@interface GetSubscriberRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *subscriberId;

@end

#pragma mark - GetSubscriberResponse

typedef GPB_ENUM(GetSubscriberResponse_FieldNumber) {
  GetSubscriberResponse_FieldNumber_Subscriber = 1,
};

@interface GetSubscriberResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Subscriber *subscriber;
/// Test to see if @c subscriber has been set.
@property(nonatomic, readwrite) BOOL hasSubscriber;

@end

#pragma mark - UnsubscribeFromNotificationsRequest

typedef GPB_ENUM(UnsubscribeFromNotificationsRequest_FieldNumber) {
  UnsubscribeFromNotificationsRequest_FieldNumber_SubscriberId = 1,
};

@interface UnsubscribeFromNotificationsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *subscriberId;

@end

#pragma mark - UnsubscribeFromNotificationsResponse

@interface UnsubscribeFromNotificationsResponse : GPBMessage

@end

#pragma mark - NotifyRequest

typedef GPB_ENUM(NotifyRequest_FieldNumber) {
  NotifyRequest_FieldNumber_Username = 1,
  NotifyRequest_FieldNumber_Notification = 2,
};

@interface NotifyRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *username;

@property(nonatomic, readwrite, strong, null_resettable) Notification *notification;
/// Test to see if @c notification has been set.
@property(nonatomic, readwrite) BOOL hasNotification;

@end

#pragma mark - NotifyResponse

@interface NotifyResponse : GPBMessage

@end

#pragma mark - LinkAccountsRequest

typedef GPB_ENUM(LinkAccountsRequest_FieldNumber) {
  LinkAccountsRequest_FieldNumber_BankId = 1,
  LinkAccountsRequest_FieldNumber_AccountLinkPayloadsArray = 2,
};

@interface LinkAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

/// encrypted AccountsLinkPayload
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *accountLinkPayloadsArray;
/// The number of items in @c accountLinkPayloadsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger accountLinkPayloadsArray_Count;

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

#pragma mark - CreateTokenRequest

typedef GPB_ENUM(CreateTokenRequest_FieldNumber) {
  CreateTokenRequest_FieldNumber_Payload = 1,
};

@interface CreateTokenRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TokenPayload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@end

#pragma mark - CreateTokenResponse

typedef GPB_ENUM(CreateTokenResponse_FieldNumber) {
  CreateTokenResponse_FieldNumber_Token = 1,
};

@interface CreateTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetTokenRequest

typedef GPB_ENUM(GetTokenRequest_FieldNumber) {
  GetTokenRequest_FieldNumber_TokenId = 1,
};

@interface GetTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@end

#pragma mark - GetTokenResponse

typedef GPB_ENUM(GetTokenResponse_FieldNumber) {
  GetTokenResponse_FieldNumber_Token = 1,
};

@interface GetTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Token *token;
/// Test to see if @c token has been set.
@property(nonatomic, readwrite) BOOL hasToken;

@end

#pragma mark - GetTokensRequest

typedef GPB_ENUM(GetTokensRequest_FieldNumber) {
  GetTokensRequest_FieldNumber_Type = 1,
  GetTokensRequest_FieldNumber_Page = 2,
};

@interface GetTokensRequest : GPBMessage

@property(nonatomic, readwrite) GetTokensRequest_Type type;

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

/// Fetches the raw value of a @c GetTokensRequest's @c type property, even
/// if the value was not defined by the enum at the time the code was generated.
int32_t GetTokensRequest_Type_RawValue(GetTokensRequest *message);
/// Sets the raw value of an @c GetTokensRequest's @c type property, allowing
/// it to be set to a value that was not defined by the enum at the time the code
/// was generated.
void SetGetTokensRequest_Type_RawValue(GetTokensRequest *message, int32_t value);

#pragma mark - GetTokensResponse

typedef GPB_ENUM(GetTokensResponse_FieldNumber) {
  GetTokensResponse_FieldNumber_TokensArray = 1,
  GetTokensResponse_FieldNumber_Offset = 2,
};

@interface GetTokensResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Token*> *tokensArray;
/// The number of items in @c tokensArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tokensArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

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
  EndorseTokenResponse_FieldNumber_Result = 1,
};

@interface EndorseTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TokenOperationResult *result;
/// Test to see if @c result has been set.
@property(nonatomic, readwrite) BOOL hasResult;

@end

#pragma mark - CancelTokenRequest

typedef GPB_ENUM(CancelTokenRequest_FieldNumber) {
  CancelTokenRequest_FieldNumber_TokenId = 1,
  CancelTokenRequest_FieldNumber_Signature = 2,
};

@interface CancelTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/// Test to see if @c signature has been set.
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - CancelTokenResponse

typedef GPB_ENUM(CancelTokenResponse_FieldNumber) {
  CancelTokenResponse_FieldNumber_Result = 1,
};

@interface CancelTokenResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TokenOperationResult *result;
/// Test to see if @c result has been set.
@property(nonatomic, readwrite) BOOL hasResult;

@end

#pragma mark - CreateTransferRequest

typedef GPB_ENUM(CreateTransferRequest_FieldNumber) {
  CreateTransferRequest_FieldNumber_Payload = 1,
  CreateTransferRequest_FieldNumber_PayloadSignature = 2,
};

@interface CreateTransferRequest : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Transfer_Payload *payload;
/// Test to see if @c payload has been set.
@property(nonatomic, readwrite) BOOL hasPayload;

@property(nonatomic, readwrite, strong, null_resettable) Signature *payloadSignature;
/// Test to see if @c payloadSignature has been set.
@property(nonatomic, readwrite) BOOL hasPayloadSignature;

@end

#pragma mark - CreateTransferResponse

typedef GPB_ENUM(CreateTransferResponse_FieldNumber) {
  CreateTransferResponse_FieldNumber_Transfer = 1,
};

@interface CreateTransferResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Transfer *transfer;
/// Test to see if @c transfer has been set.
@property(nonatomic, readwrite) BOOL hasTransfer;

@end

#pragma mark - GetTransferRequest

typedef GPB_ENUM(GetTransferRequest_FieldNumber) {
  GetTransferRequest_FieldNumber_TransferId = 1,
};

@interface GetTransferRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *transferId;

@end

#pragma mark - GetTransferResponse

typedef GPB_ENUM(GetTransferResponse_FieldNumber) {
  GetTransferResponse_FieldNumber_Transfer = 1,
};

@interface GetTransferResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Transfer *transfer;
/// Test to see if @c transfer has been set.
@property(nonatomic, readwrite) BOOL hasTransfer;

@end

#pragma mark - GetTransfersRequest

typedef GPB_ENUM(GetTransfersRequest_FieldNumber) {
  GetTransfersRequest_FieldNumber_TokenId = 1,
  GetTransfersRequest_FieldNumber_Page = 2,
};

@interface GetTransfersRequest : GPBMessage

/// Optional token_id to filter transfers by.
@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

/// Optional paging settings.
@property(nonatomic, readwrite, strong, null_resettable) Page *page;
/// Test to see if @c page has been set.
@property(nonatomic, readwrite) BOOL hasPage;

@end

#pragma mark - GetTransfersResponse

typedef GPB_ENUM(GetTransfersResponse_FieldNumber) {
  GetTransfersResponse_FieldNumber_TransfersArray = 1,
  GetTransfersResponse_FieldNumber_Offset = 2,
};

@interface GetTransfersResponse : GPBMessage

/// List of transfers.
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Transfer*> *transfersArray;
/// The number of items in @c transfersArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger transfersArray_Count;

/// Optional offset state for the client to roundtrip.
@property(nonatomic, readwrite, copy, null_resettable) NSString *offset;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
