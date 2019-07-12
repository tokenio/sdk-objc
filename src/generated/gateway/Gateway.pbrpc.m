#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "gateway/Gateway.pbrpc.h"
#import "gateway/Gateway.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import "google/api/Annotations.pbobjc.h"
#import "Account.pbobjc.h"
#import "Address.pbobjc.h"
#import "Bankinfo.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Blob.pbobjc.h"
#import "Consent.pbobjc.h"
#import "Eidas.pbobjc.h"
#import "Alias.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Notification.pbobjc.h"
#import "Security.pbobjc.h"
#import "Subscriber.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "extensions/Field.pbobjc.h"
#import "extensions/Service.pbobjc.h"

@implementation GatewayService

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"io.token.proto.gateway"
                 serviceName:@"GatewayService"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"io.token.proto.gateway"
                 serviceName:@"GatewayService"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

// Deprecated methods.
/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
 */
- (GRPCUnaryProtoCall *)createMemberWithMessage:(CreateMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateMember"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateMemberResponse class]];
}

#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

// Deprecated methods.
/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)updateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
 */
- (GRPCUnaryProtoCall *)updateMemberWithMessage:(UpdateMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UpdateMember"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UpdateMemberResponse class]];
}

#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

// Deprecated methods.
/**
 * Get information about a member
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about a member
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get information about a member
 */
- (GRPCUnaryProtoCall *)getMemberWithMessage:(GetMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetMember"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetMemberResponse class]];
}

#pragma mark SetProfile(SetProfileRequest) returns (SetProfileResponse)

// Deprecated methods.
/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)setProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetProfileWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSetProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetProfile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetProfileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)setProfileWithMessage:(SetProfileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SetProfile"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SetProfileResponse class]];
}

#pragma mark GetProfile(GetProfileRequest) returns (GetProfileResponse)

// Deprecated methods.
/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetProfileWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetProfile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetProfileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)getProfileWithMessage:(GetProfileRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetProfile"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetProfileResponse class]];
}

#pragma mark SetProfilePicture(SetProfilePictureRequest) returns (SetProfilePictureResponse)

// Deprecated methods.
/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)setProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetProfilePictureWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSetProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetProfilePicture"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetProfilePictureResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)setProfilePictureWithMessage:(SetProfilePictureRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SetProfilePicture"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SetProfilePictureResponse class]];
}

#pragma mark GetProfilePicture(GetProfilePictureRequest) returns (GetProfilePictureResponse)

// Deprecated methods.
/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetProfilePictureWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetProfilePicture"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetProfilePictureResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCUnaryProtoCall *)getProfilePictureWithMessage:(GetProfilePictureRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetProfilePicture"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetProfilePictureResponse class]];
}

#pragma mark SetReceiptContact(SetReceiptContactRequest) returns (SetReceiptContactResponse)

// Deprecated methods.
/**
 * Set a member's contact (e.g. email) for receipt delivery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)setReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetReceiptContactWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Set a member's contact (e.g. email) for receipt delivery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSetReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetReceiptContact"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetReceiptContactResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (GRPCUnaryProtoCall *)setReceiptContactWithMessage:(SetReceiptContactRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SetReceiptContact"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SetReceiptContactResponse class]];
}

#pragma mark GetReceiptContact(GetReceiptContactRequest) returns (GetReceiptContactResponse)

// Deprecated methods.
/**
 * Get a member's email address for receipts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetReceiptContactWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get a member's email address for receipts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetReceiptContact"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetReceiptContactResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get a member's email address for receipts
 */
- (GRPCUnaryProtoCall *)getReceiptContactWithMessage:(GetReceiptContactRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetReceiptContact"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetReceiptContactResponse class]];
}

#pragma mark ResolveAlias(ResolveAliasRequest) returns (ResolveAliasResponse)

// Deprecated methods.
/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ResolveAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCUnaryProtoCall *)resolveAliasWithMessage:(ResolveAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ResolveAlias"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ResolveAliasResponse class]];
}

#pragma mark GetAliases(GetAliasesRequest) returns (GetAliasesResponse)

// Deprecated methods.
/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAliasesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAliases"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAliasesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCUnaryProtoCall *)getAliasesWithMessage:(GetAliasesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAliases"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAliasesResponse class]];
}

#pragma mark CompleteVerification(CompleteVerificationRequest) returns (CompleteVerificationResponse)

// Deprecated methods.
/**
 * Use a verification code
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)completeVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCompleteVerificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use a verification code
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCompleteVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CompleteVerification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CompleteVerificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Use a verification code
 */
- (GRPCUnaryProtoCall *)completeVerificationWithMessage:(CompleteVerificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CompleteVerification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CompleteVerificationResponse class]];
}

