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
@class Key;
@class MemberAddKeyOperation;
@class MemberAliasOperation;
@class MemberOperation;
@class MemberRemoveKeyOperation;
@class MemberUsernameOperation;
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

#pragma mark - MemberUsernameOperation

typedef GPB_ENUM(MemberUsernameOperation_FieldNumber) {
  MemberUsernameOperation_FieldNumber_Username = 1,
};

/**
 * TODO(PR-1161): Remove this when we no longer require backwards compatibility with usernames
 **/
@interface MemberUsernameOperation : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *username;

@end

#pragma mark - MemberOperation

typedef GPB_ENUM(MemberOperation_FieldNumber) {
  MemberOperation_FieldNumber_AddKey = 1,
  MemberOperation_FieldNumber_RemoveKey = 2,
  MemberOperation_FieldNumber_AddUsername = 3,
  MemberOperation_FieldNumber_RemoveAlias = 4,
  MemberOperation_FieldNumber_AddAlias = 5,
};

typedef GPB_ENUM(MemberOperation_Operation_OneOfCase) {
  MemberOperation_Operation_OneOfCase_GPBUnsetOneOfCase = 0,
  MemberOperation_Operation_OneOfCase_AddKey = 1,
  MemberOperation_Operation_OneOfCase_RemoveKey = 2,
  MemberOperation_Operation_OneOfCase_AddAlias = 5,
  MemberOperation_Operation_OneOfCase_RemoveAlias = 4,
  MemberOperation_Operation_OneOfCase_AddUsername = 3,
};

@interface MemberOperation : GPBMessage

@property(nonatomic, readonly) MemberOperation_Operation_OneOfCase operationOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) MemberAddKeyOperation *addKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberRemoveKeyOperation *removeKey;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *addAlias;

@property(nonatomic, readwrite, strong, null_resettable) MemberAliasOperation *removeAlias;

/** TODO(PR-1161): Remove this when we no longer require bakcwards compatibility with usernames */
@property(nonatomic, readwrite, strong, null_resettable) MemberUsernameOperation *addUsername;

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

#pragma mark - Member

typedef GPB_ENUM(Member_FieldNumber) {
  Member_FieldNumber_Id_p = 1,
  Member_FieldNumber_LastHash = 2,
  Member_FieldNumber_AliasHashesArray = 3,
  Member_FieldNumber_KeysArray = 4,
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

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
