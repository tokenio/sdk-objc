// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: bankinfo.proto

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

#import "Bankinfo.pbobjc.h"
#import "Alias.pbobjc.h"
#import "extensions/Field.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - BankinfoRoot

@implementation BankinfoRoot

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

#pragma mark - BankinfoRoot_FileDescriptor

static GPBFileDescriptor *BankinfoRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.bank"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Bank

@implementation Bank

@dynamic id_p;
@dynamic name;
@dynamic logoUri;
@dynamic fullLogoUri;
@dynamic supportsAppless;
@dynamic supportsGuestCheckout;
@dynamic supportsInformation;
@dynamic requiresExternalAuth;
@dynamic supportsSendPayment;
@dynamic supportsReceivePayment;
@dynamic supportsBalance;
@dynamic supportsScheduledPayment;
@dynamic supportsStandingOrder;
@dynamic supportsBulkTransfer;
@dynamic requiresLegacyTransfer;
@dynamic requiresOneStepPayment;
@dynamic supportsLinkingUri;
@dynamic provider;
@dynamic country;
@dynamic identifier;
@dynamic supportedTransferDestinationTypesArray, supportedTransferDestinationTypesArray_Count;
@dynamic supportsAisGuestCheckout;

typedef struct Bank__storage_ {
  uint32_t _has_storage_[2];
  NSString *id_p;
  NSString *name;
  NSString *logoUri;
  NSString *fullLogoUri;
  NSString *provider;
  NSString *country;
  NSString *identifier;
  NSMutableArray *supportedTransferDestinationTypesArray;
} Bank__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Bank__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_Name,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Bank__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "logoUri",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_LogoUri,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Bank__storage_, logoUri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "fullLogoUri",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_FullLogoUri,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Bank__storage_, fullLogoUri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "supportsAppless",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsAppless,
        .hasIndex = 4,
        .offset = 5,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsInformation",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsInformation,
        .hasIndex = 8,
        .offset = 9,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "requiresExternalAuth",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_RequiresExternalAuth,
        .hasIndex = 10,
        .offset = 11,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsSendPayment",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsSendPayment,
        .hasIndex = 12,
        .offset = 13,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsReceivePayment",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsReceivePayment,
        .hasIndex = 14,
        .offset = 15,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "provider",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_Provider,
        .hasIndex = 30,
        .offset = (uint32_t)offsetof(Bank__storage_, provider),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "country",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_Country,
        .hasIndex = 31,
        .offset = (uint32_t)offsetof(Bank__storage_, country),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "identifier",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_Identifier,
        .hasIndex = 32,
        .offset = (uint32_t)offsetof(Bank__storage_, identifier),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "requiresLegacyTransfer",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_RequiresLegacyTransfer,
        .hasIndex = 24,
        .offset = 25,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsGuestCheckout",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsGuestCheckout,
        .hasIndex = 6,
        .offset = 7,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsBalance",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsBalance,
        .hasIndex = 16,
        .offset = 17,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "requiresOneStepPayment",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_RequiresOneStepPayment,
        .hasIndex = 26,
        .offset = 27,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsScheduledPayment",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsScheduledPayment,
        .hasIndex = 18,
        .offset = 19,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsStandingOrder",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsStandingOrder,
        .hasIndex = 20,
        .offset = 21,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsBulkTransfer",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsBulkTransfer,
        .hasIndex = 22,
        .offset = 23,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportedTransferDestinationTypesArray",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportedTransferDestinationTypesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(Bank__storage_, supportedTransferDestinationTypesArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "supportsLinkingUri",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsLinkingUri,
        .hasIndex = 28,
        .offset = 29,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "supportsAisGuestCheckout",
        .dataTypeSpecific.className = NULL,
        .number = Bank_FieldNumber_SupportsAisGuestCheckout,
        .hasIndex = 33,
        .offset = 34,  // Stored in _has_storage_ to save space.
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBool,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Bank class]
                                     rootClass:[BankinfoRoot class]
                                          file:BankinfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Bank__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - BankInfo

