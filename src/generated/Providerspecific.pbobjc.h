// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: providerspecific.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class Cma9AccountDetails;
@class Cma9StandingOrderDetails;
@class NextGenPsd2AccountDetails;
@class NextGenPsd2TransactionDetails;
@class NextGenPsd2TransferMetadata;
@class POLISHAPIPolishApiAccountDetails;
@class POLISHAPIPolishApiTransactionDetails;
@class POLISHAPIPolishApiTransferMetadata;
@class StetAccountDetails;
@class StetTransactionDetails;
@class StetTransferMetadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ProviderspecificRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface ProviderspecificRoot : GPBRootObject
@end

#pragma mark - ProviderAccountDetails

typedef GPB_ENUM(ProviderAccountDetails_FieldNumber) {
  ProviderAccountDetails_FieldNumber_Cma9AccountDetails = 1,
  ProviderAccountDetails_FieldNumber_PolishApiAccountDetails = 2,
  ProviderAccountDetails_FieldNumber_NextGenPsd2AccountDetails = 3,
  ProviderAccountDetails_FieldNumber_StetAccountDetails = 4,
};

typedef GPB_ENUM(ProviderAccountDetails_Details_OneOfCase) {
  ProviderAccountDetails_Details_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderAccountDetails_Details_OneOfCase_Cma9AccountDetails = 1,
  ProviderAccountDetails_Details_OneOfCase_PolishApiAccountDetails = 2,
  ProviderAccountDetails_Details_OneOfCase_NextGenPsd2AccountDetails = 3,
  ProviderAccountDetails_Details_OneOfCase_StetAccountDetails = 4,
};

GPB_FINAL @interface ProviderAccountDetails : GPBMessage

@property(nonatomic, readonly) ProviderAccountDetails_Details_OneOfCase detailsOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) Cma9AccountDetails *cma9AccountDetails;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiAccountDetails *polishApiAccountDetails;

@property(nonatomic, readwrite, strong, null_resettable) NextGenPsd2AccountDetails *nextGenPsd2AccountDetails;

@property(nonatomic, readwrite, strong, null_resettable) StetAccountDetails *stetAccountDetails;

@end

/**
 * Clears whatever value was set for the oneof 'details'.
 **/
void ProviderAccountDetails_ClearDetailsOneOfCase(ProviderAccountDetails *message);

#pragma mark - ProviderTransactionDetails

typedef GPB_ENUM(ProviderTransactionDetails_FieldNumber) {
  ProviderTransactionDetails_FieldNumber_PolishApiTransactionDetails = 1,
  ProviderTransactionDetails_FieldNumber_NextGenPsd2TransactionDetails = 3,
  ProviderTransactionDetails_FieldNumber_StetTransactionDetails = 4,
};

typedef GPB_ENUM(ProviderTransactionDetails_Details_OneOfCase) {
  ProviderTransactionDetails_Details_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderTransactionDetails_Details_OneOfCase_PolishApiTransactionDetails = 1,
  ProviderTransactionDetails_Details_OneOfCase_NextGenPsd2TransactionDetails = 3,
  ProviderTransactionDetails_Details_OneOfCase_StetTransactionDetails = 4,
};

GPB_FINAL @interface ProviderTransactionDetails : GPBMessage

@property(nonatomic, readonly) ProviderTransactionDetails_Details_OneOfCase detailsOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiTransactionDetails *polishApiTransactionDetails;

@property(nonatomic, readwrite, strong, null_resettable) NextGenPsd2TransactionDetails *nextGenPsd2TransactionDetails;

@property(nonatomic, readwrite, strong, null_resettable) StetTransactionDetails *stetTransactionDetails;

@end

/**
 * Clears whatever value was set for the oneof 'details'.
 **/
void ProviderTransactionDetails_ClearDetailsOneOfCase(ProviderTransactionDetails *message);

#pragma mark - ProviderStandingOrderDetails

typedef GPB_ENUM(ProviderStandingOrderDetails_FieldNumber) {
  ProviderStandingOrderDetails_FieldNumber_Cma9StandingOrderDetails = 1,
};

typedef GPB_ENUM(ProviderStandingOrderDetails_Details_OneOfCase) {
  ProviderStandingOrderDetails_Details_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderStandingOrderDetails_Details_OneOfCase_Cma9StandingOrderDetails = 1,
};

GPB_FINAL @interface ProviderStandingOrderDetails : GPBMessage

@property(nonatomic, readonly) ProviderStandingOrderDetails_Details_OneOfCase detailsOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) Cma9StandingOrderDetails *cma9StandingOrderDetails;

@end

/**
 * Clears whatever value was set for the oneof 'details'.
 **/
void ProviderStandingOrderDetails_ClearDetailsOneOfCase(ProviderStandingOrderDetails *message);

#pragma mark - ProviderTransferMetadata

typedef GPB_ENUM(ProviderTransferMetadata_FieldNumber) {
  ProviderTransferMetadata_FieldNumber_PolishApiTransferMetadata = 1,
  ProviderTransferMetadata_FieldNumber_NextGenPsd2TransferMetadata = 2,
  ProviderTransferMetadata_FieldNumber_StetTransferMetadata = 3,
};

typedef GPB_ENUM(ProviderTransferMetadata_Metadata_OneOfCase) {
  ProviderTransferMetadata_Metadata_OneOfCase_GPBUnsetOneOfCase = 0,
  ProviderTransferMetadata_Metadata_OneOfCase_PolishApiTransferMetadata = 1,
  ProviderTransferMetadata_Metadata_OneOfCase_NextGenPsd2TransferMetadata = 2,
  ProviderTransferMetadata_Metadata_OneOfCase_StetTransferMetadata = 3,
};

GPB_FINAL @interface ProviderTransferMetadata : GPBMessage

@property(nonatomic, readonly) ProviderTransferMetadata_Metadata_OneOfCase metadataOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) POLISHAPIPolishApiTransferMetadata *polishApiTransferMetadata;

@property(nonatomic, readwrite, strong, null_resettable) NextGenPsd2TransferMetadata *nextGenPsd2TransferMetadata;

@property(nonatomic, readwrite, strong, null_resettable) StetTransferMetadata *stetTransferMetadata;

@end

/**
 * Clears whatever value was set for the oneof 'metadata'.
 **/
void ProviderTransferMetadata_ClearMetadataOneOfCase(ProviderTransferMetadata *message);

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
