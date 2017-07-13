//
// Created by Alexey Kalinichenko on 9/16/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <GRPCClient/GRPCCall+ChannelArg.h>


#import "fank/Fank.pbrpc.h"
#import "TKJson.h"

#import "TKBankClient.h"


@implementation TKBankClient {
    NSString *url;
    NSDictionary* headers;
}

static NSString *const TEST_BIC = @"IRONUSCA000";

+ (TKBankClient *)bankClientWithHost:(NSString *)host port:(int)port useSsl:(BOOL)useSsl {
    return [[TKBankClient alloc] initWithHost:host port:port useSsl:useSsl];
}

- (TKBankClient *)initWithHost:(NSString *)host port:(int)port useSsl:(BOOL)useSsl {
    self = [super init];

    if (self) {
        NSString *protocol = useSsl ? @"https" : @"http";
        url = [NSString stringWithFormat:@"%@://%@:%d", protocol, host, port];
        headers = @{@"user-agent": @"Token-iOS/1.0"};
    }

    return self;
}

- (FankClient *)addClientWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    FankAddClientRequest *request = [FankAddClientRequest message];
    request.firstName = firstName;
    request.lastName = lastName;
    UNIHTTPJsonResponse *response = [self httpPutCall:[NSString stringWithFormat:@"%@/banks/%@/clients", url, TEST_BIC]
                                             withData:[TKJson serializeData:request]];
    return [TKJson deserializeMessageOfClass:[FankClient class]
                              fromDictionary:response.body.object[@"client"]];
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
    NSString *urlPath = [NSString stringWithFormat:@"%@/banks/%@/clients/%@/accounts", url, TEST_BIC, client.id_p];
    UNIHTTPJsonResponse *response = [self httpPutCall:urlPath
                                             withData:[TKJson serializeData:request]];
    return [TKJson deserializeMessageOfClass:[FankAccount class]
                              fromDictionary:response.body.object[@"account"]];
}

- (NSArray<SealedMessage*> *)authorizeAccountLinkingFor:(NSString *)username
                                          clientId:(NSString *)clientId
                                    accountNumbers:(NSArray<NSString *> *)accountNumbers {
    FankAuthorizeLinkAccountsRequest *request = [FankAuthorizeLinkAccountsRequest message];
    request.username = username;
    request.clientId = clientId;
    [request.accountsArray addObjectsFromArray:accountNumbers];
    NSString *urlPath = [NSString stringWithFormat:@"%@/banks/%@/clients/%@/link-accounts", url, TEST_BIC, clientId];
    UNIHTTPJsonResponse *response = [self httpPutCall:urlPath
                                             withData:[TKJson serializeData:request]];
    BankAuthorization *auth = [TKJson deserializeMessageOfClass:[BankAuthorization class]
                                                          fromDictionary:response.body.object];
    return auth.accountsArray;
}

- (UNIHTTPJsonResponse *)httpPutCall:(NSString *)url withData:(NSData *)data {
    return [[UNIRest putEntity:^(UNIBodyRequest *request) {
        [request setUrl:url];
        [request setHeaders:headers];
        [request setBody:data];
    }] asJson];
}

@end
