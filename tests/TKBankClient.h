//
// Created by Alexey Kalinichenko on 9/16/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UNIRest.h>
#import "Security.pbobjc.h"

@class FankAccount;
@class FankClient;


/**
 * Talks to the Fank to create accounts and get the account linking payload
 * that is then used to link the accounts with Token. Simulates what we
 * would normally do in the web client.
 */
@interface TKBankClient : NSObject

+ (TKBankClient *)bankClientWithHost:(NSString *)host port:(int)port useSsl:(BOOL)useSsl;


- (FankClient *)addClientWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

- (FankAccount *)addAccountWithName:(NSString *)name
                          forClient:(FankClient *)client
                  withAccountNumber:(NSString *)accountNumber
                             amount:(NSString *)amount
                           currency:(NSString *)currency;

- (NSArray<SealedMessage*> *)authorizeAccountLinkingFor:(NSString *)username
                                          clientId:(NSString *)clientId
                                    accountNumbers:(NSArray<NSString *> *)accountNumbers;
@end
