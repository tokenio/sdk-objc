//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Member.pbobjc.h"
#import "Token.pbobjc.h"

#import "TKJson.h"

#import "gateway/Auth.pbobjc.h"
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
    
    Key *key = [Key message];
    key.publicKey = @"public-key";
    
    MemberOperation *operation = [MemberOperation message];
    operation.addKey.key = key;
    [request.update.operationsArray addObject:operation];
    
    request.updateSignature.keyId = @"key-id";
    request.updateSignature.signature = @"signature";

    NSString *json = [TKJson serialize:request];
    XCTAssertEqualObjects(json, @"{\"update\":{\"memberId\":\"m123\",\"operations\":[{\"addKey\":{\"key\":{\"publicKey\":\"public-key\"}}}]},\"updateSignature\":{\"keyId\":\"key-id\",\"signature\":\"signature\"}}");
}

/**
 * Repeated fields, proto message.
 */
- (void)testRepeated_Message {
    TokenSignature *s1 = [TokenSignature message];
    s1.action = TokenSignature_Action_Endorsed;

    TokenSignature *s2 = [TokenSignature message];
    s2.action = TokenSignature_Action_Cancelled;

    Token *token = [Token message];
    token.payloadSignaturesArray = [@[s1, s2] mutableCopy];

    NSString *json = [TKJson serialize:token];
    XCTAssertEqualObjects(json, @"{\"payloadSignatures\":[{\"action\":\"ENDORSED\"},{\"action\":\"CANCELLED\"}]}");
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
 * Long long (64 bit) field.
 */
- (void)testLongLong {
    GrpcAuthPayload *payload = [GrpcAuthPayload message];
    payload.request = [@"Hello" dataUsingEncoding:NSASCIIStringEncoding];
    payload.createdAtMs = 1479441243495;
    
    NSString *json = [TKJson serialize:payload];
    XCTAssertEqualObjects(json, @"{\"createdAtMs\":\"1479441243495\",\"request\":\"SGVsbG8=\"}");
}

/**
 * Deserialize Simple message.
 */
- (void)testDeserializeSimple {
    CreateMemberRequest *request1 = [CreateMemberRequest message];
    request1.nonce = @"12345";

    NSString* json1 = [TKJson serialize:request1];
    CreateMemberRequest *request2  = [TKJson deserializeMessageOfClass:[CreateMemberRequest class]
                                                              fromJSON:json1];
    NSString* json2 = [TKJson serialize:request2];
    
    XCTAssertEqualObjects(json1, json2);
}

/**
 * Deserialize Empty message.
 */
- (void)testDeserializeEmpty {
    GetMemberRequest *request1 = [GetMemberRequest message];
    
    NSString* json1 = [TKJson serialize:request1];
    GetMemberRequest *request2  = [TKJson deserializeMessageOfClass:[GetMemberRequest class]
                                                           fromJSON:json1];
    NSString* json2 = [TKJson serialize:request2];
    
    XCTAssertEqualObjects(json1, json2);
}

/**
 * Slashes mess up standard serializer. There is a hack in the code to fix it.
 */
- (void)testDeserializeSlashes {
    CreateMemberRequest *request1 = [CreateMemberRequest message];
    request1.nonce = @"123/45";
    
    NSString* json1 = [TKJson serialize:request1];
    CreateMemberRequest *request2  = [TKJson deserializeMessageOfClass:[CreateMemberRequest class]
                                                              fromJSON:json1];
    NSString* json2 = [TKJson serialize:request2];
    
    XCTAssertEqualObjects(json1, json2);
}

/**
 * Deserialize Repeated fields.
 */
- (void)testDeserialzeRepeated {
    UpdateMemberRequest *request1 = [UpdateMemberRequest message];
    request1.update.memberId = @"m123";
    
    Key *key = [Key message];
    key.publicKey = @"public-key";
    key.level = Key_Level_Privileged;
    
    MemberOperation *operation = [MemberOperation message];
    operation.addKey.key = key;
    [request1.update.operationsArray addObject:operation];
    
    request1.updateSignature.keyId = @"key-id";
    request1.updateSignature.signature = @"signature";
    
    NSString* json1 = [TKJson serialize:request1];
    UpdateMemberRequest *request2  = [TKJson deserializeMessageOfClass:[UpdateMemberRequest class]
                                                              fromJSON:json1];
    NSString* json2 = [TKJson serialize:request2];

    XCTAssertEqualObjects(json1, json2);
}

/**
 * Deserialise Repeated fields, proto message.
 */
- (void)testDeserializeRepeated_Message {
    TokenSignature *s1 = [TokenSignature message];
    s1.action = TokenSignature_Action_Endorsed;
    
    TokenSignature *s2 = [TokenSignature message];
    s2.action = TokenSignature_Action_Cancelled;
    
    Token *token1 = [Token message];
    token1.payloadSignaturesArray = [@[s1, s2] mutableCopy];
    
    NSString *json1 = [TKJson serialize:token1];
    Token *token2  = [TKJson deserializeMessageOfClass:[Token class] fromJSON:json1];
    NSString* json2 = [TKJson serialize:token2];
    
    XCTAssertEqualObjects(json1, json2);
}

/**
 * Deserialize Enum fields.
 */
- (void)testDeserializeEnum {
    TokenSignature *signature1 = [TokenSignature message];
    signature1.action = TokenSignature_Action_Endorsed;
    signature1.signature.keyId = @"key-id";
    signature1.signature.signature = @"signature";
    
    NSString *json1 = [TKJson serialize:signature1];
    TokenSignature *signature2  = [TKJson deserializeMessageOfClass:[TokenSignature class]
                                                           fromJSON:json1];
    NSString* json2 = [TKJson serialize:signature2];
    
    XCTAssertEqualObjects(json1, json2);
}

/**
 * Long long (64 bit) field.
 */
- (void)testDeserializeLongLong {
    GrpcAuthPayload *payload = [GrpcAuthPayload message];
    payload.request = [@"Hello" dataUsingEncoding:NSASCIIStringEncoding];
    payload.createdAtMs = 1479441243495;
    
    NSString *json1 = [TKJson serialize:payload];
    GrpcAuthPayload *payload2 = [TKJson deserializeMessageOfClass:[GrpcAuthPayload class]
                                                         fromJSON:json1];
    NSString *json2 = [TKJson serialize:payload2];
    
    XCTAssertEqualObjects(json1, json2);
}


@end
