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
