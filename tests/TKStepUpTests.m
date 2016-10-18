//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Token.pbobjc.h"

@interface TKStepUpTest : TKTestBase
@end

@implementation TKStepUpTest {
    TKAccount *payerAccount;
    TKMember *payer;
    TKAccount *payeeAccount;
    TKMember *payee;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
    }];
}

- (void)testRedeemToken {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        [payer subscribeToNotifications:@"Token"
                                 target:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979"
                               platform:Platform_Ios];
        Token *token = [payer createTokenForAccount:payerAccount.id
                                             amount:100
                                           currency:@"USD"
                                      redeemerUsername:payee.firstUsername
                                        description:@"transfer test"];
        token = [payer endorseToken:token];
    }];
}

@end
