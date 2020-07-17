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

#import <stdatomic.h>

#import "Transfer.pbobjc.h"
#import "Money.pbobjc.h"
#import "Security.pbobjc.h"
#import "Submission.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "extensions/Field.pbobjc.h"
#import "extensions/Message.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(BulkTransfer);
GPBObjCClassDeclaration(BulkTransferBody_Transfer);
GPBObjCClassDeclaration(BulkTransfer_Transaction);
GPBObjCClassDeclaration(Money);
GPBObjCClassDeclaration(Signature);
GPBObjCClassDeclaration(TransferDestination);
GPBObjCClassDeclaration(TransferEndpoint);
GPBObjCClassDeclaration(TransferInstructions_Metadata);
GPBObjCClassDeclaration(TransferPayload);

#pragma mark - TransferRoot

@implementation TransferRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    registry = [[GPBExtensionRegistry alloc] init];
    // Merge in the imports (direct or indirect) that defined extensions.
    [registry addExtensions:[FieldRoot extensionRegistry]];
    [registry addExtensions:[MessageRoot extensionRegistry]];
  }
  return registry;
}

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
@dynamic transactionId;
@dynamic createdAtMs;
@dynamic hasPayload, payload;
@dynamic payloadSignaturesArray, payloadSignaturesArray_Count;
@dynamic status;
@dynamic orderId;
@dynamic method;
@dynamic executionDate;

typedef struct Transfer__storage_ {
  uint32_t _has_storage_[1];
  TransactionStatus status;
  Transfer_Method method;
  NSString *id_p;
  NSString *transactionId;
  TransferPayload *payload;
  NSMutableArray *payloadSignaturesArray;
  NSString *orderId;
  NSString *executionDate;
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
        .dataTypeSpecific.clazz = Nil,
        .number = Transfer_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Transfer__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "transactionId",
        .dataTypeSpecific.clazz = Nil,
        .number = Transfer_FieldNumber_TransactionId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Transfer__storage_, transactionId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "createdAtMs",
        .dataTypeSpecific.clazz = Nil,
        .number = Transfer_FieldNumber_CreatedAtMs,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Transfer__storage_, createdAtMs),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "payload",
        .dataTypeSpecific.clazz = GPBObjCClass(TransferPayload),
        .number = Transfer_FieldNumber_Payload,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Transfer__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payloadSignaturesArray",
        .dataTypeSpecific.clazz = GPBObjCClass(Signature),
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
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "orderId",
        .dataTypeSpecific.clazz = Nil,
        .number = Transfer_FieldNumber_OrderId,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(Transfer__storage_, orderId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "method",
        .dataTypeSpecific.enumDescFunc = Transfer_Method_EnumDescriptor,
        .number = Transfer_FieldNumber_Method,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(Transfer__storage_, method),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "executionDate",
        .dataTypeSpecific.clazz = Nil,
        .number = Transfer_FieldNumber_ExecutionDate,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(Transfer__storage_, executionDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
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
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t Transfer_Status_RawValue(Transfer *message) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Status];
  return GPBGetMessageRawEnumField(message, field);
}

void SetTransfer_Status_RawValue(Transfer *message, int32_t value) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Status];
  GPBSetMessageRawEnumField(message, field, value);
}

int32_t Transfer_Method_RawValue(Transfer *message) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Method];
  return GPBGetMessageRawEnumField(message, field);
}

