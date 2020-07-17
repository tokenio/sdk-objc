// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: member.proto

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

@class Address;
@class Alias;
@class Key;
@class MemberAddKeyOperation;
@class MemberAliasOperation;
@class MemberDeleteOperation;
@class MemberOperation;
@class MemberOperationMetadata_AddAliasMetadata;
@class MemberOperationMetadata_AddKeyMetadata;
@class MemberOperationResponseMetadata_AddAliasResponseMetadata;
@class MemberPartnerOperation;
@class MemberRealmPermissionOperation;
@class MemberRecoveryOperation;
@class MemberRecoveryOperation_Authorization;
@class MemberRecoveryRulesOperation;
@class MemberRemoveKeyOperation;
@class RecoveryRule;
@class Signature;
@class TrustedBeneficiary_Payload;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum ProfilePictureSize

/** Profile picture sizes */
typedef GPB_ENUM(ProfilePictureSize) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  ProfilePictureSize_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  ProfilePictureSize_Invalid = 0,

  /** same size as uploaded */
  ProfilePictureSize_Original = 1,

  /** 200x200 */
  ProfilePictureSize_Small = 2,

  /** 600x600 */
  ProfilePictureSize_Medium = 3,
  ProfilePictureSize_Large = 4,
};

GPBEnumDescriptor *ProfilePictureSize_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ProfilePictureSize_IsValidValue(int32_t value);

#pragma mark - Enum CreateMemberType

typedef GPB_ENUM(CreateMemberType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  CreateMemberType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  CreateMemberType_InvalidMemberType = 0,
  CreateMemberType_Personal = 1,
  CreateMemberType_Business = 2,
  CreateMemberType_Transient = 3,
};

GPBEnumDescriptor *CreateMemberType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL CreateMemberType_IsValidValue(int32_t value);

#pragma mark - Enum RealmPermission

typedef GPB_ENUM(RealmPermission) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  RealmPermission_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  RealmPermission_InvalidRealmPermission = 0,
  RealmPermission_VerifyAlias = 1,
  RealmPermission_AddAlias = 2,
  RealmPermission_RemoveAlias = 3,
  RealmPermission_AddKey = 4,
  RealmPermission_RemoveKey = 5,
};

GPBEnumDescriptor *RealmPermission_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL RealmPermission_IsValidValue(int32_t value);

#pragma mark - Enum Member_MemberType

typedef GPB_ENUM(Member_MemberType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  Member_MemberType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Member_MemberType_InvalidMemberType = 0,
  Member_MemberType_Personal = 1,
  Member_MemberType_BusinessUnverified = 2,
  Member_MemberType_BusinessVerified = 3,
  Member_MemberType_Transient = 4,
};

GPBEnumDescriptor *Member_MemberType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL Member_MemberType_IsValidValue(int32_t value);

#pragma mark - Enum ReceiptContact_Type

typedef GPB_ENUM(ReceiptContact_Type) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  ReceiptContact_Type_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  ReceiptContact_Type_Invalid = 0,
  ReceiptContact_Type_Email = 1,
};

GPBEnumDescriptor *ReceiptContact_Type_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ReceiptContact_Type_IsValidValue(int32_t value);

#pragma mark - MemberRoot

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
GPB_FINAL @interface MemberRoot : GPBRootObject
@end

#pragma mark - MemberAddKeyOperation

typedef GPB_ENUM(MemberAddKeyOperation_FieldNumber) {
  MemberAddKeyOperation_FieldNumber_Key = 1,
};

/**
 * Adds member key to the directory.
 **/
GPB_FINAL @interface MemberAddKeyOperation : GPBMessage

/** Key to add */
@property(nonatomic, readwrite, strong, null_resettable) Key *key;
/** Test to see if @c key has been set. */
@property(nonatomic, readwrite) BOOL hasKey;

@end

#pragma mark - MemberRemoveKeyOperation

typedef GPB_ENUM(MemberRemoveKeyOperation_FieldNumber) {
  MemberRemoveKeyOperation_FieldNumber_KeyId = 1,
};

/**
 * Removes member key from the directory.
 **/
GPB_FINAL @interface MemberRemoveKeyOperation : GPBMessage

/** ID of key to remove */
@property(nonatomic, readwrite, copy, null_resettable) NSString *keyId;

