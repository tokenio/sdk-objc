
#import "TKJson.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"


@interface TKPreferencesTests : TKTestBase
@end

@implementation TKPreferencesTests {
    TKMember *member;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIO *tokenIO) {
        member = [self createMember:tokenIO];
    }];
}

- (void)testSetAndGetPreference {
    [self run: ^(TokenIO *tokenIO) {
        NSString *preference = @"preference_data";


        [member setPreferences:preference];
        NSString *result = [member getPreferences];

        XCTAssertEqualObjects(preference, result);
    }];
}

@end
