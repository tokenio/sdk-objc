// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: providerspecific.proto

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

@class Address;
@class Cma9AccountDetails;
@class Cma9AccountDetails_Cma9Address;
@class POLISHAPIPolishApiAccountDetails;
@class POLISHAPIPolishApiTransactionDetails;
@class POLISHAPIPolishApiTransferMetadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum Cma9AccountDetails_PartyType

typedef GPB_ENUM(Cma9AccountDetails_PartyType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Cma9AccountDetails_PartyType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Cma9AccountDetails_PartyType_InvalidPartyType = 0,
  Cma9AccountDetails_PartyType_Delegate = 1,
  Cma9AccountDetails_PartyType_Joint = 2,
  Cma9AccountDetails_PartyType_Sole = 3,
};

GPBEnumDescriptor *Cma9AccountDetails_PartyType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Cma9AccountDetails_PartyType_IsValidValue(int32_t value);

#pragma mark - Enum Cma9AccountDetails_AddressType

typedef GPB_ENUM(Cma9AccountDetails_AddressType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Cma9AccountDetails_AddressType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Cma9AccountDetails_AddressType_InvalidAddressType = 0,
  Cma9AccountDetails_AddressType_Business = 1,
  Cma9AccountDetails_AddressType_Correspondence = 2,
  Cma9AccountDetails_AddressType_Deliveryto = 3,
  Cma9AccountDetails_AddressType_Mailto = 4,
  Cma9AccountDetails_AddressType_Pobox = 5,
  Cma9AccountDetails_AddressType_Postal = 6,
  Cma9AccountDetails_AddressType_Residential = 7,
  Cma9AccountDetails_AddressType_Statement = 8,
};

GPBEnumDescriptor *Cma9AccountDetails_AddressType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Cma9AccountDetails_AddressType_IsValidValue(int32_t value);

#pragma mark - Enum Cma9AccountDetails_AccountType

typedef GPB_ENUM(Cma9AccountDetails_AccountType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Cma9AccountDetails_AccountType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Cma9AccountDetails_AccountType_InvalidAccountType = 0,
  Cma9AccountDetails_AccountType_BusinessAccount = 1,
  Cma9AccountDetails_AccountType_PersonalAccount = 2,
};

GPBEnumDescriptor *Cma9AccountDetails_AccountType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Cma9AccountDetails_AccountType_IsValidValue(int32_t value);

#pragma mark - Enum Cma9AccountDetails_AccountSubtype

typedef GPB_ENUM(Cma9AccountDetails_AccountSubtype) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Cma9AccountDetails_AccountSubtype_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Cma9AccountDetails_AccountSubtype_InvalidAccountSubtype = 0,
  Cma9AccountDetails_AccountSubtype_ChargeCard = 1,
  Cma9AccountDetails_AccountSubtype_CreditCard = 2,
  Cma9AccountDetails_AccountSubtype_CurrentAccount = 3,
  Cma9AccountDetails_AccountSubtype_Emoney = 4,
  Cma9AccountDetails_AccountSubtype_Loan = 5,
  Cma9AccountDetails_AccountSubtype_Mortgage = 6,
  Cma9AccountDetails_AccountSubtype_PrepaidCard = 7,
  Cma9AccountDetails_AccountSubtype_Savings = 8,
};

GPBEnumDescriptor *Cma9AccountDetails_AccountSubtype_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Cma9AccountDetails_AccountSubtype_IsValidValue(int32_t value);

#pragma mark - ProviderspecificRoot

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
@interface ProviderspecificRoot : GPBRootObject
@end

#pragma mark - ProviderAccountDetails

typedef GPB_ENUM(ProviderAccountDetails_FieldNumber) {
  ProviderAccountDetails_FieldNumber_Cma9AccountDetails = 1,
  ProviderAccountDetails_FieldNumber_PolishApiAccountDetails = 2,
};

typedef GPB_ENUM(ProviderAccountDetails_Details_OneOfCase) {
  ProviderAccountDetails_Details_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderAccountDetails_Details_OneOfCase_Cma9AccountDetails = 1,
  ProviderAccountDetails_Details_OneOfCase_PolishApiAccountDetails = 2,
};

@interface ProviderAccountDetails : GPBMessage

@property(nonatomic, readonly) ProviderAccountDetails_Details_OneOfCase detailsOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) Cma9AccountDetails *cma9AccountDetails;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiAccountDetails *polishApiAccountDetails;

@end

/**
 * Clears whatever value was set for the oneof 'details'.
 **/
void ProviderAccountDetails_ClearDetailsOneOfCase(ProviderAccountDetails *message);

#pragma mark - ProviderTransactionDetails

typedef GPB_ENUM(ProviderTransactionDetails_FieldNumber) {
  ProviderTransactionDetails_FieldNumber_PolishApiTransactionDetails = 1,
};

typedef GPB_ENUM(ProviderTransactionDetails_Details_OneOfCase) {
  ProviderTransactionDetails_Details_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderTransactionDetails_Details_OneOfCase_PolishApiTransactionDetails = 1,
};

