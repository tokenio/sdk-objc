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
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Notification.pbobjc.h"
#import "Security.pbobjc.h"
#import "Subscriber.pbobjc.h"
#import "Token.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Alias.pbobjc.h"
#import "Transferinstructions.pbobjc.h"
#import "extensions/Field.pbobjc.h"
#import "extensions/Service.pbobjc.h"

@implementation GatewayService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"io.token.proto.gateway"
                 serviceName:@"GatewayService"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

/**
 * Create a member. Mints a member ID; newly-created member does not yet
 * have keys, alias, or anything other than an ID.
 * Used by createMember, https://developer.token.io/sdk/#create-a-member
 * (SDK's createMember also uses UpdateMember rpc).
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
 */
- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

/**
 * Apply member updates. Used when adding/removing keys, aliases to/from member.
 * These updates require a signature.
 * See how Java SDK's Client.updateMember uses it:
 * https://developer.token.io/sdk/javadoc/io/token/rpc/Client.html#updateMember-io.token.proto.common.member.MemberProtos.Member-java.util.List-
 * See how JS SDK's AuthHttpClient._memberUpdate uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-_memberUpdate
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
 */
- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

/**
 * Get information about a member
 */
- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about a member
 */
- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetProfile(SetProfileRequest) returns (SetProfileResponse)

