//
//  sdkTests.m
//  sdkTests
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "Gateway.pbrpc.h"

static NSString * const kHostAddress = @"localhost:9000";


@interface sdkTests : XCTestCase

@end

@implementation sdkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [GRPCCall useInsecureConnectionsForHost:kHostAddress];
    [GRPCCall setUserAgentPrefix:@"HelloWorld/1.0" forHost:kHostAddress];
    
    GatewayService *service = [GatewayService serviceWithHost:kHostAddress];
    
    CreateMemberRequest *request = [CreateMemberRequest message];
    request.nonce = @"1234567890";
    
    [service createMemberWithRequest:request handler:^(CreateMemberResponse *response, NSError *error) {
         NSLog(@"Hi there, I am GREAT!");
     }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
