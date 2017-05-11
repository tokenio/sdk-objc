//
//  Created by Mariano Sorgente on 5/10/17.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenIO.h"
#import "Money.pbobjc.h"
#import "Transaction.pbobjc.h"
#import "Transfer.pbobjc.h"
#import "Transferinstructions.pbobjc.h"


@interface TKBlobstoreTests : TKTestBase
@end

@implementation TKBlobstoreTests {
    TKAccount *payerAccount;
    TKMember *payer;
    TKAccount *payeeAccount;
    TKMember *payee;
}

-(NSData*)randomData:(int)capacity {
    NSMutableData* theData = [NSMutableData dataWithCapacity:capacity];
    for( unsigned int i = 0 ; i < capacity/4 ; ++i  )
    {
        u_int32_t randomBits = arc4random();
        [theData appendBytes:(void*)&randomBits length:4];
    }
    return theData;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIO *tokenIO) {
        payerAccount = [self createAccount:tokenIO];
        payer = payerAccount.member;
        payeeAccount = [self createAccount:tokenIO];
        payee = payeeAccount.member;
    }];
}

- (void)testBlobs {
    [self run: ^(TokenIO *tokenIO) {
        NSData *data = [self randomData:100];
        Attachment *attachment = [payer createBlob:payer.id
                                          withType:@"application/json"
                                          withName:@"file.json"
                                          withData:data];
        NSLog(@"%@", attachment);
        XCTAssertEqualObjects(attachment.name, @"file.json");
        XCTAssertEqualObjects(attachment.type, @"application/json");
        XCTAssert(attachment.blobId.length > 5);
        
        Blob* blob = [payer getBlob:attachment.blobId];
        
        XCTAssertEqualObjects(blob.payload.name, @"file.json");
        XCTAssertEqualObjects(blob.payload.type, @"application/json");
        XCTAssert([blob.payload.data_p isEqualToData:data]);
        XCTAssert((blob.payload.data_p.length == 100));
    }];
}
    - (void)testTokenBlobs {
        [self run: ^(TokenIO *tokenIO) {
            NSData *data = [self randomData:200];
            Attachment *attachment = [payer createBlob:payer.id
                                              withType:@"application/json"
                                              withName:@"file.json"
                                              withData:data];
            NSArray<Attachment*> *attachments = [NSArray arrayWithObjects:attachment, nil];
            NSMutableArray<Destination*> *destinations = [NSMutableArray array];
            Token *token = [payer createTransferToken:payee.firstUsername
                                           forAccount:payerAccount.id
                                               amount:100.99
                                             currency:@"USD"
                                          description:@"transfer test"
                                         destinations:destinations
                                          attachments:attachments];
            [payer endorseToken:token withKey:Key_Level_Standard];
            Blob* blob = [payer getTokenBlob:token.id_p withBlobId:attachment.blobId];

            XCTAssertEqualObjects(blob.payload.name, @"file.json");
            XCTAssertEqualObjects(blob.payload.type, @"application/json");
            XCTAssert([blob.payload.data_p isEqualToData:data]);
            XCTAssert((blob.payload.data_p.length == 200));
        }];
}

@end