@implementation BankInfo

@dynamic linkingUri;
@dynamic redirectUriRegex;
@dynamic bankLinkingUri;
@dynamic realmArray, realmArray_Count;
@dynamic customAliasLabel;
@dynamic aliasTypesArray, aliasTypesArray_Count;

typedef struct BankInfo__storage_ {
  uint32_t _has_storage_[1];
  NSString *linkingUri;
  NSString *redirectUriRegex;
  NSString *bankLinkingUri;
  NSMutableArray *realmArray;
  NSString *customAliasLabel;
  GPBEnumArray *aliasTypesArray;
} BankInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "linkingUri",
        .dataTypeSpecific.className = NULL,
        .number = BankInfo_FieldNumber_LinkingUri,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BankInfo__storage_, linkingUri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "redirectUriRegex",
        .dataTypeSpecific.className = NULL,
        .number = BankInfo_FieldNumber_RedirectUriRegex,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BankInfo__storage_, redirectUriRegex),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bankLinkingUri",
        .dataTypeSpecific.className = NULL,
        .number = BankInfo_FieldNumber_BankLinkingUri,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BankInfo__storage_, bankLinkingUri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "realmArray",
        .dataTypeSpecific.className = NULL,
        .number = BankInfo_FieldNumber_RealmArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BankInfo__storage_, realmArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "customAliasLabel",
        .dataTypeSpecific.className = NULL,
        .number = BankInfo_FieldNumber_CustomAliasLabel,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(BankInfo__storage_, customAliasLabel),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "aliasTypesArray",
        .dataTypeSpecific.enumDescFunc = Alias_Type_EnumDescriptor,
        .number = BankInfo_FieldNumber_AliasTypesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BankInfo__storage_, aliasTypesArray),
        .flags = (GPBFieldFlags)(GPBFieldRepeated | GPBFieldPacked | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BankInfo class]
                                     rootClass:[BankinfoRoot class]
                                          file:BankinfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BankInfo__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Paging

@implementation Paging

@dynamic page;
@dynamic perPage;
@dynamic pageCount;
@dynamic totalCount;

typedef struct Paging__storage_ {
  uint32_t _has_storage_[1];
  int32_t page;
  int32_t perPage;
  int32_t pageCount;
  int32_t totalCount;
} Paging__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "page",
        .dataTypeSpecific.className = NULL,
        .number = Paging_FieldNumber_Page,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Paging__storage_, page),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "perPage",
        .dataTypeSpecific.className = NULL,
        .number = Paging_FieldNumber_PerPage,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Paging__storage_, perPage),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "pageCount",
        .dataTypeSpecific.className = NULL,
        .number = Paging_FieldNumber_PageCount,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Paging__storage_, pageCount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "totalCount",
        .dataTypeSpecific.className = NULL,
        .number = Paging_FieldNumber_TotalCount,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Paging__storage_, totalCount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Paging class]
                                     rootClass:[BankinfoRoot class]
                                          file:BankinfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Paging__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - BankFilter

@implementation BankFilter

@dynamic provider;
@dynamic tppId;
@dynamic destinationCountry;
@dynamic country;
@dynamic idsArray, idsArray_Count;
@dynamic search;
@dynamic requiresBankFeatures, requiresBankFeatures_Count;
@dynamic hasBankFeatures, bankFeatures;

