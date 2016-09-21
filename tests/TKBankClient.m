//
// Created by Alexey Kalinichenko on 9/16/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCCLient/GRPCCall+Tests.h>

#import <bankapi/Bankapi.pbrpc.h>
#import <bankapi/Fank.pbobjc.h>

#import "TKBankClient.h"
#import "TKRpcSyncCall.h"


@implementation TKBankClient {
    AccountService *accounts;
}

+ (TKBankClient *)bankClientWithHost:(NSString *)host port:(int)port {
    return [[TKBankClient alloc] initWithHost:host port:port];
}

- (TKBankClient *)initWithHost:(NSString *)host port:(int)port {
    self = [super init];

    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];

        [GRPCCall useInsecureConnectionsForHost:address];
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];

        accounts = [AccountService serviceWithHost:address];
    }

    return self;
}

- (NSData *)startAccountsLinkingForAlias:(NSString *)alias
                          accountNumbers:(NSArray<NSString *> *)accountNumbers
                                metadata:(FankMetadata *)metadata {
    TKRpcSyncCall<NSData *> *call = [TKRpcSyncCall create];
    return [call run:^{
        GPBAny *meta = [GPBAny message];
        meta.typeURL = [@"type.googleapis.com/" stringByAppendingFormat:@"%@.%@",
                        metadata.descriptor.file.package,
                        metadata.descriptor.name];
        meta.value = [metadata data];

        StartLinkBankRequest *request = [StartLinkBankRequest message];
        request.alias = alias;
        request.secret = @"";
        request.metadata = meta;
        [request.accountsArray addObjectsFromArray:accountNumbers];

        [accounts startLinkBankWithRequest:request
                                   handler:
                                           ^(StartLinkBankResponse *response, NSError *error) {
                                               if (response) {
                                                   call.onSuccess(response.accountLinkPayload);
                                               } else {
                                                   call.onError(error);
                                               }
                                           }];
    }];
}

@end
