// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: token.proto

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

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/Wrappers.pbobjc.h>
#else
 #import "google/protobuf/Wrappers.pbobjc.h"
#endif

 #import "Token.pbobjc.h"
 #import "Security.pbobjc.h"
 #import "Transfer.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - TokenRoot

@implementation TokenRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[GPBWrappersRoot extensionRegistry]];
    [registry addExtensions:[SecurityRoot extensionRegistry]];
    [registry addExtensions:[TransferRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - TokenRoot_FileDescriptor

static GPBFileDescriptor *TokenRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.token"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - TokenSignature

@implementation TokenSignature

@dynamic action;
@dynamic hasSignature, signature;

typedef struct TokenSignature__storage_ {
  uint32_t _has_storage_[1];
  TokenSignature_Action action;
  Signature *signature;
} TokenSignature__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "action",
        .dataTypeSpecific.enumDescFunc = TokenSignature_Action_EnumDescriptor,
        .number = TokenSignature_FieldNumber_Action,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TokenSignature__storage_, action),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "signature",
        .dataTypeSpecific.className = GPBStringifySymbol(Signature),
        .number = TokenSignature_FieldNumber_Signature,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TokenSignature__storage_, signature),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TokenSignature class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TokenSignature__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t TokenSignature_Action_RawValue(TokenSignature *message) {
  GPBDescriptor *descriptor = [TokenSignature descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:TokenSignature_FieldNumber_Action];
  return GPBGetMessageInt32Field(message, field);
}

void SetTokenSignature_Action_RawValue(TokenSignature *message, int32_t value) {
  GPBDescriptor *descriptor = [TokenSignature descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:TokenSignature_FieldNumber_Action];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum TokenSignature_Action

GPBEnumDescriptor *TokenSignature_Action_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Invalid\000Endorsed\000Cancelled\000";
    static const int32_t values[] = {
        TokenSignature_Action_Invalid,
        TokenSignature_Action_Endorsed,
        TokenSignature_Action_Cancelled,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(TokenSignature_Action)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:TokenSignature_Action_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL TokenSignature_Action_IsValidValue(int32_t value__) {
  switch (value__) {
    case TokenSignature_Action_Invalid:
    case TokenSignature_Action_Endorsed:
    case TokenSignature_Action_Cancelled:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - TokenMember

@implementation TokenMember

@dynamic id_p;
@dynamic alias;
@dynamic name;

typedef struct TokenMember__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  NSString *alias;
  NSString *name;
} TokenMember__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = TokenMember_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TokenMember__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "alias",
        .dataTypeSpecific.className = NULL,
        .number = TokenMember_FieldNumber_Alias,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TokenMember__storage_, alias),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = TokenMember_FieldNumber_Name,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TokenMember__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TokenMember class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TokenMember__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PaymentToken

@implementation PaymentToken

@dynamic id_p;
@dynamic hasPayload, payload;
@dynamic payloadSignaturesArray, payloadSignaturesArray_Count;

typedef struct PaymentToken__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  PaymentToken_Payload *payload;
  NSMutableArray *payloadSignaturesArray;
} PaymentToken__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PaymentToken__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "payload",
        .dataTypeSpecific.className = GPBStringifySymbol(PaymentToken_Payload),
        .number = PaymentToken_FieldNumber_Payload,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PaymentToken__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payloadSignaturesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenSignature),
        .number = PaymentToken_FieldNumber_PayloadSignaturesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PaymentToken__storage_, payloadSignaturesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PaymentToken class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PaymentToken__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PaymentToken_Payload

@implementation PaymentToken_Payload

@dynamic version;
@dynamic nonce;
@dynamic hasIssuer, issuer;
@dynamic hasPayer, payer;
@dynamic hasRedeemer, redeemer;
@dynamic hasTransfer, transfer;
@dynamic hasFeesPaidBy, feesPaidBy;
@dynamic currency;
@dynamic lifetimeAmount;
@dynamic amount;
@dynamic effectiveAtMs;
@dynamic expiresAtMs;
@dynamic description_p;
@dynamic vars, vars_Count;

