#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "fank/Cma9.pbrpc.h"
#import "fank/Cma9.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import "google/api/Annotations.pbobjc.h"

@implementation Cma9Service

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"io.token.proto.cma9"
                 serviceName:@"Cma9Service"];
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

#pragma mark CreateAccountRequest(AccountRequestsRequest) returns (AccountRequestsResponse)

/**
 * Used to request information about accounts and transactions.
 */
- (void)createAccountRequestWithRequest:(AccountRequestsRequest *)request handler:(void(^)(AccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccountRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to request information about accounts and transactions.
 */
- (GRPCProtoCall *)RPCToCreateAccountRequestWithRequest:(AccountRequestsRequest *)request handler:(void(^)(AccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccountRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountRequestsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RemoveAccountRequest(DeleteAccountRequestsRequest) returns (DeleteAccountRequestsResponse)

/**
 * Used to delete a request for account/transaction information.
 */
- (void)removeAccountRequestWithRequest:(DeleteAccountRequestsRequest *)request handler:(void(^)(DeleteAccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveAccountRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to delete a request for account/transaction information.
 */
- (GRPCProtoCall *)RPCToRemoveAccountRequestWithRequest:(DeleteAccountRequestsRequest *)request handler:(void(^)(DeleteAccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveAccountRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAccountRequestsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccounts(AccountsRequest) returns (AccountsResponse)

/**
 * Used to retrieve a list of accounts the AISP is authorized to access
 */
- (void)getAccountsWithRequest:(AccountsRequest *)request handler:(void(^)(AccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to retrieve a list of accounts the AISP is authorized to access
 */
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(AccountsRequest *)request handler:(void(^)(AccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccount(AccountRequest) returns (AccountResponse)

/**
 * Used to query information about a particular account.
 */
- (void)getAccountWithRequest:(AccountRequest *)request handler:(void(^)(AccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query information about a particular account.
 */
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(AccountRequest *)request handler:(void(^)(AccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccountBalances(AccountBalancesRequest) returns (AccountBalancesResponse)

/**
 * Used to query account balances.
 */
- (void)getAccountBalancesWithRequest:(AccountBalancesRequest *)request handler:(void(^)(AccountBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountBalancesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query account balances.
 */
- (GRPCProtoCall *)RPCToGetAccountBalancesWithRequest:(AccountBalancesRequest *)request handler:(void(^)(AccountBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountBalances"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountBalancesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccountTransactions(AccountTransactionsRequest) returns (AccountTransactionsResponse)

/**
 * Used to query information about an account's transactions.
 */
- (void)getAccountTransactionsWithRequest:(AccountTransactionsRequest *)request handler:(void(^)(AccountTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query information about an account's transactions.
 */
- (GRPCProtoCall *)RPCToGetAccountTransactionsWithRequest:(AccountTransactionsRequest *)request handler:(void(^)(AccountTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountTransactionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreatePayment(PaymentsRequest) returns (PaymentsResponse)

/**
 * Used to create a payment object, later to be redeemed.
 */
- (void)createPaymentWithRequest:(PaymentsRequest *)request handler:(void(^)(PaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreatePaymentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to create a payment object, later to be redeemed.
 */
- (GRPCProtoCall *)RPCToCreatePaymentWithRequest:(PaymentsRequest *)request handler:(void(^)(PaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreatePayment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreatePaymentSubmission(PaymentSubmissionsRequest) returns (PaymentSubmissionsResponse)

/**
 * Used to submit/redeem an existing payment object.
 */
- (void)createPaymentSubmissionWithRequest:(PaymentSubmissionsRequest *)request handler:(void(^)(PaymentSubmissionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreatePaymentSubmissionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to submit/redeem an existing payment object.
 */
- (GRPCProtoCall *)RPCToCreatePaymentSubmissionWithRequest:(PaymentSubmissionsRequest *)request handler:(void(^)(PaymentSubmissionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreatePaymentSubmission"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PaymentSubmissionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
#endif
