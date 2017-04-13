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

- (void)testRedeemToken_stepUp {
    [self run: ^(TokenIO *tokenIO) {
        NSMutableArray* tags = [NSMutableArray arrayWithCapacity:1];
        [tags addObject:@"iphone"];
        NSMutableDictionary * instructions = [NSMutableDictionary dictionaryWithDictionary:@{
                    @"PLATFORM": @"IOS",
                    @"TARGET": @"36f21423d991dfe63fc2e4b4177409d29141fd4bcbdb5bff202a10535581f979"}];
    
        [payer subscribeToNotifications:@"token" handlerInstructions:instructions];
        Token *token = [payer createTransferToken:payee.firstUsername
                                       forAccount:payerAccount.id
                                           amount:100
                                         currency:@"USD"
                                      description:@"transfer test"];
        TokenOperationResult *result = [payer endorseToken:token withKey:Key_Level_Low];
        XCTAssertEqual(result.status, TokenOperationResult_Status_MoreSignaturesNeeded);

        result = [payer endorseToken:token withKey:Key_Level_Standard];
        XCTAssertEqual(result.status, TokenOperationResult_Status_Success);
    }];
}

@end
