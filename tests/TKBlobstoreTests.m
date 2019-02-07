//
//  Created by Mariano Sorgente on 5/10/17.
//  Copyright © 2016 Token Inc. All rights reserved.
//

#import "TKAccount.h"
#import "TKMember.h"
#import "TKTestBase.h"
#import "TokenClient.h"
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
    TokenClient *tokenClient = [self client];
    payerAccount = [self createAccount:tokenClient];
    payer = payerAccount.member;
    payeeAccount = [self createAccount:tokenClient];
    payee = payeeAccount.member;
}

- (void)testBlobs {
    NSData *data = [self randomData:100];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer
     createBlob:payer.id
     withType:@"application/json"
     withName:@"file.json"
     withData:data
     onSuccess:^(Attachment *attachment) {
         XCTAssertEqualObjects(attachment.name, @"file.json");
         XCTAssertEqualObjects(attachment.type, @"application/json");
         XCTAssert(attachment.blobId.length > 5);
         
         [self->payer getBlob:attachment.blobId onSuccess:^(Blob* blob) {
             XCTAssertEqualObjects(blob.payload.name, @"file.json");
             XCTAssertEqualObjects(blob.payload.type, @"application/json");
             XCTAssert([blob.payload.data_p isEqualToData:data]);
             XCTAssert((blob.payload.data_p.length == 100));
             [expectation fulfill];
         } onError:THROWERROR];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testTokenBlobs {
    NSData *data = [self randomData:200];
    TKTestExpectation *expectation = [[TKTestExpectation alloc] init];
    [payer
     createBlob:payer.id
     withType:@"application/json"
     withName:@"file.json"
     withData:data
     onSuccess:^(Attachment *attachment) {
         XCTAssertEqualObjects(attachment.name, @"file.json");
         XCTAssertEqualObjects(attachment.type, @"application/json");
         XCTAssert(attachment.blobId.length > 5);
         NSArray<Attachment*> *attachments = [NSArray arrayWithObjects:attachment, nil];
         NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.11"];
         TransferTokenBuilder *builder = [self->payer createTransferToken:amount currency:@"USD"];
         builder.accountId = self->payerAccount.id;
         builder.toMemberId = self->payee.id;
         builder.attachments = attachments;
         [builder executeAsync:^(Token *token) {
             [self->payer endorseToken:token withKey:Key_Level_Standard onSuccess:^(TokenOperationResult *result) {
                 [self->payer getTokenBlob:token.id_p withBlobId:attachment.blobId onSuccess:^(Blob* blob) {
                     XCTAssertEqualObjects(blob.payload.name, @"file.json");
                     XCTAssertEqualObjects(blob.payload.type, @"application/json");
                     XCTAssert([blob.payload.data_p isEqualToData:data]);
                     XCTAssert((blob.payload.data_p.length == 200));
                     [expectation fulfill];
                 } onError:THROWERROR];
             } onError:THROWERROR];
         } onError:THROWERROR];
     } onError:THROWERROR];
    [self waitForExpectations:@[expectation] timeout:10];
}

@end
