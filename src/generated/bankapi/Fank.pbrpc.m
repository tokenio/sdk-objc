#import "bankapi/Fank.pbrpc.h"

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
@end
