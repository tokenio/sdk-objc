// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: provider/polishapi.proto

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

@class POLISHAPIAccountPsuRelation;
@class POLISHAPIBank;
@class POLISHAPIBankAccountInfo;
@class POLISHAPICurrencyRate;
@class POLISHAPINameAddress;
@class POLISHAPIPayer;
@class POLISHAPISenderRecipient;
@class POLISHAPISocialSecurityPayer;
@class POLISHAPITransactionInfoCard;
@class POLISHAPITransactionInfoTax;
@class POLISHAPITransactionInfoZus;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum POLISHAPIDeliveryMode

typedef GPB_ENUM(POLISHAPIDeliveryMode) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  POLISHAPIDeliveryMode_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  POLISHAPIDeliveryMode_InvalidDeliveryMode = 0,

  /** only applies to non-EEA destinations */
  POLISHAPIDeliveryMode_StandardD2 = 1,

  /** only applies to EEA destinations */
  POLISHAPIDeliveryMode_StandardD1 = 2,

  /** only applies to non-EEA destinations */
  POLISHAPIDeliveryMode_UrgentD1 = 3,

  /** applies to all destinations */
  POLISHAPIDeliveryMode_ExpressD0 = 4,
};

GPBEnumDescriptor *POLISHAPIDeliveryMode_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL POLISHAPIDeliveryMode_IsValidValue(int32_t value);

#pragma mark - Enum POLISHAPITypeOfRelation

typedef GPB_ENUM(POLISHAPITypeOfRelation) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  POLISHAPITypeOfRelation_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  POLISHAPITypeOfRelation_InvalidTypeOfRelation = 0,
  POLISHAPITypeOfRelation_Owner = 1,
  POLISHAPITypeOfRelation_Borrower = 2,
  POLISHAPITypeOfRelation_Guarantor = 3,
  POLISHAPITypeOfRelation_ProxyOwner = 4,
  POLISHAPITypeOfRelation_Beneficiary = 5,
  POLISHAPITypeOfRelation_Trustee = 6,
};

GPBEnumDescriptor *POLISHAPITypeOfRelation_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL POLISHAPITypeOfRelation_IsValidValue(int32_t value);

#pragma mark - Enum POLISHAPITypeOfProxy

typedef GPB_ENUM(POLISHAPITypeOfProxy) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  POLISHAPITypeOfProxy_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  POLISHAPITypeOfProxy_InvalidTypeOfProxy = 0,
  POLISHAPITypeOfProxy_General = 1,
  POLISHAPITypeOfProxy_Special = 2,
  POLISHAPITypeOfProxy_Administrator = 3,
  POLISHAPITypeOfProxy_User = 4,
};

GPBEnumDescriptor *POLISHAPITypeOfProxy_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL POLISHAPITypeOfProxy_IsValidValue(int32_t value);

#pragma mark - Enum POLISHAPIAccountHolderType

typedef GPB_ENUM(POLISHAPIAccountHolderType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  POLISHAPIAccountHolderType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  POLISHAPIAccountHolderType_InvalidAccountHolderType = 0,
  POLISHAPIAccountHolderType_Individual = 1,
  POLISHAPIAccountHolderType_Corporation = 2,
};

GPBEnumDescriptor *POLISHAPIAccountHolderType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL POLISHAPIAccountHolderType_IsValidValue(int32_t value);

#pragma mark - POLISHAPIPolishapiRoot

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
GPB_FINAL @interface POLISHAPIPolishapiRoot : GPBRootObject
@end

#pragma mark - POLISHAPIPolishApiAccountDetails

typedef GPB_ENUM(POLISHAPIPolishApiAccountDetails_FieldNumber) {
  POLISHAPIPolishApiAccountDetails_FieldNumber_NameAddress = 1,
  POLISHAPIPolishApiAccountDetails_FieldNumber_AccountHolderType = 2,
  POLISHAPIPolishApiAccountDetails_FieldNumber_AccountNameClient = 3,
  POLISHAPIPolishApiAccountDetails_FieldNumber_Currency = 4,
  POLISHAPIPolishApiAccountDetails_FieldNumber_Bank = 5,
  POLISHAPIPolishApiAccountDetails_FieldNumber_PsuRelationsArray = 6,
  POLISHAPIPolishApiAccountDetails_FieldNumber_AuxData = 7,
};

GPB_FINAL @interface POLISHAPIPolishApiAccountDetails : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPINameAddress *nameAddress;
/** Test to see if @c nameAddress has been set. */
@property(nonatomic, readwrite) BOOL hasNameAddress;

@property(nonatomic, readwrite) POLISHAPIAccountHolderType accountHolderType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNameClient;

