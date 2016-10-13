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

#pragma mark - Token

@implementation Token

@dynamic id_p;
@dynamic hasPayload, payload;
@dynamic payloadSignaturesArray, payloadSignaturesArray_Count;

typedef struct Token__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  TokenPayload *payload;
  NSMutableArray *payloadSignaturesArray;
} Token__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = Token_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Token__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "payload",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenPayload),
        .number = Token_FieldNumber_Payload,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Token__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payloadSignaturesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenSignature),
        .number = Token_FieldNumber_PayloadSignaturesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Token__storage_, payloadSignaturesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Token class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Token__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

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

#pragma mark - TokenPayload

@implementation TokenPayload

@dynamic bodyOneOfCase;
@dynamic version;
@dynamic nonce;
@dynamic hasIssuer, issuer;
@dynamic hasFrom, from;
@dynamic hasTo, to;
@dynamic effectiveAtMs;
@dynamic expiresAtMs;
@dynamic description_p;
@dynamic bankTransfer;
@dynamic access;

typedef struct TokenPayload__storage_ {
  uint32_t _has_storage_[2];
  NSString *version;
  NSString *nonce;
  TokenMember *issuer;
  TokenMember *from;
  TokenMember *to;
  NSString *description_p;
  BankTransfer *bankTransfer;
  Access *access;
  int64_t effectiveAtMs;
  int64_t expiresAtMs;
} TokenPayload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "version",
        .dataTypeSpecific.className = NULL,
        .number = TokenPayload_FieldNumber_Version,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, version),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nonce",
        .dataTypeSpecific.className = NULL,
        .number = TokenPayload_FieldNumber_Nonce,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, nonce),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "issuer",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = TokenPayload_FieldNumber_Issuer,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, issuer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "from",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = TokenPayload_FieldNumber_From,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, from),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "to",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = TokenPayload_FieldNumber_To,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, to),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "effectiveAtMs",
        .dataTypeSpecific.className = NULL,
        .number = TokenPayload_FieldNumber_EffectiveAtMs,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, effectiveAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "expiresAtMs",
        .dataTypeSpecific.className = NULL,
        .number = TokenPayload_FieldNumber_ExpiresAtMs,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, expiresAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = TokenPayload_FieldNumber_Description_p,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bankTransfer",
        .dataTypeSpecific.className = GPBStringifySymbol(BankTransfer),
        .number = TokenPayload_FieldNumber_BankTransfer,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, bankTransfer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "access",
        .dataTypeSpecific.className = GPBStringifySymbol(Access),
        .number = TokenPayload_FieldNumber_Access,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(TokenPayload__storage_, access),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TokenPayload class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TokenPayload__storage_)
                                         flags:0];
    static const char *oneofs[] = {
      "body",
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

void TokenPayload_ClearBodyOneOfCase(TokenPayload *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - BankTransfer

@implementation BankTransfer

@dynamic hasRedeemer, redeemer;
@dynamic hasTransfer, transfer;
@dynamic hasFeesPaidBy, feesPaidBy;
@dynamic currency;
@dynamic lifetimeAmount;
@dynamic amount;
@dynamic vars, vars_Count;

typedef struct BankTransfer__storage_ {
  uint32_t _has_storage_[1];
  TokenMember *redeemer;
  Transfer *transfer;
  TokenMember *feesPaidBy;
  NSString *currency;
  NSString *lifetimeAmount;
  NSString *amount;
  NSMutableDictionary *vars;
} BankTransfer__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "redeemer",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = BankTransfer_FieldNumber_Redeemer,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, redeemer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transfer",
        .dataTypeSpecific.className = GPBStringifySymbol(Transfer),
        .number = BankTransfer_FieldNumber_Transfer,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, transfer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "feesPaidBy",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenMember),
        .number = BankTransfer_FieldNumber_FeesPaidBy,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, feesPaidBy),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "currency",
        .dataTypeSpecific.className = NULL,
        .number = BankTransfer_FieldNumber_Currency,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, currency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "lifetimeAmount",
        .dataTypeSpecific.className = NULL,
        .number = BankTransfer_FieldNumber_LifetimeAmount,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, lifetimeAmount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "amount",
        .dataTypeSpecific.className = NULL,
        .number = BankTransfer_FieldNumber_Amount,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, amount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "vars",
        .dataTypeSpecific.className = GPBStringifySymbol(Var),
        .number = BankTransfer_FieldNumber_Vars,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BankTransfer__storage_, vars),
        .flags = GPBFieldMapKeyString,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BankTransfer class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BankTransfer__storage_)
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

#pragma mark - Access

@implementation Access

@dynamic resourcesArray, resourcesArray_Count;

typedef struct Access__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *resourcesArray;
} Access__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "resourcesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(Access_Resource),
        .number = Access_FieldNumber_ResourcesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Access__storage_, resourcesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Access class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Access__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Access_Resource

@implementation Access_Resource

@dynamic resourceOneOfCase;
@dynamic address;
@dynamic account;
@dynamic transaction;

typedef struct Access_Resource__storage_ {
  uint32_t _has_storage_[2];
  Access_Resource_Address *address;
  Access_Resource_Account *account;
  Access_Resource_Transaction *transaction;
} Access_Resource__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "address",
        .dataTypeSpecific.className = GPBStringifySymbol(Access_Resource_Address),
        .number = Access_Resource_FieldNumber_Address,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Access_Resource__storage_, address),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "account",
        .dataTypeSpecific.className = GPBStringifySymbol(Access_Resource_Account),
        .number = Access_Resource_FieldNumber_Account,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Access_Resource__storage_, account),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transaction",
        .dataTypeSpecific.className = GPBStringifySymbol(Access_Resource_Transaction),
        .number = Access_Resource_FieldNumber_Transaction,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Access_Resource__storage_, transaction),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Access_Resource class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Access_Resource__storage_)
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

void Access_Resource_ClearResourceOneOfCase(Access_Resource *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - Access_Resource_Address

@implementation Access_Resource_Address

@dynamic addressId;

typedef struct Access_Resource_Address__storage_ {
  uint32_t _has_storage_[1];
  NSString *addressId;
} Access_Resource_Address__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "addressId",
        .dataTypeSpecific.className = NULL,
        .number = Access_Resource_Address_FieldNumber_AddressId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Access_Resource_Address__storage_, addressId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Access_Resource_Address class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Access_Resource_Address__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Access_Resource_Account

@implementation Access_Resource_Account

@dynamic accountId;

typedef struct Access_Resource_Account__storage_ {
  uint32_t _has_storage_[1];
  NSString *accountId;
} Access_Resource_Account__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = Access_Resource_Account_FieldNumber_AccountId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Access_Resource_Account__storage_, accountId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Access_Resource_Account class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Access_Resource_Account__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Access_Resource_Transaction

@implementation Access_Resource_Transaction

@dynamic accountId;

typedef struct Access_Resource_Transaction__storage_ {
  uint32_t _has_storage_[1];
  NSString *accountId;
} Access_Resource_Transaction__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = Access_Resource_Transaction_FieldNumber_AccountId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Access_Resource_Transaction__storage_, accountId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Access_Resource_Transaction class]
                                     rootClass:[TokenRoot class]
                                          file:TokenRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Access_Resource_Transaction__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