@end

#pragma mark - MemberAliasOperation

typedef GPB_ENUM(MemberAliasOperation_FieldNumber) {
  MemberAliasOperation_FieldNumber_AliasHash = 1,
  MemberAliasOperation_FieldNumber_Realm = 2,
  MemberAliasOperation_FieldNumber_RealmId = 3,
};

/**
 * Adds/removes member alias to/from the directory.
 **/
GPB_FINAL @interface MemberAliasOperation : GPBMessage

/**
 * Hash of alias to add/remove
 * https://developer.token.io/sdk/esdoc/class/src/Util.js~Util.html#static-method-hashAndSerializeAlias
 **/
@property(nonatomic, readwrite, copy, null_resettable) NSString *aliasHash;

/** Realm of alias to add/remove */
@property(nonatomic, readwrite, copy, null_resettable) NSString *realm GPB_DEPRECATED_MSG("io.token.proto.common.member.MemberAliasOperation.realm is deprecated (see member.proto).");

@property(nonatomic, readwrite, copy, null_resettable) NSString *realmId;

@end

#pragma mark - MemberRecoveryRulesOperation

typedef GPB_ENUM(MemberRecoveryRulesOperation_FieldNumber) {
  MemberRecoveryRulesOperation_FieldNumber_RecoveryRule = 1,
};

/**
 * Sets recovery rules for member. Overrides all previously set rules.
 * https://developer.token.io/sdk/?java#recovery-rules
 **/
GPB_FINAL @interface MemberRecoveryRulesOperation : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) RecoveryRule *recoveryRule;
/** Test to see if @c recoveryRule has been set. */
@property(nonatomic, readwrite) BOOL hasRecoveryRule;

@end

#pragma mark - MemberRecoveryOperation

typedef GPB_ENUM(MemberRecoveryOperation_FieldNumber) {
  MemberRecoveryOperation_FieldNumber_Authorization = 1,
  MemberRecoveryOperation_FieldNumber_AgentSignature = 2,
};

/**
 * Provides an agent signature authorizing the recovery operation. Multiple authorizations
 * might be required in order to initiate the recovery process.  The number of required signatures
 * is governed by Recovery Rules associated with the member.
 **/
GPB_FINAL @interface MemberRecoveryOperation : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryOperation_Authorization *authorization;
/** Test to see if @c authorization has been set. */
@property(nonatomic, readwrite) BOOL hasAuthorization;

/**
 * Java SDK Member.authorizeRecovery can generate signature
 * https://developer.token.io/sdk/javadoc/io/token/Member.html#authorizeRecovery-io.token.proto.common.member.MemberProtos.MemberRecoveryOperation.Authorization-
 **/
@property(nonatomic, readwrite, strong, null_resettable) Signature *agentSignature;
/** Test to see if @c agentSignature has been set. */
@property(nonatomic, readwrite) BOOL hasAgentSignature;

@end

#pragma mark - MemberRecoveryOperation_Authorization

typedef GPB_ENUM(MemberRecoveryOperation_Authorization_FieldNumber) {
  MemberRecoveryOperation_Authorization_FieldNumber_MemberId = 1,
  MemberRecoveryOperation_Authorization_FieldNumber_PrevHash = 2,
  MemberRecoveryOperation_Authorization_FieldNumber_MemberKey = 3,
};

GPB_FINAL @interface MemberRecoveryOperation_Authorization : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *prevHash;

@property(nonatomic, readwrite, strong, null_resettable) Key *memberKey;
/** Test to see if @c memberKey has been set. */
@property(nonatomic, readwrite) BOOL hasMemberKey;

@end

#pragma mark - MemberDeleteOperation

GPB_FINAL @interface MemberDeleteOperation : GPBMessage

@end

#pragma mark - MemberPartnerOperation

GPB_FINAL @interface MemberPartnerOperation : GPBMessage

@end

#pragma mark - MemberRealmPermissionOperation

typedef GPB_ENUM(MemberRealmPermissionOperation_FieldNumber) {
  MemberRealmPermissionOperation_FieldNumber_PermissionsArray = 1,
};

GPB_FINAL @interface MemberRealmPermissionOperation : GPBMessage

