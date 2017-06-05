// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: transaction.proto

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

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Money;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum TransactionType

typedef GPB_ENUM(TransactionType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  TransactionType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  TransactionType_InvalidType = 0,
  TransactionType_Debit = 1,
  TransactionType_Credit = 2,
};

GPBEnumDescriptor *TransactionType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL TransactionType_IsValidValue(int32_t value);

#pragma mark - Enum TransactionStatus

typedef GPB_ENUM(TransactionStatus) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  TransactionStatus_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** invalid status */
  TransactionStatus_InvalidStatus = 0,

  /** the transaction is pending submission */
  TransactionStatus_Pending = 1,

  /** the transaction is being processed */
  TransactionStatus_Processing = 7,

  /** the transaction has been successful */
  TransactionStatus_Success = 2,

  /** the transaction has been canceled */
  TransactionStatus_FailureCanceled = 10,

  /** the transaction has failed due to insufficient funds */
  TransactionStatus_FailureInsufficientFunds = 3,

  /** the transaction has failed due to currency mismatch */
  TransactionStatus_FailureInvalidCurrency = 4,

  /** the transaction has failed due to access violation */
  TransactionStatus_FailurePermissionDenied = 6,

  /** the transaction has failed due to other reasons */
  TransactionStatus_FailureGeneric = 5,
};

GPBEnumDescriptor *TransactionStatus_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL TransactionStatus_IsValidValue(int32_t value);

#pragma mark - TransactionRoot

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
@interface TransactionRoot : GPBRootObject
@end

#pragma mark - Transaction

typedef GPB_ENUM(Transaction_FieldNumber) {
  Transaction_FieldNumber_Id_p = 1,
  Transaction_FieldNumber_Type = 2,
  Transaction_FieldNumber_Status = 3,
  Transaction_FieldNumber_Amount = 4,
  Transaction_FieldNumber_Description_p = 5,
  Transaction_FieldNumber_TokenId = 6,
  Transaction_FieldNumber_TokenTransferId = 7,
};

@interface Transaction : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite) TransactionType type;

@property(nonatomic, readwrite) TransactionStatus status;

@property(nonatomic, readwrite, strong, null_resettable) Money *amount;
/** Test to see if @c amount has been set. */
@property(nonatomic, readwrite) BOOL hasAmount;

@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

/** Points to the token, only set for Token transactions. */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenId;

/** Points to the token transfer, only set for Token transactions. */
@property(nonatomic, readwrite, copy, null_resettable) NSString *tokenTransferId;

@end

/**
 * Fetches the raw value of a @c Transaction's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Transaction_Type_RawValue(Transaction *message);
/**
 * Sets the raw value of an @c Transaction's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetTransaction_Type_RawValue(Transaction *message, int32_t value);

/**
 * Fetches the raw value of a @c Transaction's @c status property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Transaction_Status_RawValue(Transaction *message);
/**
 * Sets the raw value of an @c Transaction's @c status property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetTransaction_Status_RawValue(Transaction *message, int32_t value);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
