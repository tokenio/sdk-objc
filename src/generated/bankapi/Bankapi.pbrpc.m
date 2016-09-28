#import "bankapi/Bankapi.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation TransactionService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.bankapi" serviceName:@"TransactionService"]);
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


#pragma mark Transfer(TransferRequest) returns (TransferResponse)

- (void)transferWithRequest:(TransferRequest *)request handler:(void(^)(TransferResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTransferWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTransferWithRequest:(TransferRequest *)request handler:(void(^)(TransferResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Transfer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransferResponse class]
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
@end
@implementation AccountService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.bankapi" serviceName:@"AccountService"]);
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


#pragma mark StartLinkBank(StartLinkBankRequest) returns (StartLinkBankResponse)

- (void)startLinkBankWithRequest:(StartLinkBankRequest *)request handler:(void(^)(StartLinkBankResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToStartLinkBankWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToStartLinkBankWithRequest:(StartLinkBankRequest *)request handler:(void(^)(StartLinkBankResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"StartLinkBank"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[StartLinkBankResponse class]
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
@end
@implementation StorageService

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"io.token.proto.bankapi" serviceName:@"StorageService"]);
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


#pragma mark SetValue(SetValueRequest) returns (SetValueResponse)

- (void)setValueWithRequest:(SetValueRequest *)request handler:(void(^)(SetValueResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSetValueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSetValueWithRequest:(SetValueRequest *)request handler:(void(^)(SetValueResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SetValue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SetValueResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark GetValue(GetValueRequest) returns (GetValueResponse)

- (void)getValueWithRequest:(GetValueRequest *)request handler:(void(^)(GetValueResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetValueWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToGetValueWithRequest:(GetValueRequest *)request handler:(void(^)(GetValueResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetValue"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetValueResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
@end
