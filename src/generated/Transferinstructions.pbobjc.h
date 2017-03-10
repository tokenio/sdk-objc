// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: transferinstructions.proto

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

@class Destination;
@class DestinationAch;
@class DestinationBic;
@class DestinationIban;
@class DestinationLocal;
@class DestinationTips;
@class Source;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum DestinationIban_Method

typedef GPB_ENUM(DestinationIban_Method) {
  /// Value used if any message's field encounters a value that is not defined
  /// by this enum. The message will also have C functions to get/set the rawValue
  /// of the field.
  DestinationIban_Method_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  DestinationIban_Method_Invalid = 0,
  DestinationIban_Method_Swift = 1,
  DestinationIban_Method_Sepa = 2,
};

GPBEnumDescriptor *DestinationIban_Method_EnumDescriptor(void);

/// Checks to see if the given value is defined by the enum or was not known at
/// the time this source was generated.
BOOL DestinationIban_Method_IsValidValue(int32_t value);

#pragma mark - TransferinstructionsRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface TransferinstructionsRoot : GPBRootObject
@end

#pragma mark - TransferInstructions

typedef GPB_ENUM(TransferInstructions_FieldNumber) {
  TransferInstructions_FieldNumber_Source = 1,
  TransferInstructions_FieldNumber_DestinationsArray = 2,
};

/// Money transfer instructions.
@interface TransferInstructions : GPBMessage

/// Transfer source.
@property(nonatomic, readwrite, strong, null_resettable) Source *source;
/// Test to see if @c source has been set.
@property(nonatomic, readwrite) BOOL hasSource;

/// Transfer desitination.
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Destination*> *destinationsArray;
/// The number of items in @c destinationsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger destinationsArray_Count;

@end

#pragma mark - Source

typedef GPB_ENUM(Source_FieldNumber) {
  Source_FieldNumber_AccountId = 1,
  Source_FieldNumber_AccountNumber = 2,
};

/// Money transfer source. This could be an transferDest id assigned by Token or
/// real bank transferDest number.
@interface Source : GPBMessage

/// Required when coming from the client.
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

/// Optional when coming from the client, required at the bank.
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - Destination

typedef GPB_ENUM(Destination_FieldNumber) {
  Destination_FieldNumber_Swift = 1,
  Destination_FieldNumber_Iban = 2,
  Destination_FieldNumber_Ach = 3,
  Destination_FieldNumber_Local = 4,
  Destination_FieldNumber_Tips = 5,
};

typedef GPB_ENUM(Destination_Destination_OneOfCase) {
  Destination_Destination_OneOfCase_GPBUnsetOneOfCase = 0,
  Destination_Destination_OneOfCase_Swift = 1,
  Destination_Destination_OneOfCase_Iban = 2,
  Destination_Destination_OneOfCase_Ach = 3,
  Destination_Destination_OneOfCase_Local = 4,
  Destination_Destination_OneOfCase_Tips = 5,
};

/// Money transfer destination. The desitination is described differently
/// depending on the transfer method being used.
@interface Destination : GPBMessage

@property(nonatomic, readonly) Destination_Destination_OneOfCase destinationOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) DestinationBic *swift;

@property(nonatomic, readwrite, strong, null_resettable) DestinationIban *iban;

@property(nonatomic, readwrite, strong, null_resettable) DestinationAch *ach;

@property(nonatomic, readwrite, strong, null_resettable) DestinationLocal *local;

@property(nonatomic, readwrite, strong, null_resettable) DestinationTips *tips;

@end

/// Clears whatever value was set for the oneof 'destination'.
void Destination_ClearDestinationOneOfCase(Destination *message);

#pragma mark - DestinationBic

typedef GPB_ENUM(DestinationBic_FieldNumber) {
  DestinationBic_FieldNumber_Bic = 1,
  DestinationBic_FieldNumber_Account = 2,
};

/// SWIFT transfer destination.
@interface DestinationBic : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - DestinationIban

typedef GPB_ENUM(DestinationIban_FieldNumber) {
  DestinationIban_FieldNumber_Method = 1,
  DestinationIban_FieldNumber_Iban = 2,
  DestinationIban_FieldNumber_Name = 3,
};

/// IBAN transfer destination, can be used with different transfer methods.
@interface DestinationIban : GPBMessage

@property(nonatomic, readwrite) DestinationIban_Method method;

@property(nonatomic, readwrite, copy, null_resettable) NSString *iban;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@end

/// Fetches the raw value of a @c DestinationIban's @c method property, even
/// if the value was not defined by the enum at the time the code was generated.
int32_t DestinationIban_Method_RawValue(DestinationIban *message);
/// Sets the raw value of an @c DestinationIban's @c method property, allowing
/// it to be set to a value that was not defined by the enum at the time the code
/// was generated.
void SetDestinationIban_Method_RawValue(DestinationIban *message, int32_t value);

#pragma mark - DestinationAch

typedef GPB_ENUM(DestinationAch_FieldNumber) {
  DestinationAch_FieldNumber_Routing = 1,
  DestinationAch_FieldNumber_Account = 2,
};

/// ACH transfer destination.
@interface DestinationAch : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *routing;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - DestinationLocal

typedef GPB_ENUM(DestinationLocal_FieldNumber) {
  DestinationLocal_FieldNumber_AccountId = 1,
  DestinationLocal_FieldNumber_AccountNumber = 2,
};

/// Local transfer within the same bank.
@interface DestinationLocal : GPBMessage

/// Required when coming from the client.
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

/// Optional when coming from the client, required at the bank.
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - DestinationTips

typedef GPB_ENUM(DestinationTips_FieldNumber) {
  DestinationTips_FieldNumber_Username = 1,
};

/// Token Instant Payment Service
@interface DestinationTips : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *username;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
