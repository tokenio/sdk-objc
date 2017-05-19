// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: transfer.proto

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

 #import "Transfer.pbobjc.h"
 #import "Money.pbobjc.h"
 #import "Security.pbobjc.h"
 #import "Transaction.pbobjc.h"
 #import "Transferinstructions.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - TransferRoot

@implementation TransferRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - TransferRoot_FileDescriptor

static GPBFileDescriptor *TransferRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.transfer"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Transfer

@implementation Transfer

@dynamic id_p;
@dynamic referenceId;
@dynamic createdAtMs;
@dynamic hasPayload, payload;
@dynamic payloadSignaturesArray, payloadSignaturesArray_Count;
@dynamic status;
@dynamic orderId;

typedef struct Transfer__storage_ {
  uint32_t _has_storage_[1];
  TransactionStatus status;
  NSString *id_p;
  NSString *referenceId;
  TransferPayload *payload;
  NSMutableArray *payloadSignaturesArray;
  NSString *orderId;
  int64_t createdAtMs;
} Transfer__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = Transfer_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Transfer__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "referenceId",
        .dataTypeSpecific.className = NULL,
        .number = Transfer_FieldNumber_ReferenceId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Transfer__storage_, referenceId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "createdAtMs",
        .dataTypeSpecific.className = NULL,
        .number = Transfer_FieldNumber_CreatedAtMs,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Transfer__storage_, createdAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "payload",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferPayload),
        .number = Transfer_FieldNumber_Payload,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Transfer__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payloadSignaturesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(Signature),
        .number = Transfer_FieldNumber_PayloadSignaturesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Transfer__storage_, payloadSignaturesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "status",
        .dataTypeSpecific.enumDescFunc = TransactionStatus_EnumDescriptor,
        .number = Transfer_FieldNumber_Status,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(Transfer__storage_, status),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "orderId",
        .dataTypeSpecific.className = NULL,
        .number = Transfer_FieldNumber_OrderId,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(Transfer__storage_, orderId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Transfer class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Transfer__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t Transfer_Status_RawValue(Transfer *message) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Status];
  return GPBGetMessageInt32Field(message, field);
}

void SetTransfer_Status_RawValue(Transfer *message, int32_t value) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Status];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - TransferPayload

@implementation TransferPayload

@dynamic nonce;
@dynamic tokenId;
@dynamic hasAmount, amount;
@dynamic destinationsArray, destinationsArray_Count;
@dynamic description_p;

typedef struct TransferPayload__storage_ {
  uint32_t _has_storage_[1];
  NSString *nonce;
  NSString *tokenId;
  Money *amount;
  NSMutableArray *destinationsArray;
  NSString *description_p;
} TransferPayload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "nonce",
        .dataTypeSpecific.className = NULL,
        .number = TransferPayload_FieldNumber_Nonce,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, nonce),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "tokenId",
        .dataTypeSpecific.className = NULL,
        .number = TransferPayload_FieldNumber_TokenId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, tokenId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "amount",
        .dataTypeSpecific.className = GPBStringifySymbol(Money),
        .number = TransferPayload_FieldNumber_Amount,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, amount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "destinationsArray",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferEndpoint),
        .number = TransferPayload_FieldNumber_DestinationsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, destinationsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = TransferPayload_FieldNumber_Description_p,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferPayload class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferPayload__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransferQuote

@implementation TransferQuote

@dynamic id_p;
@dynamic accountCurrency;
@dynamic feesTotal;
@dynamic feesArray, feesArray_Count;
@dynamic hasFxRate, fxRate;
@dynamic expiresAtMs;

typedef struct TransferQuote__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  NSString *accountCurrency;
  NSString *feesTotal;
  NSMutableArray *feesArray;
  TransferQuote_FxRate *fxRate;
  int64_t expiresAtMs;
} TransferQuote__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "accountCurrency",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FieldNumber_AccountCurrency,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, accountCurrency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "feesTotal",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FieldNumber_FeesTotal,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, feesTotal),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "feesArray",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferQuote_Fee),
        .number = TransferQuote_FieldNumber_FeesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, feesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "fxRate",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferQuote_FxRate),
        .number = TransferQuote_FieldNumber_FxRate,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, fxRate),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "expiresAtMs",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FieldNumber_ExpiresAtMs,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(TransferQuote__storage_, expiresAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferQuote class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferQuote__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransferQuote_Fee

@implementation TransferQuote_Fee

@dynamic amount;
@dynamic description_p;

typedef struct TransferQuote_Fee__storage_ {
  uint32_t _has_storage_[1];
  NSString *amount;
  NSString *description_p;
} TransferQuote_Fee__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "amount",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_Fee_FieldNumber_Amount,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferQuote_Fee__storage_, amount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_Fee_FieldNumber_Description_p,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransferQuote_Fee__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferQuote_Fee class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferQuote_Fee__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(TransferQuote)];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransferQuote_FxRate

@implementation TransferQuote_FxRate

@dynamic baseCurrency;
@dynamic quoteCurrency;
@dynamic rate;

typedef struct TransferQuote_FxRate__storage_ {
  uint32_t _has_storage_[1];
  NSString *baseCurrency;
  NSString *quoteCurrency;
  NSString *rate;
} TransferQuote_FxRate__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "baseCurrency",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FxRate_FieldNumber_BaseCurrency,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferQuote_FxRate__storage_, baseCurrency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "quoteCurrency",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FxRate_FieldNumber_QuoteCurrency,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransferQuote_FxRate__storage_, quoteCurrency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "rate",
        .dataTypeSpecific.className = NULL,
        .number = TransferQuote_FxRate_FieldNumber_Rate,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TransferQuote_FxRate__storage_, rate),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferQuote_FxRate class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferQuote_FxRate__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(TransferQuote)];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
