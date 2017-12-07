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
@class Alias;
@class Key;
@class MemberAddKeyOperation;
@class MemberAliasOperation;
@class MemberOperation;
@class MemberOperationMetadata_AddAliasMetadata;
@class MemberOperationResponseMetadata_AddAliasResponseMetadata;
@class MemberRecoveryOperation;
@class MemberRecoveryOperation_Authorization;
@class MemberRecoveryRulesOperation;
@class MemberRemoveKeyOperation;
@class RecoveryRule;
@class Signature;

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
  ProfilePictureSize_Original = 1,
  ProfilePictureSize_Small = 2,
  ProfilePictureSize_Medium = 3,
  ProfilePictureSize_Large = 4,
};

GPBEnumDescriptor *ProfilePictureSize_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ProfilePictureSize_IsValidValue(int32_t value);

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
@interface MemberRoot : GPBRootObject
@end

#pragma mark - MemberAddKeyOperation

typedef GPB_ENUM(MemberAddKeyOperation_FieldNumber) {
  MemberAddKeyOperation_FieldNumber_Key = 1,
};

/**
 * Adds member key to the directory.
 **/
@interface MemberAddKeyOperation : GPBMessage

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
@interface MemberRemoveKeyOperation : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *keyId;

@end

#pragma mark - MemberAliasOperation

typedef GPB_ENUM(MemberAliasOperation_FieldNumber) {
  MemberAliasOperation_FieldNumber_AliasHash = 1,
};

/**
 * Adds/removes member alias to/from the directory.
 **/
@interface MemberAliasOperation : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *aliasHash;

@end

#pragma mark - MemberRecoveryRulesOperation

typedef GPB_ENUM(MemberRecoveryRulesOperation_FieldNumber) {
  MemberRecoveryRulesOperation_FieldNumber_RecoveryRule = 1,
};

/**
 * Sets recovery rules for member. Overrides all previously set rules.
 **/
@interface MemberRecoveryRulesOperation : GPBMessage

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
@interface MemberRecoveryOperation : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryOperation_Authorization *authorization;
/** Test to see if @c authorization has been set. */
@property(nonatomic, readwrite) BOOL hasAuthorization;

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

@interface MemberRecoveryOperation_Authorization : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *prevHash;

@property(nonatomic, readwrite, strong, null_resettable) Key *memberKey;
/** Test to see if @c memberKey has been set. */
@property(nonatomic, readwrite) BOOL hasMemberKey;

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
};

typedef GPB_ENUM(MemberOperation_Operation_OneOfCase) {
  MemberOperation_Operation_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperation_Operation_OneOfCase_AddKey = 1,
  MemberOperation_Operation_OneOfCase_RemoveKey = 2,
  MemberOperation_Operation_OneOfCase_AddAlias = 5,
  MemberOperation_Operation_OneOfCase_RemoveAlias = 4,
  MemberOperation_Operation_OneOfCase_VerifyAlias = 6,
  MemberOperation_Operation_OneOfCase_RecoveryRules = 7,
  MemberOperation_Operation_OneOfCase_Recover = 8,
};

@interface MemberOperation : GPBMessage

@property(nonatomic, readonly) MemberOperation_Operation_OneOfCase operationOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberAddKeyOperation *addKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberRemoveKeyOperation *removeKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *addAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *removeAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *verifyAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryRulesOperation *recoveryRules;

@property(nonatomic, readwrite, strong, null_resettable) MemberRecoveryOperation *recover;

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
@interface MemberUpdate : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *prevHash;

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<MemberOperation*> *operationsArray;
/** The number of items in @c operationsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger operationsArray_Count;

@end

#pragma mark - MemberOperationMetadata

typedef GPB_ENUM(MemberOperationMetadata_FieldNumber) {
  MemberOperationMetadata_FieldNumber_AddAliasMetadata = 1,
};

typedef GPB_ENUM(MemberOperationMetadata_Type_OneOfCase) {
  MemberOperationMetadata_Type_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperationMetadata_Type_OneOfCase_AddAliasMetadata = 1,
};

/**
 * Metadata associated with MemberUpdate.
 * It is outside of MemberUpdate because MemberUpdate is signed and passed to the Directory.
 **/
@interface MemberOperationMetadata : GPBMessage

@property(nonatomic, readonly) MemberOperationMetadata_Type_OneOfCase typeOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberOperationMetadata_AddAliasMetadata *addAliasMetadata;

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

@interface MemberOperationMetadata_AddAliasMetadata : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *aliasHash;

@property(nonatomic, readwrite, strong, null_resettable) Alias *alias;
/** Test to see if @c alias has been set. */
@property(nonatomic, readwrite) BOOL hasAlias;

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
@interface MemberOperationResponseMetadata : GPBMessage

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

@interface MemberOperationResponseMetadata_AddAliasResponseMetadata : GPBMessage

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
@interface RecoveryRule : GPBMessage

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
};

/**
 * A member record that is computed by replaying all the member updates.
 **/
@interface Member : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *lastHash;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *aliasHashesArray;
/** The number of items in @c aliasHashesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger aliasHashesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<Key*> *keysArray;
/** The number of items in @c keysArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger keysArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<NSString*> *unverifiedAliasHashesArray;
/** The number of items in @c unverifiedAliasHashesArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger unverifiedAliasHashesArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) RecoveryRule *recoveryRule;
/** Test to see if @c recoveryRule has been set. */
@property(nonatomic, readwrite) BOOL hasRecoveryRule;

/** the sequence number for the member's last recovery entry */
@property(nonatomic, readwrite) int32_t lastRecoverySequence;

/** the sequence number for the member's last operation */
@property(nonatomic, readwrite) int32_t lastOperationSequence;

@end

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
@interface AddressRecord : GPBMessage

/** Address id */
@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/** The display name of the address */
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
@interface Profile : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *displayNameFirst;

@property(nonatomic, readwrite, copy, null_resettable) NSString *displayNameLast;

/** Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *originalPictureId;

/** Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *smallPictureId;

/** Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *mediumPictureId;

/** Ignored in set profile request */
@property(nonatomic, readwrite, copy, null_resettable) NSString *largePictureId;

@end

#pragma mark - Device

typedef GPB_ENUM(Device_FieldNumber) {
  Device_FieldNumber_Name = 1,
  Device_FieldNumber_Key = 2,
};

@interface Device : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, strong, null_resettable) Key *key;
/** Test to see if @c key has been set. */
@property(nonatomic, readwrite) BOOL hasKey;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