#pragma mark RetryVerification(RetryVerificationRequest) returns (RetryVerificationResponse)

// Deprecated methods.
/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)retryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRetryVerificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRetryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RetryVerification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RetryVerificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (GRPCUnaryProtoCall *)retryVerificationWithMessage:(RetryVerificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RetryVerification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RetryVerificationResponse class]];
}

#pragma mark GetPairedDevices(GetPairedDevicesRequest) returns (GetPairedDevicesResponse)

// Deprecated methods.
/**
 * Get auth'd members paired devices (as created by provisionDevice)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPairedDevicesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get auth'd members paired devices (as created by provisionDevice)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPairedDevices"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPairedDevicesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (GRPCUnaryProtoCall *)getPairedDevicesWithMessage:(GetPairedDevicesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetPairedDevices"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetPairedDevicesResponse class]];
}

#pragma mark DeleteMember(DeleteMemberRequest) returns (DeleteMemberResponse)

// Deprecated methods.
- (void)deleteMemberWithRequest:(DeleteMemberRequest *)request handler:(void(^)(DeleteMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeleteMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToDeleteMemberWithRequest:(DeleteMemberRequest *)request handler:(void(^)(DeleteMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeleteMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)deleteMemberWithMessage:(DeleteMemberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DeleteMember"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DeleteMemberResponse class]];
}

#pragma mark NormalizeAlias(NormalizeAliasRequest) returns (NormalizeAliasResponse)

// Deprecated methods.
- (void)normalizeAliasWithRequest:(NormalizeAliasRequest *)request handler:(void(^)(NormalizeAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNormalizeAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToNormalizeAliasWithRequest:(NormalizeAliasRequest *)request handler:(void(^)(NormalizeAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"NormalizeAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NormalizeAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)normalizeAliasWithMessage:(NormalizeAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"NormalizeAlias"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[NormalizeAliasResponse class]];
}

#pragma mark VerifyAffiliate(VerifyAffiliateRequest) returns (VerifyAffiliateResponse)

// Deprecated methods.
- (void)verifyAffiliateWithRequest:(VerifyAffiliateRequest *)request handler:(void(^)(VerifyAffiliateResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyAffiliateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToVerifyAffiliateWithRequest:(VerifyAffiliateRequest *)request handler:(void(^)(VerifyAffiliateResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyAffiliate"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyAffiliateResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)verifyAffiliateWithMessage:(VerifyAffiliateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyAffiliate"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[VerifyAffiliateResponse class]];
}

#pragma mark SetAppCallbackUrl(SetAppCallbackUrlRequest) returns (SetAppCallbackUrlResponse)

// Deprecated methods.
- (void)setAppCallbackUrlWithRequest:(SetAppCallbackUrlRequest *)request handler:(void(^)(SetAppCallbackUrlResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetAppCallbackUrlWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSetAppCallbackUrlWithRequest:(SetAppCallbackUrlRequest *)request handler:(void(^)(SetAppCallbackUrlResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetAppCallbackUrl"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetAppCallbackUrlResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)setAppCallbackUrlWithMessage:(SetAppCallbackUrlRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SetAppCallbackUrl"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SetAppCallbackUrlResponse class]];
}

#pragma mark BeginRecovery(BeginRecoveryRequest) returns (BeginRecoveryResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)beginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToBeginRecoveryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToBeginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"BeginRecovery"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BeginRecoveryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)beginRecoveryWithMessage:(BeginRecoveryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"BeginRecovery"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[BeginRecoveryResponse class]];
}

#pragma mark CompleteRecovery(CompleteRecoveryRequest) returns (CompleteRecoveryResponse)

// Deprecated methods.
/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)completeRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCompleteRecoveryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCompleteRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CompleteRecovery"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CompleteRecoveryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)completeRecoveryWithMessage:(CompleteRecoveryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CompleteRecovery"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CompleteRecoveryResponse class]];
}

#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

// Deprecated methods.
/**
 * Verify an alias
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)verifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Verify an alias
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToVerifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Verify an alias
 */
- (GRPCUnaryProtoCall *)verifyAliasWithMessage:(VerifyAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyAlias"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[VerifyAliasResponse class]];
}

#pragma mark VerifyEidas(VerifyEidasRequest) returns (VerifyEidasResponse)

// Deprecated methods.
/**
 * Verify an eidas
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)verifyEidasWithRequest:(VerifyEidasRequest *)request handler:(void(^)(VerifyEidasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyEidasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Verify an eidas
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToVerifyEidasWithRequest:(VerifyEidasRequest *)request handler:(void(^)(VerifyEidasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyEidas"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyEidasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Verify an eidas
 */