@property(nonatomic, readwrite, copy, null_resettable) NSString *currency;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIBankAccountInfo *bank;
/** Test to see if @c bank has been set. */
@property(nonatomic, readwrite) BOOL hasBank;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<POLISHAPIAccountPsuRelation*> *psuRelationsArray;
/** The number of items in @c psuRelationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger psuRelationsArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *auxData;
/** The number of items in @c auxData without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger auxData_Count;

@end

/**
 * Fetches the raw value of a @c POLISHAPIPolishApiAccountDetails's @c accountHolderType property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t POLISHAPIPolishApiAccountDetails_AccountHolderType_RawValue(POLISHAPIPolishApiAccountDetails *message);
/**
 * Sets the raw value of an @c POLISHAPIPolishApiAccountDetails's @c accountHolderType property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPOLISHAPIPolishApiAccountDetails_AccountHolderType_RawValue(POLISHAPIPolishApiAccountDetails *message, int32_t value);

#pragma mark - POLISHAPIPolishApiTransactionDetails

typedef GPB_ENUM(POLISHAPIPolishApiTransactionDetails_FieldNumber) {
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TransactionType = 1,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_Mcc = 2,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_AuxData = 3,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_Initiator = 4,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_Sender = 5,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_Recipient = 6,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TradeDate = 7,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_PostTransactionBalance = 8,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_RejectionDate = 9,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_RejectionReason = 10,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_ZusInfo = 11,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TaxInfo = 12,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_CardInfo = 13,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_CurrencyDate = 14,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TransactionRateArray = 15,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_BaseCurrency = 16,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_AccountBaseCurrency = 17,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_UsedPaymentInstrumentId = 18,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TppTransactionId = 19,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_TppName = 20,
  POLISHAPIPolishApiTransactionDetails_FieldNumber_HoldExpirationDate = 21,
};

GPB_FINAL @interface POLISHAPIPolishApiTransactionDetails : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *transactionType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *mcc;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *auxData;
/** The number of items in @c auxData without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger auxData_Count;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPINameAddress *initiator;
/** Test to see if @c initiator has been set. */
@property(nonatomic, readwrite) BOOL hasInitiator;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPISenderRecipient *sender;
/** Test to see if @c sender has been set. */
@property(nonatomic, readwrite) BOOL hasSender;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPISenderRecipient *recipient;
/** Test to see if @c recipient has been set. */
@property(nonatomic, readwrite) BOOL hasRecipient;

@property(nonatomic, readwrite, copy, null_resettable) NSString *tradeDate;

@property(nonatomic, readwrite, copy, null_resettable) NSString *postTransactionBalance;

@property(nonatomic, readwrite, copy, null_resettable) NSString *rejectionDate;

@property(nonatomic, readwrite, copy, null_resettable) NSString *rejectionReason;

/** from Polish API getTransactionDetail endpoint */
@property(nonatomic, readwrite, strong, null_resettable) POLISHAPITransactionInfoZus *zusInfo;
/** Test to see if @c zusInfo has been set. */
@property(nonatomic, readwrite) BOOL hasZusInfo;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPITransactionInfoTax *taxInfo;
/** Test to see if @c taxInfo has been set. */
@property(nonatomic, readwrite) BOOL hasTaxInfo;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPITransactionInfoCard *cardInfo;
/** Test to see if @c cardInfo has been set. */
@property(nonatomic, readwrite) BOOL hasCardInfo;

@property(nonatomic, readwrite, copy, null_resettable) NSString *currencyDate;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<POLISHAPICurrencyRate*> *transactionRateArray;
/** The number of items in @c transactionRateArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger transactionRateArray_Count;

@property(nonatomic, readwrite, copy, null_resettable) NSString *baseCurrency;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountBaseCurrency;

@property(nonatomic, readwrite, copy, null_resettable) NSString *usedPaymentInstrumentId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *tppTransactionId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *tppName;

@property(nonatomic, readwrite, copy, null_resettable) NSString *holdExpirationDate;

@end

#pragma mark - POLISHAPIPolishApiTransferMetadata

typedef GPB_ENUM(POLISHAPIPolishApiTransferMetadata_FieldNumber) {
  POLISHAPIPolishApiTransferMetadata_FieldNumber_DeliveryMode = 1,
  POLISHAPIPolishApiTransferMetadata_FieldNumber_Hold = 2,
};

GPB_FINAL @interface POLISHAPIPolishApiTransferMetadata : GPBMessage

@property(nonatomic, readwrite) POLISHAPIDeliveryMode deliveryMode;

/** indicates that the funds should be reserved until the payment is executable (e.g. for Bank holidays) */
@property(nonatomic, readwrite) BOOL hold;

@end

