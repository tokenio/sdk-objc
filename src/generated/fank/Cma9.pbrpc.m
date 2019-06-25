#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "fank/Cma9.pbrpc.h"
#import "fank/Cma9.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

#import "google/api/Annotations.pbobjc.h"

@implementation Cma9Service

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"io.token.proto.cma9"
                 serviceName:@"Cma9Service"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"io.token.proto.cma9"
                 serviceName:@"Cma9Service"];
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

#pragma mark CreateAccountRequest(AccountRequestsRequest) returns (AccountRequestsResponse)

// Deprecated methods.
/**
 * Used to request information about accounts and transactions.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createAccountRequestWithRequest:(AccountRequestsRequest *)request handler:(void(^)(AccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccountRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to request information about accounts and transactions.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreateAccountRequestWithRequest:(AccountRequestsRequest *)request handler:(void(^)(AccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccountRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountRequestsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to request information about accounts and transactions.
 */
- (GRPCUnaryProtoCall *)createAccountRequestWithMessage:(AccountRequestsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreateAccountRequest"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AccountRequestsResponse class]];
}

#pragma mark RemoveAccountRequest(DeleteAccountRequestsRequest) returns (DeleteAccountRequestsResponse)

// Deprecated methods.
/**
 * Used to delete a request for account/transaction information.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)removeAccountRequestWithRequest:(DeleteAccountRequestsRequest *)request handler:(void(^)(DeleteAccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRemoveAccountRequestWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to delete a request for account/transaction information.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRemoveAccountRequestWithRequest:(DeleteAccountRequestsRequest *)request handler:(void(^)(DeleteAccountRequestsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RemoveAccountRequest"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAccountRequestsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to delete a request for account/transaction information.
 */
- (GRPCUnaryProtoCall *)removeAccountRequestWithMessage:(DeleteAccountRequestsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RemoveAccountRequest"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DeleteAccountRequestsResponse class]];
}

#pragma mark GetAccounts(AccountsRequest) returns (AccountsResponse)

// Deprecated methods.
/**
 * Used to retrieve a list of accounts the AISP is authorized to access
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountsWithRequest:(AccountsRequest *)request handler:(void(^)(AccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to retrieve a list of accounts the AISP is authorized to access
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(AccountsRequest *)request handler:(void(^)(AccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to retrieve a list of accounts the AISP is authorized to access
 */
- (GRPCUnaryProtoCall *)getAccountsWithMessage:(AccountsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccounts"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AccountsResponse class]];
}

#pragma mark GetAccount(AccountRequest) returns (AccountResponse)

// Deprecated methods.
/**
 * Used to query information about a particular account.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountWithRequest:(AccountRequest *)request handler:(void(^)(AccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query information about a particular account.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(AccountRequest *)request handler:(void(^)(AccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to query information about a particular account.
 */
- (GRPCUnaryProtoCall *)getAccountWithMessage:(AccountRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccount"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AccountResponse class]];
}

#pragma mark GetAccountBalances(AccountBalancesRequest) returns (AccountBalancesResponse)

// Deprecated methods.
/**
 * Used to query account balances.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountBalancesWithRequest:(AccountBalancesRequest *)request handler:(void(^)(AccountBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountBalancesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query account balances.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountBalancesWithRequest:(AccountBalancesRequest *)request handler:(void(^)(AccountBalancesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountBalances"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountBalancesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to query account balances.
 */
- (GRPCUnaryProtoCall *)getAccountBalancesWithMessage:(AccountBalancesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccountBalances"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AccountBalancesResponse class]];
}

#pragma mark GetAccountTransactions(AccountTransactionsRequest) returns (AccountTransactionsResponse)

// Deprecated methods.
/**
 * Used to query information about an account's transactions.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getAccountTransactionsWithRequest:(AccountTransactionsRequest *)request handler:(void(^)(AccountTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to query information about an account's transactions.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetAccountTransactionsWithRequest:(AccountTransactionsRequest *)request handler:(void(^)(AccountTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccountTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AccountTransactionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to query information about an account's transactions.
 */
- (GRPCUnaryProtoCall *)getAccountTransactionsWithMessage:(AccountTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetAccountTransactions"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AccountTransactionsResponse class]];
}

#pragma mark CreatePayment(PaymentsRequest) returns (PaymentsResponse)

// Deprecated methods.
/**
 * Used to create a payment object, later to be redeemed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createPaymentWithRequest:(PaymentsRequest *)request handler:(void(^)(PaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreatePaymentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to create a payment object, later to be redeemed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreatePaymentWithRequest:(PaymentsRequest *)request handler:(void(^)(PaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreatePayment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to create a payment object, later to be redeemed.
 */
- (GRPCUnaryProtoCall *)createPaymentWithMessage:(PaymentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreatePayment"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PaymentsResponse class]];
}

#pragma mark CreatePaymentSubmission(PaymentSubmissionsRequest) returns (PaymentSubmissionsResponse)

// Deprecated methods.
/**
 * Used to submit/redeem an existing payment object.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)createPaymentSubmissionWithRequest:(PaymentSubmissionsRequest *)request handler:(void(^)(PaymentSubmissionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreatePaymentSubmissionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to submit/redeem an existing payment object.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCreatePaymentSubmissionWithRequest:(PaymentSubmissionsRequest *)request handler:(void(^)(PaymentSubmissionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreatePaymentSubmission"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PaymentSubmissionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to submit/redeem an existing payment object.
 */
- (GRPCUnaryProtoCall *)createPaymentSubmissionWithMessage:(PaymentSubmissionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CreatePaymentSubmission"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PaymentSubmissionsResponse class]];
}

#pragma mark GetParty(PartyRequest) returns (PartyResponse)

// Deprecated methods.
/**
 * Used to get account details
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getPartyWithRequest:(PartyRequest *)request handler:(void(^)(PartyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPartyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * Used to get account details
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetPartyWithRequest:(PartyRequest *)request handler:(void(^)(PartyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetParty"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PartyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * Used to get account details
 */
- (GRPCUnaryProtoCall *)getPartyWithMessage:(PartyRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetParty"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PartyResponse class]];
}

@end
#endif