// |permissionsArray| contains |RealmPermission|
@property(nonatomic, readwrite, strong, null_resettable) GPBEnumArray *permissionsArray;
/** The number of items in @c permissionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger permissionsArray_Count;

@end

#pragma mark - MemberOperation

typedef GPB_ENUM(MemberOperation_FieldNumber) {
  MemberOperation_FieldNumber_AddKey = 1,
  MemberOperation_FieldNumber_RemoveKey = 2,
  MemberOperation_FieldNumber_RemoveAlias = 4,
  MemberOperation_FieldNumber_AddAlias = 5,
  MemberOperation_FieldNumber_VerifyAlias = 6,
  MemberOperation_FieldNumber_RecoveryRules = 7,
  MemberOperation_FieldNumber_Recover = 8,
  MemberOperation_FieldNumber_Delete_p = 9,
  MemberOperation_FieldNumber_VerifyPartner = 10,
  MemberOperation_FieldNumber_UnverifyPartner = 11,
  MemberOperation_FieldNumber_RealmPermissions = 12,
};

typedef GPB_ENUM(MemberOperation_Operation_OneOfCase) {
  MemberOperation_Operation_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperation_Operation_OneOfCase_AddKey = 1,
  MemberOperation_Operation_OneOfCase_RemoveKey = 2,
  MemberOperation_Operation_OneOfCase_RemoveAlias = 4,
  MemberOperation_Operation_OneOfCase_AddAlias = 5,
  MemberOperation_Operation_OneOfCase_VerifyAlias = 6,
  MemberOperation_Operation_OneOfCase_RecoveryRules = 7,
  MemberOperation_Operation_OneOfCase_Recover = 8,
  MemberOperation_Operation_OneOfCase_Delete_p = 9,
  MemberOperation_Operation_OneOfCase_VerifyPartner = 10,
  MemberOperation_Operation_OneOfCase_UnverifyPartner = 11,
  MemberOperation_Operation_OneOfCase_RealmPermissions = 12,
};

GPB_FINAL @interface MemberOperation : GPBMessage

@property(nonatomic, readonly) MemberOperation_Operation_OneOfCase operationOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberAddKeyOperation *addKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberRemoveKeyOperation *removeKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *removeAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *addAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *verifyAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryRulesOperation *recoveryRules;

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryOperation *recover;

@property(nonatomic, readwrite, strong, null_resettable) MemberDeleteOperation *delete_p;

@property(nonatomic, readwrite, strong, null_resettable) MemberPartnerOperation *verifyPartner;

@property(nonatomic, readwrite, strong, null_resettable) MemberPartnerOperation *unverifyPartner;

@property(nonatomic, readwrite, strong, null_resettable) MemberRealmPermissionOperation *realmPermissions;

@end

/**
 * Clears whatever value was set for the oneof 'operation'.
 **/
void MemberOperation_ClearOperationOneOfCase(MemberOperation *message);

#pragma mark - MemberUpdate

typedef GPB_ENUM(MemberUpdate_FieldNumber) {
  MemberUpdate_FieldNumber_PrevHash = 1,
  MemberUpdate_FieldNumber_MemberId = 2,
  MemberUpdate_FieldNumber_OperationsArray = 3,
};

/**
 * Updates member information in the directory. The directory is append only
 * log of operations.
 **/
GPB_FINAL @interface MemberUpdate : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *prevHash;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<MemberOperation*> *operationsArray;
/** The number of items in @c operationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger operationsArray_Count;

@end

#pragma mark - MemberOperationMetadata

typedef GPB_ENUM(MemberOperationMetadata_FieldNumber) {
  MemberOperationMetadata_FieldNumber_AddAliasMetadata = 1,
  MemberOperationMetadata_FieldNumber_AddKeyMetadata = 2,
};

typedef GPB_ENUM(MemberOperationMetadata_Type_OneOfCase) {
  MemberOperationMetadata_Type_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperationMetadata_Type_OneOfCase_AddAliasMetadata = 1,
  MemberOperationMetadata_Type_OneOfCase_AddKeyMetadata = 2,
};

/**
 * Metadata associated with MemberUpdate.
 * It is outside of MemberUpdate because MemberUpdate is signed and passed to the Directory.
 **/
GPB_FINAL @interface MemberOperationMetadata : GPBMessage

