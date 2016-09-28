//
// Created by Alexey Kalinichenko on 9/16/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FankMetadata;


/**
 * Talks to the Fank to create accounts and get the account linking payload
 * that is then used to link the accounts with Token. Simulates what we
 * would normally do in the web client.
 */
@interface TKBankClient : NSObject

+ (TKBankClient *)bankClientWithHost:(NSString *)host port:(int)port;

- (NSData *)startAccountsLinkingForAlias:(NSString *)alias
                          accountNumbers:(NSArray<NSString *> *)accountNumbers
                                metadata:(FankMetadata *)metadata;

@end
