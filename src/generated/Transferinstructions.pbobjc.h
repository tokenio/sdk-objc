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
@class BankAccount;
@class CustomerData;
@class ProviderTransferMetadata;
@class TransferDestination;
@class TransferDestination_Ach;
@class TransferDestination_BlueCash;
@class TransferDestination_Custom;
@class TransferDestination_Elixir;
@class TransferDestination_ExpressElixir;
@class TransferDestination_FasterPayments;
@class TransferDestination_Sepa;
@class TransferDestination_SepaInstant;
@class TransferDestination_Sorbnet;
@class TransferDestination_Swift;
@class TransferDestination_Token;
@class TransferEndpoint;
@class TransferInstructions_Metadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum PurposeOfPayment

/** A bank might require a Purpose of Payment for some transfers. */
typedef GPB_ENUM(PurposeOfPayment) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  PurposeOfPayment_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  PurposeOfPayment_Invalid = 0,
  PurposeOfPayment_Other = 1,
  PurposeOfPayment_PersonalExpenses = 2,
  PurposeOfPayment_PurchaseOfShares = 3,
  PurposeOfPayment_TransferToYourOwnAccount = 4,
  PurposeOfPayment_PurchaseOfProperty = 5,
  PurposeOfPayment_FamilyMaintenance = 6,
  PurposeOfPayment_Savings = 7,
};

GPBEnumDescriptor *PurposeOfPayment_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL PurposeOfPayment_IsValidValue(int32_t value);

#pragma mark - Enum PaymentContext

/** A bank might require a context code for some transfers. */
typedef GPB_ENUM(PaymentContext) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  PaymentContext_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  PaymentContext_InvalidContext = 0,
  PaymentContext_OtherContext = 1,
  PaymentContext_BillPayment = 2,
  PaymentContext_EcommerceGoods = 3,
  PaymentContext_EcommerceServices = 4,
  PaymentContext_PersonToPerson = 5,
};

GPBEnumDescriptor *PaymentContext_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL PaymentContext_IsValidValue(int32_t value);

#pragma mark - TransferinstructionsRoot

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
@interface TransferinstructionsRoot : GPBRootObject
@end

#pragma mark - CustomerData

typedef GPB_ENUM(CustomerData_FieldNumber) {
  CustomerData_FieldNumber_LegalNamesArray = 1,
  CustomerData_FieldNumber_Address = 2,
};

@interface CustomerData : GPBMessage

/** Repeated in case of joint account holders. */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *legalNamesArray;
/** The number of items in @c legalNamesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger legalNamesArray_Count;

/** Physical address */
@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/** Test to see if @c address has been set. */
@property(nonatomic, readwrite) BOOL hasAddress;

@end

#pragma mark - TransferEndpoint

typedef GPB_ENUM(TransferEndpoint_FieldNumber) {
  TransferEndpoint_FieldNumber_Account = 1,
  TransferEndpoint_FieldNumber_CustomerData = 2,
};

/**
 * Money transfer source or destination account.
 **/
@interface TransferEndpoint : GPBMessage

/** Account identifier, e.g., SWIFT transfer info */
@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

/** Customer data: name and address */
@property(nonatomic, readwrite, strong, null_resettable) CustomerData *customerData;
/** Test to see if @c customerData has been set. */
@property(nonatomic, readwrite) BOOL hasCustomerData;

@end

#pragma mark - TransferDestination

typedef GPB_ENUM(TransferDestination_FieldNumber) {
  TransferDestination_FieldNumber_Token = 1,
  TransferDestination_FieldNumber_Sepa = 2,
  TransferDestination_FieldNumber_SepaInstant = 3,
  TransferDestination_FieldNumber_FasterPayments = 4,
  TransferDestination_FieldNumber_Ach = 5,
  TransferDestination_FieldNumber_Swift = 6,
  TransferDestination_FieldNumber_Elixir = 7,
  TransferDestination_FieldNumber_ExpressElixir = 8,
  TransferDestination_FieldNumber_BlueCash = 9,
  TransferDestination_FieldNumber_Sorbnet = 10,
  TransferDestination_FieldNumber_CustomerData = 11,
  TransferDestination_FieldNumber_Custom = 12,
};