@property(nonatomic, readonly) MemberOperationMetadata_Type_OneOfCase typeOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberOperationMetadata_AddAliasMetadata *addAliasMetadata;

@property(nonatomic, readwrite, strong, null_resettable) MemberOperationMetadata_AddKeyMetadata *addKeyMetadata;

@end

/**
 * Clears whatever value was set for the oneof 'type'.
 **/
void MemberOperationMetadata_ClearTypeOneOfCase(MemberOperationMetadata *message);

#pragma mark - MemberOperationMetadata_AddAliasMetadata

typedef GPB_ENUM(MemberOperationMetadata_AddAliasMetadata_FieldNumber) {
  MemberOperationMetadata_AddAliasMetadata_FieldNumber_AliasHash = 1,
  MemberOperationMetadata_AddAliasMetadata_FieldNumber_Alias = 2,
};

GPB_FINAL @interface MemberOperationMetadata_AddAliasMetadata : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *aliasHash;

@property(nonatomic, readwrite, strong, null_resettable) Alias *alias;
/** Test to see if @c alias has been set. */
@property(nonatomic, readwrite) BOOL hasAlias;

@end

#pragma mark - MemberOperationMetadata_AddKeyMetadata

typedef GPB_ENUM(MemberOperationMetadata_AddKeyMetadata_FieldNumber) {
  MemberOperationMetadata_AddKeyMetadata_FieldNumber_KeychainId = 1,
};

GPB_FINAL @interface MemberOperationMetadata_AddKeyMetadata : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *keychainId;

@end

#pragma mark - MemberOperationResponseMetadata

typedef GPB_ENUM(MemberOperationResponseMetadata_FieldNumber) {
  MemberOperationResponseMetadata_FieldNumber_AddAliasResponseMetadata = 1,
};

typedef GPB_ENUM(MemberOperationResponseMetadata_Type_OneOfCase) {
  MemberOperationResponseMetadata_Type_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperationResponseMetadata_Type_OneOfCase_AddAliasResponseMetadata = 1,
};

/**
 * Metadata associated with MemberUpdateResponse.
 **/
GPB_FINAL @interface MemberOperationResponseMetadata : GPBMessage

@property(nonatomic, readonly) MemberOperationResponseMetadata_Type_OneOfCase typeOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberOperationResponseMetadata_AddAliasResponseMetadata *addAliasResponseMetadata;

@end

/**
 * Clears whatever value was set for the oneof 'type'.
 **/
void MemberOperationResponseMetadata_ClearTypeOneOfCase(MemberOperationResponseMetadata *message);

#pragma mark - MemberOperationResponseMetadata_AddAliasResponseMetadata

typedef GPB_ENUM(MemberOperationResponseMetadata_AddAliasResponseMetadata_FieldNumber) {
  MemberOperationResponseMetadata_AddAliasResponseMetadata_FieldNumber_AliasHash = 1,
  MemberOperationResponseMetadata_AddAliasResponseMetadata_FieldNumber_VerificationId = 2,
};

GPB_FINAL @interface MemberOperationResponseMetadata_AddAliasResponseMetadata : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *aliasHash;

@property(nonatomic, readwrite, copy, null_resettable) NSString *verificationId;

@end

#pragma mark - RecoveryRule

typedef GPB_ENUM(RecoveryRule_FieldNumber) {
  RecoveryRule_FieldNumber_PrimaryAgent = 1,
  RecoveryRule_FieldNumber_SecondaryAgentsArray = 2,
};

/**
 * A recovery rule specifies which signatures are required for a member reset operation.
 **/
GPB_FINAL @interface RecoveryRule : GPBMessage

/** the member id of the primary agent */
@property(nonatomic, readwrite, copy, null_resettable) NSString *primaryAgent;