typedef struct PaymentToken_Payload__storage_ {
  uint32_t _has_storage_[1];
  NSString *version;
  NSString *nonce;
  TokenMember *issuer;
  TokenMember *payer;
  TokenMember *redeemer;
  Transfer *transfer;
  TokenMember *feesPaidBy;
  NSString *currency;
  NSString *lifetimeAmount;
  NSString *amount;
  NSString *description_p;
  NSMutableDictionary *vars;
  int64_t effectiveAtMs;
  int64_t expiresAtMs;
} PaymentToken_Payload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "version",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_Version,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, version),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nonce",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_Nonce,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, nonce),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "issuer",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = PaymentToken_Payload_FieldNumber_Issuer,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, issuer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payer",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = PaymentToken_Payload_FieldNumber_Payer,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, payer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "redeemer",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = PaymentToken_Payload_FieldNumber_Redeemer,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, redeemer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transfer",
        .dataTypeSpecific.className = GPBStringifySymbol(Transfer),
        .number = PaymentToken_Payload_FieldNumber_Transfer,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, transfer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "feesPaidBy",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = PaymentToken_Payload_FieldNumber_FeesPaidBy,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, feesPaidBy),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "currency",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_Currency,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, currency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lifetimeAmount",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_LifetimeAmount,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, lifetimeAmount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "amount",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_Amount,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, amount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "effectiveAtMs",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_EffectiveAtMs,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, effectiveAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "expiresAtMs",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_ExpiresAtMs,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, expiresAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = PaymentToken_Payload_FieldNumber_Description_p,
        .hasIndex = 12,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "vars",
        .dataTypeSpecific.className = GPBStringifySymbol(Var),
        .number = PaymentToken_Payload_FieldNumber_Vars,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PaymentToken_Payload__storage_, vars),
        .flags = GPBFieldMapKeyString,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PaymentToken_Payload class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PaymentToken_Payload__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Var

@implementation Var

@dynamic hasRange, range;
@dynamic oneOfArray, oneOfArray_Count;
@dynamic regex;
@dynamic value;
@dynamic hasPeriod, period;

typedef struct Var__storage_ {
  uint32_t _has_storage_[1];
  DoubleRange *range;
  NSMutableArray *oneOfArray;
  NSString *regex;
  NSString *value;
  TimePeriod *period;
} Var__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "range",
        .dataTypeSpecific.className = GPBStringifySymbol(DoubleRange),
        .number = Var_FieldNumber_Range,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Var__storage_, range),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "oneOfArray",
        .dataTypeSpecific.className = NULL,
        .number = Var_FieldNumber_OneOfArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Var__storage_, oneOfArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "regex",
        .dataTypeSpecific.className = NULL,
        .number = Var_FieldNumber_Regex,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Var__storage_, regex),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "value",
        .dataTypeSpecific.className = NULL,
        .number = Var_FieldNumber_Value,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Var__storage_, value),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "period",
        .dataTypeSpecific.className = GPBStringifySymbol(TimePeriod),
        .number = Var_FieldNumber_Period,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Var__storage_, period),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Var class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Var__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - DoubleRange

@implementation DoubleRange

@dynamic min;
@dynamic max;
@dynamic default_p;

