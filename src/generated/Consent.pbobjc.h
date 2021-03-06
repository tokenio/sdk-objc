// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: consent.proto

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

@class ActingAs;
@class BankAccount;
@class Consent_Beneficiary;
@class Consent_BulkPayment;
@class Consent_BulkPayment_Payment;
@class Consent_InformationAccess;
@class Consent_InformationAccess_ResourceAccess;
@class Consent_Payment;
@class Consent_StandingOrder;
@class Money;
@class TokenMember;
@class TransferDestination;
@class TransferEndpoint;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum Consent_InformationAccess_ResourceAccess_ResourceType

typedef GPB_ENUM(Consent_InformationAccess_ResourceAccess_ResourceType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Consent_InformationAccess_ResourceAccess_ResourceType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Consent_InformationAccess_ResourceAccess_ResourceType_InvalidResourceType = 0,
  Consent_InformationAccess_ResourceAccess_ResourceType_Account = 1,
  Consent_InformationAccess_ResourceAccess_ResourceType_Balance = 2,
  Consent_InformationAccess_ResourceAccess_ResourceType_Transactions = 3,
  Consent_InformationAccess_ResourceAccess_ResourceType_TransferDestinations = 4,
  Consent_InformationAccess_ResourceAccess_ResourceType_FundsConfirmations = 5,
  Consent_InformationAccess_ResourceAccess_ResourceType_StandingOrders = 6,
};

GPBEnumDescriptor *Consent_InformationAccess_ResourceAccess_ResourceType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Consent_InformationAccess_ResourceAccess_ResourceType_IsValidValue(int32_t value);

#pragma mark - ConsentRoot

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
GPB_FINAL @interface ConsentRoot : GPBRootObject
@end

#pragma mark - Consent

typedef GPB_ENUM(Consent_FieldNumber) {
  Consent_FieldNumber_Id_p = 1,
  Consent_FieldNumber_Beneficiary = 2,
  Consent_FieldNumber_MemberId = 3,
  Consent_FieldNumber_InformationAccess = 5,
  Consent_FieldNumber_Payment = 6,
  Consent_FieldNumber_InitiatorId = 7,
  Consent_FieldNumber_InitiatorRefId = 8,
  Consent_FieldNumber_StandingOrder = 9,
  Consent_FieldNumber_BulkPayment = 10,
};

typedef GPB_ENUM(Consent_Type_OneOfCase) {
  Consent_Type_OneOfCase_GPBUnsetOneOfCase = 0,
  Consent_Type_OneOfCase_InformationAccess = 5,
  Consent_Type_OneOfCase_Payment = 6,
  Consent_Type_OneOfCase_StandingOrder = 9,
  Consent_Type_OneOfCase_BulkPayment = 10,
};

GPB_FINAL @interface Consent : GPBMessage

/** Same as the corresponding token id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, strong, null_resettable) Consent_Beneficiary *beneficiary;
/** Test to see if @c beneficiary has been set. */
@property(nonatomic, readwrite) BOOL hasBeneficiary;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readonly) Consent_Type_OneOfCase typeOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) Consent_InformationAccess *informationAccess;

@property(nonatomic, readwrite, strong, null_resettable) Consent_Payment *payment;

@property(nonatomic, readwrite, strong, null_resettable) Consent_StandingOrder *standingOrder;

@property(nonatomic, readwrite, strong, null_resettable) Consent_BulkPayment *bulkPayment;

/** ID of the member requesting consent (e.g. merchant) */
@property(nonatomic, readwrite, copy, null_resettable) NSString *initiatorId;

/** Reference ID set by the member requesting consent */
@property(nonatomic, readwrite, copy, null_resettable) NSString *initiatorRefId;

@end

/**
 * Clears whatever value was set for the oneof 'type'.
 **/
void Consent_ClearTypeOneOfCase(Consent *message);

#pragma mark - Consent_InformationAccess

typedef GPB_ENUM(Consent_InformationAccess_FieldNumber) {
  Consent_InformationAccess_FieldNumber_ResourceAccessArray = 1,
};

