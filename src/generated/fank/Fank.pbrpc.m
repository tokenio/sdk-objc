#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "fank/Fank.pbrpc.h"
#import "fank/Fank.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import "google/api/Annotations.pbobjc.h"
#import "Alias.pbobjc.h"
#import "Member.pbobjc.h"
#import "Money.pbobjc.h"
#import "Banklink.pbobjc.h"
#import "Notification.pbobjc.h"

@implementation FankFankService

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"io.token.proto.bankapi"
                 serviceName:@"FankService"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"io.token.proto.bankapi"
                 serviceName:@"FankService"];
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

#pragma mark AddClient(AddClientRequest) returns (AddClientResponse)

// Deprecated methods.
- (void)addClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddClientWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddClient"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankAddClientResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)addClientWithMessage:(FankAddClientRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddClient"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankAddClientResponse class]];
}

#pragma mark GetClient(GetClientRequest) returns (GetClientResponse)

// Deprecated methods.
- (void)getClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetClientWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetClient"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetClientResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getClientWithMessage:(FankGetClientRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetClient"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetClientResponse class]];
}

#pragma mark AddAccount(AddAccountRequest) returns (AddAccountResponse)

// Deprecated methods.
- (void)addAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAddAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankAddAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)addAccountWithMessage:(FankAddAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankAddAccountResponse class]];
}

#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

// Deprecated methods.
- (void)getAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getAccountsWithMessage:(FankGetAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetAccountsResponse class]];
}

#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

// Deprecated methods.
- (void)getAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getAccountWithMessage:(FankGetAccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetAccountResponse class]];
}

#pragma mark AuthorizeLinkAccounts(AuthorizeLinkAccountsRequest) returns (BankAuthorization)

// Deprecated methods.
- (void)authorizeLinkAccountsWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(BankAuthorization *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAuthorizeLinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAuthorizeLinkAccountsWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(BankAuthorization *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AuthorizeLinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BankAuthorization class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)authorizeLinkAccountsWithMessage:(FankAuthorizeLinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AuthorizeLinkAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[BankAuthorization class]];
}

#pragma mark AuthorizeLinkAccountsGet(AuthorizeLinkAccountsRequest) returns (BankAuthorization)

// Deprecated methods.
- (void)authorizeLinkAccountsGetWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(BankAuthorization *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAuthorizeLinkAccountsGetWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAuthorizeLinkAccountsGetWithRequest:(FankAuthorizeLinkAccountsRequest *)request handler:(void(^)(BankAuthorization *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AuthorizeLinkAccountsGet"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BankAuthorization class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)authorizeLinkAccountsGetWithMessage:(FankAuthorizeLinkAccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AuthorizeLinkAccountsGet"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[BankAuthorization class]];
}

#pragma mark GetOauthAccessToken(GetOauthAccessTokenRequest) returns (GetOauthAccessTokenResponse)

// Deprecated methods.
/**
 * 
 * Used by bank-demo to obtain access token.
 * 
 */
- (void)getOauthAccessTokenWithRequest:(FankGetOauthAccessTokenRequest *)request handler:(void(^)(FankGetOauthAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetOauthAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * 
 * Used by bank-demo to obtain access token.
 * 
 */
- (GRPCProtoCall *)RPCToGetOauthAccessTokenWithRequest:(FankGetOauthAccessTokenRequest *)request handler:(void(^)(FankGetOauthAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetOauthAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetOauthAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * 
 * Used by bank-demo to obtain access token.
 * 
 */
- (GRPCUnaryProtoCall *)getOauthAccessTokenWithMessage:(FankGetOauthAccessTokenRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetOauthAccessToken"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetOauthAccessTokenResponse class]];
}

#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

// Deprecated methods.
/**
 * 
 * Used by clients to make sure that notifications were routed and correctly delivered to
 * the fank. This is mainly for testing the flow where a notification is sent through a bank
 * instead of straight to devices.
 * 
 */
- (void)getNotificationWithRequest:(FankGetNotificationRequest *)request handler:(void(^)(FankGetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * 
 * Used by clients to make sure that notifications were routed and correctly delivered to
 * the fank. This is mainly for testing the flow where a notification is sent through a bank
 * instead of straight to devices.
 * 
 */
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(FankGetNotificationRequest *)request handler:(void(^)(FankGetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetNotificationResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * 
 * Used by clients to make sure that notifications were routed and correctly delivered to
 * the fank. This is mainly for testing the flow where a notification is sent through a bank
 * instead of straight to devices.
 * 
 */
- (GRPCUnaryProtoCall *)getNotificationWithMessage:(FankGetNotificationRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNotification"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetNotificationResponse class]];
}

#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

// Deprecated methods.
- (void)getNotificationsWithRequest:(FankGetNotificationsRequest *)request handler:(void(^)(FankGetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(FankGetNotificationsRequest *)request handler:(void(^)(FankGetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankGetNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)getNotificationsWithMessage:(FankGetNotificationsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNotifications"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankGetNotificationsResponse class]];
}

#pragma mark VerifyAlias(VerifyAliasRequest) returns (VerifyAliasResponse)

// Deprecated methods.
/**
 * 
 * Used by sdk-java-tests to create members in the fank realms.
 * 
 * 
 */
- (void)verifyAliasWithRequest:(FankVerifyAliasRequest *)request handler:(void(^)(FankVerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyAliasWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * 
 * Used by sdk-java-tests to create members in the fank realms.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToVerifyAliasWithRequest:(FankVerifyAliasRequest *)request handler:(void(^)(FankVerifyAliasResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyAlias"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FankVerifyAliasResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * 
 * Used by sdk-java-tests to create members in the fank realms.
 * 
 * 
 */
- (GRPCUnaryProtoCall *)verifyAliasWithMessage:(FankVerifyAliasRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyAlias"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FankVerifyAliasResponse class]];
}

@end
#endif