- (GRPCUnaryProtoCall *)verifyEidasWithMessage:(VerifyEidasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyEidas"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[VerifyEidasResponse class]];
}

#pragma mark GetDefaultAgent(GetDefaultAgentRequest) returns (GetDefaultAgentResponse)

// Deprecated methods.
/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetDefaultAgentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetDefaultAgent"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetDefaultAgentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCUnaryProtoCall *)getDefaultAgentWithMessage:(GetDefaultAgentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetDefaultAgent"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetDefaultAgentResponse class]];
}

#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)addAddressWithMessage:(AddAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddAddress"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddAddressResponse class]];
}

#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

// Deprecated methods.
/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)getAddressWithMessage:(GetAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAddress"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAddressResponse class]];
}

#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

// Deprecated methods.
/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddresses"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)getAddressesWithMessage:(GetAddressesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAddresses"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAddressesResponse class]];
}

#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

// Deprecated methods.
/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeleteAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeleteAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCUnaryProtoCall *)deleteAddressWithMessage:(DeleteAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DeleteAddress"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DeleteAddressResponse class]];
}

#pragma mark AddTrustedBeneficiary(AddTrustedBeneficiaryRequest) returns (AddTrustedBeneficiaryResponse)

// Deprecated methods.
/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddTrustedBeneficiaryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddTrustedBeneficiary"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddTrustedBeneficiaryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)addTrustedBeneficiaryWithMessage:(AddTrustedBeneficiaryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddTrustedBeneficiary"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddTrustedBeneficiaryResponse class]];
}

#pragma mark RemoveTrustedBeneficiary(RemoveTrustedBeneficiaryRequest) returns (RemoveTrustedBeneficiaryResponse)

// Deprecated methods.
/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)removeTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveTrustedBeneficiaryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRemoveTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveTrustedBeneficiary"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RemoveTrustedBeneficiaryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)removeTrustedBeneficiaryWithMessage:(RemoveTrustedBeneficiaryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveTrustedBeneficiary"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RemoveTrustedBeneficiaryResponse class]];
}

#pragma mark GetTrustedBeneficiaries(GetTrustedBeneficiariesRequest) returns (GetTrustedBeneficiariesResponse)

// Deprecated methods.
/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTrustedBeneficiariesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTrustedBeneficiaries"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTrustedBeneficiariesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCUnaryProtoCall *)getTrustedBeneficiariesWithMessage:(GetTrustedBeneficiariesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTrustedBeneficiaries"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTrustedBeneficiariesResponse class]];
}

#pragma mark CreateCustomization(CreateCustomizationRequest) returns (CreateCustomizationResponse)

// Deprecated methods.
/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createCustomizationWithRequest:(CreateCustomizationRequest *)request handler:(void(^)(CreateCustomizationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateCustomizationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateCustomizationWithRequest:(CreateCustomizationRequest *)request handler:(void(^)(CreateCustomizationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateCustomization"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateCustomizationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Set Customization
 * https://developer.token.io/sdk/#customization
 */
- (GRPCUnaryProtoCall *)createCustomizationWithMessage:(CreateCustomizationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateCustomization"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateCustomizationResponse class]];
}

#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSubscribeToNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SubscribeToNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SubscribeToNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)subscribeToNotificationsWithMessage:(SubscribeToNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeToNotifications"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SubscribeToNotificationsResponse class]];
}

#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

// Deprecated methods.
/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscribersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscribers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscribersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)getSubscribersWithMessage:(GetSubscribersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetSubscribers"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetSubscribersResponse class]];
}

#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

// Deprecated methods.
/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscriberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscriber"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscriberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)getSubscriberWithMessage:(GetSubscriberRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetSubscriber"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetSubscriberResponse class]];
}

#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

// Deprecated methods.
/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)unsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnsubscribeFromNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUnsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnsubscribeFromNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnsubscribeFromNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)unsubscribeFromNotificationsWithMessage:(UnsubscribeFromNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UnsubscribeFromNotifications"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UnsubscribeFromNotificationsResponse class]];
}

#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

// Deprecated methods.
/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)notifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToNotifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Notify"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCUnaryProtoCall *)notifyWithMessage:(NotifyRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"Notify"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[NotifyResponse class]];
}

#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

// Deprecated methods.
/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCUnaryProtoCall *)getNotificationsWithMessage:(GetNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNotifications"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetNotificationsResponse class]];
}

#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

// Deprecated methods.
/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCUnaryProtoCall *)getNotificationWithMessage:(GetNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetNotificationResponse class]];
}

#pragma mark RequestTransfer(RequestTransferRequest) returns (RequestTransferResponse)

