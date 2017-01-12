//
// Created by Alexey Kalinichenko on 9/16/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCCLient/GRPCCall+Tests.h>

#import "bankapi/Fank.pbrpc.h"
#import "bankapi/Fank.pbobjc.h"

#import "TKBankClient.h"
#import "TKRpcSyncCall.h"


@implementation TKBankClient {
    FankFankService *fank;
}

+ (TKBankClient *)bankClientWithHost:(NSString *)host port:(int)port useSsl:(BOOL)useSsl {
    return [[TKBankClient alloc] initWithHost:host port:port useSsl:useSsl];
}

- (TKBankClient *)initWithHost:(NSString *)host port:(int)port useSsl:(BOOL)useSsl {
    self = [super init];

    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];
    
        if (!useSsl) {
            [GRPCCall useInsecureConnectionsForHost:address];
        }
        
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];
        fank = [FankFankService serviceWithHost:address];
    }

    return self;
}

- (FankClient *)addClientWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    FankAddClientRequest *request = [FankAddClientRequest message];
    request.firstName = firstName;
    request.lastName = lastName;
    
    TKRpcSyncCall<FankClient *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [fank addClientWithRequest:request
                           handler:^(FankAddClientResponse *response, NSError *error) {
                               if (response) {
                                   call.onSuccess(response.client);
                               } else {
                                   call.onError(error);
                               }
                           }];
    }];
}

- (FankAccount *)addAccountWithName:(NSString *)name
                      forClient:(FankClient *)client
             withAccountNumber:(NSString *)accountNumber
                        amount:(NSString *)amount
                      currency:(NSString *)currency {
    FankAddAccountRequest *request = [FankAddAccountRequest message];
    request.clientId = client.id_p;
    request.name = name;
    request.accountNumber = accountNumber;
    request.balance.value = amount;
    request.balance.currency = currency;
    
    TKRpcSyncCall<FankAccount *> *call = [TKRpcSyncCall create];
    return [call run:^{
        [fank addAccountWithRequest:request
                            handler:^(FankAddAccountResponse *response, NSError *error) {
                                if (response) {
                                    call.onSuccess(response.account);
                                } else {
                                    call.onError(error);
                                }
                            }];
    }];
}

- (NSArray<SealedMessage*> *)authorizeAccountLinkingFor:(NSString *)username
                                          clientId:(NSString *)clientId
                                    accountNumbers:(NSArray<NSString *> *)accountNumbers {
    TKRpcSyncCall<NSArray<SealedMessage*> *> *call = [TKRpcSyncCall create];
    return [call run:^{
        FankAuthorizeLinkAccountsRequest *request = [FankAuthorizeLinkAccountsRequest message];
        request.username = username;
        request.clientId = clientId;
        [request.accountsArray addObjectsFromArray:accountNumbers];

        [fank authorizeLinkAccountsWithRequest:request
                                       handler:
                                           ^(AccountLinkingPayloads *response, NSError *error) {
                                               if (response) {
                                                   call.onSuccess(response.payloadsArray);
                                               } else {
                                                   call.onError(error);
                                               }
                                           }];
    }];
}

@end