typedef GPB_ENUM(TransferDestination_Destination_OneOfCase) {
  TransferDestination_Destination_OneOfCase_GPBUnsetOneOfCase = 0,
  TransferDestination_Destination_OneOfCase_Token = 1,
  TransferDestination_Destination_OneOfCase_Sepa = 2,
  TransferDestination_Destination_OneOfCase_SepaInstant = 3,
  TransferDestination_Destination_OneOfCase_FasterPayments = 4,
  TransferDestination_Destination_OneOfCase_Ach = 5,
  TransferDestination_Destination_OneOfCase_Swift = 6,
  TransferDestination_Destination_OneOfCase_Elixir = 7,
  TransferDestination_Destination_OneOfCase_ExpressElixir = 8,
  TransferDestination_Destination_OneOfCase_BlueCash = 9,
  TransferDestination_Destination_OneOfCase_Sorbnet = 10,
  TransferDestination_Destination_OneOfCase_Custom = 12,
};

@interface TransferDestination : GPBMessage

@property(nonatomic, readonly) TransferDestination_Destination_OneOfCase destinationOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Token *token;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Sepa *sepa;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_SepaInstant *sepaInstant;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_FasterPayments *fasterPayments;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Ach *ach;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Swift *swift;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Elixir *elixir;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_ExpressElixir *expressElixir;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_BlueCash *blueCash;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Sorbnet *sorbnet;

@property(nonatomic, readwrite, strong, null_resettable) TransferDestination_Custom *custom;

@property(nonatomic, readwrite, strong, null_resettable) CustomerData *customerData;
/** Test to see if @c customerData has been set. */
@property(nonatomic, readwrite) BOOL hasCustomerData;

@end

/**
 * Clears whatever value was set for the oneof 'destination'.
 **/
void TransferDestination_ClearDestinationOneOfCase(TransferDestination *message);

#pragma mark - TransferDestination_Token

typedef GPB_ENUM(TransferDestination_Token_FieldNumber) {
  TransferDestination_Token_FieldNumber_MemberId = 1,
  TransferDestination_Token_FieldNumber_AccountId = 2,
};

/**
 * Token account Destination. Useful as source or destination
 * for a transfer; doesn't make sense for a bank to "link" this.
 **/
@interface TransferDestination_Token : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - TransferDestination_Custom

typedef GPB_ENUM(TransferDestination_Custom_FieldNumber) {
  TransferDestination_Custom_FieldNumber_BankId = 1,
  TransferDestination_Custom_FieldNumber_Payload = 2,
};

/**
 * Custom authorization
 **/
@interface TransferDestination_Custom : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *payload;

@end

#pragma mark - TransferDestination_Sepa

typedef GPB_ENUM(TransferDestination_Sepa_FieldNumber) {
  TransferDestination_Sepa_FieldNumber_Bic = 1,
  TransferDestination_Sepa_FieldNumber_Iban = 2,
};

/**
 * SEPA transfer
 **/
@interface TransferDestination_Sepa : GPBMessage

/** Optional */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *iban;

@end

#pragma mark - TransferDestination_SepaInstant

typedef GPB_ENUM(TransferDestination_SepaInstant_FieldNumber) {
  TransferDestination_SepaInstant_FieldNumber_Iban = 1,
};

@interface TransferDestination_SepaInstant : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *iban;

@end

#pragma mark - TransferDestination_FasterPayments

typedef GPB_ENUM(TransferDestination_FasterPayments_FieldNumber) {
  TransferDestination_FasterPayments_FieldNumber_SortCode = 1,
  TransferDestination_FasterPayments_FieldNumber_AccountNumber = 2,
};

/**
 * Faster Payments Service transfer (UK)
 **/
@interface TransferDestination_FasterPayments : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *sortCode;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - TransferDestination_Ach

typedef GPB_ENUM(TransferDestination_Ach_FieldNumber) {
  TransferDestination_Ach_FieldNumber_Routing = 1,
  TransferDestination_Ach_FieldNumber_Account = 2,
};

/**
 * ACH transfer
 **/
@interface TransferDestination_Ach : GPBMessage

/** Routing number */
@property(nonatomic, readwrite, copy, null_resettable) NSString *routing;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - TransferDestination_Swift

typedef GPB_ENUM(TransferDestination_Swift_FieldNumber) {
  TransferDestination_Swift_FieldNumber_Bic = 1,
  TransferDestination_Swift_FieldNumber_Account = 2,
};

@interface TransferDestination_Swift : GPBMessage

/** BIC code AAAABBCCDD */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - TransferDestination_Elixir

typedef GPB_ENUM(TransferDestination_Elixir_FieldNumber) {
  TransferDestination_Elixir_FieldNumber_AccountNumber = 1,
};

/**
 * Polish domestic
 **/
@interface TransferDestination_Elixir : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - TransferDestination_ExpressElixir

typedef GPB_ENUM(TransferDestination_ExpressElixir_FieldNumber) {
  TransferDestination_ExpressElixir_FieldNumber_AccountNumber = 1,
};

/**
 * Polish domestic
 **/
@interface TransferDestination_ExpressElixir : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - TransferDestination_BlueCash

