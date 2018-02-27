// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: account.proto

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

@class AccountFeatures;
@class AccountTag;
@class BankAccount;
@class BankAccount_Ach;
@class BankAccount_Bank;
@class BankAccount_FasterPayments;
@class BankAccount_Sepa;
@class BankAccount_Swift;
@class BankAccount_Token;
@class BankAccount_TokenAuthorization;
@class BankAuthorization;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - AccountRoot

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
@interface AccountRoot : GPBRootObject
@end

#pragma mark - PlaintextBankAuthorization

typedef GPB_ENUM(PlaintextBankAuthorization_FieldNumber) {
  PlaintextBankAuthorization_FieldNumber_MemberId = 1,
  PlaintextBankAuthorization_FieldNumber_AccountName = 2,
  PlaintextBankAuthorization_FieldNumber_Account = 3,
  PlaintextBankAuthorization_FieldNumber_ExpirationMs = 4,
};

/**
 * The payload of the bank authorization request.
 * The value of the payload is encrypted as a serialized JSON object
 * in a BankAuthorization.
 * as described at https://developer.token.io/bank-integration/
 **/
@interface PlaintextBankAuthorization : GPBMessage

/** Token member id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

/** e.g., "Checking account with # ending 5678" */
@property(nonatomic, readwrite, copy, null_resettable) NSString *accountName;

/** Account info by some method, e.g., SEPA */
@property(nonatomic, readwrite, strong, null_resettable) BankAccount *account;
/** Test to see if @c account has been set. */
@property(nonatomic, readwrite) BOOL hasAccount;

/** Expiration time */
@property(nonatomic, readwrite) int64_t expirationMs;

@end

#pragma mark - AccountTag

typedef GPB_ENUM(AccountTag_FieldNumber) {
  AccountTag_FieldNumber_Key = 1,
  AccountTag_FieldNumber_Value = 2,
};

/**
 * Optional account tag data.
 **/
@interface AccountTag : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *key;

@property(nonatomic, readwrite, copy, null_resettable) NSString *value;

@end

#pragma mark - AccountFeatures

typedef GPB_ENUM(AccountFeatures_FieldNumber) {
  AccountFeatures_FieldNumber_SupportsPayment = 1,
  AccountFeatures_FieldNumber_SupportsInformation = 2,
  AccountFeatures_FieldNumber_RequiresExternalAuth = 3,
  AccountFeatures_FieldNumber_SupportsSendPayment = 4,
  AccountFeatures_FieldNumber_SupportsReceivePayment = 5,
};

/**
 * Not all accounts support all Token features.
 **/
@interface AccountFeatures : GPBMessage

/** **DEPRECATED** can both send and receive payments */
@property(nonatomic, readwrite) BOOL supportsPayment;

/** can get info, e.g., get balance */
@property(nonatomic, readwrite) BOOL supportsInformation;

@property(nonatomic, readwrite) BOOL requiresExternalAuth;

/** can send payments from account */
@property(nonatomic, readwrite) BOOL supportsSendPayment;

/** can receive payments to account */
@property(nonatomic, readwrite) BOOL supportsReceivePayment;

@end

#pragma mark - Account

typedef GPB_ENUM(Account_FieldNumber) {
  Account_FieldNumber_Id_p = 1,
  Account_FieldNumber_Name = 2,
  Account_FieldNumber_BankId = 3,
  Account_FieldNumber_TagsArray = 4,
  Account_FieldNumber_IsLocked = 5,
  Account_FieldNumber_AccountFeatures = 6,
};

/**
 * Token linked account.
 **/
@interface Account : GPBMessage

/** account ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** human-friendly name. E.g., "Checking account with number ...1234" */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/** bank ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<AccountTag*> *tagsArray;
/** The number of items in @c tagsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger tagsArray_Count;

/** indicates whether account requires re-linking (perhaps after member recovery) */
@property(nonatomic, readwrite) BOOL isLocked;

/** features account supports */
@property(nonatomic, readwrite, strong, null_resettable) AccountFeatures *accountFeatures;
/** Test to see if @c accountFeatures has been set. */
@property(nonatomic, readwrite) BOOL hasAccountFeatures;

@end

#pragma mark - BankAccount

typedef GPB_ENUM(BankAccount_FieldNumber) {
  BankAccount_FieldNumber_Token = 1,
  BankAccount_FieldNumber_TokenAuthorization = 2,
  BankAccount_FieldNumber_Swift = 3,
  BankAccount_FieldNumber_Sepa = 4,
  BankAccount_FieldNumber_Ach = 5,
  BankAccount_FieldNumber_Bank = 6,
  BankAccount_FieldNumber_Metadata = 7,
  BankAccount_FieldNumber_AccountFeatures = 8,
  BankAccount_FieldNumber_FasterPayments = 9,
};