typedef struct DoubleRange__storage_ {
  uint32_t _has_storage_[1];
  NSString *min;
  NSString *max;
  NSString *default_p;
} DoubleRange__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "min",
        .dataTypeSpecific.className = NULL,
        .number = DoubleRange_FieldNumber_Min,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(DoubleRange__storage_, min),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "max",
        .dataTypeSpecific.className = NULL,
        .number = DoubleRange_FieldNumber_Max,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(DoubleRange__storage_, max),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "default_p",
        .dataTypeSpecific.className = NULL,
        .number = DoubleRange_FieldNumber_Default_p,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(DoubleRange__storage_, default_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[DoubleRange class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(DoubleRange__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TimePeriod

@implementation TimePeriod

@dynamic duration;
@dynamic max;

typedef struct TimePeriod__storage_ {
  uint32_t _has_storage_[1];
  NSString *duration;
  NSString *max;
} TimePeriod__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "duration",
        .dataTypeSpecific.className = NULL,
        .number = TimePeriod_FieldNumber_Duration,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TimePeriod__storage_, duration),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "max",
        .dataTypeSpecific.className = NULL,
        .number = TimePeriod_FieldNumber_Max,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TimePeriod__storage_, max),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TimePeriod class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TimePeriod__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccessToken

@implementation AccessToken

@dynamic id_p;
@dynamic hasPayload, payload;
@dynamic payloadSignaturesArray, payloadSignaturesArray_Count;

typedef struct AccessToken__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  AccessToken_Payload *payload;
  NSMutableArray *payloadSignaturesArray;
} AccessToken__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccessToken__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "payload",
        .dataTypeSpecific.className = GPBStringifySymbol(AccessToken_Payload),
        .number = AccessToken_FieldNumber_Payload,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AccessToken__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payloadSignaturesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenSignature),
        .number = AccessToken_FieldNumber_PayloadSignaturesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(AccessToken__storage_, payloadSignaturesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccessToken_Payload

@implementation AccessToken_Payload

@dynamic version;
@dynamic nonce;
@dynamic hasGrantor, grantor;
@dynamic hasGrantee, grantee;
@dynamic resourcesArray, resourcesArray_Count;
@dynamic effectiveAtMs;
@dynamic expiresAtMs;
@dynamic description_p;

typedef struct AccessToken_Payload__storage_ {
  uint32_t _has_storage_[1];
  NSString *version;
  NSString *nonce;
  TokenMember *grantor;
  TokenMember *grantee;
  NSMutableArray *resourcesArray;
  NSString *description_p;
  int64_t effectiveAtMs;
  int64_t expiresAtMs;
} AccessToken_Payload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "version",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Payload_FieldNumber_Version,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, version),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nonce",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Payload_FieldNumber_Nonce,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, nonce),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "grantor",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = AccessToken_Payload_FieldNumber_Grantor,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, grantor),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "grantee",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = AccessToken_Payload_FieldNumber_Grantee,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, grantee),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "resourcesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(AccessToken_Resource),
        .number = AccessToken_Payload_FieldNumber_ResourcesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, resourcesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "effectiveAtMs",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Payload_FieldNumber_EffectiveAtMs,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, effectiveAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "expiresAtMs",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Payload_FieldNumber_ExpiresAtMs,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, expiresAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Payload_FieldNumber_Description_p,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(AccessToken_Payload__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken_Payload class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken_Payload__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccessToken_Resource

@implementation AccessToken_Resource

@dynamic resourceOneOfCase;
@dynamic address;
@dynamic account;
@dynamic transaction;

typedef struct AccessToken_Resource__storage_ {
  uint32_t _has_storage_[2];
  AccessToken_Resource_Address *address;
  AccessToken_Resource_Account *account;
  AccessToken_Resource_Transaction *transaction;
} AccessToken_Resource__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "address",
        .dataTypeSpecific.className = GPBStringifySymbol(AccessToken_Resource_Address),
        .number = AccessToken_Resource_FieldNumber_Address,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(AccessToken_Resource__storage_, address),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "account",
        .dataTypeSpecific.className = GPBStringifySymbol(AccessToken_Resource_Account),
        .number = AccessToken_Resource_FieldNumber_Account,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(AccessToken_Resource__storage_, account),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transaction",
        .dataTypeSpecific.className = GPBStringifySymbol(AccessToken_Resource_Transaction),
        .number = AccessToken_Resource_FieldNumber_Transaction,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(AccessToken_Resource__storage_, transaction),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken_Resource class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken_Resource__storage_)
                                         flags:0];
    static const char *oneofs[] = {
      "resource",
    };
    [localDescriptor setupOneofs:oneofs
                           count:(uint32_t)(sizeof(oneofs) / sizeof(char*))
                   firstHasIndex:-1];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

void AccessToken_Resource_ClearResourceOneOfCase(AccessToken_Resource *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - AccessToken_Resource_Address

@implementation AccessToken_Resource_Address

@dynamic addressId;

typedef struct AccessToken_Resource_Address__storage_ {
  uint32_t _has_storage_[1];
  NSString *addressId;
} AccessToken_Resource_Address__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "addressId",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Resource_Address_FieldNumber_AddressId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccessToken_Resource_Address__storage_, addressId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken_Resource_Address class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken_Resource_Address__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccessToken_Resource_Account

@implementation AccessToken_Resource_Account

@dynamic accountId;

typedef struct AccessToken_Resource_Account__storage_ {
  uint32_t _has_storage_[1];
  NSString *accountId;
} AccessToken_Resource_Account__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Resource_Account_FieldNumber_AccountId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccessToken_Resource_Account__storage_, accountId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken_Resource_Account class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken_Resource_Account__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccessToken_Resource_Transaction

@implementation AccessToken_Resource_Transaction

@dynamic accountId;

typedef struct AccessToken_Resource_Transaction__storage_ {
  uint32_t _has_storage_[1];
  NSString *accountId;
} AccessToken_Resource_Transaction__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = AccessToken_Resource_Transaction_FieldNumber_AccountId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccessToken_Resource_Transaction__storage_, accountId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccessToken_Resource_Transaction class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccessToken_Resource_Transaction__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