/** an optional list of member ids acting as secondary agents */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *secondaryAgentsArray;
/** The number of items in @c secondaryAgentsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger secondaryAgentsArray_Count;

@end

#pragma mark - Member

typedef GPB_ENUM(Member_FieldNumber) {
  Member_FieldNumber_Id_p = 1,
  Member_FieldNumber_LastHash = 2,
  Member_FieldNumber_AliasHashesArray = 3,
  Member_FieldNumber_KeysArray = 4,
  Member_FieldNumber_UnverifiedAliasHashesArray = 5,
  Member_FieldNumber_RecoveryRule = 6,
  Member_FieldNumber_LastRecoverySequence = 7,
  Member_FieldNumber_LastOperationSequence = 8,
  Member_FieldNumber_Type = 9,
  Member_FieldNumber_PartnerId = 10,
  Member_FieldNumber_IsVerifiedPartner = 11,
  Member_FieldNumber_RealmId = 12,
  Member_FieldNumber_RealmPermissionsArray = 13,
};

/**
 * A member record that is computed by replaying all the member updates.
 **/
GPB_FINAL @interface Member : GPBMessage

/** member ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** last hash; used with UpdateMember */
@property(nonatomic, readwrite, copy, null_resettable) NSString *lastHash;

/** hashes of verified aliases */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *aliasHashesArray;
/** The number of items in @c aliasHashesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger aliasHashesArray_Count;

/** public keys */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Key*> *keysArray;
/** The number of items in @c keysArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger keysArray_Count;

/** hashes of unverified aliases */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *unverifiedAliasHashesArray;
/** The number of items in @c unverifiedAliasHashesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger unverifiedAliasHashesArray_Count;

/** recovery rule */
@property(nonatomic, readwrite, strong, null_resettable) RecoveryRule *recoveryRule;
/** Test to see if @c recoveryRule has been set. */
@property(nonatomic, readwrite) BOOL hasRecoveryRule;

/** sequence number for member's last recovery entry */
@property(nonatomic, readwrite) int32_t lastRecoverySequence;

/** sequence number for member's last operation */
@property(nonatomic, readwrite) int32_t lastOperationSequence;

/** type of member */
@property(nonatomic, readwrite) Member_MemberType type;

/** affiliated partner id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *partnerId;

/** indicates if member is verified partner */
@property(nonatomic, readwrite) BOOL isVerifiedPartner;

/** realm owner member id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *realmId;

/** realm permissions assigned; Used to verify MemberOperations that this member can perform as realm owner. */
// |realmPermissionsArray| contains |RealmPermission|
@property(nonatomic, readwrite, strong, null_resettable) GPBEnumArray *realmPermissionsArray;
/** The number of items in @c realmPermissionsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger realmPermissionsArray_Count;

@end

/**
 * Fetches the raw value of a @c Member's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t Member_Type_RawValue(Member *message);
/**
 * Sets the raw value of an @c Member's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetMember_Type_RawValue(Member *message, int32_t value);

#pragma mark - AddressRecord

typedef GPB_ENUM(AddressRecord_FieldNumber) {
  AddressRecord_FieldNumber_Id_p = 1,
  AddressRecord_FieldNumber_Name = 2,
  AddressRecord_FieldNumber_Address = 3,
  AddressRecord_FieldNumber_AddressSignature = 4,
};

/**
 * A member address record
 **/
GPB_FINAL @interface AddressRecord : GPBMessage

/** Address id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** The display name of the address, e.g., "Office" */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/** Country specific JSON address */
@property(nonatomic, readwrite, strong, null_resettable) Address *address;
/** Test to see if @c address has been set. */
@property(nonatomic, readwrite) BOOL hasAddress;

/** member signature of the address */
@property(nonatomic, readwrite, strong, null_resettable) Signature *addressSignature;
/** Test to see if @c addressSignature has been set. */
@property(nonatomic, readwrite) BOOL hasAddressSignature;

@end

#pragma mark - Profile

typedef GPB_ENUM(Profile_FieldNumber) {
  Profile_FieldNumber_DisplayNameFirst = 1,
  Profile_FieldNumber_DisplayNameLast = 2,
  Profile_FieldNumber_OriginalPictureId = 3,
  Profile_FieldNumber_SmallPictureId = 4,
  Profile_FieldNumber_MediumPictureId = 5,
  Profile_FieldNumber_LargePictureId = 6,
};

/**
 * Public profile
 **/
GPB_FINAL @interface Profile : GPBMessage

/** first name */
@property(nonatomic, readwrite, copy, null_resettable) NSString *displayNameFirst;

/** last name */
@property(nonatomic, readwrite, copy, null_resettable) NSString *displayNameLast;

