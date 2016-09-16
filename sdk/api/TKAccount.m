//
// Created by Alexey Kalinichenko on 9/15/16.
// Copyright (c) 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "Account.pbobjc.h"
#import "TKClient.h"


@implementation TKAccount {
    Account *account;
    TKClient *client;
}

+ (TKAccount *)account:(Account *)account of:(TKMember *)member useClient:(TKClient *)client {
    return [[TKAccount alloc] initWithAccount:account of:member useClient:client];
}

- (id)initWithAccount:(Account *)account_ of:(TKMember *)member useClient:(TKClient *)client_ {
    self = [super init];

    if (self) {
        account = account_;
        client = client_;
        _member = member;
    }

    return self;
}

- (NSString *)id {
    return account.id_p;
}

- (NSString *)name {
    return account.name;
}

@end