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
#import "Payment.pbobjc.h"


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
        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:10
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token];
        Payment *payment = [payee redeemPaymentToken:token amount:@100 currency:@"USD"];
    }];

}

@end
