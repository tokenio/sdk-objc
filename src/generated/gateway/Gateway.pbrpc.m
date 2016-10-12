#import "gateway/Gateway.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation GatewayService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.gateway" serviceName:@"GatewayService"]);
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


#pragma mark CreateMember(CreateMemberRequest) returns (CreateMemberResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member registration, key and alias mamangement.
 * 
 * 
 */
- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member registration, key and alias mamangement.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UpdateMember(UpdateMemberRequest) returns (UpdateMemberResponse)

- (void)updateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUpdateMemberWithRequest:(UpdateMemberRequest *)request handler:(void(^)(UpdateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UpdateMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetMember(GetMemberRequest) returns (GetMemberResponse)

- (void)getMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetMemberWithRequest:(GetMemberRequest *)request handler:(void(^)(GetMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetMember"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetMemberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark AliasExists(AliasExistsRequest) returns (AliasExistsResponse)

- (void)aliasExistsWithRequest:(AliasExistsRequest *)request handler:(void(^)(AliasExistsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAliasExistsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToAliasExistsWithRequest:(AliasExistsRequest *)request handler:(void(^)(AliasExistsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AliasExists"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AliasExistsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark AddAddress(AddAddressRequest) returns (AddAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
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
 */
- (GRPCProtoCall *)RPCToAddAddressWithRequest:(AddAddressRequest *)request handler:(void(^)(AddAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAddress(GetAddressRequest) returns (GetAddressResponse)

- (void)getAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAddressWithRequest:(GetAddressRequest *)request handler:(void(^)(GetAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAddresses(GetAddressesRequest) returns (GetAddressesResponse)

- (void)getAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAddressesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAddressesWithRequest:(GetAddressesRequest *)request handler:(void(^)(GetAddressesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAddresses"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAddressesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DeleteAddress(DeleteAddressRequest) returns (DeleteAddressResponse)

- (void)deleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeleteAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToDeleteAddressWithRequest:(DeleteAddressRequest *)request handler:(void(^)(DeleteAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeleteAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SubscribeDevice(SubscribeDeviceRequest) returns (SubscribeDeviceResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (void)subscribeDeviceWithRequest:(SubscribeDeviceRequest *)request handler:(void(^)(SubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSubscribeDeviceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
 */
- (GRPCProtoCall *)RPCToSubscribeDeviceWithRequest:(SubscribeDeviceRequest *)request handler:(void(^)(SubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SubscribeDevice"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SubscribeDeviceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnsubscribeDevice(UnsubscribeDeviceRequest) returns (UnsubscribeDeviceResponse)

- (void)unsubscribeDeviceWithRequest:(UnsubscribeDeviceRequest *)request handler:(void(^)(UnsubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnsubscribeDeviceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUnsubscribeDeviceWithRequest:(UnsubscribeDeviceRequest *)request handler:(void(^)(UnsubscribeDeviceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnsubscribeDevice"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnsubscribeDeviceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NotifyLinkAccounts(NotifyLinkAccountsRequest) returns (NotifyLinkAccountsResponse)

- (void)notifyLinkAccountsWithRequest:(NotifyLinkAccountsRequest *)request handler:(void(^)(NotifyLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyLinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToNotifyLinkAccountsWithRequest:(NotifyLinkAccountsRequest *)request handler:(void(^)(NotifyLinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"NotifyLinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyLinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NotifyAddKey(NotifyAddKeyRequest) returns (NotifyAddKeyResponse)

- (void)notifyAddKeyWithRequest:(NotifyAddKeyRequest *)request handler:(void(^)(NotifyAddKeyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyAddKeyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToNotifyAddKeyWithRequest:(NotifyAddKeyRequest *)request handler:(void(^)(NotifyAddKeyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"NotifyAddKey"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyAddKeyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark NotifyLinkAccountsAndAddKey(NotifyLinkAccountsAndAddKeyRequest) returns (NotifyLinkAccountsAndAddKeyResponse)

- (void)notifyLinkAccountsAndAddKeyWithRequest:(NotifyLinkAccountsAndAddKeyRequest *)request handler:(void(^)(NotifyLinkAccountsAndAddKeyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyLinkAccountsAndAddKeyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToNotifyLinkAccountsAndAddKeyWithRequest:(NotifyLinkAccountsAndAddKeyRequest *)request handler:(void(^)(NotifyLinkAccountsAndAddKeyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"NotifyLinkAccountsAndAddKey"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyLinkAccountsAndAddKeyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LinkAccounts(LinkAccountsRequest) returns (LinkAccountsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
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
 */
- (GRPCProtoCall *)RPCToLinkAccountsWithRequest:(LinkAccountsRequest *)request handler:(void(^)(LinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

- (void)getAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountWithRequest:(GetAccountRequest *)request handler:(void(^)(GetAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

- (void)getAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(GetAccountsRequest *)request handler:(void(^)(GetAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccountsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SetAccountName(SetAccountNameRequest) returns (SetAccountNameResponse)

- (void)setAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetAccountNameWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSetAccountNameWithRequest:(SetAccountNameRequest *)request handler:(void(^)(SetAccountNameResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetAccountName"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetAccountNameResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransactionsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreatePaymentToken(CreatePaymentTokenRequest) returns (CreatePaymentTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Payment Tokens.
 * 
 * 
 */
- (void)createPaymentTokenWithRequest:(CreatePaymentTokenRequest *)request handler:(void(^)(CreatePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreatePaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Payment Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreatePaymentTokenWithRequest:(CreatePaymentTokenRequest *)request handler:(void(^)(CreatePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreatePaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreatePaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPaymentToken(GetPaymentTokenRequest) returns (GetPaymentTokenResponse)

- (void)getPaymentTokenWithRequest:(GetPaymentTokenRequest *)request handler:(void(^)(GetPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaymentTokenWithRequest:(GetPaymentTokenRequest *)request handler:(void(^)(GetPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPaymentTokens(GetPaymentTokensRequest) returns (GetPaymentTokensResponse)

- (void)getPaymentTokensWithRequest:(GetPaymentTokensRequest *)request handler:(void(^)(GetPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaymentTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaymentTokensWithRequest:(GetPaymentTokensRequest *)request handler:(void(^)(GetPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPaymentTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPaymentTokensResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EndorsePaymentToken(EndorsePaymentTokenRequest) returns (EndorsePaymentTokenResponse)

- (void)endorsePaymentTokenWithRequest:(EndorsePaymentTokenRequest *)request handler:(void(^)(EndorsePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEndorsePaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToEndorsePaymentTokenWithRequest:(EndorsePaymentTokenRequest *)request handler:(void(^)(EndorsePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EndorsePaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EndorsePaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CancelPaymentToken(CancelPaymentTokenRequest) returns (CancelPaymentTokenResponse)

- (void)cancelPaymentTokenWithRequest:(CancelPaymentTokenRequest *)request handler:(void(^)(CancelPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCancelPaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCancelPaymentTokenWithRequest:(CancelPaymentTokenRequest *)request handler:(void(^)(CancelPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CancelPaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CancelPaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateAccessToken(CreateAccessTokenRequest) returns (CreateAccessTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Access Tokens.
 * 
 * 
 */
- (void)createAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Access Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateAccessTokenWithRequest:(CreateAccessTokenRequest *)request handler:(void(^)(CreateAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccessToken(GetAccessTokenRequest) returns (GetAccessTokenResponse)

- (void)getAccessTokenWithRequest:(GetAccessTokenRequest *)request handler:(void(^)(GetAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccessTokenWithRequest:(GetAccessTokenRequest *)request handler:(void(^)(GetAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetAccessTokens(GetAccessTokensRequest) returns (GetAccessTokensResponse)

- (void)getAccessTokensWithRequest:(GetAccessTokensRequest *)request handler:(void(^)(GetAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetAccessTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetAccessTokensWithRequest:(GetAccessTokensRequest *)request handler:(void(^)(GetAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetAccessTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetAccessTokensResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EndorseAccessToken(EndorseAccessTokenRequest) returns (EndorseAccessTokenResponse)

- (void)endorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEndorseAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToEndorseAccessTokenWithRequest:(EndorseAccessTokenRequest *)request handler:(void(^)(EndorseAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EndorseAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EndorseAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CancelAccessToken(CancelAccessTokenRequest) returns (CancelAccessTokenResponse)

- (void)cancelAccessTokenWithRequest:(CancelAccessTokenRequest *)request handler:(void(^)(CancelAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCancelAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCancelAccessTokenWithRequest:(CancelAccessTokenRequest *)request handler:(void(^)(CancelAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CancelAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CancelAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RedeemPaymentToken(RedeemPaymentTokenRequest) returns (RedeemPaymentTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Payments.
 * 
 * 
 */
- (void)redeemPaymentTokenWithRequest:(RedeemPaymentTokenRequest *)request handler:(void(^)(RedeemPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRedeemPaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Payments.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToRedeemPaymentTokenWithRequest:(RedeemPaymentTokenRequest *)request handler:(void(^)(RedeemPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RedeemPaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RedeemPaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPayment(GetPaymentRequest) returns (GetPaymentResponse)

- (void)getPaymentWithRequest:(GetPaymentRequest *)request handler:(void(^)(GetPaymentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaymentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaymentWithRequest:(GetPaymentRequest *)request handler:(void(^)(GetPaymentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPayment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPaymentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPayments(GetPaymentsRequest) returns (GetPaymentsResponse)

- (void)getPaymentsWithRequest:(GetPaymentsRequest *)request handler:(void(^)(GetPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPaymentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPaymentsWithRequest:(GetPaymentsRequest *)request handler:(void(^)(GetPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPayments"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
