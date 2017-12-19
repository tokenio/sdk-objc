//
//  TKAuthorizationEngine.m
//  TokenSdk
//
//  Created by Sibin Lu on 12/12/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import "TKAuthorizationEngine.h"
#import "TKBrowser.h"
#import "TKTokenBrowser.h"
#import "TKError.h"
#import "TKLocalizer.h"
#import "TKLogManager.h"
#import "TKJson.h"

@implementation TKAuthorizationEngine {
    ExternalAuthorizationDetails *details;
    OnSuccessWithBankAuthorization onSuccess;
    OnError onError;
    TKBrowser* browser;
    
    BOOL completionUrlIsFound;
}

- (id)initWithBrowserFactory:(TKBrowserFactory)browserFactory
ExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details_ {
    self = [super init];
    
    if (self) {
        browser = browserFactory(self);
        details = details_;
        completionUrlIsFound = NO;
    }
    
    return self;
}

- (void)authorizeOnSuccess:(OnSuccessWithBankAuthorization)onSuccess_
                   onError:(OnError)onError_ {
    onSuccess = onSuccess_;
    onError = onError_;
    
    [browser loadUrl:details.URL];
}

- (void)close {
    if (browser) {
        [browser dismiss];
        browser = nil;
    }
}

#pragma mark - TKBrowserDelegate
- (BOOL) shouldStartLoadWithRequest:(NSURLRequest *)request {
    TKLogDebug(@"Should start loading %@",request)
    if (completionUrlIsFound) {
        // Should not load any request after the completion url is found
        return NO;
    }
    
    NSString* url = request.URL.absoluteString;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:details.completionPattern
                                  options:0
                                  error:&error];
    if (error != nil) {
        onError(error);
        return NO;
    }
    
    NSArray* matches = [regex matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    
    if (matches.count == 0) {
        return YES;
    }
    
    completionUrlIsFound = YES;
    
    // Download the bank authorization data
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession]
     dataTaskWithRequest:request
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (!error)
             {
                 NSError *err = nil;
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:&err];
                 if (err != nil) {
                     onError(err);
                 } else {
                     BankAuthorization *bankAuth =
                     [TKJson deserializeMessageOfClass:[BankAuthorization class]
                                        fromDictionary:dict];
                     TKLogDebug(@"Received BankAuth %@",bankAuth)
                     onSuccess(bankAuth);
                 }
             } else {
                 onError(error);
             }
         });
     }];
    
    [task resume];
    
    return NO;
}

- (void) browserWillCancel:(NSError *)error {
    onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                details:TKLocalizedString(@"User_Cancelled_Authentication",
                                                          @"User cancelled authentication")
                      encapsulatedError:error]);
}
@end
