// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: provider/stet.proto

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

#import "provider/Stet.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#pragma mark - Objective C Class declarations
// Forward declarations of Objective C classes that we can use as
// static values in struct initializers.
// We don't use [Foo class] because it is not a static value.
GPBObjCClassDeclaration(AccountIdentification);
GPBObjCClassDeclaration(Beneficiary);
GPBObjCClassDeclaration(ClearingSystemMemberIdentification);
GPBObjCClassDeclaration(FinancialInstitutionIdentification);
GPBObjCClassDeclaration(GenericIdentification);
GPBObjCClassDeclaration(PartyIdentification);
GPBObjCClassDeclaration(PaymentTypeInformation);
GPBObjCClassDeclaration(PostalAddress);
GPBObjCClassDeclaration(RegulatoryReportingCodes);

#pragma mark - StetRoot

@implementation StetRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - StetRoot_FileDescriptor

static GPBFileDescriptor *StetRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"io.token.proto.common.providerspecific.stet"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - StetAccountDetails

@implementation StetAccountDetails

@dynamic bicFi;
@dynamic hasAccountId, accountId;
@dynamic details;
@dynamic linkedAccount;
@dynamic usage;
@dynamic cashAccountType;
@dynamic product;
@dynamic psuStatus;

typedef struct StetAccountDetails__storage_ {
  uint32_t _has_storage_[1];
  NSString *bicFi;
  AccountIdentification *accountId;
  NSString *details;
  NSString *linkedAccount;
  NSString *usage;
  NSString *cashAccountType;
  NSString *product;
  NSString *psuStatus;
} StetAccountDetails__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "bicFi",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_BicFi,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, bicFi),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "accountId",
        .dataTypeSpecific.clazz = GPBObjCClass(AccountIdentification),
        .number = StetAccountDetails_FieldNumber_AccountId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, accountId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "details",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_Details,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, details),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "linkedAccount",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_LinkedAccount,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, linkedAccount),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "usage",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_Usage,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, usage),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "cashAccountType",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_CashAccountType,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, cashAccountType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "product",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_Product,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, product),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "psuStatus",
        .dataTypeSpecific.clazz = Nil,
        .number = StetAccountDetails_FieldNumber_PsuStatus,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(StetAccountDetails__storage_, psuStatus),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StetAccountDetails class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StetAccountDetails__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\002\t\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - StetTransactionDetails

@implementation StetTransactionDetails

@dynamic entryReference;
@dynamic valueDate;
@dynamic transactionDate;

typedef struct StetTransactionDetails__storage_ {
  uint32_t _has_storage_[1];
  NSString *entryReference;
  NSString *valueDate;
  NSString *transactionDate;
} StetTransactionDetails__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "entryReference",
        .dataTypeSpecific.clazz = Nil,
        .number = StetTransactionDetails_FieldNumber_EntryReference,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StetTransactionDetails__storage_, entryReference),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "valueDate",
        .dataTypeSpecific.clazz = Nil,
        .number = StetTransactionDetails_FieldNumber_ValueDate,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(StetTransactionDetails__storage_, valueDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "transactionDate",
        .dataTypeSpecific.clazz = Nil,
        .number = StetTransactionDetails_FieldNumber_TransactionDate,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(StetTransactionDetails__storage_, transactionDate),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StetTransactionDetails class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StetTransactionDetails__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - StetTransferMetadata

@implementation StetTransferMetadata

@dynamic hasPaymentTypeInformation, paymentTypeInformation;
@dynamic hasDebtorAgent, debtorAgent;
@dynamic hasBeneficiary, beneficiary;
@dynamic endToEndId;
@dynamic executionRule;
@dynamic hasRegulatoryReportingCodes, regulatoryReportingCodes;

typedef struct StetTransferMetadata__storage_ {
  uint32_t _has_storage_[1];
  PaymentTypeInformation *paymentTypeInformation;
  FinancialInstitutionIdentification *debtorAgent;
  Beneficiary *beneficiary;
  NSString *endToEndId;
  NSString *executionRule;
  RegulatoryReportingCodes *regulatoryReportingCodes;
} StetTransferMetadata__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "paymentTypeInformation",
        .dataTypeSpecific.clazz = GPBObjCClass(PaymentTypeInformation),
        .number = StetTransferMetadata_FieldNumber_PaymentTypeInformation,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, paymentTypeInformation),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "debtorAgent",
        .dataTypeSpecific.clazz = GPBObjCClass(FinancialInstitutionIdentification),
        .number = StetTransferMetadata_FieldNumber_DebtorAgent,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, debtorAgent),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "beneficiary",
        .dataTypeSpecific.clazz = GPBObjCClass(Beneficiary),
        .number = StetTransferMetadata_FieldNumber_Beneficiary,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, beneficiary),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "endToEndId",
        .dataTypeSpecific.clazz = Nil,
        .number = StetTransferMetadata_FieldNumber_EndToEndId,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, endToEndId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "executionRule",
        .dataTypeSpecific.clazz = Nil,
        .number = StetTransferMetadata_FieldNumber_ExecutionRule,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, executionRule),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "regulatoryReportingCodes",
        .dataTypeSpecific.clazz = GPBObjCClass(RegulatoryReportingCodes),
        .number = StetTransferMetadata_FieldNumber_RegulatoryReportingCodes,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(StetTransferMetadata__storage_, regulatoryReportingCodes),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[StetTransferMetadata class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(StetTransferMetadata__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - AccountIdentification

@implementation AccountIdentification

@dynamic iban;
@dynamic hasOther, other;
@dynamic currency;

typedef struct AccountIdentification__storage_ {
  uint32_t _has_storage_[1];
  NSString *iban;
  GenericIdentification *other;
  NSString *currency;
} AccountIdentification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "iban",
        .dataTypeSpecific.clazz = Nil,
        .number = AccountIdentification_FieldNumber_Iban,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AccountIdentification__storage_, iban),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "other",
        .dataTypeSpecific.clazz = GPBObjCClass(GenericIdentification),
        .number = AccountIdentification_FieldNumber_Other,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AccountIdentification__storage_, other),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "currency",
        .dataTypeSpecific.clazz = Nil,
        .number = AccountIdentification_FieldNumber_Currency,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(AccountIdentification__storage_, currency),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AccountIdentification class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AccountIdentification__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - GenericIdentification

