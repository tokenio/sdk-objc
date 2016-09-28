#import "bankapi/Bankapi.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
  #import <Protobuf/Any.pbobjc.h>
#else
  #import "google/protobuf/Any.pbobjc.h"
#endif
#import "Money.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"


NS_ASSUME_NONNULL_BEGIN

@protocol TransactionService <NSObject>

#pragma mark Transfer(TransferRequest) returns (TransferResponse)

- (void)transferWithRequest:(TransferRequest *)request handler:(void(^)(TransferResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTransferWithRequest:(TransferRequest *)request handler:(void(^)(TransferResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransaction(GetTransactionRequest) returns (GetTransactionResponse)

- (void)getTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionWithRequest:(GetTransactionRequest *)request handler:(void(^)(GetTransactionResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactions(GetTransactionsRequest) returns (GetTransactionsResponse)

- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(GetTransactionsResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface TransactionService : GRPCProtoService<TransactionService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
@protocol AccountService <NSObject>

#pragma mark StartLinkBank(StartLinkBankRequest) returns (StartLinkBankResponse)

- (void)startLinkBankWithRequest:(StartLinkBankRequest *)request handler:(void(^)(StartLinkBankResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToStartLinkBankWithRequest:(StartLinkBankRequest *)request handler:(void(^)(StartLinkBankResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetBalance(GetBalanceRequest) returns (GetBalanceResponse)

- (void)getBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetBalanceWithRequest:(GetBalanceRequest *)request handler:(void(^)(GetBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface AccountService : GRPCProtoService<AccountService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
@protocol StorageService <NSObject>

#pragma mark SetValue(SetValueRequest) returns (SetValueResponse)

- (void)setValueWithRequest:(SetValueRequest *)request handler:(void(^)(SetValueResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToSetValueWithRequest:(SetValueRequest *)request handler:(void(^)(SetValueResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetValue(GetValueRequest) returns (GetValueResponse)

- (void)getValueWithRequest:(GetValueRequest *)request handler:(void(^)(GetValueResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetValueWithRequest:(GetValueRequest *)request handler:(void(^)(GetValueResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface StorageService : GRPCProtoService<StorageService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
