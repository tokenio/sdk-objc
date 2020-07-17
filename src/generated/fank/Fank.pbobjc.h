// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: fank/fank.proto

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

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Alias;
@class FankAccount;
@class FankClient;
@class Money;
@class Notification;
@class Signature;
@class TokenPayload;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FankRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface FankRoot : GPBRootObject
@end

#pragma mark - FankClient

typedef GPB_ENUM(FankClient_FieldNumber) {
  FankClient_FieldNumber_Id_p = 1,
  FankClient_FieldNumber_FirstName = 2,
  FankClient_FieldNumber_LastName = 3,
};

/**
 *
 * A bank client, such as John Doe. Client can have multiple accounts.
 **/
GPB_FINAL @interface FankClient : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@end

#pragma mark - FankAccount

typedef GPB_ENUM(FankAccount_FieldNumber) {
  FankAccount_FieldNumber_Name = 2,
  FankAccount_FieldNumber_AccountNumber = 4,
  FankAccount_FieldNumber_Balance = 5,
};

GPB_FINAL @interface FankAccount : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, strong, null_resettable) Money *balance;
/** Test to see if @c balance has been set. */
@property(nonatomic, readwrite) BOOL hasBalance;

@end

#pragma mark - FankAddClientRequest

typedef GPB_ENUM(FankAddClientRequest_FieldNumber) {
  FankAddClientRequest_FieldNumber_Bic = 1,
  FankAddClientRequest_FieldNumber_FirstName = 2,
  FankAddClientRequest_FieldNumber_LastName = 3,
};

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Requests/Responses for the API.
 **/
GPB_FINAL @interface FankAddClientRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@end

#pragma mark - FankAddClientResponse

typedef GPB_ENUM(FankAddClientResponse_FieldNumber) {
  FankAddClientResponse_FieldNumber_Client = 1,
};

GPB_FINAL @interface FankAddClientResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankClient *client;
/** Test to see if @c client has been set. */
@property(nonatomic, readwrite) BOOL hasClient;

@end

#pragma mark - FankGetClientRequest

typedef GPB_ENUM(FankGetClientRequest_FieldNumber) {
  FankGetClientRequest_FieldNumber_Bic = 1,
  FankGetClientRequest_FieldNumber_ClientId = 2,
};

GPB_FINAL @interface FankGetClientRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@end

#pragma mark - FankGetClientResponse

typedef GPB_ENUM(FankGetClientResponse_FieldNumber) {
  FankGetClientResponse_FieldNumber_Client = 1,
};

GPB_FINAL @interface FankGetClientResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankClient *client;
/** Test to see if @c client has been set. */
@property(nonatomic, readwrite) BOOL hasClient;

@end

#pragma mark - FankAddAccountRequest

typedef GPB_ENUM(FankAddAccountRequest_FieldNumber) {
  FankAddAccountRequest_FieldNumber_Bic = 1,
  FankAddAccountRequest_FieldNumber_ClientId = 2,
  FankAddAccountRequest_FieldNumber_Name = 3,
  FankAddAccountRequest_FieldNumber_AccountNumber = 4,
  FankAddAccountRequest_FieldNumber_Balance = 5,
  FankAddAccountRequest_FieldNumber_Profile = 6,
};

GPB_FINAL @interface FankAddAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, strong, null_resettable) Money *balance;
/** Test to see if @c balance has been set. */
@property(nonatomic, readwrite) BOOL hasBalance;

@property(nonatomic, readwrite, copy, null_resettable) NSString *profile;

@end

#pragma mark - FankAddAccountResponse

typedef GPB_ENUM(FankAddAccountResponse_FieldNumber) {
  FankAddAccountResponse_FieldNumber_Account = 1,
};

GPB_FINAL @interface FankAddAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - FankGetAccountsRequest

typedef GPB_ENUM(FankGetAccountsRequest_FieldNumber) {
  FankGetAccountsRequest_FieldNumber_Bic = 1,
  FankGetAccountsRequest_FieldNumber_ClientId = 2,
};

GPB_FINAL @interface FankGetAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@end

#pragma mark - FankGetAccountsResponse

typedef GPB_ENUM(FankGetAccountsResponse_FieldNumber) {
  FankGetAccountsResponse_FieldNumber_AccountArray = 1,
};

GPB_FINAL @interface FankGetAccountsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<FankAccount*> *accountArray;
/** The number of items in @c accountArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger accountArray_Count;

@end

#pragma mark - FankGetAccountRequest

typedef GPB_ENUM(FankGetAccountRequest_FieldNumber) {
  FankGetAccountRequest_FieldNumber_Bic = 1,
  FankGetAccountRequest_FieldNumber_ClientId = 2,
  FankGetAccountRequest_FieldNumber_AccountNumber = 3,
};

GPB_FINAL @interface FankGetAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - FankGetAccountResponse

typedef GPB_ENUM(FankGetAccountResponse_FieldNumber) {
  FankGetAccountResponse_FieldNumber_Account = 1,
};

GPB_FINAL @interface FankGetAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - FankAuthorizeLinkAccountsRequest

typedef GPB_ENUM(FankAuthorizeLinkAccountsRequest_FieldNumber) {
  FankAuthorizeLinkAccountsRequest_FieldNumber_Bic = 1,
  FankAuthorizeLinkAccountsRequest_FieldNumber_MemberId = 2,
  FankAuthorizeLinkAccountsRequest_FieldNumber_ClientId = 3,
  FankAuthorizeLinkAccountsRequest_FieldNumber_AccountsArray = 4,
};

GPB_FINAL @interface FankAuthorizeLinkAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *accountsArray;
/** The number of items in @c accountsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger accountsArray_Count;

@end

#pragma mark - FankGetNotificationRequest

typedef GPB_ENUM(FankGetNotificationRequest_FieldNumber) {
  FankGetNotificationRequest_FieldNumber_SubscriberId = 1,
  FankGetNotificationRequest_FieldNumber_NotificationId = 2,
};

GPB_FINAL @interface FankGetNotificationRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *subscriberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *notificationId;

@end

#pragma mark - FankGetNotificationResponse

typedef GPB_ENUM(FankGetNotificationResponse_FieldNumber) {
  FankGetNotificationResponse_FieldNumber_Notification = 1,
};

GPB_FINAL @interface FankGetNotificationResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Notification *notification;
/** Test to see if @c notification has been set. */
@property(nonatomic, readwrite) BOOL hasNotification;