void SetTransfer_Method_RawValue(Transfer *message, int32_t value) {
  GPBDescriptor *descriptor = [Transfer descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Transfer_FieldNumber_Method];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - Enum Transfer_Method

GPBEnumDescriptor *Transfer_Method_EnumDescriptor(void) {
  static _Atomic(GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "Default\000Instant\000";
    static const int32_t values[] = {
        Transfer_Method_Default,
        Transfer_Method_Instant,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Transfer_Method)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Transfer_Method_IsValidValue];
    GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Transfer_Method_IsValidValue(int32_t value__) {
  switch (value__) {
    case Transfer_Method_Default:
    case Transfer_Method_Instant:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - BulkTransfer

@implementation BulkTransfer

@dynamic id_p;
@dynamic tokenId;
@dynamic createdAtMs;
@dynamic transactionsArray, transactionsArray_Count;
@dynamic totalAmount;
@dynamic hasSource, source;

typedef struct BulkTransfer__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  NSString *tokenId;
  NSMutableArray *transactionsArray;
  NSString *totalAmount;
  TransferEndpoint *source;
  int64_t createdAtMs;
} BulkTransfer__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = BulkTransfer_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "tokenId",
        .dataTypeSpecific.clazz = Nil,
        .number = BulkTransfer_FieldNumber_TokenId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, tokenId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "createdAtMs",
        .dataTypeSpecific.clazz = Nil,
        .number = BulkTransfer_FieldNumber_CreatedAtMs,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, createdAtMs),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "transactionsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(BulkTransfer_Transaction),
        .number = BulkTransfer_FieldNumber_TransactionsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, transactionsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "totalAmount",
        .dataTypeSpecific.clazz = Nil,
        .number = BulkTransfer_FieldNumber_TotalAmount,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, totalAmount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "source",
        .dataTypeSpecific.clazz = GPBObjCClass(TransferEndpoint),
        .number = BulkTransfer_FieldNumber_Source,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(BulkTransfer__storage_, source),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BulkTransfer class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BulkTransfer__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - BulkTransfer_Transaction

@implementation BulkTransfer_Transaction

@dynamic hasTransfer, transfer;
@dynamic transactionId;
@dynamic status;

typedef struct BulkTransfer_Transaction__storage_ {
  uint32_t _has_storage_[1];
  TransactionStatus status;
  BulkTransferBody_Transfer *transfer;
  NSString *transactionId;
} BulkTransfer_Transaction__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transfer",
        .dataTypeSpecific.clazz = GPBObjCClass(BulkTransferBody_Transfer),
        .number = BulkTransfer_Transaction_FieldNumber_Transfer,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BulkTransfer_Transaction__storage_, transfer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transactionId",
        .dataTypeSpecific.clazz = Nil,
        .number = BulkTransfer_Transaction_FieldNumber_TransactionId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BulkTransfer_Transaction__storage_, transactionId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "status",
        .dataTypeSpecific.enumDescFunc = TransactionStatus_EnumDescriptor,
        .number = BulkTransfer_Transaction_FieldNumber_Status,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BulkTransfer_Transaction__storage_, status),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BulkTransfer_Transaction class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BulkTransfer_Transaction__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    [localDescriptor setupContainingMessageClass:GPBObjCClass(BulkTransfer)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t BulkTransfer_Transaction_Status_RawValue(BulkTransfer_Transaction *message) {
  GPBDescriptor *descriptor = [BulkTransfer_Transaction descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:BulkTransfer_Transaction_FieldNumber_Status];
  return GPBGetMessageRawEnumField(message, field);
}

void SetBulkTransfer_Transaction_Status_RawValue(BulkTransfer_Transaction *message, int32_t value) {
  GPBDescriptor *descriptor = [BulkTransfer_Transaction descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:BulkTransfer_Transaction_FieldNumber_Status];
  GPBSetMessageRawEnumField(message, field, value);
}

#pragma mark - TransferPayload

@implementation TransferPayload

@dynamic refId;
@dynamic tokenId;
@dynamic hasAmount, amount;
@dynamic destinationsArray, destinationsArray_Count;
@dynamic description_p;
@dynamic transferDestinationsArray, transferDestinationsArray_Count;
@dynamic hasMetadata, metadata;
@dynamic confirmFunds;

typedef struct TransferPayload__storage_ {
  uint32_t _has_storage_[1];
  NSString *refId;
  NSString *tokenId;
  Money *amount;
  NSMutableArray *destinationsArray;
  NSString *description_p;
  NSMutableArray *transferDestinationsArray;
  TransferInstructions_Metadata *metadata;
} TransferPayload__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "refId",
        .dataTypeSpecific.clazz = Nil,
        .number = TransferPayload_FieldNumber_RefId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, refId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "tokenId",
        .dataTypeSpecific.clazz = Nil,
        .number = TransferPayload_FieldNumber_TokenId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, tokenId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "amount",
        .dataTypeSpecific.clazz = GPBObjCClass(Money),
        .number = TransferPayload_FieldNumber_Amount,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, amount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "destinationsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(TransferEndpoint),
        .number = TransferPayload_FieldNumber_DestinationsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, destinationsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.clazz = Nil,
        .number = TransferPayload_FieldNumber_Description_p,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, description_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "transferDestinationsArray",
        .dataTypeSpecific.clazz = GPBObjCClass(TransferDestination),
        .number = TransferPayload_FieldNumber_TransferDestinationsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, transferDestinationsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "metadata",
        .dataTypeSpecific.clazz = GPBObjCClass(TransferInstructions_Metadata),
        .number = TransferPayload_FieldNumber_Metadata,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(TransferPayload__storage_, metadata),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "confirmFunds",
        .dataTypeSpecific.clazz = Nil,
        .number = TransferPayload_FieldNumber_ConfirmFunds,
        .hasIndex = 5,
        .offset = 6,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeBool,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferPayload class]
                                     rootClass:[TransferRoot class]
                                          file:TransferRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferPayload__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
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