/**
 * Fetches the raw value of a @c POLISHAPIPolishApiTransferMetadata's @c deliveryMode property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t POLISHAPIPolishApiTransferMetadata_DeliveryMode_RawValue(POLISHAPIPolishApiTransferMetadata *message);
/**
 * Sets the raw value of an @c POLISHAPIPolishApiTransferMetadata's @c deliveryMode property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPOLISHAPIPolishApiTransferMetadata_DeliveryMode_RawValue(POLISHAPIPolishApiTransferMetadata *message, int32_t value);

#pragma mark - POLISHAPISenderRecipient

typedef GPB_ENUM(POLISHAPISenderRecipient_FieldNumber) {
  POLISHAPISenderRecipient_FieldNumber_AccountNumber = 1,
  POLISHAPISenderRecipient_FieldNumber_AccountMassPayment = 2,
  POLISHAPISenderRecipient_FieldNumber_Bank = 3,
  POLISHAPISenderRecipient_FieldNumber_NameAddress = 4,
};

GPB_FINAL @interface POLISHAPISenderRecipient : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountMassPayment;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIBank *bank;
/** Test to see if @c bank has been set. */
@property(nonatomic, readwrite) BOOL hasBank;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPINameAddress *nameAddress;
/** Test to see if @c nameAddress has been set. */
@property(nonatomic, readwrite) BOOL hasNameAddress;

@end

#pragma mark - POLISHAPIAccountPsuRelation

typedef GPB_ENUM(POLISHAPIAccountPsuRelation_FieldNumber) {
  POLISHAPIAccountPsuRelation_FieldNumber_TypeOfRelation = 1,
  POLISHAPIAccountPsuRelation_FieldNumber_TypeOfProxy = 2,
  POLISHAPIAccountPsuRelation_FieldNumber_Stake = 3,
};

GPB_FINAL @interface POLISHAPIAccountPsuRelation : GPBMessage

@property(nonatomic, readwrite) POLISHAPITypeOfRelation typeOfRelation;

@property(nonatomic, readwrite) POLISHAPITypeOfProxy typeOfProxy;

@property(nonatomic, readwrite) int32_t stake;

@end

/**
 * Fetches the raw value of a @c POLISHAPIAccountPsuRelation's @c typeOfRelation property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t POLISHAPIAccountPsuRelation_TypeOfRelation_RawValue(POLISHAPIAccountPsuRelation *message);
/**
 * Sets the raw value of an @c POLISHAPIAccountPsuRelation's @c typeOfRelation property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPOLISHAPIAccountPsuRelation_TypeOfRelation_RawValue(POLISHAPIAccountPsuRelation *message, int32_t value);

/**
 * Fetches the raw value of a @c POLISHAPIAccountPsuRelation's @c typeOfProxy property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t POLISHAPIAccountPsuRelation_TypeOfProxy_RawValue(POLISHAPIAccountPsuRelation *message);
/**
 * Sets the raw value of an @c POLISHAPIAccountPsuRelation's @c typeOfProxy property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetPOLISHAPIAccountPsuRelation_TypeOfProxy_RawValue(POLISHAPIAccountPsuRelation *message, int32_t value);

#pragma mark - POLISHAPINameAddress

typedef GPB_ENUM(POLISHAPINameAddress_FieldNumber) {
  POLISHAPINameAddress_FieldNumber_ValueArray = 1,
};

GPB_FINAL @interface POLISHAPINameAddress : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *valueArray;
/** The number of items in @c valueArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger valueArray_Count;

@end

#pragma mark - POLISHAPIBankAccountInfo

typedef GPB_ENUM(POLISHAPIBankAccountInfo_FieldNumber) {
  POLISHAPIBankAccountInfo_FieldNumber_BicOrSwift = 1,
  POLISHAPIBankAccountInfo_FieldNumber_Name = 2,
  POLISHAPIBankAccountInfo_FieldNumber_AddressArray = 3,
};

GPB_FINAL @interface POLISHAPIBankAccountInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bicOrSwift;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *addressArray;
/** The number of items in @c addressArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger addressArray_Count;

@end

#pragma mark - POLISHAPIBank

typedef GPB_ENUM(POLISHAPIBank_FieldNumber) {
  POLISHAPIBank_FieldNumber_BicOrSwift = 1,
  POLISHAPIBank_FieldNumber_Name = 2,
  POLISHAPIBank_FieldNumber_Code = 3,
  POLISHAPIBank_FieldNumber_CountryCode = 4,
  POLISHAPIBank_FieldNumber_AddressArray = 5,
};

GPB_FINAL @interface POLISHAPIBank : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bicOrSwift;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *code;

@property(nonatomic, readwrite, copy, null_resettable) NSString *countryCode;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *addressArray;
/** The number of items in @c addressArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger addressArray_Count;

@end

#pragma mark - POLISHAPITransactionInfoZus

typedef GPB_ENUM(POLISHAPITransactionInfoZus_FieldNumber) {
  POLISHAPITransactionInfoZus_FieldNumber_PayerInfo = 1,
  POLISHAPITransactionInfoZus_FieldNumber_ContributionType = 2,
  POLISHAPITransactionInfoZus_FieldNumber_ContributionId = 3,
  POLISHAPITransactionInfoZus_FieldNumber_ContributionPeriod = 4,
  POLISHAPITransactionInfoZus_FieldNumber_PaymentTypeId = 5,
  POLISHAPITransactionInfoZus_FieldNumber_ObligationId = 6,
};

GPB_FINAL @interface POLISHAPITransactionInfoZus : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPISocialSecurityPayer *payerInfo;
/** Test to see if @c payerInfo has been set. */
@property(nonatomic, readwrite) BOOL hasPayerInfo;

