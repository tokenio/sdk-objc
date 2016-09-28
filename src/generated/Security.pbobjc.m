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

 #import "Security.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - SecurityRoot

@implementation SecurityRoot

@end

#pragma mark - SecurityRoot_FileDescriptor

static GPBFileDescriptor *SecurityRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.security"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Key

@implementation Key

@dynamic id_p;
@dynamic publicKey;

typedef struct Key__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  NSString *publicKey;
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
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Key class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Key__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Signature

@implementation Signature

@dynamic keyId;
@dynamic signature;
@dynamic timestampMs;

typedef struct Signature__storage_ {
  uint32_t _has_storage_[1];
  NSString *keyId;
  NSString *signature;
  int64_t timestampMs;
} Signature__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "keyId",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_KeyId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Signature__storage_, keyId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "signature",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_Signature,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Signature__storage_, signature),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "timestampMs",
        .dataTypeSpecific.className = NULL,
        .number = Signature_FieldNumber_TimestampMs,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Signature__storage_, timestampMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Signature class]
                                     rootClass:[SecurityRoot class]
                                          file:SecurityRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Signature__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
