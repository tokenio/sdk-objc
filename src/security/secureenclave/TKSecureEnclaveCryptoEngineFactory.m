//
//  TKSecureEnclaveCryptoEngineFactory.m
//  TokenSdk
//
//  Created by Vadim on 1/10/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKSecureEnclaveCryptoEngineFactory.h"
#import "TKSecureEnclaveCryptoEngine.h"

@implementation TKSecureEnclaveCryptoEngineFactory {
    BOOL _useDevicePasscodeOnly;
}

+ (id<TKCryptoEngineFactory>)factoryWithAuthenticationOption:(BOOL)useDevicePasscodeOnly {
    return [[TKSecureEnclaveCryptoEngineFactory alloc]
            initWithAuthenticationOption:useDevicePasscodeOnly];
    
}

- (id)initWithAuthenticationOption:(BOOL)useDevicePasscodeOnly {
    self = [super init];
    
    if (self) {
        _useDevicePasscodeOnly = useDevicePasscodeOnly;
    }
    
    return self;
}

- (id<TKCryptoEngine>)createEngine:(NSString *)memberId {
    return [[TKSecureEnclaveCryptoEngine alloc] initWithMemberId:memberId
                                            authenticationOption:_useDevicePasscodeOnly];
}

@end