// Deprecated methods.
/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)requestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRequestTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRequestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RequestTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RequestTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (GRPCUnaryProtoCall *)requestTransferWithMessage:(RequestTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RequestTransfer"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RequestTransferResponse class]];
}

#pragma mark TriggerStepUpNotification(TriggerStepUpNotificationRequest) returns (TriggerStepUpNotificationResponse)

// Deprecated methods.
/**
 * send step-up (approve with higher-privilege key) request notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)triggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerStepUpNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send step-up (approve with higher-privilege key) request notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToTriggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerStepUpNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TriggerStepUpNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (GRPCUnaryProtoCall *)triggerStepUpNotificationWithMessage:(TriggerStepUpNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"TriggerStepUpNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TriggerStepUpNotificationResponse class]];
}

#pragma mark TriggerEndorseAndAddKeyNotification(TriggerEndorseAndAddKeyNotificationRequest) returns (TriggerEndorseAndAddKeyNotificationResponse)

// Deprecated methods.
/**
 * send endorse and add key notification (approve with higher-privilege key)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)triggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerEndorseAndAddKeyNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send endorse and add key notification (approve with higher-privilege key)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToTriggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerEndorseAndAddKeyNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TriggerEndorseAndAddKeyNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (GRPCUnaryProtoCall *)triggerEndorseAndAddKeyNotificationWithMessage:(TriggerEndorseAndAddKeyNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"TriggerEndorseAndAddKeyNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TriggerEndorseAndAddKeyNotificationResponse class]];
}

#pragma mark TriggerCreateAndEndorseTokenNotification(TriggerCreateAndEndorseTokenNotificationRequest) returns (TriggerCreateAndEndorseTokenNotificationResponse)

// Deprecated methods.
/**
 * send create and endorse token notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)triggerCreateAndEndorseTokenNotificationWithRequest:(TriggerCreateAndEndorseTokenNotificationRequest *)request handler:(void(^)(TriggerCreateAndEndorseTokenNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerCreateAndEndorseTokenNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send create and endorse token notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToTriggerCreateAndEndorseTokenNotificationWithRequest:(TriggerCreateAndEndorseTokenNotificationRequest *)request handler:(void(^)(TriggerCreateAndEndorseTokenNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerCreateAndEndorseTokenNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TriggerCreateAndEndorseTokenNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send create and endorse token notification
 */
- (GRPCUnaryProtoCall *)triggerCreateAndEndorseTokenNotificationWithMessage:(TriggerCreateAndEndorseTokenNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"TriggerCreateAndEndorseTokenNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TriggerCreateAndEndorseTokenNotificationResponse class]];
}

#pragma mark InvalidateNotification(InvalidateNotificationRequest) returns (InvalidateNotificationResponse)

// Deprecated methods.
/**
 * send invalidate notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)invalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToInvalidateNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send invalidate notification
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToInvalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"InvalidateNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[InvalidateNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * send invalidate notification
 */
- (GRPCUnaryProtoCall *)invalidateNotificationWithMessage:(InvalidateNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"InvalidateNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[InvalidateNotificationResponse class]];
}

#pragma mark UpdateNotificationStatus(UpdateNotificationStatusRequest) returns (UpdateNotificationStatusResponse)

// Deprecated methods.
/**
 * update notification status
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)updateNotificationStatusWithRequest:(UpdateNotificationStatusRequest *)request handler:(void(^)(UpdateNotificationStatusResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateNotificationStatusWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * update notification status
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUpdateNotificationStatusWithRequest:(UpdateNotificationStatusRequest *)request handler:(void(^)(UpdateNotificationStatusResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateNotificationStatus"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateNotificationStatusResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * update notification status
 */
- (GRPCUnaryProtoCall *)updateNotificationStatusWithMessage:(UpdateNotificationStatusRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UpdateNotificationStatus"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UpdateNotificationStatusResponse class]];
}

#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)linkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToLinkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)linkAccountsWithMessage:(LinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"LinkAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[LinkAccountsResponse class]];
}

#pragma mark LinkAccountsOauth(LinkAccountsOauthRequest) returns (LinkAccountsOauthResponse)

// Deprecated methods.
/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)linkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLinkAccountsOauthWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToLinkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccountsOauth"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountsOauthResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)linkAccountsOauthWithMessage:(LinkAccountsOauthRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"LinkAccountsOauth"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[LinkAccountsOauthResponse class]];
}

#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

// Deprecated methods.
/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)unlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnlinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUnlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnlinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnlinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)unlinkAccountsWithMessage:(UnlinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UnlinkAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UnlinkAccountsResponse class]];
}

#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

// Deprecated methods.
/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCUnaryProtoCall *)getAccountWithMessage:(GetAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAccountResponse class]];
}

