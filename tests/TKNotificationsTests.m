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
#import "Subscriber.pbobjc.h"



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
        
        Subscriber *s = [payer subscribeToNotifications:@"Token"
               target:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                      platform:Platform_Ios];
        
        Token *token = [payer createPaymentTokenForAccount:payerAccount.id
                                                    amount:100.99
                                                  currency:@"USD"
                                             redeemerAlias:payee.firstAlias
                                               description:@"payment t est"];
        token = [payer endorsePaymentToken:token];
        Payment *payment = [payee redeemPaymentToken:token];
        
        XCTAssertEqualObjects(@"100.99", payment.payload.amount.value);
        XCTAssertEqualObjects(@"USD", payment.payload.amount.currency);
        
        [payer unsubscribeFromNotifications:s.id_p];
        
        Token *token2 = [payer createPaymentTokenForAccount:payerAccount.id
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
        [payer subscribeToNotifications:@"Token"
               target:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                      platform:Platform_Ios];

        [tokenIO notifyLinkAccounts:payer.firstAlias
                             bankId:@"bank-id"
                accountsLinkPayload:@"12345"];
    }];
}


- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {

        [payer subscribeToNotifications:@"Token"
               target:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                      platform:Platform_Ios];

        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyAddKey:payer.firstAlias
                    publicKey:key.publicKeyStr
                         name:@"Chrome 53.0"];
    }];
}


- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"Token"
                        target:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                      platform:Platform_Ios];
        
        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstAlias
                                      bankId:@"bank-id"
                         accountsLinkPayload:@"12345"
                                   publicKey:key.publicKeyStr
                                        name:@"Chrome 53.0"];
    }];
}

- (void)testGetSubscribers {
    [self run: ^(TokenIO *tokenIO) {
        
        Subscriber * subscriber = [payer subscribeToNotifications:@"Token"
                                 target:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Test];
        
        [payer getSubscribers];
        XCTAssert([payer getSubscribers].count == 1);
        Subscriber * subscriber2 = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:subscriber2.id_p]);
        XCTAssert([subscriber.target isEqualToString:subscriber2.target]);
        XCTAssert(subscriber.platform == subscriber2.platform);
    }];
}

@end
