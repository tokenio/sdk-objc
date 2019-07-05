//
//  TKSampleBase.h
//  TokenSdk
//
//  Shared setup for our code samples.
//  Creates two members and links a bank account for each.
//
//  Created by Larry Hosken on 11/9/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKTestBase.h"

NS_ASSUME_NONNULL_BEGIN
@interface TKSampleBase : TKTestBase

@property(readonly) TokenClient *tokenClient;

@property(readonly) Alias *payerAlias;
@property(readonly) TKMember *payer;
@property(readonly) TKAccount *payerAccount;

@property(readonly) Alias *payeeAlias;
@property(readonly) TKMember *payee;
@property(readonly) TKAccount *payeeAccount;

- (void)setUp;

@end
NS_ASSUME_NONNULL_END
