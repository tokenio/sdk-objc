//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKMember.h"
#import "TokenIO.h"
#import "TKTestBase.h"


@interface TKMemberRegistrationTests : TKTestBase
@end

@implementation TKMemberRegistrationTests

- (void)testCreateMember {
    [self run: ^(TokenIO *tokenIO) {
        TKMember *member = [tokenIO createMember];
    }];
}

- (void)testLoginMember {
    [self run: ^(TokenIO *tokenIO) {
        TKMember *created = [tokenIO createMember];
        TKMember *loggedIn = [tokenIO loginMember:created.id secretKey:created.key];
    }];
}

@end
