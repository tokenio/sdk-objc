//
//  TKTransferSamples.m
//  TokenSdkTests
//
//  Created by Larry Hosken on 10/31/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TKSampleBase.h"

#import "TokenSdk.h"

// These "tests" are snippets of sample code that get included in
// our web documentation (plus some test code to make sure the
// samples keep working).

@interface TKTransferSamples : TKSampleBase

@end

@implementation TKTransferSamples

- (void)testNotifyPaymentRequest {
    TokenClient *tokenClient = [self client];
    TKMember *payee = self.payee;
    Alias *payerAlias = self.payerAlias;
    
    __block int notificationSent = false;
    
    // notifyPaymentRequest begin snippet to include in docs
    TokenPayload *payload = [TokenPayload message]; // hoped-for payment
    payload.description_p = @"lunch";
    payload.from.alias = payerAlias;
    payload.to.id_p = payee.id;
    payload.transfer.lifetimeAmount = @"100";
    payload.transfer.currency = @"EUR";
    
    [tokenClient notifyPaymentRequest:payload
                            onSuccess:^ {
                                // Notification sent.
                                notificationSent = true;
                            } onError:^(NSError *e) {
                                // Something went wrong.
                                // Maybe we used wrong alias?
                                @throw [NSException exceptionWithName:@"NotifyException"
                                                               reason:[e localizedFailureReason]
                                                             userInfo:[e userInfo]];
                            }
     ];
     // notifyPaymentRequest done snippet to include in docs
    
    [self runUntilTrue:^ {
        return notificationSent;
    }];
}

- (void)testCreateEndorseTransferToken {
    TKMember *payer = self.payer;
    TKAccount *payerAccount = self.payerAccount;
    TKMember *payee = self.payee;
    NSString *refId = @"purchase:2829363by";
    __block Token *transferToken = nil;
    
    // createTransferToken begin snippet to include in docs
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = payee.id;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t) {
        // Use token.
        transferToken = t;
    } onError:^(NSError *e) {
        // Something went wrong. (We don't just build a structure; we also
        // upload it to Token cloud. So things can go wrong.)
        @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                       reason:[e localizedFailureReason]
                                     userInfo:[e userInfo]];
    }];
    // createTransferToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken != nil);
    }];
    
    // endorseToken begin snippet to include in docs
    [payer endorseToken:transferToken
                withKey:Key_Level_Standard
              onSuccess:^(TokenOperationResult *result) {
                  // Update transferToken with newer value:
                  // Payload is same; now has signatures attached.
                  transferToken = result.token;
              } onError:^(NSError *e) {
                  // something went wrong
                  @throw [NSException exceptionWithName:@"EndorseException"
                                                 reason:[e localizedFailureReason]
                                               userInfo:[e userInfo]];
              }];
    // endorseToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken.payloadSignaturesArray_Count > 0);
    }];
    
    __block Transfer *transfer = nil;
    
    // redeemToken begin snippet to include in docs
    // There are a few ways to specify destination; here we use (fake) IBAN
    TransferEndpoint *destination = [[TransferEndpoint alloc] init];
    destination.account.sepa.iban = @"123";
    [payee getToken:transferToken.id_p
          onSuccess:^(Token * token) {
              [payee redeemToken:token
                          amount:nil // use default
                        currency:nil // use default
                     description:nil // use default
                     destination:destination
                        onSuccess:^(Transfer *t) {
                            // use transfer
                            transfer = t;
                        } onError:^(NSError *e) {
                            // something went wrong
                            @throw [NSException exceptionWithName:@"RedeemException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
          } onError:^(NSError *e) {
              // something went wrong
              @throw [NSException exceptionWithName:@"GetTokenException"
                                             reason:[e localizedFailureReason]
                                           userInfo:[e userInfo]];
          }];
    // redeemToken done snippet to include in docs
    
    // make sure it worked
    [self runUntilTrue:^ {
        return (transfer != nil);
    }];
}

- (void)testCancelTransferToken {
    TKMember *payer = self.payer;
    TKAccount *payerAccount = self.payerAccount;
    NSString *refId = @"purchase:2829363by";
    __block Token *transferToken = nil;
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
    TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.toMemberId = self.payee.id;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t) {
        [payer endorseToken:t
                    withKey:Key_Level_Standard
                  onSuccess:^(TokenOperationResult *result) {
                      transferToken = result.token;
                  } onError:^(NSError *e) {
                      // something went wrong
                      @throw [NSException exceptionWithName:@"EndorseException"
                                                     reason:[e localizedFailureReason]
                                                   userInfo:[e userInfo]];
                  }];
    } onError:^(NSError *e) {
                      // Something went wrong. (We don't just build a structure; we also
                      // upload it to Token cloud. So things can go wrong.)
                      @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                                     reason:[e localizedFailureReason]
                                                   userInfo:[e userInfo]];
                  }];
    
    [self runUntilTrue:^ {
        return (transferToken != nil);
    }];
    
    // cancelToken begin snippet to include in docs
    [payer cancelToken:transferToken
             onSuccess:^(TokenOperationResult *result) {
                 // token now has more signatures; in this case, at least
                 // one is a cancellation signature
                 transferToken = result.token;
             } onError: ^(NSError *e) {
                 // Something went wrong
             }];
    // cancelToken done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken.payloadSignaturesArray_Count > 0);
    }];
}

