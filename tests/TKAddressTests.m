
#import "TKJson.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Member.pbobjc.h"


@interface TKAddressTests : TKTestBase
@end

@implementation TKAddressTests {
    TKMember *member;
}

- (void)setUp {
    [super setUp];

    [self run: ^(TokenIO *tokenIO) {
        member = [self createMember:tokenIO];
    }];
}

- (void)testCreateAddress {
    [self run: ^(TokenIO *tokenIO) {
        NSString *name = @"address_name";
        NSString *data = @"address_data";

        Address *address = [member createAddressName:name withData:data];

        XCTAssertEqualObjects(name, address.name);
        XCTAssertEqualObjects(data, address.data_p);
    }];
}

- (void)testCreateAdnGetAddress {
    [self run: ^(TokenIO *tokenIO) {
        NSString *name = @"address_name";
        NSString *data = @"address_data";

        Address *address = [member createAddressName:name withData:data];
        Address *result = [member getAddressById:address.id_p];

        XCTAssertEqualObjects(address, result);
    }];
}

- (void)testCreateAdnGetAddresses {
    [self run: ^(TokenIO *tokenIO) {
        NSString *name_1 = @"address_name_1";
        NSString *data_1 = @"address_data_1";
        NSString *name_2 = @"address_name_2";
        NSString *data_2 = @"address_data_2";

        Address *address_1 = [member createAddressName:name_1 withData:data_1];
        Address *address_2 = [member createAddressName:name_2 withData:data_2];

        NSArray<Address *> *result = [member getAddresses];

        XCTAssertEqualObjects(address_1, result[0]);
        XCTAssertEqualObjects(address_2, result[1]);
    }];
}

- (void)testGetAddresses_NotFound {
    [self run: ^(TokenIO *tokenIO) {
        NSArray<Address *> *result = [member getAddresses];

        XCTAssertEqual(result.count, 0);
    }];
}

- (void)testGetAddress_NotFound {
    [self run: ^(TokenIO *tokenIO) {
        XCTAssertThrows(
                [member getAddressById:@"invalidAddressId"]);

    }];
}

- (void)testDeleteAddress {
    [self run: ^(TokenIO *tokenIO) {
        NSString *name = @"address_name";
        NSString *data = @"address_data";

        Address *address = [member createAddressName:name withData:data];
        Address *result = [member getAddressById:address.id_p];

        XCTAssertEqualObjects(address, result);

        [member deleteAddressById:address.id_p];

        XCTAssertThrows(
                [member getAddressById:address.id_p]);

    }];
}

- (void)testDeleteAddress_NotFound {
    [self run: ^(TokenIO *tokenIO) {
        XCTAssertThrows(
                [member deleteAddressById:@"invalidAddressId"]);
    }];
}

@end
