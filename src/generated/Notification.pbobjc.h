// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: notification.proto

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
@class AddKey;
@class LinkAccounts;
@class Payment;
@class PaymentToken;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - NotificationRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface NotificationRoot : GPBRootObject
@end

#pragma mark - PaymentProcessed

typedef GPB_ENUM(PaymentProcessed_FieldNumber) {
  PaymentProcessed_FieldNumber_Payment = 1,
};

/// A notification that a payment was sucecssfully processed
@interface PaymentProcessed : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) Payment *payment;
/// Test to see if @c payment has been set.
@property(nonatomic, readwrite) BOOL hasPayment;

@end

#pragma mark - LinkAccounts

typedef GPB_ENUM(LinkAccounts_FieldNumber) {
  LinkAccounts_FieldNumber_BankId = 1,
  LinkAccounts_FieldNumber_AccountLinkPayload = 2,
};

/// A notification that a bank wants to be linked
@interface LinkAccounts : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountLinkPayload;

@end

#pragma mark - StepUp

typedef GPB_ENUM(StepUp_FieldNumber) {
  StepUp_FieldNumber_PaymentToken = 1,
  StepUp_FieldNumber_AccessToken = 2,
};

typedef GPB_ENUM(StepUp_Token_OneOfCase) {
  StepUp_Token_OneOfCase_GPBUnsetOneOfCase = 0,
  StepUp_Token_OneOfCase_PaymentToken = 1,
  StepUp_Token_OneOfCase_AccessToken = 2,
};

/// A notification to step up / endorse a token
@interface StepUp : GPBMessage

@property(nonatomic, readonly) StepUp_Token_OneOfCase tokenOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) PaymentToken *paymentToken;

@property(nonatomic, readwrite, strong, null_resettable) AccessToken *accessToken;

@end

/// Clears whatever value was set for the oneof 'token'.
void StepUp_ClearTokenOneOfCase(StepUp *message);

#pragma mark - AddKey

typedef GPB_ENUM(AddKey_FieldNumber) {
  AddKey_FieldNumber_PublicKey = 1,
  AddKey_FieldNumber_TagsArray = 2,
};

/// A notification that a key wants to be added to a member
@interface AddKey : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *publicKey;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *tagsArray;
/// The number of items in @c tagsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

@end

#pragma mark - LinkAccountsAndAddKey

typedef GPB_ENUM(LinkAccountsAndAddKey_FieldNumber) {
  LinkAccountsAndAddKey_FieldNumber_LinkAccounts = 1,
  LinkAccountsAndAddKey_FieldNumber_AddKey = 2,
};

/// A notification that a bank wants to be linked, and keys want to be added
@interface LinkAccountsAndAddKey : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) LinkAccounts *linkAccounts;
/// Test to see if @c linkAccounts has been set.
@property(nonatomic, readwrite) BOOL hasLinkAccounts;

@property(nonatomic, readwrite, strong, null_resettable) AddKey *addKey;
/// Test to see if @c addKey has been set.
@property(nonatomic, readwrite) BOOL hasAddKey;

@end

#pragma mark - Custom

typedef GPB_ENUM(Custom_FieldNumber) {
  Custom_FieldNumber_Payload = 1,
};

/// A custom message with the specified payload
@interface Custom : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *payload;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