typedef GPB_ENUM(TransferDestination_BlueCash_FieldNumber) {
  TransferDestination_BlueCash_FieldNumber_AccountNumber = 1,
};

/**
 * Polish domestic
 **/
@interface TransferDestination_BlueCash : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - TransferDestination_Sorbnet

typedef GPB_ENUM(TransferDestination_Sorbnet_FieldNumber) {
  TransferDestination_Sorbnet_FieldNumber_AccountNumber = 1,
};

/**
 * Polish domestic
 **/
@interface TransferDestination_Sorbnet : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

#pragma mark - TransferInstructions

typedef GPB_ENUM(TransferInstructions_FieldNumber) {
  TransferInstructions_FieldNumber_Source = 1,
  TransferInstructions_FieldNumber_DestinationsArray = 2,
  TransferInstructions_FieldNumber_Metadata = 3,
  TransferInstructions_FieldNumber_TransferDestinationsArray = 4,
};

/**
 * Money transfer instructions.
 **/
@interface TransferInstructions : GPBMessage

/** Transfer source. */
@property(nonatomic, readwrite, strong, null_resettable) TransferEndpoint *source;
/** Test to see if @c source has been set. */
@property(nonatomic, readwrite) BOOL hasSource;

/** Transfer destinations. */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TransferEndpoint*> *destinationsArray GPB_DEPRECATED_MSG("io.token.proto.common.transferinstructions.TransferInstructions.destinations is deprecated (see transferinstructions.proto).");
/** The number of items in @c destinationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger destinationsArray_Count GPB_DEPRECATED_MSG("io.token.proto.common.transferinstructions.TransferInstructions.destinations is deprecated (see transferinstructions.proto).");

@property(nonatomic, readwrite, strong, null_resettable) TransferInstructions_Metadata *metadata;
/** Test to see if @c metadata has been set. */
@property(nonatomic, readwrite) BOOL hasMetadata;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<TransferDestination*> *transferDestinationsArray;
/** The number of items in @c transferDestinationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger transferDestinationsArray_Count;

@end

#pragma mark - TransferInstructions_Metadata

typedef GPB_ENUM(TransferInstructions_Metadata_FieldNumber) {
  TransferInstructions_Metadata_FieldNumber_TransferPurpose = 1,
  TransferInstructions_Metadata_FieldNumber_PaymentContext = 2,
  TransferInstructions_Metadata_FieldNumber_MerchantCategoryCode = 3,
  TransferInstructions_Metadata_FieldNumber_MerchantCustomerId = 4,
  TransferInstructions_Metadata_FieldNumber_DeliveryAddress = 5,
  TransferInstructions_Metadata_FieldNumber_ProviderTransferMetadata = 6,
};

@interface TransferInstructions_Metadata : GPBMessage

/** Purpose of payment */
@property(nonatomic, readwrite) PurposeOfPayment transferPurpose;

/** Optional payment context */
@property(nonatomic, readwrite) PaymentContext paymentContext;

/** Optional ISO 18245 Merchant Category Code (MCC) */
@property(nonatomic, readwrite, copy, null_resettable) NSString *merchantCategoryCode;

/** Optional Unique merchant customer identifier */
@property(nonatomic, readwrite, copy, null_resettable) NSString *merchantCustomerId;

/** Optional delivery address */
@property(nonatomic, readwrite, strong, null_resettable) Address *deliveryAddress;
/** Test to see if @c deliveryAddress has been set. */
@property(nonatomic, readwrite) BOOL hasDeliveryAddress;

@property(nonatomic, readwrite, strong, null_resettable) ProviderTransferMetadata *providerTransferMetadata;
/** Test to see if @c providerTransferMetadata has been set. */
@property(nonatomic, readwrite) BOOL hasProviderTransferMetadata;

@end

/**
 * Fetches the raw value of a @c TransferInstructions_Metadata's @c transferPurpose property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t TransferInstructions_Metadata_TransferPurpose_RawValue(TransferInstructions_Metadata *message);
/**
 * Sets the raw value of an @c TransferInstructions_Metadata's @c transferPurpose property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetTransferInstructions_Metadata_TransferPurpose_RawValue(TransferInstructions_Metadata *message, int32_t value);

/**
 * Fetches the raw value of a @c TransferInstructions_Metadata's @c paymentContext property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t TransferInstructions_Metadata_PaymentContext_RawValue(TransferInstructions_Metadata *message);
/**
 * Sets the raw value of an @c TransferInstructions_Metadata's @c paymentContext property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetTransferInstructions_Metadata_PaymentContext_RawValue(TransferInstructions_Metadata *message, int32_t value);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
