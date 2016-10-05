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
#pragma mark CreateAddress(CreateAddressRequest) returns (CreateAddressResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (void)createAddressWithRequest:(CreateAddressRequest *)request handler:(void(^)(CreateAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Member addresses and preferences
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateAddressWithRequest:(CreateAddressRequest *)request handler:(void(^)(CreateAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateAddressResponse class]
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
#pragma mark SetPreference(SetPreferenceRequest) returns (SetPreferenceResponse)

- (void)setPreferenceWithRequest:(SetPreferenceRequest *)request handler:(void(^)(SetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetPreferenceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSetPreferenceWithRequest:(SetPreferenceRequest *)request handler:(void(^)(SetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetPreference"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetPreferenceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetPreference(GetPreferenceRequest) returns (GetPreferenceResponse)

- (void)getPreferenceWithRequest:(GetPreferenceRequest *)request handler:(void(^)(GetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetPreferenceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetPreferenceWithRequest:(GetPreferenceRequest *)request handler:(void(^)(GetPreferenceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetPreference"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetPreferenceResponse class]
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
#pragma mark LinkAccount(LinkAccountRequest) returns (LinkAccountResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (void)linkAccountWithRequest:(LinkAccountRequest *)request handler:(void(^)(LinkAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLinkAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Bank accounts.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToLinkAccountWithRequest:(LinkAccountRequest *)request handler:(void(^)(LinkAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LinkAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LinkAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupAccount(LookupAccountRequest) returns (LookupAccountResponse)

- (void)lookupAccountWithRequest:(LookupAccountRequest *)request handler:(void(^)(LookupAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupAccountWithRequest:(LookupAccountRequest *)request handler:(void(^)(LookupAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupAccounts(LookupAccountsRequest) returns (LookupAccountsResponse)

- (void)lookupAccountsWithRequest:(LookupAccountsRequest *)request handler:(void(^)(LookupAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupAccountsWithRequest:(LookupAccountsRequest *)request handler:(void(^)(LookupAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupAccountsResponse class]
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
#pragma mark LookupBalance(LookupBalanceRequest) returns (LookupBalanceResponse)

- (void)lookupBalanceWithRequest:(LookupBalanceRequest *)request handler:(void(^)(LookupBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupBalanceWithRequest:(LookupBalanceRequest *)request handler:(void(^)(LookupBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupTransaction(LookupTransactionRequest) returns (LookupTransactionResponse)

- (void)lookupTransactionWithRequest:(LookupTransactionRequest *)request handler:(void(^)(LookupTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupTransactionWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupTransactionWithRequest:(LookupTransactionRequest *)request handler:(void(^)(LookupTransactionResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupTransaction"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupTransactionResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupTransactions(LookupTransactionsRequest) returns (LookupTransactionsResponse)

- (void)lookupTransactionsWithRequest:(LookupTransactionsRequest *)request handler:(void(^)(LookupTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupTransactionsWithRequest:(LookupTransactionsRequest *)request handler:(void(^)(LookupTransactionsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupTransactionsResponse class]
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
#pragma mark LookupPaymentToken(LookupPaymentTokenRequest) returns (LookupPaymentTokenResponse)

- (void)lookupPaymentTokenWithRequest:(LookupPaymentTokenRequest *)request handler:(void(^)(LookupPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupPaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupPaymentTokenWithRequest:(LookupPaymentTokenRequest *)request handler:(void(^)(LookupPaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupPaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupPaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupPaymentTokens(LookupPaymentTokensRequest) returns (LookupPaymentTokensResponse)

- (void)lookupPaymentTokensWithRequest:(LookupPaymentTokensRequest *)request handler:(void(^)(LookupPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupPaymentTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupPaymentTokensWithRequest:(LookupPaymentTokensRequest *)request handler:(void(^)(LookupPaymentTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupPaymentTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupPaymentTokensResponse class]
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
#pragma mark RevokePaymentToken(RevokePaymentTokenRequest) returns (RevokePaymentTokenResponse)

- (void)revokePaymentTokenWithRequest:(RevokePaymentTokenRequest *)request handler:(void(^)(RevokePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRevokePaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRevokePaymentTokenWithRequest:(RevokePaymentTokenRequest *)request handler:(void(^)(RevokePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RevokePaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RevokePaymentTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DeclinePaymentToken(DeclinePaymentTokenRequest) returns (DeclinePaymentTokenResponse)

- (void)declinePaymentTokenWithRequest:(DeclinePaymentTokenRequest *)request handler:(void(^)(DeclinePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeclinePaymentTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToDeclinePaymentTokenWithRequest:(DeclinePaymentTokenRequest *)request handler:(void(^)(DeclinePaymentTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeclinePaymentToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeclinePaymentTokenResponse class]
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
#pragma mark LookupAccessToken(LookupAccessTokenRequest) returns (LookupAccessTokenResponse)

- (void)lookupAccessTokenWithRequest:(LookupAccessTokenRequest *)request handler:(void(^)(LookupAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupAccessTokenWithRequest:(LookupAccessTokenRequest *)request handler:(void(^)(LookupAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupAccessTokens(LookupAccessTokensRequest) returns (LookupAccessTokensResponse)

- (void)lookupAccessTokensWithRequest:(LookupAccessTokensRequest *)request handler:(void(^)(LookupAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupAccessTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupAccessTokensWithRequest:(LookupAccessTokensRequest *)request handler:(void(^)(LookupAccessTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupAccessTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupAccessTokensResponse class]
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
#pragma mark RevokeAccessToken(RevokeAccessTokenRequest) returns (RevokeAccessTokenResponse)

- (void)revokeAccessTokenWithRequest:(RevokeAccessTokenRequest *)request handler:(void(^)(RevokeAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRevokeAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRevokeAccessTokenWithRequest:(RevokeAccessTokenRequest *)request handler:(void(^)(RevokeAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RevokeAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RevokeAccessTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark DeclineAccessToken(DeclineAccessTokenRequest) returns (DeclineAccessTokenResponse)

- (void)declineAccessTokenWithRequest:(DeclineAccessTokenRequest *)request handler:(void(^)(DeclineAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeclineAccessTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToDeclineAccessTokenWithRequest:(DeclineAccessTokenRequest *)request handler:(void(^)(DeclineAccessTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeclineAccessToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeclineAccessTokenResponse class]
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
#pragma mark LookupPayment(LookupPaymentRequest) returns (LookupPaymentResponse)

- (void)lookupPaymentWithRequest:(LookupPaymentRequest *)request handler:(void(^)(LookupPaymentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupPaymentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupPaymentWithRequest:(LookupPaymentRequest *)request handler:(void(^)(LookupPaymentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupPayment"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupPaymentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark LookupPayments(LookupPaymentsRequest) returns (LookupPaymentsResponse)

- (void)lookupPaymentsWithRequest:(LookupPaymentsRequest *)request handler:(void(^)(LookupPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupPaymentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLookupPaymentsWithRequest:(LookupPaymentsRequest *)request handler:(void(^)(LookupPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupPayments"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LookupPaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