#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

// Deprecated methods.
/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCUnaryProtoCall *)getAccountsWithMessage:(GetAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAccountsResponse class]];
}

#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

// Deprecated methods.
/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (GRPCUnaryProtoCall *)getBalanceWithMessage:(GetBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBalance"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBalanceResponse class]];
}

#pragma mark GetBalances(GetBalancesRequest) returns (GetBalancesResponse)

// Deprecated methods.
- (void)getBalancesWithRequest:(GetBalancesRequest *)request handler:(void(^)(GetBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBalancesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBalancesWithRequest:(GetBalancesRequest *)request handler:(void(^)(GetBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBalances"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBalancesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getBalancesWithMessage:(GetBalancesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBalances"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBalancesResponse class]];
}

#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

// Deprecated methods.
/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCUnaryProtoCall *)getTransactionWithMessage:(GetTransactionRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTransaction"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTransactionResponse class]];
}

#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

// Deprecated methods.
/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCUnaryProtoCall *)getTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTransactions"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTransactionsResponse class]];
}

#pragma mark ApplySca(ApplyScaRequest) returns (ApplyScaResponse)

// Deprecated methods.
- (void)applyScaWithRequest:(ApplyScaRequest *)request handler:(void(^)(ApplyScaResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToApplyScaWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToApplyScaWithRequest:(ApplyScaRequest *)request handler:(void(^)(ApplyScaResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ApplySca"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ApplyScaResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)applyScaWithMessage:(ApplyScaRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ApplySca"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ApplyScaResponse class]];
}

#pragma mark GetDefaultAccount(GetDefaultAccountRequest) returns (GetDefaultAccountResponse)

// Deprecated methods.
/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetDefaultAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetDefaultAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetDefaultAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCUnaryProtoCall *)getDefaultAccountWithMessage:(GetDefaultAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetDefaultAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetDefaultAccountResponse class]];
}

#pragma mark SetDefaultAccount(SetDefaultAccountRequest) returns (SetDefaultAccountResponse)

// Deprecated methods.
/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)setDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetDefaultAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSetDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetDefaultAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetDefaultAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCUnaryProtoCall *)setDefaultAccountWithMessage:(SetDefaultAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SetDefaultAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SetDefaultAccountResponse class]];
}

#pragma mark ResolveTransferDestinations(ResolveTransferDestinationsRequest) returns (ResolveTransferDestinationsResponse)

// Deprecated methods.
/**
 * Get the resolved transfer destinations of the given account.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)resolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveTransferDestinationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the resolved transfer destinations of the given account.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToResolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveTransferDestinations"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ResolveTransferDestinationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get the resolved transfer destinations of the given account.
 */
- (GRPCUnaryProtoCall *)resolveTransferDestinationsWithMessage:(ResolveTransferDestinationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ResolveTransferDestinations"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ResolveTransferDestinationsResponse class]];
}

#pragma mark ConfirmFunds(ConfirmFundsRequest) returns (ConfirmFundsResponse)

// Deprecated methods.
/**
 * Confirm that the given account has sufficient funds to cover the charge.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)confirmFundsWithRequest:(ConfirmFundsRequest *)request handler:(void(^)(ConfirmFundsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToConfirmFundsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Confirm that the given account has sufficient funds to cover the charge.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToConfirmFundsWithRequest:(ConfirmFundsRequest *)request handler:(void(^)(ConfirmFundsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ConfirmFunds"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ConfirmFundsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Confirm that the given account has sufficient funds to cover the charge.
 */
- (GRPCUnaryProtoCall *)confirmFundsWithMessage:(ConfirmFundsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ConfirmFunds"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ConfirmFundsResponse class]];
}

#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTestBankAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTestBankAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTestBankAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)createTestBankAccountWithMessage:(CreateTestBankAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateTestBankAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateTestBankAccountResponse class]];
}

#pragma mark GetTestBankNotification(GetTestBankNotificationRequest) returns (GetTestBankNotificationResponse)

// Deprecated methods.
/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTestBankNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTestBankNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTestBankNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (GRPCUnaryProtoCall *)getTestBankNotificationWithMessage:(GetTestBankNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTestBankNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTestBankNotificationResponse class]];
}

#pragma mark GetTestBankNotifications(GetTestBankNotificationsRequest) returns (GetTestBankNotificationsResponse)

// Deprecated methods.
/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTestBankNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTestBankNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTestBankNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (GRPCUnaryProtoCall *)getTestBankNotificationsWithMessage:(GetTestBankNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTestBankNotifications"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTestBankNotificationsResponse class]];
}

#pragma mark CreateBlob(CreateBlobRequest) returns (CreateBlobResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateBlobWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)createBlobWithMessage:(CreateBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateBlob"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateBlobResponse class]];
}