@implementation GenericIdentification

@dynamic identification;
@dynamic schemeName;
@dynamic issuer;

typedef struct GenericIdentification__storage_ {
  uint32_t _has_storage_[1];
  NSString *identification;
  NSString *schemeName;
  NSString *issuer;
} GenericIdentification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "identification",
        .dataTypeSpecific.clazz = Nil,
        .number = GenericIdentification_FieldNumber_Identification,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(GenericIdentification__storage_, identification),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "schemeName",
        .dataTypeSpecific.clazz = Nil,
        .number = GenericIdentification_FieldNumber_SchemeName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(GenericIdentification__storage_, schemeName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "issuer",
        .dataTypeSpecific.clazz = Nil,
        .number = GenericIdentification_FieldNumber_Issuer,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(GenericIdentification__storage_, issuer),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[GenericIdentification class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GenericIdentification__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PartyIdentification

@implementation PartyIdentification

@dynamic name;
@dynamic hasPostalAddress, postalAddress;
@dynamic hasOrganisationId, organisationId;
@dynamic hasPrivateId, privateId;

typedef struct PartyIdentification__storage_ {
  uint32_t _has_storage_[1];
  NSString *name;
  PostalAddress *postalAddress;
  GenericIdentification *organisationId;
  GenericIdentification *privateId;
} PartyIdentification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.clazz = Nil,
        .number = PartyIdentification_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PartyIdentification__storage_, name),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "postalAddress",
        .dataTypeSpecific.clazz = GPBObjCClass(PostalAddress),
        .number = PartyIdentification_FieldNumber_PostalAddress,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PartyIdentification__storage_, postalAddress),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "organisationId",
        .dataTypeSpecific.clazz = GPBObjCClass(GenericIdentification),
        .number = PartyIdentification_FieldNumber_OrganisationId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PartyIdentification__storage_, organisationId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "privateId",
        .dataTypeSpecific.clazz = GPBObjCClass(GenericIdentification),
        .number = PartyIdentification_FieldNumber_PrivateId,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PartyIdentification__storage_, privateId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PartyIdentification class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PartyIdentification__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PaymentTypeInformation

@implementation PaymentTypeInformation

@dynamic instructionPriority;
@dynamic serviceLevel;
@dynamic localInstrument;
@dynamic categoryPurpose;

typedef struct PaymentTypeInformation__storage_ {
  uint32_t _has_storage_[1];
  NSString *instructionPriority;
  NSString *serviceLevel;
  NSString *localInstrument;
  NSString *categoryPurpose;
} PaymentTypeInformation__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "instructionPriority",
        .dataTypeSpecific.clazz = Nil,
        .number = PaymentTypeInformation_FieldNumber_InstructionPriority,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PaymentTypeInformation__storage_, instructionPriority),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "serviceLevel",
        .dataTypeSpecific.clazz = Nil,
        .number = PaymentTypeInformation_FieldNumber_ServiceLevel,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PaymentTypeInformation__storage_, serviceLevel),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "localInstrument",
        .dataTypeSpecific.clazz = Nil,
        .number = PaymentTypeInformation_FieldNumber_LocalInstrument,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PaymentTypeInformation__storage_, localInstrument),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "categoryPurpose",
        .dataTypeSpecific.clazz = Nil,
        .number = PaymentTypeInformation_FieldNumber_CategoryPurpose,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PaymentTypeInformation__storage_, categoryPurpose),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PaymentTypeInformation class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PaymentTypeInformation__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - FinancialInstitutionIdentification

@implementation FinancialInstitutionIdentification

@dynamic bicFi;
@dynamic hasClearingSystemMemberId, clearingSystemMemberId;
@dynamic name;
@dynamic hasPostalAddress, postalAddress;

