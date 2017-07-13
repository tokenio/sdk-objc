#import "fank/Fank.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation FankFankService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.bankapi" serviceName:@"FankService"]);
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}


#pragma mark AddClient(AddClientRequest) returns (AddClientResponse)

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
#pragma mark GetClient(GetClientRequest) returns (GetClientResponse)

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
#pragma mark AddAccount(AddAccountRequest) returns (AddAccountResponse)

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
#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

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
#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

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
#pragma mark AuthorizeLinkAccounts(AuthorizeLinkAccountsRequest) returns (BankAuthorization)

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
#pragma mark AuthorizeLinkAccountsGet(AuthorizeLinkAccountsRequest) returns (BankAuthorization)

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
#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

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
#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

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
@end