#pragma mark GetBlob(GetBlobRequest) returns (GetBlobResponse)

// Deprecated methods.
/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlobWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)getBlobWithMessage:(GetBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBlob"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBlobResponse class]];
}

#pragma mark GetTokenBlob(GetTokenBlobRequest) returns (GetTokenBlobResponse)

// Deprecated methods.
/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenBlobWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokenBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCUnaryProtoCall *)getTokenBlobWithMessage:(GetTokenBlobRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTokenBlob"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTokenBlobResponse class]];
}

#pragma mark StoreTokenRequest(StoreTokenRequestRequest) returns (StoreTokenRequestResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)storeTokenRequestWithRequest:(StoreTokenRequestRequest *)request handler:(void(^)(StoreTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToStoreTokenRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToStoreTokenRequestWithRequest:(StoreTokenRequestRequest *)request handler:(void(^)(StoreTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"StoreTokenRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[StoreTokenRequestResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
 */
- (GRPCUnaryProtoCall *)storeTokenRequestWithMessage:(StoreTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"StoreTokenRequest"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[StoreTokenRequestResponse class]];
}

#pragma mark RetrieveTokenRequest(RetrieveTokenRequestRequest) returns (RetrieveTokenRequestResponse)

// Deprecated methods.
/**
 * Retrieve a Token Request
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)retrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRetrieveTokenRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Retrieve a Token Request
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRetrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RetrieveTokenRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RetrieveTokenRequestResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Retrieve a Token Request
 */
- (GRPCUnaryProtoCall *)retrieveTokenRequestWithMessage:(RetrieveTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RetrieveTokenRequest"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RetrieveTokenRequestResponse class]];
}

#pragma mark UpdateTokenRequest(UpdateTokenRequestRequest) returns (UpdateTokenRequestResponse)

// Deprecated methods.
- (void)updateTokenRequestWithRequest:(UpdateTokenRequestRequest *)request handler:(void(^)(UpdateTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateTokenRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUpdateTokenRequestWithRequest:(UpdateTokenRequestRequest *)request handler:(void(^)(UpdateTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateTokenRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateTokenRequestResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)updateTokenRequestWithMessage:(UpdateTokenRequestRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UpdateTokenRequest"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UpdateTokenRequestResponse class]];
}

#pragma mark PrepareToken(PrepareTokenRequest) returns (PrepareTokenResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)prepareTokenWithRequest:(PrepareTokenRequest *)request handler:(void(^)(PrepareTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToPrepareTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToPrepareTokenWithRequest:(PrepareTokenRequest *)request handler:(void(^)(PrepareTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"PrepareToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PrepareTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Prepare a token (resolve token payload and determine policy)
 */
- (GRPCUnaryProtoCall *)prepareTokenWithMessage:(PrepareTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"PrepareToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PrepareTokenResponse class]];
}

#pragma mark CreateToken(CreateTokenRequest) returns (CreateTokenResponse)

// Deprecated methods.
/**
 * Create a Token.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Create a Token.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Create a Token.
 */
- (GRPCUnaryProtoCall *)createTokenWithMessage:(CreateTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateTokenResponse class]];
}

#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

// Deprecated methods.
/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransferTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransferToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTransferTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (GRPCUnaryProtoCall *)createTransferTokenWithMessage:(CreateTransferTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateTransferToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateTransferTokenResponse class]];
}

#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

// Deprecated methods.
/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (GRPCUnaryProtoCall *)createAccessTokenWithMessage:(CreateAccessTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateAccessToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateAccessTokenResponse class]];
}

#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

// Deprecated methods.
/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (GRPCUnaryProtoCall *)getTokenWithMessage:(GetTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTokenResponse class]];
}

#pragma mark GetActiveAccessToken(GetActiveAccessTokenRequest) returns (GetActiveAccessTokenResponse)

// Deprecated methods.
/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetActiveAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetActiveAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetActiveAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (GRPCUnaryProtoCall *)getActiveAccessTokenWithMessage:(GetActiveAccessTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetActiveAccessToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetActiveAccessTokenResponse class]];
}

#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

// Deprecated methods.
/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokensResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
 */
- (GRPCUnaryProtoCall *)getTokensWithMessage:(GetTokensRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTokens"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTokensResponse class]];
}

#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

// Deprecated methods.
/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)endorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEndorseTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToEndorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EndorseToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EndorseTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (GRPCUnaryProtoCall *)endorseTokenWithMessage:(EndorseTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"EndorseToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[EndorseTokenResponse class]];
}

#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