/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (void)setProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetProfileWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * set profile information (display name)
 * Ignores picture fields; use SetProfilePicture for those.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToSetProfileWithRequest:(SetProfileRequest *)request handler:(void(^)(SetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetProfile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetProfileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetProfile(GetProfileRequest) returns (GetProfileResponse)

/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (void)getProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetProfileWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get a member's profile (display information)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToGetProfileWithRequest:(GetProfileRequest *)request handler:(void(^)(GetProfileResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetProfile"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetProfileResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetProfilePicture(SetProfilePictureRequest) returns (SetProfilePictureResponse)

/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (void)setProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetProfilePictureWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * upload an image to use as auth'd member's profile picture
 * Automatically creates smaller sizes; this works best with square images.
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToSetProfilePictureWithRequest:(SetProfilePictureRequest *)request handler:(void(^)(SetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetProfilePicture"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetProfilePictureResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetProfilePicture(GetProfilePictureRequest) returns (GetProfilePictureResponse)

/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (void)getProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetProfilePictureWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get member's profile picture (can also use GetBlob with a blob ID from profile)
 * https://developer.token.io/sdk/#profile
 */
- (GRPCProtoCall *)RPCToGetProfilePictureWithRequest:(GetProfilePictureRequest *)request handler:(void(^)(GetProfilePictureResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetProfilePicture"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetProfilePictureResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetReceiptContact(SetReceiptContactRequest) returns (SetReceiptContactResponse)

/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (void)setReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetReceiptContactWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Set a member's contact (e.g. email) for receipt delivery
 */
- (GRPCProtoCall *)RPCToSetReceiptContactWithRequest:(SetReceiptContactRequest *)request handler:(void(^)(SetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetReceiptContact"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetReceiptContactResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetReceiptContact(GetReceiptContactRequest) returns (GetReceiptContactResponse)

/**
 * Get a member's email address for receipts
 */
- (void)getReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetReceiptContactWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get a member's email address for receipts
 */
- (GRPCProtoCall *)RPCToGetReceiptContactWithRequest:(GetReceiptContactRequest *)request handler:(void(^)(GetReceiptContactResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetReceiptContact"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetReceiptContactResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ResolveAlias(ResolveAliasRequest) returns (ResolveAliasResponse)

/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (void)resolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get ID of member that owns an alias, if any.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCProtoCall *)RPCToResolveAliasWithRequest:(ResolveAliasRequest *)request handler:(void(^)(ResolveAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ResolveAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAliases(GetAliasesRequest) returns (GetAliasesResponse)

/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (void)getAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAliasesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the auth'd member's aliases.
 * https://developer.token.io/sdk/#aliases
 */
- (GRPCProtoCall *)RPCToGetAliasesWithRequest:(GetAliasesRequest *)request handler:(void(^)(GetAliasesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAliases"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAliasesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CompleteVerification(CompleteVerificationRequest) returns (CompleteVerificationResponse)

/**
 * Use a verification code
 */
- (void)completeVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCompleteVerificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Use a verification code
 */
- (GRPCProtoCall *)RPCToCompleteVerificationWithRequest:(CompleteVerificationRequest *)request handler:(void(^)(CompleteVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CompleteVerification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CompleteVerificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RetryVerification(RetryVerificationRequest) returns (RetryVerificationResponse)

/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (void)retryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRetryVerificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Retries verification. For example, if verifying an email alias,
 * re-sends verification-code email to the email address.
 */
- (GRPCProtoCall *)RPCToRetryVerificationWithRequest:(RetryVerificationRequest *)request handler:(void(^)(RetryVerificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RetryVerification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RetryVerificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPairedDevices(GetPairedDevicesRequest) returns (GetPairedDevicesResponse)

/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (void)getPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPairedDevicesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get auth'd members paired devices (as created by provisionDevice)
 */
- (GRPCProtoCall *)RPCToGetPairedDevicesWithRequest:(GetPairedDevicesRequest *)request handler:(void(^)(GetPairedDevicesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPairedDevices"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPairedDevicesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DeleteMember(DeleteMemberRequest) returns (DeleteMemberResponse)

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
#pragma mark VerifyAliasOnBehalf(VerifyAliasOnBehalfRequest) returns (VerifyAliasOnBehalfResponse)

- (void)verifyAliasOnBehalfWithRequest:(VerifyAliasOnBehalfRequest *)request handler:(void(^)(VerifyAliasOnBehalfResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyAliasOnBehalfWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToVerifyAliasOnBehalfWithRequest:(VerifyAliasOnBehalfRequest *)request handler:(void(^)(VerifyAliasOnBehalfResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyAliasOnBehalf"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyAliasOnBehalfResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NormalizeAlias(NormalizeAliasRequest) returns (NormalizeAliasResponse)

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
#pragma mark VerifyAffiliate(VerifyAffiliateRequest) returns (VerifyAffiliateResponse)

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
#pragma mark BeginRecovery(BeginRecoveryRequest) returns (BeginRecoveryResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member account recovery
 * 
 * 
 * Begin member recovery. If the member has a "normal consumer" recovery rule,
 * this sends a recovery message to their email address.
 * https://developer.token.io/sdk/#recovery
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
 */
- (GRPCProtoCall *)RPCToBeginRecoveryWithRequest:(BeginRecoveryRequest *)request handler:(void(^)(BeginRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"BeginRecovery"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BeginRecoveryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CompleteRecovery(CompleteRecoveryRequest) returns (CompleteRecoveryResponse)

/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (void)completeRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCompleteRecoveryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Complete member recovery.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCProtoCall *)RPCToCompleteRecoveryWithRequest:(CompleteRecoveryRequest *)request handler:(void(^)(CompleteRecoveryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CompleteRecovery"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CompleteRecoveryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

/**
 * Verify an alias
 */
- (void)verifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Verify an alias
 */
- (GRPCProtoCall *)RPCToVerifyAliasWithRequest:(VerifyAliasRequest *)request handler:(void(^)(VerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetDefaultAgent(GetDefaultAgentRequest) returns (GetDefaultAgentResponse)

/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (void)getDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetDefaultAgentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get member ID of "normal consumer" recovery agent.
 * https://developer.token.io/sdk/#recovery
 */
- (GRPCProtoCall *)RPCToGetDefaultAgentWithRequest:(GetDefaultAgentRequest *)request handler:(void(^)(GetDefaultAgentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetDefaultAgent"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetDefaultAgentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 * Add a shipping address
 * https://developer.token.io/sdk/#address
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
 */
- (GRPCProtoCall *)RPCToAddAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get all of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddresses"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeleteAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Remove one of the auth'd member's shipping addresses
 * https://developer.token.io/sdk/#address
 */
- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeleteAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark AddTrustedBeneficiary(AddTrustedBeneficiaryRequest) returns (AddTrustedBeneficiaryResponse)

/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)addTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddTrustedBeneficiaryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Add a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToAddTrustedBeneficiaryWithRequest:(AddTrustedBeneficiaryRequest *)request handler:(void(^)(AddTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddTrustedBeneficiary"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddTrustedBeneficiaryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RemoveTrustedBeneficiary(RemoveTrustedBeneficiaryRequest) returns (RemoveTrustedBeneficiaryResponse)

/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)removeTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveTrustedBeneficiaryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Remove a trusted beneficiary
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToRemoveTrustedBeneficiaryWithRequest:(RemoveTrustedBeneficiaryRequest *)request handler:(void(^)(RemoveTrustedBeneficiaryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveTrustedBeneficiary"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RemoveTrustedBeneficiaryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTrustedBeneficiaries(GetTrustedBeneficiariesRequest) returns (GetTrustedBeneficiariesResponse)

/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (void)getTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTrustedBeneficiariesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get all trusted beneficiaries
 * https://developer.token.io/sdk/#trusted-beneficiary
 */
- (GRPCProtoCall *)RPCToGetTrustedBeneficiariesWithRequest:(GetTrustedBeneficiariesRequest *)request handler:(void(^)(GetTrustedBeneficiariesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTrustedBeneficiaries"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTrustedBeneficiariesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 * subscribe member to notifications
 * https://developer.token.io/sdk/#notifications
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
 */
- (GRPCProtoCall *)RPCToSubscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SubscribeToNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SubscribeToNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (void)getSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscribersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get member's notification subscriber[s]
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToGetSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscribers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscribersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (void)getSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscriberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get one of a member's notification subscribers
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToGetSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscriber"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscriberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (void)unsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnsubscribeFromNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * unsubscribe one of a member's subscribers from notifications
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToUnsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnsubscribeFromNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnsubscribeFromNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (void)notifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send a notification
 * https://developer.token.io/sdk/#notifications
 */
- (GRPCProtoCall *)RPCToNotifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Notify"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (void)getNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get notifications
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (void)getNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get one particular notification
 * https://developer.token.io/sdk/#polling-for-notifications
 */
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RequestTransfer(RequestTransferRequest) returns (RequestTransferResponse)

/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (void)requestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRequestTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send transfer-request notification
 * https://developer.token.io/sdk/#request-payment
 */
- (GRPCProtoCall *)RPCToRequestTransferWithRequest:(RequestTransferRequest *)request handler:(void(^)(RequestTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RequestTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RequestTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TriggerStepUpNotification(TriggerStepUpNotificationRequest) returns (TriggerStepUpNotificationResponse)

/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (void)triggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerStepUpNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send step-up (approve with higher-privilege key) request notification
 */
- (GRPCProtoCall *)RPCToTriggerStepUpNotificationWithRequest:(TriggerStepUpNotificationRequest *)request handler:(void(^)(TriggerStepUpNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerStepUpNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TriggerStepUpNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TriggerEndorseAndAddKeyNotification(TriggerEndorseAndAddKeyNotificationRequest) returns (TriggerEndorseAndAddKeyNotificationResponse)

/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (void)triggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTriggerEndorseAndAddKeyNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send endorse and add key notification (approve with higher-privilege key)
 */
- (GRPCProtoCall *)RPCToTriggerEndorseAndAddKeyNotificationWithRequest:(TriggerEndorseAndAddKeyNotificationRequest *)request handler:(void(^)(TriggerEndorseAndAddKeyNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TriggerEndorseAndAddKeyNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TriggerEndorseAndAddKeyNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark InvalidateNotification(InvalidateNotificationRequest) returns (InvalidateNotificationResponse)

/**
 * send invalidate notification
 */
- (void)invalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToInvalidateNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * send invalidate notification
 */
- (GRPCProtoCall *)RPCToInvalidateNotificationWithRequest:(InvalidateNotificationRequest *)request handler:(void(^)(InvalidateNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"InvalidateNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[InvalidateNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
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
 */
- (GRPCProtoCall *)RPCToLinkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LinkAccountsOauth(LinkAccountsOauthRequest) returns (LinkAccountsOauthResponse)

/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)linkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLinkAccountsOauthWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToLinkAccountsOauthWithRequest:(LinkAccountsOauthRequest *)request handler:(void(^)(LinkAccountsOauthResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccountsOauth"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountsOauthResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)unlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnlinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * un-associate bank accounts with member
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToUnlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnlinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnlinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get info about one linked account
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get info about linked accounts
 * https://developer.token.io/sdk/#get-accounts
 */
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get current and available balance for a linked account
 * https://developer.token.io/sdk/#get-account-balance
 */
- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBalances(GetBalancesRequest) returns (GetBalancesResponse)

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
#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get information about a particular transaction
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * get information about several transactions
 * https://developer.token.io/sdk/#get-transactions
 */
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ApplySca(ApplyScaRequest) returns (ApplyScaResponse)

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
#pragma mark GetDefaultAccount(GetDefaultAccountRequest) returns (GetDefaultAccountResponse)

/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (void)getDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetDefaultAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about the auth'd member's default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCProtoCall *)RPCToGetDefaultAccountWithRequest:(GetDefaultAccountRequest *)request handler:(void(^)(GetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetDefaultAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetDefaultAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetDefaultAccount(SetDefaultAccountRequest) returns (SetDefaultAccountResponse)

/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (void)setDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetDefaultAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Set one auth'd member's accounts as its default account.
 * https://developer.token.io/sdk/#default-bank-account
 */
- (GRPCProtoCall *)RPCToSetDefaultAccountWithRequest:(SetDefaultAccountRequest *)request handler:(void(^)(SetDefaultAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetDefaultAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetDefaultAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ResolveTransferDestinations(ResolveTransferDestinationsRequest) returns (ResolveTransferDestinationsResponse)

/**
 * Get the resolved transfer destinations of the given account.
 */
- (void)resolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToResolveTransferDestinationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the resolved transfer destinations of the given account.
 */
- (GRPCProtoCall *)RPCToResolveTransferDestinationsWithRequest:(ResolveTransferDestinationsRequest *)request handler:(void(^)(ResolveTransferDestinationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ResolveTransferDestinations"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ResolveTransferDestinationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Testing.
 * 
 * 
 * Create a test account at "iron" test bank.
 * https://developer.token.io/sdk/#link-a-bank-account
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
 */
- (GRPCProtoCall *)RPCToCreateTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTestBankAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTestBankAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTestBankNotification(GetTestBankNotificationRequest) returns (GetTestBankNotificationResponse)

/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (void)getTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTestBankNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get notification from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get a notification is GetNotification.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationWithRequest:(GetTestBankNotificationRequest *)request handler:(void(^)(GetTestBankNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTestBankNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTestBankNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTestBankNotifications(GetTestBankNotificationsRequest) returns (GetTestBankNotificationsResponse)

/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (void)getTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTestBankNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get notifications from "iron" test bank. Useful for Token when testing its test bank.
 * Normal way to get notifications is GetNotifications.
 */
- (GRPCProtoCall *)RPCToGetTestBankNotificationsWithRequest:(GetTestBankNotificationsRequest *)request handler:(void(^)(GetTestBankNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTestBankNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTestBankNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateBlob(CreateBlobRequest) returns (CreateBlobResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Blobs.
 * 
 * 
 * Create a blob.
 * https://developer.token.io/sdk/#transfer-token-options
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
 */
- (GRPCProtoCall *)RPCToCreateBlobWithRequest:(CreateBlobRequest *)request handler:(void(^)(CreateBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBlob(GetBlobRequest) returns (GetBlobResponse)

/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (void)getBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBlobWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Fetch a blob. Works if the authenticated member is the blob's
 * owner or if the blob is public-access.
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCProtoCall *)RPCToGetBlobWithRequest:(GetBlobRequest *)request handler:(void(^)(GetBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTokenBlob(GetTokenBlobRequest) returns (GetTokenBlobResponse)

/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (void)getTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenBlobWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Fetch a blob using a Token's authority. Works if Blob is attached to token
 * and authenticated member is the Token's "from" or "to".
 * https://developer.token.io/sdk/#transfer-token-options
 */
- (GRPCProtoCall *)RPCToGetTokenBlobWithRequest:(GetTokenBlobRequest *)request handler:(void(^)(GetTokenBlobResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokenBlob"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenBlobResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark StoreTokenRequest(StoreTokenRequestRequest) returns (StoreTokenRequestResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens Requests.
 * 
 * 
 * Store a Token Request
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
 */
- (GRPCProtoCall *)RPCToStoreTokenRequestWithRequest:(StoreTokenRequestRequest *)request handler:(void(^)(StoreTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"StoreTokenRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[StoreTokenRequestResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RetrieveTokenRequest(RetrieveTokenRequestRequest) returns (RetrieveTokenRequestResponse)

/**
 * Retrviee a Token Request
 */
- (void)retrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRetrieveTokenRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Retrviee a Token Request
 */
- (GRPCProtoCall *)RPCToRetrieveTokenRequestWithRequest:(RetrieveTokenRequestRequest *)request handler:(void(^)(RetrieveTokenRequestResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RetrieveTokenRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RetrieveTokenRequestResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransferToken(CreateTransferTokenRequest) returns (CreateTransferTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (void)createTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTransferTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 * Create a Transfer Token.
 * https://developer.token.io/sdk/#create-transfer-token
 */
- (GRPCProtoCall *)RPCToCreateTransferTokenWithRequest:(CreateTransferTokenRequest *)request handler:(void(^)(CreateTransferTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransferToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTransferTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Create an Access Token.
 * https://developer.token.io/sdk/#create-access-token
 */
- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (void)getTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about one token.
 * https://developer.token.io/sdk/#redeem-transfer-token
 */
- (GRPCProtoCall *)RPCToGetTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetActiveAccessToken(GetActiveAccessTokenRequest) returns (GetActiveAccessTokenResponse)

/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (void)getActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetActiveAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get existing Access Token where the calling member is the
 * remitter and provided member is the beneficiary.
 */
- (GRPCProtoCall *)RPCToGetActiveAccessTokenWithRequest:(GetActiveAccessTokenRequest *)request handler:(void(^)(GetActiveAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetActiveAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetActiveAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

/**
 * Gets list of tokens the member has given/received.
 * Used by getTransferTokens, getAccessTokens.
 * https://developer.token.io/sdk/#get-tokens
 * https://developer.token.io/sdk/#replace-access-token
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
 */
- (GRPCProtoCall *)RPCToGetTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokensResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (void)endorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEndorseTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Endorse a token
 * https://developer.token.io/sdk/#endorse-transfer-token
 * https://developer.token.io/sdk/#endorse-access-token
 */
- (GRPCProtoCall *)RPCToEndorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EndorseToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EndorseTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (void)cancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCancelTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Cancel a token
 * https://developer.token.io/sdk/#cancel-transfer-token
 * https://developer.token.io/sdk/#cancel-access-token
 */
- (GRPCProtoCall *)RPCToCancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CancelToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CancelTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

/**
 * Replace an access token
 * https://developer.token.io/sdk/#replace-access-token
 * 
 * See how replaceAndEndorseToken uses it:
 * https://developer.token.io/sdk/esdoc/class/src/http/AuthHttpClient.js~AuthHttpClient.html#instance-method-replaceAndEndorseToken
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
 */
- (GRPCProtoCall *)RPCToReplaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ReplaceToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ReplaceTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SignTokenRequestState(SignTokenRequestStateRequest) returns (SignTokenRequestStateResponse)

/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (void)signTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSignTokenRequestStateWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Request a Token signature on a token request state payload (tokenId | state)
 */
- (GRPCProtoCall *)RPCToSignTokenRequestStateWithRequest:(SignTokenRequestStateRequest *)request handler:(void(^)(SignTokenRequestStateResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SignTokenRequestState"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SignTokenRequestStateResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTokenRequestResult(GetTokenRequestResultRequest) returns (GetTokenRequestResultResponse)

/**
 * Get the token request result from the token request id
 */
- (void)getTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenRequestResultWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get the token request result from the token request id
 */
- (GRPCProtoCall *)RPCToGetTokenRequestResultWithRequest:(GetTokenRequestResultRequest *)request handler:(void(^)(GetTokenRequestResultResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokenRequestResult"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenRequestResultResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

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
 */
- (GRPCProtoCall *)RPCToCreateTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information about one transfer.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransfersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get a list of the auth'd member's transfers.
 * https://developer.token.io/sdk/#get-transfers
 */
- (GRPCProtoCall *)RPCToGetTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransfers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransfersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBanks(GetBanksRequest) returns (GetBanksResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)getBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBanksWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank Information Endpoints.
 * 
 * 
 * Get a list of "link-able" banks.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToGetBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBanks"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBanksResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (void)getBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBankInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Get information useful for linking one bank.
 * https://developer.token.io/sdk/#link-a-bank-account
 */
- (GRPCProtoCall *)RPCToGetBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBankInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBankInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
#endif
