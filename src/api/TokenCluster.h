//
//  TokenCluster.h
//  TokenSdk
//
//  Created by Sibin Lu on 6/8/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenCluster : NSObject <NSCopying>
@property (nonatomic, readonly, strong) NSString *envUrl;
@property (nonatomic, readonly, strong) NSString *webAppUrl;

- (id)initWithEnvUrl:(NSString *)envUrl webAppUrl:(NSString *)webAppUrl;

+ (TokenCluster *)development;

+ (TokenCluster *)integration;

+ (TokenCluster *)integration2;

+ (TokenCluster *)localhost;

+ (TokenCluster *)sandbox;

+ (TokenCluster *)staging;

+ (TokenCluster *)performance;

+ (TokenCluster *)production;
@end