@interface ProviderTransactionDetails : GPBMessage

@property(nonatomic, readonly) ProviderTransactionDetails_Details_OneOfCase detailsOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiTransactionDetails *polishApiTransactionDetails;

@end

/**
 * Clears whatever value was set for the oneof 'details'.
 **/
void ProviderTransactionDetails_ClearDetailsOneOfCase(ProviderTransactionDetails *message);

#pragma mark - ProviderTransferMetadata

typedef GPB_ENUM(ProviderTransferMetadata_FieldNumber) {
  ProviderTransferMetadata_FieldNumber_PolishApiTransferMetadata = 1,
};

typedef GPB_ENUM(ProviderTransferMetadata_Metadata_OneOfCase) {
  ProviderTransferMetadata_Metadata_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderTransferMetadata_Metadata_OneOfCase_PolishApiTransferMetadata = 1,
};

@interface ProviderTransferMetadata : GPBMessage

@property(nonatomic, readonly) ProviderTransferMetadata_Metadata_OneOfCase metadataOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiTransferMetadata *polishApiTransferMetadata;

@end

/**
 * Clears whatever value was set for the oneof 'metadata'.
 **/
void ProviderTransferMetadata_ClearMetadataOneOfCase(ProviderTransferMetadata *message);

#pragma mark - Cma9AccountDetails

typedef GPB_ENUM(Cma9AccountDetails_FieldNumber) {
  Cma9AccountDetails_FieldNumber_PartyId = 1,
  Cma9AccountDetails_FieldNumber_PartyNumber = 2,
  Cma9AccountDetails_FieldNumber_PartyType = 3,
  Cma9AccountDetails_FieldNumber_Name = 4,
  Cma9AccountDetails_FieldNumber_EmailAddress = 5,
  Cma9AccountDetails_FieldNumber_Phone = 6,
  Cma9AccountDetails_FieldNumber_Mobile = 7,
  Cma9AccountDetails_FieldNumber_AddressArray = 8,
  Cma9AccountDetails_FieldNumber_AccountType = 9,
  Cma9AccountDetails_FieldNumber_AccountSubtype = 10,
  Cma9AccountDetails_FieldNumber_Description_p = 11,
};

@interface Cma9AccountDetails : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *partyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *partyNumber;

@property(nonatomic, readwrite) Cma9AccountDetails_PartyType partyType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *emailAddress;

@property(nonatomic, readwrite, copy, null_resettable) NSString *phone;

@property(nonatomic, readwrite, copy, null_resettable) NSString *mobile;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Cma9AccountDetails_Cma9Address*> *addressArray;
/** The number of items in @c addressArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger addressArray_Count;

@property(nonatomic, readwrite) Cma9AccountDetails_AccountType accountType;

@property(nonatomic, readwrite) Cma9AccountDetails_AccountSubtype accountSubtype;

@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

@end

/**
 * Fetches the raw value of a @c Cma9AccountDetails's @c partyType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Cma9AccountDetails_PartyType_RawValue(Cma9AccountDetails *message);
/**
 * Sets the raw value of an @c Cma9AccountDetails's @c partyType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCma9AccountDetails_PartyType_RawValue(Cma9AccountDetails *message, int32_t value);

/**
 * Fetches the raw value of a @c Cma9AccountDetails's @c accountType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Cma9AccountDetails_AccountType_RawValue(Cma9AccountDetails *message);
/**
 * Sets the raw value of an @c Cma9AccountDetails's @c accountType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCma9AccountDetails_AccountType_RawValue(Cma9AccountDetails *message, int32_t value);

/**
 * Fetches the raw value of a @c Cma9AccountDetails's @c accountSubtype property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Cma9AccountDetails_AccountSubtype_RawValue(Cma9AccountDetails *message);
/**
 * Sets the raw value of an @c Cma9AccountDetails's @c accountSubtype property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCma9AccountDetails_AccountSubtype_RawValue(Cma9AccountDetails *message, int32_t value);

#pragma mark - Cma9AccountDetails_Cma9Address

typedef GPB_ENUM(Cma9AccountDetails_Cma9Address_FieldNumber) {
  Cma9AccountDetails_Cma9Address_FieldNumber_AddressType = 1,
  Cma9AccountDetails_Cma9Address_FieldNumber_Address = 2,
};

@interface Cma9AccountDetails_Cma9Address : GPBMessage

@property(nonatomic, readwrite) Cma9AccountDetails_AddressType addressType;

@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/** Test to see if @c address has been set. */
@property(nonatomic, readwrite) BOOL hasAddress;

@end

/**
 * Fetches the raw value of a @c Cma9AccountDetails_Cma9Address's @c addressType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Cma9AccountDetails_Cma9Address_AddressType_RawValue(Cma9AccountDetails_Cma9Address *message);
/**
 * Sets the raw value of an @c Cma9AccountDetails_Cma9Address's @c addressType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetCma9AccountDetails_Cma9Address_AddressType_RawValue(Cma9AccountDetails_Cma9Address *message, int32_t value);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