// Deprecated methods.
/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)cancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCancelTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CancelToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CancelTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (GRPCUnaryProtoCall *)cancelTokenWithMessage:(CancelTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CancelToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CancelTokenResponse class]];
}

#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

// Deprecated methods.
/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)replaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToReplaceTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToReplaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ReplaceToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ReplaceTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
 */
- (GRPCUnaryProtoCall *)replaceTokenWithMessage:(ReplaceTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ReplaceToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ReplaceTokenResponse class]];
}

#pragma mark SignTokenRequestState(SignTokenRequestStateRequest) returns (SignTokenRequestStateResponse)

// Deprecated methods.
/**
 * Request a Token signature on a token request state payload (tokenId | state)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)signTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSignTokenRequestStateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Request a Token signature on a token request state payload (tokenId | state)
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSignTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SignTokenRequestState"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SignTokenRequestStateResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (GRPCUnaryProtoCall *)signTokenRequestStateWithMessage:(SignTokenRequestStateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SignTokenRequestState"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SignTokenRequestStateResponse class]];
}

#pragma mark GetTokenRequestResult(GetTokenRequestResultRequest) returns (GetTokenRequestResultResponse)

// Deprecated methods.
/**
 * Get the token request result from the token request id
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenRequestResultWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the token request result from the token request id
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokenRequestResult"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenRequestResultResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get the token request result from the token request id
 */
- (GRPCUnaryProtoCall *)getTokenRequestResultWithMessage:(GetTokenRequestResultRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTokenRequestResult"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTokenRequestResultResponse class]];
}

#pragma mark GetAuthRequestPayload(GetAuthRequestPayloadRequest) returns (GetAuthRequestPayloadResponse)

// Deprecated methods.
/**
 * Gets a payload to sign
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAuthRequestPayloadWithRequest:(GetAuthRequestPayloadRequest *)request handler:(void(^)(GetAuthRequestPayloadResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAuthRequestPayloadWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Gets a payload to sign
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAuthRequestPayloadWithRequest:(GetAuthRequestPayloadRequest *)request handler:(void(^)(GetAuthRequestPayloadResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAuthRequestPayload"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAuthRequestPayloadResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Gets a payload to sign
 */
- (GRPCUnaryProtoCall *)getAuthRequestPayloadWithMessage:(GetAuthRequestPayloadRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAuthRequestPayload"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAuthRequestPayloadResponse class]];
}

#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
 * Redeem a transfer token, creating a transfer.
 * https://developer.token.io/sdk/#redeem-transfer-token
 * 
 * See how redeemToken calls it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-redeemToken
 */
- (GRPCUnaryProtoCall *)createTransferWithMessage:(CreateTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateTransfer"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateTransferResponse class]];
}

#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

// Deprecated methods.
/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCUnaryProtoCall *)getTransferWithMessage:(GetTransferRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTransfer"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTransferResponse class]];
}

#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

// Deprecated methods.
/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransfersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransfers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransfersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCUnaryProtoCall *)getTransfersWithMessage:(GetTransfersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTransfers"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTransfersResponse class]];
}

#pragma mark GetBanksCountries(GetBanksCountriesRequest) returns (GetBanksCountriesResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getBanksCountriesWithRequest:(GetBanksCountriesRequest *)request handler:(void(^)(GetBanksCountriesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBanksCountriesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetBanksCountriesWithRequest:(GetBanksCountriesRequest *)request handler:(void(^)(GetBanksCountriesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBanksCountries"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBanksCountriesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" bank countries.
 */
- (GRPCUnaryProtoCall *)getBanksCountriesWithMessage:(GetBanksCountriesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBanksCountries"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBanksCountriesResponse class]];
}

#pragma mark GetBanks(GetBanksRequest) returns (GetBanksResponse)

// Deprecated methods.
/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBanksWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBanks"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBanksResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)getBanksWithMessage:(GetBanksRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBanks"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBanksResponse class]];
}

#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

// Deprecated methods.
/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBankInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBankInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBankInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCUnaryProtoCall *)getBankInfoWithMessage:(GetBankInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetBankInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetBankInfoResponse class]];
}

#pragma mark CreateKeychain(CreateKeychainRequest) returns (CreateKeychainResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createKeychainWithRequest:(CreateKeychainRequest *)request handler:(void(^)(CreateKeychainResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateKeychainWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateKeychainWithRequest:(CreateKeychainRequest *)request handler:(void(^)(CreateKeychainResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateKeychain"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateKeychainResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Keychain management.
 * 
 * Create a keychain with a name.
 */
- (GRPCUnaryProtoCall *)createKeychainWithMessage:(CreateKeychainRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateKeychain"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CreateKeychainResponse class]];
}