GPB_FINAL @interface Consent_InformationAccess : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Consent_InformationAccess_ResourceAccess*> *resourceAccessArray;
/** The number of items in @c resourceAccessArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger resourceAccessArray_Count;

@end

#pragma mark - Consent_InformationAccess_ResourceAccess

typedef GPB_ENUM(Consent_InformationAccess_ResourceAccess_FieldNumber) {
  Consent_InformationAccess_ResourceAccess_FieldNumber_Account = 1,
  Consent_InformationAccess_ResourceAccess_FieldNumber_ResourcesArray = 2,
};

GPB_FINAL @interface Consent_InformationAccess_ResourceAccess : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

// |resourcesArray| contains |Consent_InformationAccess_ResourceAccess_ResourceType|
@property(nonatomic, readwrite, strong, null_resettable) GPBEnumArray *resourcesArray;
/** The number of items in @c resourcesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger resourcesArray_Count;

@end

#pragma mark - Consent_Payment

typedef GPB_ENUM(Consent_Payment_FieldNumber) {
  Consent_Payment_FieldNumber_Account = 1,
  Consent_Payment_FieldNumber_LifetimeAmount = 2,
  Consent_Payment_FieldNumber_Amount = 3,
  Consent_Payment_FieldNumber_DestinationsArray = 4,
  Consent_Payment_FieldNumber_TransferDestinationsArray = 5,
};

GPB_FINAL @interface Consent_Payment : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

@property(nonatomic, readwrite, strong, null_resettable) Money *lifetimeAmount;
/** Test to see if @c lifetimeAmount has been set. */
@property(nonatomic, readwrite) BOOL hasLifetimeAmount;

@property(nonatomic, readwrite, strong, null_resettable) Money *amount;
/** Test to see if @c amount has been set. */
@property(nonatomic, readwrite) BOOL hasAmount;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TransferEndpoint*> *destinationsArray GPB_DEPRECATED_MSG("io.token.proto.common.consent.Consent.Payment.destinations is deprecated (see consent.proto).");
/** The number of items in @c destinationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger destinationsArray_Count GPB_DEPRECATED_MSG("io.token.proto.common.consent.Consent.Payment.destinations is deprecated (see consent.proto).");

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TransferDestination*> *transferDestinationsArray;
/** The number of items in @c transferDestinationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger transferDestinationsArray_Count;

@end

#pragma mark - Consent_StandingOrder

typedef GPB_ENUM(Consent_StandingOrder_FieldNumber) {
  Consent_StandingOrder_FieldNumber_Account = 1,
  Consent_StandingOrder_FieldNumber_Amount = 2,
  Consent_StandingOrder_FieldNumber_Frequency = 3,
  Consent_StandingOrder_FieldNumber_TransferDestinationsArray = 4,
};

GPB_FINAL @interface Consent_StandingOrder : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

/** amount per charge */
@property(nonatomic, readwrite, strong, null_resettable) Money *amount;
/** Test to see if @c amount has been set. */
@property(nonatomic, readwrite) BOOL hasAmount;

/** ISO 20022: DAIL, WEEK, TOWK, MNTH, TOMN, QUTR, SEMI, YEAR */
@property(nonatomic, readwrite, copy, null_resettable) NSString *frequency;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TransferDestination*> *transferDestinationsArray;
/** The number of items in @c transferDestinationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger transferDestinationsArray_Count;

@end

#pragma mark - Consent_BulkPayment

typedef GPB_ENUM(Consent_BulkPayment_FieldNumber) {
  Consent_BulkPayment_FieldNumber_PaymentsArray = 1,
  Consent_BulkPayment_FieldNumber_Account = 2,
};

GPB_FINAL @interface Consent_BulkPayment : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Consent_BulkPayment_Payment*> *paymentsArray;
/** The number of items in @c paymentsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger paymentsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

@end

#pragma mark - Consent_BulkPayment_Payment

typedef GPB_ENUM(Consent_BulkPayment_Payment_FieldNumber) {
  Consent_BulkPayment_Payment_FieldNumber_Amount = 1,
  Consent_BulkPayment_Payment_FieldNumber_Currency = 2,
  Consent_BulkPayment_Payment_FieldNumber_RefId = 3,
  Consent_BulkPayment_Payment_FieldNumber_Description_p = 4,
  Consent_BulkPayment_Payment_FieldNumber_Destination = 5,
};

GPB_FINAL @interface Consent_BulkPayment_Payment : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *amount;

@property(nonatomic, readwrite, copy, null_resettable) NSString *currency;

@property(nonatomic, readwrite, copy, null_resettable) NSString *refId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination *destination;
/** Test to see if @c destination has been set. */
@property(nonatomic, readwrite) BOOL hasDestination;

@end

#pragma mark - Consent_Beneficiary

typedef GPB_ENUM(Consent_Beneficiary_FieldNumber) {
  Consent_Beneficiary_FieldNumber_Member = 1,
  Consent_Beneficiary_FieldNumber_ActingAs = 2,
};

GPB_FINAL @interface Consent_Beneficiary : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TokenMember *member;
/** Test to see if @c member has been set. */
@property(nonatomic, readwrite) BOOL hasMember;

@property(nonatomic, readwrite, strong, null_resettable) ActingAs *actingAs;
/** Test to see if @c actingAs has been set. */
@property(nonatomic, readwrite) BOOL hasActingAs;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
