//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "TKCrypto.h"
#import "TKSecretKey.h"
#import "Account.pbobjc.h"
#import "Money.pbobjc.h"
#import "Token.pbobjc.h"
#import "Payment.pbobjc.h"


@interface TKNotificationsTests : TKTestBase
@end

@implementation TKNotificationsTests {
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

- (void)testSubscribeAndUnsubscribe {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        
        [payer subscribeDevice:@"Token"
               notificationUri:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f97900"
                      platform:Platform_Ios
                          tags:tags];

        PaymentToken *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment t est"];
        token = [payer endorsePaymentToken:token];
        Payment *payment = [payee redeemPaymentToken:token];
        
        XCTAssertEqualObjects(@"100.99", payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        XCTAssertEqual(2, payment.signatureArray_Count);
        
        [payer unsubscribeDevice:@"Token" notificationUri:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f97900"];
        
        PaymentToken *token2 = [payer createPaymentTokenForAccount:payerAccount.id
                                                           amount:100.99
                                                         currency:@"USD"
                                                    redeemerAlias:payee.firstAlias
                                                      description:@"payment test"];
        token = [payer endorsePaymentToken:token2];
        [payee redeemPaymentToken:token];
        XCTAssertEqualObjects(@"100.99", payment.payload.amount.value);
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        [payer subscribeDevice:@"Token"
               notificationUri:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f97900"
                      platform:Platform_Ios
                          tags:tags];

        [tokenIO notifyLinkAccounts:payer.firstAlias
                             bankId:@"bank-id"
                accountsLinkPayload:@"12345"];
    }];
}

- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        [payer subscribeDevice:@"Token"
               notificationUri:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f97900"
                      platform:Platform_Ios
                          tags:tags];

        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyAddKey:payer.firstAlias
                    publicKey:key.publicKeyStr
                         tags:tags];
    }];
}

- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        [payer subscribeDevice:@"Token"
               notificationUri:@"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f97900"
                      platform:Platform_Ios
                          tags:tags];
        
        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstAlias
                                      bankId:@"bank-id"
                         accountsLinkPayload:@"12345"
                    publicKey:key.publicKeyStr
                         tags:tags];
    }];
}

@end