#pragma mark UpdateKeychainInfo(UpdateKeychainInfoRequest) returns (UpdateKeychainInfoResponse)

// Deprecated methods.
/**
 * Update a keychain's info.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)updateKeychainInfoWithRequest:(UpdateKeychainInfoRequest *)request handler:(void(^)(UpdateKeychainInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateKeychainInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Update a keychain's info.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUpdateKeychainInfoWithRequest:(UpdateKeychainInfoRequest *)request handler:(void(^)(UpdateKeychainInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateKeychainInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateKeychainInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Update a keychain's info.
 */
- (GRPCUnaryProtoCall *)updateKeychainInfoWithMessage:(UpdateKeychainInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UpdateKeychainInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UpdateKeychainInfoResponse class]];
}

#pragma mark GetKeychains(GetKeychainsRequest) returns (GetKeychainsResponse)

// Deprecated methods.
/**
 * Get all the keychains of a member.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getKeychainsWithRequest:(GetKeychainsRequest *)request handler:(void(^)(GetKeychainsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetKeychainsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get all the keychains of a member.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetKeychainsWithRequest:(GetKeychainsRequest *)request handler:(void(^)(GetKeychainsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetKeychains"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetKeychainsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get all the keychains of a member.
 */
- (GRPCUnaryProtoCall *)getKeychainsWithMessage:(GetKeychainsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetKeychains"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetKeychainsResponse class]];
}

#pragma mark GetMemberInfo(GetMemberInfoRequest) returns (GetMemberInfoResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getMemberInfoWithRequest:(GetMemberInfoRequest *)request handler:(void(^)(GetMemberInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetMemberInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetMemberInfoWithRequest:(GetMemberInfoRequest *)request handler:(void(^)(GetMemberInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetMemberInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetMemberInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank member only requests.
 * 
 * Get member information about a member who links at least an account from this bank
 */
- (GRPCUnaryProtoCall *)getMemberInfoWithMessage:(GetMemberInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetMemberInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetMemberInfoResponse class]];
}

#pragma mark GetConsent(GetConsentRequest) returns (GetConsentResponse)

// Deprecated methods.
- (void)getConsentWithRequest:(GetConsentRequest *)request handler:(void(^)(GetConsentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetConsentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetConsentWithRequest:(GetConsentRequest *)request handler:(void(^)(GetConsentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetConsent"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetConsentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getConsentWithMessage:(GetConsentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetConsent"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetConsentResponse class]];
}

#pragma mark GetConsents(GetConsentsRequest) returns (GetConsentsResponse)

// Deprecated methods.
- (void)getConsentsWithRequest:(GetConsentsRequest *)request handler:(void(^)(GetConsentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetConsentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetConsentsWithRequest:(GetConsentsRequest *)request handler:(void(^)(GetConsentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetConsents"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetConsentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getConsentsWithMessage:(GetConsentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetConsents"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetConsentsResponse class]];
}

#pragma mark GetTppPerformanceReport(GetTppPerformanceReportRequest) returns (GetTppPerformanceReportResponse)

// Deprecated methods.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Reports (bank member only requests).
 * 
 * Get TPP performance report.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTppPerformanceReportWithRequest:(GetTppPerformanceReportRequest *)request handler:(void(^)(GetTppPerformanceReportResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTppPerformanceReportWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Reports (bank member only requests).
 * 
 * Get TPP performance report.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTppPerformanceReportWithRequest:(GetTppPerformanceReportRequest *)request handler:(void(^)(GetTppPerformanceReportResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTppPerformanceReport"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTppPerformanceReportResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Reports (bank member only requests).
 * 
 * Get TPP performance report.
 */
- (GRPCUnaryProtoCall *)getTppPerformanceReportWithMessage:(GetTppPerformanceReportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTppPerformanceReport"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetTppPerformanceReportResponse class]];
}

#pragma mark GetAvailabilityReport(GetAvailabilityReportRequest) returns (GetAvailabilityReportResponse)

// Deprecated methods.
/**
 * Get availability report.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAvailabilityReportWithRequest:(GetAvailabilityReportRequest *)request handler:(void(^)(GetAvailabilityReportResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAvailabilityReportWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get availability report.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAvailabilityReportWithRequest:(GetAvailabilityReportRequest *)request handler:(void(^)(GetAvailabilityReportResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAvailabilityReport"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAvailabilityReportResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Get availability report.
 */
- (GRPCUnaryProtoCall *)getAvailabilityReportWithMessage:(GetAvailabilityReportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAvailabilityReport"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetAvailabilityReportResponse class]];
}

@end
#endif
