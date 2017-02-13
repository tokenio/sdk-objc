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

- (void)createMemberWithRequest:(CreateMemberRequest *)request handler:(void(^)(CreateMemberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateMemberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
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
#pragma mark GetMemberId(GetMemberIdRequest) returns (GetMemberIdResponse)

- (void)getMemberIdWithRequest:(GetMemberIdRequest *)request handler:(void(^)(GetMemberIdResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetMemberIdWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetMemberIdWithRequest:(GetMemberIdRequest *)request handler:(void(^)(GetMemberIdResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetMemberId"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetMemberIdResponse class]
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
#pragma mark SubscribeToNotifications(SubscribeToNotificationsRequest) returns (SubscribeToNotificationsResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Devices for notification service
 * 
 * 
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
 */
- (GRPCProtoCall *)RPCToSubscribeToNotificationsWithRequest:(SubscribeToNotificationsRequest *)request handler:(void(^)(SubscribeToNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SubscribeToNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SubscribeToNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetSubscribers(GetSubscribersRequest) returns (GetSubscribersResponse)

- (void)getSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscribersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetSubscribersWithRequest:(GetSubscribersRequest *)request handler:(void(^)(GetSubscribersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscribers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscribersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetSubscriber(GetSubscriberRequest) returns (GetSubscriberResponse)

- (void)getSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetSubscriberWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetSubscriberWithRequest:(GetSubscriberRequest *)request handler:(void(^)(GetSubscriberResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetSubscriber"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetSubscriberResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark UnsubscribeFromNotifications(UnsubscribeFromNotificationsRequest) returns (UnsubscribeFromNotificationsResponse)

- (void)unsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnsubscribeFromNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUnsubscribeFromNotificationsWithRequest:(UnsubscribeFromNotificationsRequest *)request handler:(void(^)(UnsubscribeFromNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnsubscribeFromNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnsubscribeFromNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark Notify(NotifyRequest) returns (NotifyResponse)

- (void)notifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNotifyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToNotifyWithRequest:(NotifyRequest *)request handler:(void(^)(NotifyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Notify"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NotifyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNotifications(GetNotificationsRequest) returns (GetNotificationsResponse)

- (void)getNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNotificationsWithRequest:(GetNotificationsRequest *)request handler:(void(^)(GetNotificationsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotifications"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetNotification(GetNotificationRequest) returns (GetNotificationResponse)

- (void)getNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNotificationWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetNotificationWithRequest:(GetNotificationRequest *)request handler:(void(^)(GetNotificationResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNotification"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetNotificationResponse class]
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
#pragma mark UnlinkAccounts(UnlinkAccountsRequest) returns (UnlinkAccountsResponse)

- (void)unlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnlinkAccountsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToUnlinkAccountsWithRequest:(UnlinkAccountsRequest *)request handler:(void(^)(UnlinkAccountsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnlinkAccounts"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnlinkAccountsResponse class]
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
#pragma mark CreateTestBankAccount(CreateTestBankAccountRequest) returns (CreateTestBankAccountResponse)

- (void)createTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTestBankAccountWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCreateTestBankAccountWithRequest:(CreateTestBankAccountRequest *)request handler:(void(^)(CreateTestBankAccountResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTestBankAccount"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTestBankAccountResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateToken(CreateTokenRequest) returns (CreateTokenResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 */
- (void)createTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCreateTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Tokens.
 * 
 * 
 */
- (GRPCProtoCall *)RPCToCreateTokenWithRequest:(CreateTokenRequest *)request handler:(void(^)(CreateTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetToken(GetTokenRequest) returns (GetTokenResponse)

- (void)getTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTokenWithRequest:(GetTokenRequest *)request handler:(void(^)(GetTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTokens(GetTokensRequest) returns (GetTokensResponse)

- (void)getTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTokensWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTokensWithRequest:(GetTokensRequest *)request handler:(void(^)(GetTokensResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTokens"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTokensResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark EndorseToken(EndorseTokenRequest) returns (EndorseTokenResponse)

- (void)endorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEndorseTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToEndorseTokenWithRequest:(EndorseTokenRequest *)request handler:(void(^)(EndorseTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EndorseToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EndorseTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CancelToken(CancelTokenRequest) returns (CancelTokenResponse)

- (void)cancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCancelTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCancelTokenWithRequest:(CancelTokenRequest *)request handler:(void(^)(CancelTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CancelToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CancelTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ReplaceToken(ReplaceTokenRequest) returns (ReplaceTokenResponse)

- (void)replaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToReplaceTokenWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToReplaceTokenWithRequest:(ReplaceTokenRequest *)request handler:(void(^)(ReplaceTokenResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ReplaceToken"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ReplaceTokenResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark CreateTransfer(CreateTransferRequest) returns (CreateTransferResponse)

/**
 * //////////////////////////////////////////////////////////////////////////////////////////////////
 * Token Transfers.
 * 
 * 
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
 */
- (GRPCProtoCall *)RPCToCreateTransferWithRequest:(CreateTransferRequest *)request handler:(void(^)(CreateTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CreateTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CreateTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransfer(GetTransferRequest) returns (GetTransferResponse)

- (void)getTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetTransferWithRequest:(GetTransferRequest *)request handler:(void(^)(GetTransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetTransferResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetTransfers(GetTransfersRequest) returns (GetTransfersResponse)

- (void)getTransfersWithRequest:(GetTransfersRequest *)request handler:(void(^)(GetTransfersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransfersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
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
 */
- (GRPCProtoCall *)RPCToGetBanksWithRequest:(GetBanksRequest *)request handler:(void(^)(GetBanksResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBanks"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBanksResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetBankInfo(GetBankInfoRequest) returns (GetBankInfoResponse)

- (void)getBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetBankInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetBankInfoWithRequest:(GetBankInfoRequest *)request handler:(void(^)(GetBankInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetBankInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetBankInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
