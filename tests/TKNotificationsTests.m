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
#import "Transfer.pbobjc.h"
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
        
        Subscriber *s = [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                                               platform:Platform_Ios];
        
        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [payer endorseToken:token];
        Transfer *transfer = [payee createTransfer:token];
        
        XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        
        [payer unsubscribeFromNotifications:s.id_p];
        
        Token *token2 = [payer createTransferToken:payee.firstUsername
                                        forAccount:payerAccount.id
                                            amount:100.99
                                          currency:@"USD"
                                       description:@"transfer test"];
        token = [payer endorseToken:token2];
        [payee createTransfer:token];
        XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
    }];
}

- (void)testNotifyLinkAccounts {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];
        NSArray<NSString*> *payloads = @[@"12345"];
        
        [tokenIO notifyLinkAccounts:payer.firstUsername
                             bankId:@"bank-id"
                           bankName:@"bank-name"
                accountLinkPayloads:payloads];
    }];
}


- (void)testNotifyAddKey {
    [self run: ^(TokenIO *tokenIO) {
        
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];
        
        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyAddKey:payer.firstUsername
                    publicKey:key.publicKeyStr
                         name:@"Chrome 53.0"];
    }];
}


- (void)testNotifyLinkAccountsAndAddKey {
    [self run: ^(TokenIO *tokenIO) {
        [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                               platform:Platform_Ios];
        NSArray<NSString*> *payloads = @[@"12345"];
        
        TKSecretKey *key = [TKCrypto generateKey];
        [tokenIO notifyLinkAccountsAndAddKey:payer.firstUsername
                                      bankId:@"bank-id"
                                    bankName:@"bank-name"
                         accountLinkPayloads:payloads
                                   publicKey:key.publicKeyStr
                                        name:@"Chrome 53.0"];
    }];
}

- (void)testGetSubscribers {
    [self run: ^(TokenIO *tokenIO) {
        
        Subscriber * subscriber = [payer subscribeToNotifications:@"8E8E256A58DE0F62F4A427202DF8CB07C6BD644AFFE93210BC49B8E5F940255400"
                                                         platform:Platform_Test];
        
        [payer getSubscribers];
        XCTAssert([payer getSubscribers].count == 1);
        Subscriber * subscriber2 = [payer getSubscriber:subscriber.id_p];
        XCTAssert([subscriber.id_p isEqualToString:subscriber2.id_p]);
        XCTAssert([subscriber.target isEqualToString:subscriber2.target]);
        XCTAssert(subscriber.platform == subscriber2.platform);
    }];
}

- (void)testTransferNotification {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        
        [payer subscribeToNotifications:@"notificationUri"
                               platform:Platform_Ios];
        
        Token *token = [payer createTransferToken:payee.firstUsername
                               forAccount:payerAccount.id
                                             amount:100.99
                                           currency:@"USD"
                                        description:@"transfer test"];
        token = [payer endorseToken:token];
        Transfer *transfer = [payee createTransfer:token];
        
        XCTAssertEqualObjects(@"100.99", transfer.payload.amount.value);
        XCTAssertEqualObjects(@"USD", transfer.payload.amount.currency);
        XCTAssertEqual(2, transfer.payloadSignaturesArray_Count);
    }];
}

@end