@end

#pragma mark - FankGetNotificationsRequest

typedef GPB_ENUM(FankGetNotificationsRequest_FieldNumber) {
  FankGetNotificationsRequest_FieldNumber_SubscriberId = 1,
};

GPB_FINAL @interface FankGetNotificationsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *subscriberId;

@end

#pragma mark - FankGetNotificationsResponse

typedef GPB_ENUM(FankGetNotificationsResponse_FieldNumber) {
  FankGetNotificationsResponse_FieldNumber_NotificationsArray = 1,
};

GPB_FINAL @interface FankGetNotificationsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Notification*> *notificationsArray;
/** The number of items in @c notificationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger notificationsArray_Count;

@end

#pragma mark - FankGetOauthAccessTokenRequest

typedef GPB_ENUM(FankGetOauthAccessTokenRequest_FieldNumber) {
  FankGetOauthAccessTokenRequest_FieldNumber_Bic = 1,
  FankGetOauthAccessTokenRequest_FieldNumber_Profile = 2,
  FankGetOauthAccessTokenRequest_FieldNumber_MemberId = 3,
  FankGetOauthAccessTokenRequest_FieldNumber_AccountsArray = 4,
  FankGetOauthAccessTokenRequest_FieldNumber_ClientId = 5,
};

GPB_FINAL @interface FankGetOauthAccessTokenRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

/** optional */
@property(nonatomic, readwrite, copy, null_resettable) NSString *profile;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<FankAccount*> *accountsArray;
/** The number of items in @c accountsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger accountsArray_Count;

/** optional */
@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@end

#pragma mark - FankGetOauthAccessTokenResponse

typedef GPB_ENUM(FankGetOauthAccessTokenResponse_FieldNumber) {
  FankGetOauthAccessTokenResponse_FieldNumber_AccessToken = 1,
  FankGetOauthAccessTokenResponse_FieldNumber_ExpiresInMs = 2,
};

GPB_FINAL @interface FankGetOauthAccessTokenResponse : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accessToken;

@property(nonatomic, readwrite) int64_t expiresInMs;

@end

#pragma mark - FankVerifyAliasRequest

typedef GPB_ENUM(FankVerifyAliasRequest_FieldNumber) {
  FankVerifyAliasRequest_FieldNumber_Bic = 1,
  FankVerifyAliasRequest_FieldNumber_MemberId = 2,
  FankVerifyAliasRequest_FieldNumber_Alias = 3,
};

GPB_FINAL @interface FankVerifyAliasRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, strong, null_resettable) Alias *alias;
/** Test to see if @c alias has been set. */
@property(nonatomic, readwrite) BOOL hasAlias;

@end

#pragma mark - FankVerifyAliasResponse

GPB_FINAL @interface FankVerifyAliasResponse : GPBMessage

@end

#pragma mark - FankGetAuthRequestPayloadRequest

typedef GPB_ENUM(FankGetAuthRequestPayloadRequest_FieldNumber) {
  FankGetAuthRequestPayloadRequest_FieldNumber_Bic = 1,
  FankGetAuthRequestPayloadRequest_FieldNumber_AuthRequestId = 2,
};

GPB_FINAL @interface FankGetAuthRequestPayloadRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *authRequestId;

@end

#pragma mark - FankGetAuthRequestPayloadResponse

typedef GPB_ENUM(FankGetAuthRequestPayloadResponse_FieldNumber) {
  FankGetAuthRequestPayloadResponse_FieldNumber_Payload = 1,
  FankGetAuthRequestPayloadResponse_FieldNumber_SourceAccountHash = 2,
};

GPB_FINAL @interface FankGetAuthRequestPayloadResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TokenPayload *payload;
/** Test to see if @c payload has been set. */
@property(nonatomic, readwrite) BOOL hasPayload;

@property(nonatomic, readwrite, copy, null_resettable) NSString *sourceAccountHash;

@end

#pragma mark - FankGetAuthRequestSignatureRequest

typedef GPB_ENUM(FankGetAuthRequestSignatureRequest_FieldNumber) {
  FankGetAuthRequestSignatureRequest_FieldNumber_Bic = 1,
  FankGetAuthRequestSignatureRequest_FieldNumber_SourceAccountHash = 2,
  FankGetAuthRequestSignatureRequest_FieldNumber_AccountNumber = 3,
};

GPB_FINAL @interface FankGetAuthRequestSignatureRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *sourceAccountHash;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - FankGetAuthRequestSignatureResponse

typedef GPB_ENUM(FankGetAuthRequestSignatureResponse_FieldNumber) {
  FankGetAuthRequestSignatureResponse_FieldNumber_BankSignature = 1,
};

GPB_FINAL @interface FankGetAuthRequestSignatureResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Signature *bankSignature;
/** Test to see if @c bankSignature has been set. */
@property(nonatomic, readwrite) BOOL hasBankSignature;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
