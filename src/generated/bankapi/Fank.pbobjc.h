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

@class FankMetadata_Client;
@class FankMetadata_ClientAccount;
@class Money;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FankRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface FankRoot : GPBRootObject
@end

#pragma mark - FankMetadata

typedef GPB_ENUM(FankMetadata_FieldNumber) {
  FankMetadata_FieldNumber_Client = 1,
  FankMetadata_FieldNumber_ClientAccountsArray = 2,
};

/// A helper proto to serialize Fake Bank metadata.
/// This payload is intendet to be used with LinkAccountRequest
/// as a serialized json inside the payload.
@interface FankMetadata : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) FankMetadata_Client *client;
/// Test to see if @c client has been set.
@property(nonatomic, readwrite) BOOL hasClient;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<FankMetadata_ClientAccount*> *clientAccountsArray;
/// The number of items in @c clientAccountsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger clientAccountsArray_Count;

@end

#pragma mark - FankMetadata_Client

typedef GPB_ENUM(FankMetadata_Client_FieldNumber) {
  FankMetadata_Client_FieldNumber_FirstName = 1,
  FankMetadata_Client_FieldNumber_LastName = 2,
};

/// Instruction for FakeBank to create a client
/// with the specified name (if doesn't already exist)
@interface FankMetadata_Client : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *firstName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastName;

@end

#pragma mark - FankMetadata_ClientAccount

typedef GPB_ENUM(FankMetadata_ClientAccount_FieldNumber) {
  FankMetadata_ClientAccount_FieldNumber_Name = 1,
  FankMetadata_ClientAccount_FieldNumber_AccountNumber = 2,
  FankMetadata_ClientAccount_FieldNumber_Balance = 3,
};

/// Instruction for FakeBank to create a client account
/// if diesn't already exist
@interface FankMetadata_ClientAccount : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, strong, null_resettable) Money *balance;
/// Test to see if @c balance has been set.
@property(nonatomic, readwrite) BOOL hasBalance;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)