typedef GPB_ENUM(BankAccount_Account_OneOfCase) {
  BankAccount_Account_OneOfCase_GPBUnsetOneOfCase = 0,
  BankAccount_Account_OneOfCase_Token = 1,
  BankAccount_Account_OneOfCase_TokenAuthorization = 2,
  BankAccount_Account_OneOfCase_Swift = 3,
  BankAccount_Account_OneOfCase_Sepa = 4,
  BankAccount_Account_OneOfCase_Ach = 5,
  BankAccount_Account_OneOfCase_Bank = 6,
  BankAccount_Account_OneOfCase_FasterPayments = 9,
};

/**
 * Account information. This is what the end user links with
 * the bank and what Token uses when it talks to the bank.
 * It's also part of the source or destination for a transfer.
 **/
@interface BankAccount : GPBMessage

@property(nonatomic, readonly) BankAccount_Account_OneOfCase accountOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_Token *token;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_TokenAuthorization *tokenAuthorization;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_Swift *swift;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_Sepa *sepa;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_Ach *ach;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_Bank *bank;

@property(nonatomic, readwrite, strong, null_resettable) BankAccount_FasterPayments *fasterPayments;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *metadata;
/** The number of items in @c metadata without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger metadata_Count;

@property(nonatomic, readwrite, strong, null_resettable) AccountFeatures *accountFeatures;
/** Test to see if @c accountFeatures has been set. */
@property(nonatomic, readwrite) BOOL hasAccountFeatures;

@end

/**
 * Clears whatever value was set for the oneof 'account'.
 **/
void BankAccount_ClearAccountOneOfCase(BankAccount *message);

#pragma mark - BankAccount_Token

typedef GPB_ENUM(BankAccount_Token_FieldNumber) {
  BankAccount_Token_FieldNumber_MemberId = 1,
  BankAccount_Token_FieldNumber_AccountId = 2,
};

/**
 * Token account Destination. Useful as source or destination
 * for a transfer; doesn't make sense for a bank to "link" this.
 **/
@interface BankAccount_Token : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountId;

@end

#pragma mark - BankAccount_TokenAuthorization

typedef GPB_ENUM(BankAccount_TokenAuthorization_FieldNumber) {
  BankAccount_TokenAuthorization_FieldNumber_Authorization = 1,
};

/**
 * One-time encrypted authorization for an account
 **/
@interface BankAccount_TokenAuthorization : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) BankAuthorization *authorization;
/** Test to see if @c authorization has been set. */
@property(nonatomic, readwrite) BOOL hasAuthorization;

@end

#pragma mark - BankAccount_Bank

typedef GPB_ENUM(BankAccount_Bank_FieldNumber) {
  BankAccount_Bank_FieldNumber_BankId = 1,
};

/**
 * Source account managed by a coop bank
 **/
@interface BankAccount_Bank : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *bankId;

@end

#pragma mark - BankAccount_Swift

typedef GPB_ENUM(BankAccount_Swift_FieldNumber) {
  BankAccount_Swift_FieldNumber_Bic = 1,
  BankAccount_Swift_FieldNumber_Account = 2,
};

/**
 * SWIFT transfer
 **/
@interface BankAccount_Swift : GPBMessage

/** BIC code AAAABBCCDD */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - BankAccount_Sepa

typedef GPB_ENUM(BankAccount_Sepa_FieldNumber) {
  BankAccount_Sepa_FieldNumber_Iban = 1,
  BankAccount_Sepa_FieldNumber_Bic = 2,
};

/**
 * SEPA transfer.
 **/
@interface BankAccount_Sepa : GPBMessage

/** International Bank Account Number */
@property(nonatomic, readwrite, copy, null_resettable) NSString *iban;

/** Bic code. Optional, except for non EEA countries */
@property(nonatomic, readwrite, copy, null_resettable) NSString *bic;

@end

#pragma mark - BankAccount_Ach

typedef GPB_ENUM(BankAccount_Ach_FieldNumber) {
  BankAccount_Ach_FieldNumber_Routing = 1,
  BankAccount_Ach_FieldNumber_Account = 2,
};

/**
 * ACH transfer
 **/
@interface BankAccount_Ach : GPBMessage

/** Routing number */
@property(nonatomic, readwrite, copy, null_resettable) NSString *routing;

@property(nonatomic, readwrite, copy, null_resettable) NSString *account;

@end

#pragma mark - BankAccount_FasterPayments

typedef GPB_ENUM(BankAccount_FasterPayments_FieldNumber) {
  BankAccount_FasterPayments_FieldNumber_SortCode = 1,
  BankAccount_FasterPayments_FieldNumber_AccountNumber = 2,
};

/**
 * Faster Payments Service transfer (UK)
 **/
@interface BankAccount_FasterPayments : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *sortCode;

@property(nonatomic, readwrite, copy, null_resettable) NSString *accountNumber;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
