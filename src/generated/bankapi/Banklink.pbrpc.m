#import "bankapi/Banklink.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation AccountLinkingService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.bankapi" serviceName:@"AccountLinkingService"]);
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


#pragma mark AuthorizeLinkAccounts(AuthorizeLinkAccountsRequest) returns (AuthorizeLinkAccountsResponse)

- (void)authorizeLinkAccountsWithRequest:(AuthorizeLinkAccountsRequest *)request handler:(void(^)(AuthorizeLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAuthorizeLinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAuthorizeLinkAccountsWithRequest:(AuthorizeLinkAccountsRequest *)request handler:(void(^)(AuthorizeLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AuthorizeLinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AuthorizeLinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
