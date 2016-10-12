#import "bankapi/Fank.pbobjc.h"

#import <ProtoRPC/ProtoService.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>

#import "google/api/Annotations.pbobjc.h"
#import "Money.pbobjc.h"


NS_ASSUME_NONNULL_BEGIN

@protocol FankFankService <NSObject>

#pragma mark AddClient(AddClientRequest) returns (AddClientResponse)

- (void)addClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddClientWithRequest:(FankAddClientRequest *)request handler:(void(^)(FankAddClientResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetClient(GetClientRequest) returns (GetClientResponse)

- (void)getClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetClientWithRequest:(FankGetClientRequest *)request handler:(void(^)(FankGetClientResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddAccount(AddAccountRequest) returns (AddAccountResponse)

- (void)addAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToAddAccountWithRequest:(FankAddAccountRequest *)request handler:(void(^)(FankAddAccountResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccounts(GetAccountsRequest) returns (GetAccountsResponse)

- (void)getAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountsWithRequest:(FankGetAccountsRequest *)request handler:(void(^)(FankGetAccountsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetAccount(GetAccountRequest) returns (GetAccountResponse)

- (void)getAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToGetAccountWithRequest:(FankGetAccountRequest *)request handler:(void(^)(FankGetAccountResponse *_Nullable response, NSError *_Nullable error))handler;


@end

/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface FankFankService : GRPCProtoService<FankFankService>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end

NS_ASSUME_NONNULL_END
