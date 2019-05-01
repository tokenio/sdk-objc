// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: security.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import <stdatomic.h>

#import "Security.pbobjc.h"
#import "extensions/Field.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - SecurityRoot

@implementation SecurityRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    registry = [[GPBExtensionRegistry alloc] init];
    // Merge in the imports (direct or indirect) that defined extensions.
    [registry addExtensions:[FieldRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - SecurityRoot_FileDescriptor

static GPBFileDescriptor *SecurityRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.security"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Key

@implementation Key

@dynamic id_p;
@dynamic publicKey;
@dynamic level;
@dynamic algorithm;
@dynamic expiresAtMs;

typedef struct Key__storage_ {
  uint32_t _has_storage_[1];
  Key_Level level;
  Key_Algorithm algorithm;
  NSString *id_p;
  NSString *publicKey;
  int64_t expiresAtMs;
} Key__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = Key_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Key__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "publicKey",
        .dataTypeSpecific.className = NULL,
        .number = Key_FieldNumber_PublicKey,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Key__storage_, publicKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "level",
        .dataTypeSpecific.enumDescFunc = Key_Level_EnumDescriptor,
        .number = Key_FieldNumber_Level,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Key__storage_, level),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "algorithm",
        .dataTypeSpecific.enumDescFunc = Key_Algorithm_EnumDescriptor,
        .number = Key_FieldNumber_Algorithm,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Key__storage_, algorithm),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "expiresAtMs",
        .dataTypeSpecific.className = NULL,
        .number = Key_FieldNumber_ExpiresAtMs,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(Key__storage_, expiresAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Key class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Key__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t Key_Level_RawValue(Key *message) {
  GPBDescriptor *descriptor = [Key descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Key_FieldNumber_Level];
  return GPBGetMessageInt32Field(message, field);
}

void SetKey_Level_RawValue(Key *message, int32_t value) {
  GPBDescriptor *descriptor = [Key descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Key_FieldNumber_Level];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t Key_Algorithm_RawValue(Key *message) {
  GPBDescriptor *descriptor = [Key descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Key_FieldNumber_Algorithm];
  return GPBGetMessageInt32Field(message, field);
}

void SetKey_Algorithm_RawValue(Key *message, int32_t value) {
  GPBDescriptor *descriptor = [Key descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Key_FieldNumber_Algorithm];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum Key_Algorithm

GPBEnumDescriptor *Key_Algorithm_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "InvalidAlgorithm\000Ed25519\000EcdsaSha256\000Rs2"
        "56\000";
    static const int32_t values[] = {
        Key_Algorithm_InvalidAlgorithm,
        Key_Algorithm_Ed25519,
        Key_Algorithm_EcdsaSha256,
        Key_Algorithm_Rs256,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Key_Algorithm)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Key_Algorithm_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Key_Algorithm_IsValidValue(int32_t value__) {
  switch (value__) {
    case Key_Algorithm_InvalidAlgorithm:
    case Key_Algorithm_Ed25519:
    case Key_Algorithm_EcdsaSha256:
    case Key_Algorithm_Rs256:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum Key_Level

GPBEnumDescriptor *Key_Level_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "InvalidLevel\000Privileged\000Standard\000Low\000";
    static const int32_t values[] = {
        Key_Level_InvalidLevel,
        Key_Level_Privileged,
        Key_Level_Standard,
        Key_Level_Low,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Key_Level)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Key_Level_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Key_Level_IsValidValue(int32_t value__) {
  switch (value__) {
    case Key_Level_InvalidLevel:
    case Key_Level_Privileged:
    case Key_Level_Standard:
    case Key_Level_Low:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - PrivateKey

@implementation PrivateKey

@dynamic id_p;
@dynamic privateKey;
@dynamic level;
@dynamic algorithm;

typedef struct PrivateKey__storage_ {
  uint32_t _has_storage_[1];
  Key_Level level;
  Key_Algorithm algorithm;
  NSString *id_p;
  NSString *privateKey;
} PrivateKey__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = PrivateKey_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PrivateKey__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "privateKey",
        .dataTypeSpecific.className = NULL,
        .number = PrivateKey_FieldNumber_PrivateKey,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PrivateKey__storage_, privateKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "level",
        .dataTypeSpecific.enumDescFunc = Key_Level_EnumDescriptor,
        .number = PrivateKey_FieldNumber_Level,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PrivateKey__storage_, level),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "algorithm",
        .dataTypeSpecific.enumDescFunc = Key_Algorithm_EnumDescriptor,
        .number = PrivateKey_FieldNumber_Algorithm,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PrivateKey__storage_, algorithm),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PrivateKey class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PrivateKey__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t PrivateKey_Level_RawValue(PrivateKey *message) {
  GPBDescriptor *descriptor = [PrivateKey descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PrivateKey_FieldNumber_Level];
  return GPBGetMessageInt32Field(message, field);
}

void SetPrivateKey_Level_RawValue(PrivateKey *message, int32_t value) {
  GPBDescriptor *descriptor = [PrivateKey descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PrivateKey_FieldNumber_Level];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PrivateKey_Algorithm_RawValue(PrivateKey *message) {
  GPBDescriptor *descriptor = [PrivateKey descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PrivateKey_FieldNumber_Algorithm];
  return GPBGetMessageInt32Field(message, field);
}

void SetPrivateKey_Algorithm_RawValue(PrivateKey *message, int32_t value) {
  GPBDescriptor *descriptor = [PrivateKey descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PrivateKey_FieldNumber_Algorithm];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Signature

@implementation Signature

@dynamic memberId;
@dynamic keyId;
@dynamic signature;

typedef struct Signature__storage_ {
  uint32_t _has_storage_[1];
  NSString *memberId;
  NSString *keyId;
  NSString *signature;
} Signature__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "memberId",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_MemberId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Signature__storage_, memberId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "keyId",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_KeyId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Signature__storage_, keyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signature",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_Signature,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Signature__storage_, signature),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Signature class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Signature__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SealedMessage

@implementation SealedMessage

@dynamic methodOneOfCase;
@dynamic ciphertext;
@dynamic noop;
@dynamic rsa;
@dynamic rsaAes;

typedef struct SealedMessage__storage_ {
  uint32_t _has_storage_[2];
  NSString *ciphertext;
  SealedMessage_NoopMethod *noop;
  SealedMessage_RsaMethod *rsa;
  SealedMessage_RsaAesMethod *rsaAes;
} SealedMessage__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "ciphertext",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_FieldNumber_Ciphertext,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SealedMessage__storage_, ciphertext),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "noop",
        .dataTypeSpecific.className = GPBStringifySymbol(SealedMessage_NoopMethod),
        .number = SealedMessage_FieldNumber_Noop,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(SealedMessage__storage_, noop),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "rsa",
        .dataTypeSpecific.className = GPBStringifySymbol(SealedMessage_RsaMethod),
        .number = SealedMessage_FieldNumber_Rsa,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(SealedMessage__storage_, rsa),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "rsaAes",
        .dataTypeSpecific.className = GPBStringifySymbol(SealedMessage_RsaAesMethod),
        .number = SealedMessage_FieldNumber_RsaAes,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(SealedMessage__storage_, rsaAes),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SealedMessage class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SealedMessage__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    static const char *oneofs[] = {
      "method",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void SealedMessage_ClearMethodOneOfCase(SealedMessage *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - SealedMessage_NoopMethod

@implementation SealedMessage_NoopMethod


typedef struct SealedMessage_NoopMethod__storage_ {
  uint32_t _has_storage_[1];
} SealedMessage_NoopMethod__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SealedMessage_NoopMethod class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(SealedMessage_NoopMethod__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(SealedMessage)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SealedMessage_RsaMethod

@implementation SealedMessage_RsaMethod

@dynamic keyId;
@dynamic algorithm;
@dynamic signature;
@dynamic signatureKeyId;

typedef struct SealedMessage_RsaMethod__storage_ {
  uint32_t _has_storage_[1];
  NSString *keyId;
  NSString *algorithm;
  NSString *signature;
  NSString *signatureKeyId;
} SealedMessage_RsaMethod__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "keyId",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaMethod_FieldNumber_KeyId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SealedMessage_RsaMethod__storage_, keyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "algorithm",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaMethod_FieldNumber_Algorithm,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SealedMessage_RsaMethod__storage_, algorithm),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signature",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaMethod_FieldNumber_Signature,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(SealedMessage_RsaMethod__storage_, signature),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signatureKeyId",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaMethod_FieldNumber_SignatureKeyId,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(SealedMessage_RsaMethod__storage_, signatureKeyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SealedMessage_RsaMethod class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SealedMessage_RsaMethod__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(SealedMessage)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SealedMessage_RsaAesMethod

@implementation SealedMessage_RsaAesMethod

@dynamic rsaKeyId;
@dynamic rsaAlgorithm;
@dynamic aesAlgorithm;
@dynamic encryptedAesKey;
@dynamic signature;
@dynamic signatureKeyId;

typedef struct SealedMessage_RsaAesMethod__storage_ {
  uint32_t _has_storage_[1];
  NSString *rsaKeyId;
  NSString *rsaAlgorithm;
  NSString *aesAlgorithm;
  NSString *encryptedAesKey;
  NSString *signature;
  NSString *signatureKeyId;
} SealedMessage_RsaAesMethod__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "rsaKeyId",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_RsaKeyId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, rsaKeyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "rsaAlgorithm",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_RsaAlgorithm,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, rsaAlgorithm),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "aesAlgorithm",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_AesAlgorithm,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, aesAlgorithm),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "encryptedAesKey",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_EncryptedAesKey,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, encryptedAesKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signature",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_Signature,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, signature),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signatureKeyId",
        .dataTypeSpecific.className = NULL,
        .number = SealedMessage_RsaAesMethod_FieldNumber_SignatureKeyId,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(SealedMessage_RsaAesMethod__storage_, signatureKeyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SealedMessage_RsaAesMethod class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SealedMessage_RsaAesMethod__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(SealedMessage)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SecurityMetadata

@implementation SecurityMetadata

@dynamic ipAddress;
@dynamic geoLocation;
@dynamic deviceFingerprint;

typedef struct SecurityMetadata__storage_ {
  uint32_t _has_storage_[1];
  NSString *ipAddress;
  NSString *geoLocation;
  NSString *deviceFingerprint;
} SecurityMetadata__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "ipAddress",
        .dataTypeSpecific.className = NULL,
        .number = SecurityMetadata_FieldNumber_IpAddress,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SecurityMetadata__storage_, ipAddress),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "geoLocation",
        .dataTypeSpecific.className = NULL,
        .number = SecurityMetadata_FieldNumber_GeoLocation,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SecurityMetadata__storage_, geoLocation),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceFingerprint",
        .dataTypeSpecific.className = NULL,
        .number = SecurityMetadata_FieldNumber_DeviceFingerprint,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(SecurityMetadata__storage_, deviceFingerprint),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SecurityMetadata class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SecurityMetadata__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