@property(nonatomic, readwrite, copy, null_resettable) NSString *contributionType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *contributionId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *contributionPeriod;

@property(nonatomic, readwrite, copy, null_resettable) NSString *paymentTypeId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *obligationId;

@end

#pragma mark - POLISHAPITransactionInfoTax

typedef GPB_ENUM(POLISHAPITransactionInfoTax_FieldNumber) {
  POLISHAPITransactionInfoTax_FieldNumber_PayerInfo = 1,
  POLISHAPITransactionInfoTax_FieldNumber_FormCode = 2,
  POLISHAPITransactionInfoTax_FieldNumber_PeriodId = 3,
  POLISHAPITransactionInfoTax_FieldNumber_PeriodType = 4,
  POLISHAPITransactionInfoTax_FieldNumber_Year = 5,
  POLISHAPITransactionInfoTax_FieldNumber_ObligationId = 6,
};

GPB_FINAL @interface POLISHAPITransactionInfoTax : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPayer *payerInfo;
/** Test to see if @c payerInfo has been set. */
@property(nonatomic, readwrite) BOOL hasPayerInfo;

@property(nonatomic, readwrite, copy, null_resettable) NSString *formCode;

@property(nonatomic, readwrite, copy, null_resettable) NSString *periodId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *periodType;

@property(nonatomic, readwrite) int32_t year;

@property(nonatomic, readwrite, copy, null_resettable) NSString *obligationId;

@end

#pragma mark - POLISHAPITransactionInfoCard

typedef GPB_ENUM(POLISHAPITransactionInfoCard_FieldNumber) {
  POLISHAPITransactionInfoCard_FieldNumber_CardHolder = 1,
  POLISHAPITransactionInfoCard_FieldNumber_CardNumber = 2,
};

GPB_FINAL @interface POLISHAPITransactionInfoCard : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *cardHolder;

@property(nonatomic, readwrite, copy, null_resettable) NSString *cardNumber;

@end

#pragma mark - POLISHAPISocialSecurityPayer

typedef GPB_ENUM(POLISHAPISocialSecurityPayer_FieldNumber) {
  POLISHAPISocialSecurityPayer_FieldNumber_Nip = 1,
  POLISHAPISocialSecurityPayer_FieldNumber_AdditionalPayerId = 2,
  POLISHAPISocialSecurityPayer_FieldNumber_AdditionalPayerIdType = 3,
};

GPB_FINAL @interface POLISHAPISocialSecurityPayer : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *nip;

@property(nonatomic, readwrite, copy, null_resettable) NSString *additionalPayerId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *additionalPayerIdType;

@end

#pragma mark - POLISHAPIPayer

typedef GPB_ENUM(POLISHAPIPayer_FieldNumber) {
  POLISHAPIPayer_FieldNumber_PayerId = 1,
  POLISHAPIPayer_FieldNumber_PayerIdType = 2,
};

GPB_FINAL @interface POLISHAPIPayer : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *payerId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *payerIdType;

@end

#pragma mark - POLISHAPICurrencyRate

typedef GPB_ENUM(POLISHAPICurrencyRate_FieldNumber) {
  POLISHAPICurrencyRate_FieldNumber_Rate = 1,
  POLISHAPICurrencyRate_FieldNumber_FromCurrency = 2,
  POLISHAPICurrencyRate_FieldNumber_ToCurrency = 3,
};

GPB_FINAL @interface POLISHAPICurrencyRate : GPBMessage

@property(nonatomic, readwrite) double rate;

@property(nonatomic, readwrite, copy, null_resettable) NSString *fromCurrency;

@property(nonatomic, readwrite, copy, null_resettable) NSString *toCurrency;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
