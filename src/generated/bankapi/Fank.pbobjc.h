// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: bankapi/fank.proto

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

@class FankAccount;
@class FankClient;
@class Money;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FankFankRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface FankFankRoot : GPBRootObject
@end

#pragma mark - FankClient

typedef GPB_ENUM(FankClient_FieldNumber) {
  FankClient_FieldNumber_Id_p = 1,
  FankClient_FieldNumber_FirstName = 2,
  FankClient_FieldNumber_LastName = 3,
};

///
/// A bank client, such as John Doe. Client can have multiple accounts.
@interface FankClient : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@end

#pragma mark - FankAccount

typedef GPB_ENUM(FankAccount_FieldNumber) {
  FankAccount_FieldNumber_Name = 2,
  FankAccount_FieldNumber_AccountNumber = 3,
  FankAccount_FieldNumber_Balance = 4,
};

@interface FankAccount : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, strong, null_resettable) Money *balance;
/// Test to see if @c balance has been set.
@property(nonatomic, readwrite) BOOL hasBalance;

@end

#pragma mark - FankAddClientRequest

typedef GPB_ENUM(FankAddClientRequest_FieldNumber) {
  FankAddClientRequest_FieldNumber_FirstName = 1,
  FankAddClientRequest_FieldNumber_LastName = 2,
};

@interface FankAddClientRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@end

#pragma mark - FankAddClientResponse

typedef GPB_ENUM(FankAddClientResponse_FieldNumber) {
  FankAddClientResponse_FieldNumber_Client = 1,
};

@interface FankAddClientResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankClient *client;
/// Test to see if @c client has been set.
@property(nonatomic, readwrite) BOOL hasClient;

@end

#pragma mark - FankGetClientRequest

typedef GPB_ENUM(FankGetClientRequest_FieldNumber) {
  FankGetClientRequest_FieldNumber_ClientId = 1,
};

@interface FankGetClientRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@end

#pragma mark - FankGetClientResponse

typedef GPB_ENUM(FankGetClientResponse_FieldNumber) {
  FankGetClientResponse_FieldNumber_Client = 1,
};

@interface FankGetClientResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankClient *client;
/// Test to see if @c client has been set.
@property(nonatomic, readwrite) BOOL hasClient;

@end

#pragma mark - FankAddAccountRequest

typedef GPB_ENUM(FankAddAccountRequest_FieldNumber) {
  FankAddAccountRequest_FieldNumber_ClientId = 1,
  FankAddAccountRequest_FieldNumber_Name = 2,
  FankAddAccountRequest_FieldNumber_AccountNumber = 3,
  FankAddAccountRequest_FieldNumber_Balance = 4,
};

@interface FankAddAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, strong, null_resettable) Money *balance;
/// Test to see if @c balance has been set.
@property(nonatomic, readwrite) BOOL hasBalance;

@end

#pragma mark - FankAddAccountResponse

typedef GPB_ENUM(FankAddAccountResponse_FieldNumber) {
  FankAddAccountResponse_FieldNumber_Account = 1,
};

@interface FankAddAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankAccount *account;
/// Test to see if @c account has been set.
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - FankGetAccountsRequest

typedef GPB_ENUM(FankGetAccountsRequest_FieldNumber) {
  FankGetAccountsRequest_FieldNumber_ClientId = 1,
};

@interface FankGetAccountsRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@end

#pragma mark - FankGetAccountsResponse

typedef GPB_ENUM(FankGetAccountsResponse_FieldNumber) {
  FankGetAccountsResponse_FieldNumber_AccountArray = 1,
};

@interface FankGetAccountsResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<FankAccount*> *accountArray;
/// The number of items in @c accountArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger accountArray_Count;

@end

#pragma mark - FankGetAccountRequest

typedef GPB_ENUM(FankGetAccountRequest_FieldNumber) {
  FankGetAccountRequest_FieldNumber_ClientId = 1,
  FankGetAccountRequest_FieldNumber_AccountNumber = 2,
};

@interface FankGetAccountRequest : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *clientId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - FankGetAccountResponse

typedef GPB_ENUM(FankGetAccountResponse_FieldNumber) {
  FankGetAccountResponse_FieldNumber_Account = 1,
};

@interface FankGetAccountResponse : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankAccount *account;
/// Test to see if @c account has been set.
@property(nonatomic, readwrite) BOOL hasAccount;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
