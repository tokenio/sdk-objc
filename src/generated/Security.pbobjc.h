// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: security.proto

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

@class SealedMessage_AesMethod;
@class SealedMessage_NoopMethod;
@class SealedMessage_RsaAesMethod;
@class SealedMessage_RsaMethod;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum Key_Level

typedef GPB_ENUM(Key_Level) {
  /// Value used if any message's field encounters a value that is not defined
  /// by this enum. The message will also have C functions to get/set the rawValue
  /// of the field.
  Key_Level_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  Key_Level_Invalid = 0,
  Key_Level_Privileged = 1,
  Key_Level_Standard = 2,
  Key_Level_Low = 3,
};

GPBEnumDescriptor *Key_Level_EnumDescriptor(void);

/// Checks to see if the given value is defined by the enum or was not known at
/// the time this source was generated.
BOOL Key_Level_IsValidValue(int32_t value);

#pragma mark - SecurityRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface SecurityRoot : GPBRootObject
@end

#pragma mark - Key

typedef GPB_ENUM(Key_FieldNumber) {
  Key_FieldNumber_Id_p = 1,
  Key_FieldNumber_PublicKey = 2,
  Key_FieldNumber_Level = 3,
};

@interface Key : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

/// Base64url encoded public key.
@property(nonatomic, readwrite, copy, null_resettable) NSString *publicKey;

@property(nonatomic, readwrite) Key_Level level;

@end

/// Fetches the raw value of a @c Key's @c level property, even
/// if the value was not defined by the enum at the time the code was generated.
int32_t Key_Level_RawValue(Key *message);
/// Sets the raw value of an @c Key's @c level property, allowing
/// it to be set to a value that was not defined by the enum at the time the code
/// was generated.
void SetKey_Level_RawValue(Key *message, int32_t value);

#pragma mark - Signature

typedef GPB_ENUM(Signature_FieldNumber) {
  Signature_FieldNumber_MemberId = 1,
  Signature_FieldNumber_KeyId = 2,
  Signature_FieldNumber_Signature = 3,
};

@interface Signature : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *memberId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *keyId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *signature;

@end

#pragma mark - SealedMessage

typedef GPB_ENUM(SealedMessage_FieldNumber) {
  SealedMessage_FieldNumber_Ciphertext = 1,
  SealedMessage_FieldNumber_Noop = 4,
  SealedMessage_FieldNumber_Aes = 5,
  SealedMessage_FieldNumber_Rsa = 6,
  SealedMessage_FieldNumber_RsaAes = 7,
};

typedef GPB_ENUM(SealedMessage_Method_OneOfCase) {
  SealedMessage_Method_OneOfCase_GPBUnsetOneOfCase = 0,
  SealedMessage_Method_OneOfCase_Noop = 4,
  SealedMessage_Method_OneOfCase_Aes = 5,
  SealedMessage_Method_OneOfCase_Rsa = 6,
  SealedMessage_Method_OneOfCase_RsaAes = 7,
};

/// Represents an encrypted message payload
@interface SealedMessage : GPBMessage

/// Base64url encoded ciphertext.
@property(nonatomic, readwrite, copy, null_resettable) NSString *ciphertext;

@property(nonatomic, readonly) SealedMessage_Method_OneOfCase methodOneOfCase;

/// Noop encryption
@property(nonatomic, readwrite, strong, null_resettable) SealedMessage_NoopMethod *noop;

/// AES blocks method
@property(nonatomic, readwrite, strong, null_resettable) SealedMessage_AesMethod *aes;

/// RSA blocks method
@property(nonatomic, readwrite, strong, null_resettable) SealedMessage_RsaMethod *rsa;

/// RSA/AES Method specific metadata
@property(nonatomic, readwrite, strong, null_resettable) SealedMessage_RsaAesMethod *rsaAes;

@end

/// Clears whatever value was set for the oneof 'method'.
void SealedMessage_ClearMethodOneOfCase(SealedMessage *message);

#pragma mark - SealedMessage_NoopMethod

