//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"

#import "TKJson.h"

#import "gateway/Gateway.pbobjc.h"
#import "Security.pbobjc.h"


@interface TKJsonTests : XCTestCase
@end

@implementation TKJsonTests

/**
 * Simple message.
 */
- (void)testSimple {
    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = @"12345";

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{\"nonce\":\"12345\"}");
}

/**
 * Empty message.
 */
- (void)testEmpty {
    GetMemberRequest *request = [GetMemberRequest message];

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{}");
}

/**
 * Slashes mess up standard serializer. There is a hack in the code to fix it.
 */
- (void)testSlashes {
    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = @"123/45";

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{\"nonce\":\"123/45\"}");
}

/**
 * Repeated fields.
 */
- (void)testRepeated {
    UpdateMemberRequest *request = [UpdateMemberRequest message];
    request.update.memberId = @"m123";
    request.update.addKey.level = 0;
    request.update.addKey.tagsArray = [@[@"one", @"two"] mutableCopy];
    request.update.addKey.publicKey = @"public-key";
    request.signature.keyId = @"key-id";
    request.signature.signature = @"signature";

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{\"signature\":{\"keyId\":\"key-id\",\"signature\":\"signature\"},\"update\":{\"addKey\":{\"publicKey\":\"public-key\",\"tags\":[\"one\",\"two\"]},\"memberId\":\"m123\"}}");
}

/**
 * Repeated fields, proto message.
 */
- (void)testRepeated_Message {
    TokenSignature *s1 = [TokenSignature message];
    s1.action = TokenSignature_Action_Endorsed;

    TokenSignature *s2 = [TokenSignature message];
    s2.action = TokenSignature_Action_Declined;

    Token *token = [Token message];
    token.signaturesArray = [@[s1, s2] mutableCopy];

    NSString *json = [TKJson serialize:token];
    XCTAssertEqualObjects(json, @"{\"signatures\":[{\"action\":\"ENDORSED\"},{\"action\":\"DECLINED\"}]}");
}

/**
 * Map fields.
 */
- (void)testMap {
    InformationTokenAcl *acl = [InformationTokenAcl message];
    acl.query = [@{@"q1": @"v1", @"q2": @"v2"} mutableCopy];

    NSString *json = [TKJson serialize:acl];
    XCTAssertEqualObjects(json, @"{\"query\":{\"v1\":\"q1\",\"v2\":\"q2\"}}");
}

/**
 * Map fields, each field is proto message.
 */
- (void)testMap_Message {
    PaymentToken *token = [PaymentToken message];
    token.amount = @"123.45";
    token.effectiveAtMs = 12345;

    Var *var1 = [Var message];
    var1.value = @"one";

    Var *var2 = [Var message];
    var2.regex = @"two";

    token.vars = [@{var1: @"one", var2: @"two"} mutableCopy];

    NSString *json = [TKJson serialize:token];
    XCTAssertEqualObjects(json, @"{\"amount\":\"123.45\",\"effectiveAtMs\":12345,\"vars\":{\"one\":{\"value\":\"one\"},\"two\":{\"regex\":\"two\"}}}");
}

/**
 * Enum fields.
 */
- (void)testEnum {
    TokenSignature *signature = [TokenSignature message];
    signature.action = TokenSignature_Action_Endorsed;
    signature.signature.keyId = @"key-id";
    signature.signature.signature = @"signature";

    NSString *json = [TKJson serialize:signature];
    XCTAssertEqualObjects(json, @"{\"action\":\"ENDORSED\",\"signature\":{\"keyId\":\"key-id\",\"signature\":\"signature\"}}");
}

/**
 * Bytes fields.
 */
- (void)testBytes {
    LinkAccountRequest *request = [LinkAccountRequest message];
    request.accountLinkPayload = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{\"accountLinkPayload\":\"aGVsbG8=\"}");
}

@end