typedef struct FinancialInstitutionIdentification__storage_ {
  uint32_t _has_storage_[1];
  NSString *bicFi;
  ClearingSystemMemberIdentification *clearingSystemMemberId;
  NSString *name;
  PostalAddress *postalAddress;
} FinancialInstitutionIdentification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "bicFi",
        .dataTypeSpecific.clazz = Nil,
        .number = FinancialInstitutionIdentification_FieldNumber_BicFi,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(FinancialInstitutionIdentification__storage_, bicFi),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "clearingSystemMemberId",
        .dataTypeSpecific.clazz = GPBObjCClass(ClearingSystemMemberIdentification),
        .number = FinancialInstitutionIdentification_FieldNumber_ClearingSystemMemberId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(FinancialInstitutionIdentification__storage_, clearingSystemMemberId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "name",
        .dataTypeSpecific.clazz = Nil,
        .number = FinancialInstitutionIdentification_FieldNumber_Name,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(FinancialInstitutionIdentification__storage_, name),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "postalAddress",
        .dataTypeSpecific.clazz = GPBObjCClass(PostalAddress),
        .number = FinancialInstitutionIdentification_FieldNumber_PostalAddress,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(FinancialInstitutionIdentification__storage_, postalAddress),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[FinancialInstitutionIdentification class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(FinancialInstitutionIdentification__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - ClearingSystemMemberIdentification

@implementation ClearingSystemMemberIdentification

@dynamic clearingSystemId;
@dynamic memberId;

typedef struct ClearingSystemMemberIdentification__storage_ {
  uint32_t _has_storage_[1];
  NSString *clearingSystemId;
  NSString *memberId;
} ClearingSystemMemberIdentification__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "clearingSystemId",
        .dataTypeSpecific.clazz = Nil,
        .number = ClearingSystemMemberIdentification_FieldNumber_ClearingSystemId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ClearingSystemMemberIdentification__storage_, clearingSystemId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "memberId",
        .dataTypeSpecific.clazz = Nil,
        .number = ClearingSystemMemberIdentification_FieldNumber_MemberId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ClearingSystemMemberIdentification__storage_, memberId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ClearingSystemMemberIdentification class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ClearingSystemMemberIdentification__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PostalAddress

@implementation PostalAddress

@dynamic country;
@dynamic addressLineArray, addressLineArray_Count;

typedef struct PostalAddress__storage_ {
  uint32_t _has_storage_[1];
  NSString *country;
  NSMutableArray *addressLineArray;
} PostalAddress__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "country",
        .dataTypeSpecific.clazz = Nil,
        .number = PostalAddress_FieldNumber_Country,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PostalAddress__storage_, country),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "addressLineArray",
        .dataTypeSpecific.clazz = Nil,
        .number = PostalAddress_FieldNumber_AddressLineArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PostalAddress__storage_, addressLineArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PostalAddress class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PostalAddress__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Beneficiary

@implementation Beneficiary

@dynamic id_p;
@dynamic hasCreditorAgent, creditorAgent;
@dynamic hasCreditor, creditor;
@dynamic hasCreditorAccount, creditorAccount;

typedef struct Beneficiary__storage_ {
  uint32_t _has_storage_[1];
  NSString *id_p;
  FinancialInstitutionIdentification *creditorAgent;
  PartyIdentification *creditor;
  AccountIdentification *creditorAccount;
} Beneficiary__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.clazz = Nil,
        .number = Beneficiary_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Beneficiary__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldClearHasIvarOnZero),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "creditorAgent",
        .dataTypeSpecific.clazz = GPBObjCClass(FinancialInstitutionIdentification),
        .number = Beneficiary_FieldNumber_CreditorAgent,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Beneficiary__storage_, creditorAgent),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "creditor",
        .dataTypeSpecific.clazz = GPBObjCClass(PartyIdentification),
        .number = Beneficiary_FieldNumber_Creditor,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Beneficiary__storage_, creditor),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "creditorAccount",
        .dataTypeSpecific.clazz = GPBObjCClass(AccountIdentification),
        .number = Beneficiary_FieldNumber_CreditorAccount,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Beneficiary__storage_, creditorAccount),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Beneficiary class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Beneficiary__storage_)
                                         flags:(GPBDescriptorInitializationFlags)(GPBDescriptorInitializationFlag_UsesClassRefs | GPBDescriptorInitializationFlag_Proto3OptionalKnown)];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RegulatoryReportingCodes

@implementation RegulatoryReportingCodes

@dynamic regulatoryReportingCodeArray, regulatoryReportingCodeArray_Count;

typedef struct RegulatoryReportingCodes__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *regulatoryReportingCodeArray;
} RegulatoryReportingCodes__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "regulatoryReportingCodeArray",
        .dataTypeSpecific.clazz = Nil,
        .number = RegulatoryReportingCodes_FieldNumber_RegulatoryReportingCodeArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(RegulatoryReportingCodes__storage_, regulatoryReportingCodeArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RegulatoryReportingCodes class]
                                     rootClass:[StetRoot class]
                                          file:StetRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RegulatoryReportingCodes__storage_)
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
