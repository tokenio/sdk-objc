//
// Created by Maxim Khutornenko on 2/22/17.
// Copyright (c) 2017 Token Inc. All rights reserved.
//
#import <GRPCClient/GRPCCall+Tests.h>

#import "ProtoRPC/ProtoRPC.h"
#import "gateway/Gateway.pbrpc.h"
#import "TKError.h"
#import "TKTestBase.h"
#import "TKRpcErrorHandler.h"
#import "TKRpcSyncCall.h"
#import "HostAndPort.h"

@interface TKErrorHandlerTests : TKTestBase {
    GatewayService *gateway;
    ResolveAliasRequest *request;
    TKRpcSyncCall<NSNumber *> *syncCall;
}
@end

@implementation TKErrorHandlerTests

- (void)setUp {
    [super setUp];
    
    NSString *sslOverride = [[[NSProcessInfo processInfo] environment] objectForKey:@"TOKEN_USE_SSL"];
    BOOL useSsl = sslOverride ? [sslOverride boolValue] : NO;
    HostAndPort *connection = [super hostAndPort:@"TOKEN_GATEWAY" withDefaultPort:useSsl ? 443 : 9000];
    
    
    NSString *address = [NSString stringWithFormat:@"%@:%d", connection.host, connection.port];
    if (!useSsl) {
        [GRPCCall useInsecureConnectionsForHost:address];
    }
    gateway = [GatewayService serviceWithHost:address];
    
    request = [ResolveAliasRequest message];
    request.alias = [Alias message];
    
    syncCall = [TKRpcSyncCall create];
}

- (void)testErrorHandlerVersionMismatch {
    [self run: ^(TokenIOSync *tokenIO) {
        TKRpcErrorHandler *errorHandler = [[TKRpcErrorHandler alloc] initWithGlobalRpcErrorCallback:^(NSError *error) {
            XCTAssertTrue(error.code == kTKErrorSdkVersionMismatch);
        }];
        GRPCProtoCall *call = [gateway
                RPCToResolveAliasWithRequest:request
                                    handler:^(ResolveAliasResponse *response, NSError *error) {
                                        if (response) {
                                            XCTFail(@"onSuccess called but expected onError");
                                        } else {
                                            [errorHandler handle:syncCall.onError withError:error];
                                        }
                                    }];
        call.requestHeaders[@"token-sdk"] = @"objc";
        call.requestHeaders[@"token-sdk-version"] = @"0.0.1";
        call.requestHeaders[@"token-dev-key"] = [self sdkBuilder].developerKey;

        @try {
            [syncCall run:^{
                dispatch_after(
                        dispatch_time(DISPATCH_TIME_NOW, 15000 * NSEC_PER_MSEC),
                        dispatch_get_main_queue(), ^{
                            [call cancel];
                        });
                [call start];
            }];
        } @catch(NSError *error) {
            XCTAssertTrue(error.code == kTKErrorSdkVersionMismatch);
            return;
        }
        XCTFail(@"Expected error is not raised");
    }];
}

- (void)testErrorHandlerInvalidDeveloperKey {
    [self run: ^(TokenIOSync *tokenIO) {
        TKRpcErrorHandler *errorHandler = [[TKRpcErrorHandler alloc] initWithGlobalRpcErrorCallback:^(NSError *error) {
            XCTAssertTrue(error.code == kTKErrorInvalidDeveloperKey);
        }];
        GRPCProtoCall *call = [gateway
                               RPCToResolveAliasWithRequest:request
                               handler:^(ResolveAliasResponse *response, NSError *error) {
                                   if (response) {
                                       XCTFail(@"onSuccess called but expected onError");
                                   } else {
                                       [errorHandler handle:syncCall.onError withError:error];
                                   }
                               }];
        call.requestHeaders[@"token-dev-key"] = @"";
        
        @try {
            [syncCall run:^{
                dispatch_after(
                               dispatch_time(DISPATCH_TIME_NOW, 15000 * NSEC_PER_MSEC),
                               dispatch_get_main_queue(), ^{
                                   [call cancel];
                               });
                [call start];
            }];
        } @catch(NSError *error) {
            XCTAssertTrue(error.code == kTKErrorInvalidDeveloperKey);
            return;
        }
        XCTFail(@"Expected error is not raised");
    }];
}

@end