- (void)testTransferTokenWithBlob {
    TKMember *payer = self.payer;
    TKAccount *payerAccount = self.payerAccount;
    TKMember *payee = self.payee;
    __block Token *transferToken = nil;
    __block int gotBlob = false;
    
    NSData* (^loadImage)(NSString*) = ^(NSString* ignored) {
        return [NSData data];
    };
    
    void (^displayImage)(NSData*) = ^(NSData* ignored) {
        // doesn't use data, but makes example easier to understand
        gotBlob = true;
    };
    
    // createBlob begin snippet to include in docs
    [payer createBlob: payer.id
             withType: @"image/jpeg"
             withName: @"invoice.jpg"
             withData: loadImage(@"invoice.jpg")
            onSuccess: ^(Attachment *a) {
                NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:@"100.99"];
                TransferTokenBuilder *builder = [payer createTransferToken:amount
                                                                  currency:@"EUR"];
                builder.accountId = payerAccount.id;
                builder.toMemberId = payee.id;
                builder.attachments = @[a]; // associate attachment with token
                
                [builder executeAsync:^(Token *t) {
                    // TransferToken exists and has been uploaded.
                    // Payee cannot see blob until payer endorses token (not shown here).
                    transferToken = t;
                } onError:^(NSError *e) {
                    @throw [NSException exceptionWithName:@"BuilderExecuteException"
                                                   reason:[e localizedFailureReason]
                                                 userInfo:[e userInfo]];
                }];
            } onError: ^(NSError *e) {
                // Something went wrong. (We don't create a blob; we also
                // upload it to Token cloud. So things can go wrong.)
                @throw [NSException exceptionWithName:@"CreateBlobException"
                                               reason:[e localizedFailureReason]
                                             userInfo:[e userInfo]];
            }];
    // createBlob done snippet to include in docs
    
    [self runUntilTrue:^ {
        return (transferToken != nil);
    }];
    
    __block int tokenHasEndorsed = false;
    
    [self.payer endorseToken:transferToken
                     withKey:Key_Level_Standard
                   onSuccess:^(TokenOperationResult *result) {
                       if (result.status == TransferTokenStatus_Success) {
                           tokenHasEndorsed = true;
                       }
                   } onError: ^(NSError *e) {
                       // Something went wrong.
                       @throw [NSException exceptionWithName:@"EndorseTokenException"
                                                      reason:[e localizedFailureReason]
                                                    userInfo:[e userInfo]];
                   }];
    
    [self runUntilTrue:^ {
        return tokenHasEndorsed;
    }];
    
    NSString *tokenId = transferToken.id_p;
    
    // getTokenBlob begin snippet to include in docs
    [payee getToken:tokenId
          onSuccess:^(Token *t) {
              // Token comes with attachments: the metadata for a blob
              // (MIME type, etc). To download the blob's "file" contents:
              [payee getTokenBlob:t.id_p
                       withBlobId:t.payload.transfer.attachmentsArray[0].blobId
                        onSuccess:^(Blob *b) {
                            // use data from blob:
                            displayImage(b.payload.data);
                        } onError:^(NSError *e) {
                            // Something went wrong.
                            @throw [NSException exceptionWithName:@"GetBlobException"
                                                           reason:[e localizedFailureReason]
                                                         userInfo:[e userInfo]];
                        }];
          } onError:^(NSError *e) {
              // Something went wrong.
              @throw [NSException exceptionWithName:@"GetTokenException"
                                             reason:[e localizedFailureReason]
                                           userInfo:[e userInfo]];
          }];
    // getTokenBlob done snippet to include in docs
    
    [self runUntilTrue:^ {
        return gotBlob;
    }];
}

@end
