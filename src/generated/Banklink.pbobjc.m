// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: banklink.proto

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

 #import "Banklink.pbobjc.h"
 #import "Security.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - BanklinkRoot

@implementation BanklinkRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[SecurityRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - BanklinkRoot_FileDescriptor

static GPBFileDescriptor *BanklinkRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.banklink"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - AccountLinkingPayloads

@implementation AccountLinkingPayloads

@dynamic bankId;
@dynamic bankName;
@dynamic payloadsArray, payloadsArray_Count;

typedef struct AccountLinkingPayloads__storage_ {
  uint32_t _has_storage_[1];
  NSString *bankId;
  NSString *bankName;
  NSMutableArray *payloadsArray;
} AccountLinkingPayloads__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "bankId",
        .dataTypeSpecific.className = NULL,
        .number = AccountLinkingPayloads_FieldNumber_BankId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccountLinkingPayloads__storage_, bankId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bankName",
        .dataTypeSpecific.className = NULL,
        .number = AccountLinkingPayloads_FieldNumber_BankName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AccountLinkingPayloads__storage_, bankName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "payloadsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(SealedMessage),
        .number = AccountLinkingPayloads_FieldNumber_PayloadsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(AccountLinkingPayloads__storage_, payloadsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccountLinkingPayloads class]
                                     rootClass:[BanklinkRoot class]
                                          file:BanklinkRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccountLinkingPayloads__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
