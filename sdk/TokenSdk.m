//
//  Token.m
//  sdk
//
//  Created by Alexey Kalinichenko on 9/13/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GRPCClient/GRPCCall+ChannelArg.h>
#import <GRPCClient/GRPCCall+Tests.h>

#import "gateway/Gateway.pbrpc.h"

#import "TokenSdk.h"
#import "TokenSdkBuilder.h"

@implementation TokenSdk

+ (TokenSdkBuilder *)builder {
    return [[TokenSdkBuilder alloc] init];
}

- (id)initWithHost:(NSString *)host port:(int)port {
    self = [super init];

    if (self) {
        NSString *address = [NSString stringWithFormat:@"%@:%d", host, port];

        [GRPCCall useInsecureConnectionsForHost:address];
        [GRPCCall setUserAgentPrefix:@"Token-iOS/1.0" forHost:address];

        GatewayService *gateway = [GatewayService serviceWithHost:address];
        CreateMemberRequest *request = [CreateMemberRequest message];
        request.nonce = @"12345";

        [gateway createMemberWithRequest:request handler:^(CreateMemberResponse *response, NSError *error) {
            NSLog(@"%@", response.debugDescription);
        }];
    }

    return self;
}

@end
