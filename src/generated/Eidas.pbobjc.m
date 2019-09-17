// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: eidas.proto

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

#import "Eidas.pbobjc.h"
#import "Alias.pbobjc.h"
#import "Security.pbobjc.h"
#import "extensions/Field.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - EidasRoot

@implementation EidasRoot

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

#pragma mark - EidasRoot_FileDescriptor

static GPBFileDescriptor *EidasRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.eidas"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum KonsentusVerificationStatus

GPBEnumDescriptor *KonsentusVerificationStatus_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "Invalid\000Success\000FailureEidasInvalid\000Fail"
        "ureErrorResponse\000";
    static const int32_t values[] = {
        KonsentusVerificationStatus_Invalid,
        KonsentusVerificationStatus_Success,
        KonsentusVerificationStatus_FailureEidasInvalid,
        KonsentusVerificationStatus_FailureErrorResponse,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(KonsentusVerificationStatus)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:KonsentusVerificationStatus_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL KonsentusVerificationStatus_IsValidValue(int32_t value__) {
  switch (value__) {
    case KonsentusVerificationStatus_Invalid:
    case KonsentusVerificationStatus_Success:
    case KonsentusVerificationStatus_FailureEidasInvalid:
    case KonsentusVerificationStatus_FailureErrorResponse:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - VerifyEidasPayload

@implementation VerifyEidasPayload

@dynamic memberId;
@dynamic hasAlias, alias;
@dynamic certificate;
@dynamic algorithm;

typedef struct VerifyEidasPayload__storage_ {
  uint32_t _has_storage_[1];
  Key_Algorithm algorithm;
  NSString *memberId;
  Alias *alias;
  NSString *certificate;
} VerifyEidasPayload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "memberId",
        .dataTypeSpecific.className = NULL,
        .number = VerifyEidasPayload_FieldNumber_MemberId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(VerifyEidasPayload__storage_, memberId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "alias",
        .dataTypeSpecific.className = GPBStringifySymbol(Alias),
        .number = VerifyEidasPayload_FieldNumber_Alias,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(VerifyEidasPayload__storage_, alias),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "certificate",
        .dataTypeSpecific.className = NULL,
        .number = VerifyEidasPayload_FieldNumber_Certificate,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(VerifyEidasPayload__storage_, certificate),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "algorithm",
        .dataTypeSpecific.enumDescFunc = Key_Algorithm_EnumDescriptor,
        .number = VerifyEidasPayload_FieldNumber_Algorithm,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(VerifyEidasPayload__storage_, algorithm),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[VerifyEidasPayload class]
                                     rootClass:[EidasRoot class]
                                          file:EidasRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(VerifyEidasPayload__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t VerifyEidasPayload_Algorithm_RawValue(VerifyEidasPayload *message) {
  GPBDescriptor *descriptor = [VerifyEidasPayload descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:VerifyEidasPayload_FieldNumber_Algorithm];
  return GPBGetMessageInt32Field(message, field);
}

void SetVerifyEidasPayload_Algorithm_RawValue(VerifyEidasPayload *message, int32_t value) {
  GPBDescriptor *descriptor = [VerifyEidasPayload descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:VerifyEidasPayload_FieldNumber_Algorithm];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