/// Clear text is used instad of encryption
@interface SealedMessage_NoopMethod : GPBMessage

@end

#pragma mark - SealedMessage_AesMethod

typedef GPB_ENUM(SealedMessage_AesMethod_FieldNumber) {
  SealedMessage_AesMethod_FieldNumber_KeyId = 1,
  SealedMessage_AesMethod_FieldNumber_Iv = 2,
  SealedMessage_AesMethod_FieldNumber_Algorithm = 3,
};

/// The message is encrypted using a symmetric key.
/// The key must be known to both sender and receipient.
@interface SealedMessage_AesMethod : GPBMessage

/// The id of the key used for encryption
@property(nonatomic, readwrite, copy, null_resettable) NSString *keyId;

/// AES/CBC/PKCS5Padding
@property(nonatomic, readwrite, copy, null_resettable) NSString *algorithm;

/// Base64url encoded initialization vector
@property(nonatomic, readwrite, copy, null_resettable) NSString *iv;

@end

#pragma mark - SealedMessage_RsaMethod

typedef GPB_ENUM(SealedMessage_RsaMethod_FieldNumber) {
  SealedMessage_RsaMethod_FieldNumber_KeyId = 1,
  SealedMessage_RsaMethod_FieldNumber_Algorithm = 2,
  SealedMessage_RsaMethod_FieldNumber_Signature = 3,
  SealedMessage_RsaMethod_FieldNumber_SignatureKeyId = 4,
};

/// The message is encrypted using the public key of the receipient.
/// The message can be decrypted only with the corresponding private key.
@interface SealedMessage_RsaMethod : GPBMessage

/// The id of the key used for encryption
@property(nonatomic, readwrite, copy, null_resettable) NSString *keyId;

/// RSA/ECB/OAEPWithSHA-256AndMGF1Padding
@property(nonatomic, readwrite, copy, null_resettable) NSString *algorithm;

/// Base64url encoded ciphertext signature.
@property(nonatomic, readwrite, copy, null_resettable) NSString *signature;

/// the key-id of the signature
@property(nonatomic, readwrite, copy, null_resettable) NSString *signatureKeyId;

@end

#pragma mark - SealedMessage_RsaAesMethod

typedef GPB_ENUM(SealedMessage_RsaAesMethod_FieldNumber) {
  SealedMessage_RsaAesMethod_FieldNumber_RsaKeyId = 1,
  SealedMessage_RsaAesMethod_FieldNumber_RsaAlgorithm = 2,
  SealedMessage_RsaAesMethod_FieldNumber_AesAlgorithm = 3,
  SealedMessage_RsaAesMethod_FieldNumber_Iv = 4,
  SealedMessage_RsaAesMethod_FieldNumber_EncryptedAesKey = 5,
  SealedMessage_RsaAesMethod_FieldNumber_Signature = 6,
  SealedMessage_RsaAesMethod_FieldNumber_SignatureKeyId = 7,
};

/// The message is encrypted with a self-generated symmetric key.
/// That key is encrypted using the public key of the receipient and
/// can only be decrypted with the corresponding private key.
@interface SealedMessage_RsaAesMethod : GPBMessage

/// The id of the key used for encryption
@property(nonatomic, readwrite, copy, null_resettable) NSString *rsaKeyId;

/// RSA/ECB/OAEPWithSHA-256AndMGF1Padding
@property(nonatomic, readwrite, copy, null_resettable) NSString *rsaAlgorithm;

/// AES/CBC/PKCS5Padding
@property(nonatomic, readwrite, copy, null_resettable) NSString *aesAlgorithm;

/// Base64url encoded initialization vector
@property(nonatomic, readwrite, copy, null_resettable) NSString *iv;

/// Base64url encoded rsa-encrypted aes key
@property(nonatomic, readwrite, copy, null_resettable) NSString *encryptedAesKey;

/// Base64url encoded ciphertext signature.
@property(nonatomic, readwrite, copy, null_resettable) NSString *signature;

/// the key-id of the signature
@property(nonatomic, readwrite, copy, null_resettable) NSString *signatureKeyId;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