/** blob ID. Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *originalPictureId;

/** blob ID. Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *smallPictureId;

/** blob ID. Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mediumPictureId;

/** blob ID. Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *largePictureId;

@end

#pragma mark - ReceiptContact

typedef GPB_ENUM(ReceiptContact_FieldNumber) {
  ReceiptContact_FieldNumber_Value = 1,
  ReceiptContact_FieldNumber_Type = 2,
};

GPB_FINAL @interface ReceiptContact : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *value;

@property(nonatomic, readwrite) ReceiptContact_Type type;

@end

/**
 * Fetches the raw value of a @c ReceiptContact's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t ReceiptContact_Type_RawValue(ReceiptContact *message);
/**
 * Sets the raw value of an @c ReceiptContact's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetReceiptContact_Type_RawValue(ReceiptContact *message, int32_t value);

#pragma mark - Device

typedef GPB_ENUM(Device_FieldNumber) {
  Device_FieldNumber_Name = 1,
  Device_FieldNumber_Key = 2,
  Device_FieldNumber_KeysArray = 3,
};

GPB_FINAL @interface Device : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) Key *key GPB_DEPRECATED_MSG("io.token.proto.common.member.Device.key is deprecated (see member.proto).");
/** Test to see if @c key has been set. */
@property(nonatomic, readwrite) BOOL hasKey GPB_DEPRECATED_MSG("io.token.proto.common.member.Device.key is deprecated (see member.proto).");

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Key*> *keysArray;
/** The number of items in @c keysArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger keysArray_Count;

@end

#pragma mark - TrustedBeneficiary

typedef GPB_ENUM(TrustedBeneficiary_FieldNumber) {
  TrustedBeneficiary_FieldNumber_Payload = 1,
  TrustedBeneficiary_FieldNumber_Signature = 2,
};

GPB_FINAL @interface TrustedBeneficiary : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) TrustedBeneficiary_Payload *payload;
/** Test to see if @c payload has been set. */
@property(nonatomic, readwrite) BOOL hasPayload;

@property(nonatomic, readwrite, strong, null_resettable) Signature *signature;
/** Test to see if @c signature has been set. */
@property(nonatomic, readwrite) BOOL hasSignature;

@end

#pragma mark - TrustedBeneficiary_Payload

typedef GPB_ENUM(TrustedBeneficiary_Payload_FieldNumber) {
  TrustedBeneficiary_Payload_FieldNumber_MemberId = 1,
  TrustedBeneficiary_Payload_FieldNumber_Nonce = 2,
};

GPB_FINAL @interface TrustedBeneficiary_Payload : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *nonce;

@end

#pragma mark - Customization

typedef GPB_ENUM(Customization_FieldNumber) {
  Customization_FieldNumber_CustomizationId = 1,
  Customization_FieldNumber_LogoBlobId = 2,
  Customization_FieldNumber_Colors = 3,
  Customization_FieldNumber_ConsentText = 4,
  Customization_FieldNumber_Name = 5,
  Customization_FieldNumber_AppName = 6,
};

GPB_FINAL @interface Customization : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *customizationId;

/** display name */
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/** logo blob id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *logoBlobId;

/** colors in hex string #AARRGGBB */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableDictionary<NSString*, NSString*> *colors;
/** The number of items in @c colors without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger colors_Count;

/** use '\\n' for line breaks. */
@property(nonatomic, readwrite, copy, null_resettable) NSString *consentText;

/** TODO(RD-1985): re-evaluate app_name */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appName;

@end

#pragma mark - Keychain

typedef GPB_ENUM(Keychain_FieldNumber) {
  Keychain_FieldNumber_KeychainId = 1,
  Keychain_FieldNumber_Name = 2,
  Keychain_FieldNumber_KeysArray = 3,
};

GPB_FINAL @interface Keychain : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *keychainId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Key*> *keysArray;
/** The number of items in @c keysArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger keysArray_Count;

@end

#pragma mark - MemberInfo

typedef GPB_ENUM(MemberInfo_FieldNumber) {
  MemberInfo_FieldNumber_Id_p = 1,
  MemberInfo_FieldNumber_AliasesArray = 2,
};

GPB_FINAL @interface MemberInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** verified aliases */
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Alias*> *aliasesArray;
/** The number of items in @c aliasesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger aliasesArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
