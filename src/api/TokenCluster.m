//
//  TokenCluster.m
//  TokenSdk
//
//  Created by Sibin Lu on 6/8/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import "TokenCluster.h"

@implementation TokenCluster

- (id)initWithEnvUrl:(NSString *)envUrl_ webAppUrl:(NSString *)webAppUrl_ {
    self = [super init];
    if (self) {
        _envUrl = envUrl_;
        _webAppUrl = webAppUrl_;
    }
    return self;
}

+ (TokenCluster *)development {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.dev.token.io"
                                      webAppUrl:@"web-app.dev.token.io"];
}

+ (TokenCluster *)integration {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.int.token.io"
                                      webAppUrl:@"web-app.int.token.io"];
}

+ (TokenCluster *)integration2 {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.int2.token.io"
                                      webAppUrl:@"web-app.int2.token.io"];
}

+ (TokenCluster *)localhost {
    return [[TokenCluster alloc] initWithEnvUrl:@"localhost"
                                      webAppUrl:@"localhost"];
}

+ (TokenCluster *)sandbox {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.sandbox.token.io"
                                      webAppUrl:@"web-app.sandbox.token.io"];
}

+ (TokenCluster *)staging {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.stg.token.io"
                                      webAppUrl:@"web-app.stg.token.io"];
}

+ (TokenCluster *)performance {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.perf.token.io"
                                      webAppUrl:@"web-app.perf.token.io"];
}

+ (TokenCluster *)production {
    return [[TokenCluster alloc] initWithEnvUrl:@"api-grpc.token.io"
                                      webAppUrl:@"web-app.token.io"];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    TokenCluster *newCluster = [[[self class] allocWithZone:zone] init];
    newCluster->_envUrl = [_envUrl copyWithZone:zone];
    newCluster->_webAppUrl = [_webAppUrl copyWithZone:zone];
    
    return newCluster;
}
@end
