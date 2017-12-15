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
    TKBrowserCreationBlock browserCreationBlock;
    ExternalAuthorizationDetails *details;
    OnSuccessWithBankAuthorization onSuccess;
    OnError onError;
    TKBrowser* browser;
    
    BOOL completionUrlIsFound;
}

/**
 * The shared pool can prevent TKAuthorizationEngine being recycled unexpectedly by ARC
 */
+ (id)sharedPool {
    static NSMutableSet<TKAuthorizationEngine *> *sharedPool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPool = [[NSMutableSet<TKAuthorizationEngine *> alloc] init];
    });
    return sharedPool;
}

- (id)initWithBrowserCreationBlock:(TKBrowserCreationBlock)browserCreationBlock_; {
    self = [super init];
    
    if (self) {
        browserCreationBlock = browserCreationBlock_;
        completionUrlIsFound = NO;
    }
    
    return self;
}

- (void)authorizedWithExternalAuthorizationDetails:(ExternalAuthorizationDetails *)details_
                                         onSuccess:(OnSuccessWithBankAuthorization)onSuccess_
                                           onError:(OnError)onError_ {
    details = details_;
    onSuccess = onSuccess_;
    onError = onError_;
    
    browser = [self _createBrowser];
    [browser loadUrl:details.URL];
    
    [[TKAuthorizationEngine sharedPool] addObject:self];
}

- (void)revoke {
    if ([[TKAuthorizationEngine sharedPool] containsObject:self]) {
        [[TKAuthorizationEngine sharedPool] removeObject:self];
        [browser dismiss];
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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:details.completionPattern
                                                                           options:nil
                                                                             error:&error];
    if (error != nil) {
        onError(error);
        return NO;
    }
    
    NSArray* matches = [regex matchesInString:url options:nil range:NSMakeRange(0, url.length)];
    
    if (matches.count == 0) {
        return YES;
    }
    
    completionUrlIsFound = YES;
    
    // Download the bank authorization data
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   NSError *err = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:nil
                                                                                          error:&err];
                                   if (err != nil) {
                                       onError(err);
                                   }
                                   else {
                                       BankAuthorization *bankAuth = [TKJson deserializeMessageOfClass:[BankAuthorization class] fromDictionary:dict];
                                       TKLogDebug(@"Receive BankAuth %@",bankAuth)
                                       onSuccess(bankAuth);
                                   }
                               } else{
                                   onError(error);
                               }
                           }];
    return NO;
}

- (void) authenticationWillCancel:(NSError *)error {
    onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                details:TKLocalizedString(@"User_Cancelled_Authentication", @"User cancelled authentication")
                      encapsulatedError:error]);
}


#pragma mark - private methods
- (TKBrowser *)_createBrowser {
    if (browserCreationBlock != nil) {
        TKBrowser *browser_ = browserCreationBlock(self);
        if (browser_ != nil) {
            return browser_;
        }
    }
    // Use TKTokenBrowser instead
    return [[TKTokenBrowser alloc] initWithBrowserDelegate:self];
}

@end
