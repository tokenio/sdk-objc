// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: notification.proto

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

 #import "Notification.pbobjc.h"
 #import "Banklink.pbobjc.h"
 #import "Security.pbobjc.h"
 #import "Token.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - NotificationRoot

@implementation NotificationRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - NotificationRoot_FileDescriptor

static GPBFileDescriptor *NotificationRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.notification"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum NotifyStatus

GPBEnumDescriptor *NotifyStatus_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Invalid\000Accepted\000NoSubscribers\000";
    static const int32_t values[] = {
        NotifyStatus_Invalid,
        NotifyStatus_Accepted,
        NotifyStatus_NoSubscribers,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(NotifyStatus)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:NotifyStatus_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL NotifyStatus_IsValidValue(int32_t value__) {
  switch (value__) {
    case NotifyStatus_Invalid:
    case NotifyStatus_Accepted:
    case NotifyStatus_NoSubscribers:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - PayerTransferProcessed

@implementation PayerTransferProcessed

@dynamic transferId;

typedef struct PayerTransferProcessed__storage_ {
  uint32_t _has_storage_[1];
  NSString *transferId;
} PayerTransferProcessed__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferId",
        .dataTypeSpecific.className = NULL,
        .number = PayerTransferProcessed_FieldNumber_TransferId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PayerTransferProcessed__storage_, transferId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PayerTransferProcessed class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PayerTransferProcessed__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PayeeTransferProcessed

@implementation PayeeTransferProcessed

@dynamic transferId;

typedef struct PayeeTransferProcessed__storage_ {
  uint32_t _has_storage_[1];
  NSString *transferId;
} PayeeTransferProcessed__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferId",
        .dataTypeSpecific.className = NULL,
        .number = PayeeTransferProcessed_FieldNumber_TransferId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PayeeTransferProcessed__storage_, transferId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PayeeTransferProcessed class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PayeeTransferProcessed__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PayerTransferFailed

@implementation PayerTransferFailed

@dynamic transferId;

typedef struct PayerTransferFailed__storage_ {
  uint32_t _has_storage_[1];
  NSString *transferId;
} PayerTransferFailed__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferId",
        .dataTypeSpecific.className = NULL,
        .number = PayerTransferFailed_FieldNumber_TransferId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PayerTransferFailed__storage_, transferId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PayerTransferFailed class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PayerTransferFailed__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransferProcessed

@implementation TransferProcessed

@dynamic transferId;

typedef struct TransferProcessed__storage_ {
  uint32_t _has_storage_[1];
  NSString *transferId;
} TransferProcessed__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferId",
        .dataTypeSpecific.className = NULL,
        .number = TransferProcessed_FieldNumber_TransferId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferProcessed__storage_, transferId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferProcessed class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferProcessed__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransferFailed

@implementation TransferFailed

@dynamic transferId;

typedef struct TransferFailed__storage_ {
  uint32_t _has_storage_[1];
  NSString *transferId;
} TransferFailed__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferId",
        .dataTypeSpecific.className = NULL,
        .number = TransferFailed_FieldNumber_TransferId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransferFailed__storage_, transferId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransferFailed class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransferFailed__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - LinkAccounts

@implementation LinkAccounts

@dynamic hasBankAuthorization, bankAuthorization;

typedef struct LinkAccounts__storage_ {
  uint32_t _has_storage_[1];
  BankAuthorization *bankAuthorization;
} LinkAccounts__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "bankAuthorization",
        .dataTypeSpecific.className = GPBStringifySymbol(BankAuthorization),
        .number = LinkAccounts_FieldNumber_BankAuthorization,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(LinkAccounts__storage_, bankAuthorization),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[LinkAccounts class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(LinkAccounts__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - StepUp

@implementation StepUp

@dynamic tokenId;

typedef struct StepUp__storage_ {
  uint32_t _has_storage_[1];
  NSString *tokenId;
} StepUp__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "tokenId",
        .dataTypeSpecific.className = NULL,
        .number = StepUp_FieldNumber_TokenId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StepUp__storage_, tokenId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StepUp class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StepUp__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - BalanceStepUp

@implementation BalanceStepUp

@dynamic accountIdArray, accountIdArray_Count;

typedef struct BalanceStepUp__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *accountIdArray;
} BalanceStepUp__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountIdArray",
        .dataTypeSpecific.className = NULL,
        .number = BalanceStepUp_FieldNumber_AccountIdArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BalanceStepUp__storage_, accountIdArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BalanceStepUp class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BalanceStepUp__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TransactionStepUp

@implementation TransactionStepUp

@dynamic accountId;
@dynamic transactionId;

typedef struct TransactionStepUp__storage_ {
  uint32_t _has_storage_[1];
  NSString *accountId;
  NSString *transactionId;
} TransactionStepUp__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = TransactionStepUp_FieldNumber_AccountId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TransactionStepUp__storage_, accountId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "transactionId",
        .dataTypeSpecific.className = NULL,
        .number = TransactionStepUp_FieldNumber_TransactionId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(TransactionStepUp__storage_, transactionId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TransactionStepUp class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TransactionStepUp__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AddKey

@implementation AddKey

@dynamic name;
@dynamic hasKey, key;
@dynamic expiresMs;

typedef struct AddKey__storage_ {
  uint32_t _has_storage_[1];
  NSString *name;
  Key *key;
  int64_t expiresMs;
} AddKey__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = AddKey_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AddKey__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "key",
        .dataTypeSpecific.className = GPBStringifySymbol(Key),
        .number = AddKey_FieldNumber_Key,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AddKey__storage_, key),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "expiresMs",
        .dataTypeSpecific.className = NULL,
        .number = AddKey_FieldNumber_ExpiresMs,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(AddKey__storage_, expiresMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AddKey class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AddKey__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - LinkAccountsAndAddKey

@implementation LinkAccountsAndAddKey

@dynamic hasLinkAccounts, linkAccounts;
@dynamic hasAddKey, addKey;

typedef struct LinkAccountsAndAddKey__storage_ {
  uint32_t _has_storage_[1];
  LinkAccounts *linkAccounts;
  AddKey *addKey;
} LinkAccountsAndAddKey__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "linkAccounts",
        .dataTypeSpecific.className = GPBStringifySymbol(LinkAccounts),
        .number = LinkAccountsAndAddKey_FieldNumber_LinkAccounts,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(LinkAccountsAndAddKey__storage_, linkAccounts),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "addKey",
        .dataTypeSpecific.className = GPBStringifySymbol(AddKey),
        .number = LinkAccountsAndAddKey_FieldNumber_AddKey,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(LinkAccountsAndAddKey__storage_, addKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[LinkAccountsAndAddKey class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(LinkAccountsAndAddKey__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PaymentRequest

@implementation PaymentRequest

@dynamic hasPayload, payload;

typedef struct PaymentRequest__storage_ {
  uint32_t _has_storage_[1];
  TokenPayload *payload;
} PaymentRequest__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "payload",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenPayload),
        .number = PaymentRequest_FieldNumber_Payload,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PaymentRequest__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PaymentRequest class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PaymentRequest__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - TokenCancelled

@implementation TokenCancelled

@dynamic tokenId;

typedef struct TokenCancelled__storage_ {
  uint32_t _has_storage_[1];
  NSString *tokenId;
} TokenCancelled__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "tokenId",
        .dataTypeSpecific.className = NULL,
        .number = TokenCancelled_FieldNumber_TokenId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(TokenCancelled__storage_, tokenId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[TokenCancelled class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(TokenCancelled__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - NotifyBody

@implementation NotifyBody

@dynamic bodyOneOfCase;
@dynamic payerTransferProcessed;
@dynamic linkAccounts;
@dynamic stepUp;
@dynamic addKey;
@dynamic linkAccountsAndAddKey;
@dynamic payeeTransferProcessed;
@dynamic paymentRequest;
@dynamic payerTransferFailed;
@dynamic transferProcessed;
@dynamic transferFailed;
@dynamic tokenCancelled;
@dynamic balanceStepUp;
@dynamic transactionStepUp;

typedef struct NotifyBody__storage_ {
  uint32_t _has_storage_[2];
  PayerTransferProcessed *payerTransferProcessed;
  LinkAccounts *linkAccounts;
  StepUp *stepUp;
  AddKey *addKey;
  LinkAccountsAndAddKey *linkAccountsAndAddKey;
  PayeeTransferProcessed *payeeTransferProcessed;
  PaymentRequest *paymentRequest;
  PayerTransferFailed *payerTransferFailed;
  TransferProcessed *transferProcessed;
  TransferFailed *transferFailed;
  TokenCancelled *tokenCancelled;
  BalanceStepUp *balanceStepUp;
  TransactionStepUp *transactionStepUp;
} NotifyBody__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "payerTransferProcessed",
        .dataTypeSpecific.className = GPBStringifySymbol(PayerTransferProcessed),
        .number = NotifyBody_FieldNumber_PayerTransferProcessed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, payerTransferProcessed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "linkAccounts",
        .dataTypeSpecific.className = GPBStringifySymbol(LinkAccounts),
        .number = NotifyBody_FieldNumber_LinkAccounts,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, linkAccounts),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "stepUp",
        .dataTypeSpecific.className = GPBStringifySymbol(StepUp),
        .number = NotifyBody_FieldNumber_StepUp,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, stepUp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "addKey",
        .dataTypeSpecific.className = GPBStringifySymbol(AddKey),
        .number = NotifyBody_FieldNumber_AddKey,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, addKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "linkAccountsAndAddKey",
        .dataTypeSpecific.className = GPBStringifySymbol(LinkAccountsAndAddKey),
        .number = NotifyBody_FieldNumber_LinkAccountsAndAddKey,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, linkAccountsAndAddKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payeeTransferProcessed",
        .dataTypeSpecific.className = GPBStringifySymbol(PayeeTransferProcessed),
        .number = NotifyBody_FieldNumber_PayeeTransferProcessed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, payeeTransferProcessed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "paymentRequest",
        .dataTypeSpecific.className = GPBStringifySymbol(PaymentRequest),
        .number = NotifyBody_FieldNumber_PaymentRequest,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, paymentRequest),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "payerTransferFailed",
        .dataTypeSpecific.className = GPBStringifySymbol(PayerTransferFailed),
        .number = NotifyBody_FieldNumber_PayerTransferFailed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, payerTransferFailed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transferProcessed",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferProcessed),
        .number = NotifyBody_FieldNumber_TransferProcessed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, transferProcessed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transferFailed",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferFailed),
        .number = NotifyBody_FieldNumber_TransferFailed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, transferFailed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "tokenCancelled",
        .dataTypeSpecific.className = GPBStringifySymbol(TokenCancelled),
        .number = NotifyBody_FieldNumber_TokenCancelled,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, tokenCancelled),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "balanceStepUp",
        .dataTypeSpecific.className = GPBStringifySymbol(BalanceStepUp),
        .number = NotifyBody_FieldNumber_BalanceStepUp,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, balanceStepUp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "transactionStepUp",
        .dataTypeSpecific.className = GPBStringifySymbol(TransactionStepUp),
        .number = NotifyBody_FieldNumber_TransactionStepUp,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(NotifyBody__storage_, transactionStepUp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[NotifyBody class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(NotifyBody__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
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

void NotifyBody_ClearBodyOneOfCase(NotifyBody *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}
#pragma mark - Notification

@implementation Notification

@dynamic id_p;
@dynamic subscriberId;
@dynamic hasContent, content;
@dynamic status;

typedef struct Notification__storage_ {
  uint32_t _has_storage_[1];
  Notification_Status status;
  NSString *id_p;
  NSString *subscriberId;
  NotificationContent *content;
} Notification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = Notification_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Notification__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "subscriberId",
        .dataTypeSpecific.className = NULL,
        .number = Notification_FieldNumber_SubscriberId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Notification__storage_, subscriberId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "content",
        .dataTypeSpecific.className = GPBStringifySymbol(NotificationContent),
        .number = Notification_FieldNumber_Content,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Notification__storage_, content),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "status",
        .dataTypeSpecific.enumDescFunc = Notification_Status_EnumDescriptor,
        .number = Notification_FieldNumber_Status,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Notification__storage_, status),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Notification class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Notification__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t Notification_Status_RawValue(Notification *message) {
  GPBDescriptor *descriptor = [Notification descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Notification_FieldNumber_Status];
  return GPBGetMessageInt32Field(message, field);
}

void SetNotification_Status_RawValue(Notification *message, int32_t value) {
  GPBDescriptor *descriptor = [Notification descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:Notification_FieldNumber_Status];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum Notification_Status

GPBEnumDescriptor *Notification_Status_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Invalid\000Pending\000Delivered\000";
    static const int32_t values[] = {
        Notification_Status_Invalid,
        Notification_Status_Pending,
        Notification_Status_Delivered,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(Notification_Status)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:Notification_Status_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL Notification_Status_IsValidValue(int32_t value__) {
  switch (value__) {
    case Notification_Status_Invalid:
    case Notification_Status_Pending:
    case Notification_Status_Delivered:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - NotificationContent

@implementation NotificationContent

@dynamic type;
@dynamic title;
@dynamic body;
@dynamic payload;
@dynamic createdAtMs;
@dynamic locKey;
@dynamic locArgsArray, locArgsArray_Count;

typedef struct NotificationContent__storage_ {
  uint32_t _has_storage_[1];
  NSString *type;
  NSString *title;
  NSString *body;
  NSString *payload;
  NSString *locKey;
  NSMutableArray *locArgsArray;
  int64_t createdAtMs;
} NotificationContent__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "type",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_Type,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, type),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "title",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_Title,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, title),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "body",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_Body,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, body),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "payload",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_Payload,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, payload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "createdAtMs",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_CreatedAtMs,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, createdAtMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "locKey",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_LocKey,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, locKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "locArgsArray",
        .dataTypeSpecific.className = NULL,
        .number = NotificationContent_FieldNumber_LocArgsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(NotificationContent__storage_, locArgsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[NotificationContent class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(NotificationContent__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