typedef struct BankFilter__storage_ {
  uint32_t _has_storage_[1];
  NSString *provider;
  NSString *tppId;
  NSString *destinationCountry;
  NSString *country;
  NSMutableArray *idsArray;
  NSString *search;
  NSMutableDictionary *requiresBankFeatures;
  BankFilter_BankFeatures *bankFeatures;
} BankFilter__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "provider",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_Provider,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BankFilter__storage_, provider),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "tppId",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_TppId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BankFilter__storage_, tppId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "destinationCountry",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_DestinationCountry,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BankFilter__storage_, destinationCountry),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "country",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_Country,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(BankFilter__storage_, country),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "idsArray",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_IdsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BankFilter__storage_, idsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "search",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_Search,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(BankFilter__storage_, search),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "requiresBankFeatures",
        .dataTypeSpecific.className = NULL,
        .number = BankFilter_FieldNumber_RequiresBankFeatures,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(BankFilter__storage_, requiresBankFeatures),
        .flags = GPBFieldMapKeyString,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bankFeatures",
        .dataTypeSpecific.className = GPBStringifySymbol(BankFilter_BankFeatures),
        .number = BankFilter_FieldNumber_BankFeatures,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(BankFilter__storage_, bankFeatures),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BankFilter class]
                                     rootClass:[BankinfoRoot class]
                                          file:BankinfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BankFilter__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - BankFilter_BankFeatures

@implementation BankFilter_BankFeatures

@dynamic hasSupportsAppless, supportsAppless;
@dynamic hasSupportsGuestCheckout, supportsGuestCheckout;
@dynamic hasSupportsInformation, supportsInformation;
@dynamic hasRequiresExternalAuth, requiresExternalAuth;
@dynamic hasSupportsSendPayment, supportsSendPayment;
@dynamic hasSupportsReceivePayment, supportsReceivePayment;
@dynamic hasSupportsBalance, supportsBalance;
@dynamic hasSupportsScheduledPayment, supportsScheduledPayment;
@dynamic hasSupportsStandingOrder, supportsStandingOrder;
@dynamic hasSupportsBulkTransfer, supportsBulkTransfer;
@dynamic hasRequiresOneStepPayment, requiresOneStepPayment;
@dynamic hasSupportsLinkingUri, supportsLinkingUri;
@dynamic hasSupportsAisGuestCheckout, supportsAisGuestCheckout;

typedef struct BankFilter_BankFeatures__storage_ {
  uint32_t _has_storage_[1];
  GPBBoolValue *supportsAppless;
  GPBBoolValue *supportsGuestCheckout;
  GPBBoolValue *supportsInformation;
  GPBBoolValue *requiresExternalAuth;
  GPBBoolValue *supportsSendPayment;
  GPBBoolValue *supportsReceivePayment;
  GPBBoolValue *supportsBalance;
  GPBBoolValue *supportsScheduledPayment;
  GPBBoolValue *supportsStandingOrder;
  GPBBoolValue *supportsBulkTransfer;
  GPBBoolValue *requiresOneStepPayment;
  GPBBoolValue *supportsLinkingUri;
  GPBBoolValue *supportsAisGuestCheckout;
} BankFilter_BankFeatures__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "supportsAppless",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsAppless,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsAppless),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsGuestCheckout",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsGuestCheckout,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsGuestCheckout),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsInformation",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsInformation,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsInformation),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "requiresExternalAuth",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_RequiresExternalAuth,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, requiresExternalAuth),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsSendPayment",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsSendPayment,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsSendPayment),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsReceivePayment",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsReceivePayment,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsReceivePayment),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsBalance",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsBalance,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsBalance),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsScheduledPayment",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsScheduledPayment,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsScheduledPayment),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsStandingOrder",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsStandingOrder,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsStandingOrder),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsBulkTransfer",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsBulkTransfer,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsBulkTransfer),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "requiresOneStepPayment",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_RequiresOneStepPayment,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, requiresOneStepPayment),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsLinkingUri",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsLinkingUri,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsLinkingUri),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "supportsAisGuestCheckout",
        .dataTypeSpecific.className = GPBStringifySymbol(GPBBoolValue),
        .number = BankFilter_BankFeatures_FieldNumber_SupportsAisGuestCheckout,
        .hasIndex = 12,
        .offset = (uint32_t)offsetof(BankFilter_BankFeatures__storage_, supportsAisGuestCheckout),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[BankFilter_BankFeatures class]
                                     rootClass:[BankinfoRoot class]
                                          file:BankinfoRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(BankFilter_BankFeatures__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
    [localDescriptor setupContainingMessageClassName:GPBStringifySymbol(BankFilter)];
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
