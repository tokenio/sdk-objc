// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: bankinfo.proto

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

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - BankinfoRoot

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
@interface BankinfoRoot : GPBRootObject
@end

#pragma mark - Bank

typedef GPB_ENUM(Bank_FieldNumber) {
  Bank_FieldNumber_Id_p = 1,
  Bank_FieldNumber_Name = 2,
  Bank_FieldNumber_LogoUri = 3,
};

@interface Bank : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *id_p;

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@property(nonatomic, readwrite, copy, null_resettable) NSString *logoUri;

@end

#pragma mark - BankInfo

typedef GPB_ENUM(BankInfo_FieldNumber) {
  BankInfo_FieldNumber_LinkingUri = 1,
  BankInfo_FieldNumber_RedirectUriRegex = 2,
};

@interface BankInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *linkingUri;

@property(nonatomic, readwrite, copy, null_resettable) NSString *redirectUriRegex;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
