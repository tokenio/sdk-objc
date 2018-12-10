//
//  TKSampleModel.m
//  TokenSdk
//
//  Created by Sibin Lu on 11/16/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import "TKSampleModel.h"
#import "TKUtil.h"

@implementation TKSampleModel

+ (TokenPayload *)aispEndrosePayload:(TKMember *)from to:(TKMember *)to {
    TokenPayload *payload = [[TokenPayload alloc] init];
    payload.refId = [TKUtil nonce];
    payload.from.id_p = from.id;
    payload.to.id_p = to.id;
    payload.to.alias = to.firstAlias;
    payload.access.resourcesArray = [NSMutableArray array];
    return payload;
}

+ (TokenPayload *)pispEndrosePayload:(TKMember *)from to:(TKMember *)to {
    TokenPayload *payload = [[TokenPayload alloc] init];
    payload.refId = [TKUtil nonce];
    payload.from.id_p = from.id;
    payload.to.id_p = to.id;
    payload.to.alias = to.firstAlias;
    payload.transfer.lifetimeAmount = @"10.11";
    payload.transfer.currency = @"EUR";
    return payload;
}

+ (TokenRequestPayload *)accessTokenRequestPayload:(TKMember *)to {
    TokenRequestPayload *payload = [[TokenRequestPayload alloc] init];
    payload.userRefId = [TKUtil nonce];
    payload.redirectURL = @"https://token.io";
    payload.to.id_p = to.id;
    payload.description_p = @"Account and balance access";
    payload.callbackState = [TKUtil nonce];
    
    GPBEnumArray *types = [[GPBEnumArray alloc] init];
    [types addValue:TokenRequestPayload_AccessBody_ResourceType_Accounts];
    [types addValue:TokenRequestPayload_AccessBody_ResourceType_Balances];
    payload.accessBody.typeArray = types;
    return payload;
}

+ (TokenRequestPayload *)transferTokenRequestPayload:(TKMember *)to {
    TokenRequestPayload *payload = [[TokenRequestPayload alloc] init];
    payload.userRefId = [TKUtil nonce];
    payload.redirectURL = @"https://token.io";
    payload.to.id_p = to.id;
    payload.description_p = @"Book purchase";
    payload.callbackState = [TKUtil nonce];
    payload.transferBody.lifetimeAmount = @"10.11";
    payload.transferBody.currency = @"EUR";
    return payload;
}

+ (TokenRequestOptions *)tokenRequestOptions:(TKMember *)from {
    TokenRequestOptions *options = [[TokenRequestOptions alloc] init];
    options.bankId = @"iron";
    options.receiptRequested = false;
    options.from.id_p = from.id;
    return options;
}

+ (ReceiptContact *)receiptContact:(NSString *)email {
    ReceiptContact *contact = [[ReceiptContact alloc] init];
    contact.type = ReceiptContact_Type_Email;
    contact.value = email;
    return contact;
}

+ (DeviceMetadata *)deviceMetadata {
    DeviceMetadata * metadata = [[DeviceMetadata alloc] init];
    metadata.application = @"Chrome";
    metadata.applicationVersion = @"56.0.2924.97";
    metadata.device = @"Mac";
    return metadata;
}

+ (Key *)lowKey:(NSString *) memberId{
    id<TKKeyStore> store = [[TKInMemoryKeyStore alloc] init];
    return [[[TKTokenCryptoEngineFactory factoryWithStore:store useLocalAuthentication:false]
             createEngine:memberId]
            generateKey:Key_Level_Low];
}
@end
