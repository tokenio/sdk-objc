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
    TokenIO *tokenIO = [self asyncSDK];
    TKMember *payee = self.payeeSync.async;
    Alias *payerAlias = self.payerAlias;
    
    __block int waitingForPayment = false;
    
    // notifyPaymentRequest begin snippet to include in docs
    TokenPayload *payload = [TokenPayload message]; // hoped-for payment
    payload.description_p = @"lunch";
    payload.from.alias = payerAlias;
    payload.to.id_p = payee.id;
    payload.transfer.lifetimeAmount = @"100";
    payload.transfer.currency = @"EUR";
    
    [tokenIO notifyPaymentRequest:payload
                        onSuccess:^ {
                            // Notification sent.
                            waitingForPayment = true;
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
        return waitingForPayment;
    }];
}

- (void)testCreateEndorseTransferToken {
    TKMember *payer = self.payerSync.async;
    TKAccount *payerAccount = self.payerAccountSync.async;
    Alias *payeeAlias = self.payeeAlias;
    TKMember *payee = self.payeeSync.async;
    NSString *refId = @"purchase:2017-11-01:28293336394ffby";
    __block Token *transferToken = nil;
    
    // createTransferToken begin snippet to include in docs
    TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.redeemerAlias = payeeAlias;
    builder.descr = @"Book purchase";
    builder.refId = refId;
    
    [builder executeAsync:^(Token *t) {
        // Use token.
        transferToken = t;
    } onAuthRequired:^(ExternalAuthorizationDetails *details) {
        // External authorization is required. Get the bank authorization
        // from the url in details.
        @throw [NSException exceptionWithName:@"ExternalAuthorizationException"
                                       reason:@"External authorization is required."
                                     userInfo:nil];
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
          onSuccess:^(Token *token) {
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
    TKMember *payer = self.payerSync.async;
    TKAccount *payerAccount = self.payerAccountSync.async;
    Alias *payeeAlias = self.payeeAlias;
    NSString *refId = @"purchase:2017-11-01:28293336394ffby";
    __block Token *transferToken = nil;
    
    TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                      currency:@"EUR"];
    builder.accountId = payerAccount.id;
    builder.redeemerAlias = payeeAlias;
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
    } onAuthRequired:^(ExternalAuthorizationDetails *details) {
        // External authorization is required. Get the bank authorization
        // from the url in details.
        @throw [NSException exceptionWithName:@"ExternalAuthorizationException"
                                       reason:@"External authorization is required."
                                     userInfo:nil];
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
    TKMember *payer = self.payerSync.async;
    TKAccount *payerAccount = self.payerAccountSync.async;
    Alias *payeeAlias = self.payeeAlias;
    TKMember *payee = self.payeeSync.async;
    __block Token *transferToken = nil;
    __block BOOL gotBlob = false;
    
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
                TransferTokenBuilder *builder = [payer createTransferToken:100.0
                                                                  currency:@"EUR"];
                builder.accountId = payerAccount.id;
                builder.redeemerAlias = payeeAlias;
                builder.attachments = @[a]; // associate attachment with token
                
                [builder executeAsync:^(Token *t) {
                    // TransferToken exists and has been uploaded.
                    // Payee cannot see blob until payer endorses token (not shown here).
                    transferToken = t;
                } onAuthRequired:^(ExternalAuthorizationDetails *details) {
                    // External authorization is required. Get the bank authorization
                    // from the url in details.
                    @throw [NSException exceptionWithName:@"ExternalAuthorizationException"
                                                   reason:@"External authorization is required."
                                                 userInfo:nil];
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
    [self.payerSync endorseToken:transferToken withKey:Key_Level_Standard];
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
        return (gotBlob == true);
    }];
}

@end
