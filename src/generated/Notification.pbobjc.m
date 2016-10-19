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
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

#pragma mark - NotificationRoot

@implementation NotificationRoot

@end

#pragma mark - NotificationRoot_FileDescriptor

static GPBFileDescriptor *NotificationRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.notification"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

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
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - LinkAccounts

@implementation LinkAccounts

@dynamic bankId;
@dynamic bankName;
@dynamic accountsLinkPayload;

typedef struct LinkAccounts__storage_ {
  uint32_t _has_storage_[1];
  NSString *bankId;
  NSString *bankName;
  NSString *accountsLinkPayload;
} LinkAccounts__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "bankId",
        .dataTypeSpecific.className = NULL,
        .number = LinkAccounts_FieldNumber_BankId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(LinkAccounts__storage_, bankId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bankName",
        .dataTypeSpecific.className = NULL,
        .number = LinkAccounts_FieldNumber_BankName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(LinkAccounts__storage_, bankName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "accountsLinkPayload",
        .dataTypeSpecific.className = NULL,
        .number = LinkAccounts_FieldNumber_AccountsLinkPayload,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(LinkAccounts__storage_, accountsLinkPayload),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[LinkAccounts class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(LinkAccounts__storage_)
                                         flags:0];
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
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AddKey

@implementation AddKey

@dynamic publicKey;
@dynamic name;

typedef struct AddKey__storage_ {
  uint32_t _has_storage_[1];
  NSString *publicKey;
  NSString *name;
} AddKey__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "publicKey",
        .dataTypeSpecific.className = NULL,
        .number = AddKey_FieldNumber_PublicKey,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AddKey__storage_, publicKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = AddKey_FieldNumber_Name,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AddKey__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AddKey class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AddKey__storage_)
                                         flags:0];
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
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Notification

@implementation Notification

@dynamic notificationOneOfCase;
@dynamic transferProcessed;
@dynamic linkAccounts;
@dynamic stepUp;
@dynamic addKey;
@dynamic linkAccountsAndAddKey;

typedef struct Notification__storage_ {
  uint32_t _has_storage_[2];
  TransferProcessed *transferProcessed;
  LinkAccounts *linkAccounts;
  StepUp *stepUp;
  AddKey *addKey;
  LinkAccountsAndAddKey *linkAccountsAndAddKey;
} Notification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "transferProcessed",
        .dataTypeSpecific.className = GPBStringifySymbol(TransferProcessed),
        .number = Notification_FieldNumber_TransferProcessed,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Notification__storage_, transferProcessed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "linkAccounts",
        .dataTypeSpecific.className = GPBStringifySymbol(LinkAccounts),
        .number = Notification_FieldNumber_LinkAccounts,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Notification__storage_, linkAccounts),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "stepUp",
        .dataTypeSpecific.className = GPBStringifySymbol(StepUp),
        .number = Notification_FieldNumber_StepUp,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Notification__storage_, stepUp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "addKey",
        .dataTypeSpecific.className = GPBStringifySymbol(AddKey),
        .number = Notification_FieldNumber_AddKey,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Notification__storage_, addKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "linkAccountsAndAddKey",
        .dataTypeSpecific.className = GPBStringifySymbol(LinkAccountsAndAddKey),
        .number = Notification_FieldNumber_LinkAccountsAndAddKey,
        .hasIndex = -1,
        .offset = (uint32_t)offsetof(Notification__storage_, linkAccountsAndAddKey),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Notification class]
                                     rootClass:[NotificationRoot class]
                                          file:NotificationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Notification__storage_)
                                         flags:0];
    static const char *oneofs[] = {
      "notification",
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

void Notification_ClearNotificationOneOfCase(Notification *message) {
  GPBDescriptor *descriptor = [message descriptor];
  GPBOneofDescriptor *oneof = [descriptor.oneofs objectAtIndex:0];
  GPBMaybeClearOneof(message, oneof, -1, 0);
}

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
