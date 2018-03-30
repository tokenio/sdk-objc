//
//  TKOAuthEngine.m
//  TokenSdk
//
//  Created by Sibin Lu on 3/29/18.
//  Copyright © 2018 Token Inc. All rights reserved.
//

#import "TKOauthEngine.h"
#import "TKBrowser.h"
#import "TKError.h"
#import "TKLocalizer.h"
#import "TKLogManager.h"
#import "TKJson.h"

@implementation TKOauthEngine {
    NSString *url;
    OnSuccessWithString onSuccess;
    OnError onError;
    TKBrowser* browser;
    
    BOOL completionUrlIsFound;
}

- (id)initWithBrowserFactory:(TKBrowserFactory)browserFactory
                         url:(NSString *)url_ {
    self = [super init];
    
    if (self) {
        browser = browserFactory(self);
        url = [url_ stringByAppendingString:@"&redirect_uri=https%3A%2F%2Ftoken.io"];
        completionUrlIsFound = NO;
    }
    
    return self;
}

- (void)authorizeOnSuccess:(OnSuccessWithString)onSuccess_
                   onError:(OnError)onError_ {
    onSuccess = onSuccess_;
    onError = onError_;
    
    [browser loadUrl:url];
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
                                  regularExpressionWithPattern:@".*token.io([/?]?.*#).*access_token=.+"
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
    
    NSArray<NSString *> *urlParts = [url componentsSeparatedByString:@"#|&"];
    for (int i = (int)urlParts.count - 1; i >=0; i--) {
        if ([urlParts[i] containsString:@"access_token="]) {
            onSuccess([urlParts[i] substringFromIndex:13]);
            return NO;
        }
    }
    
    onError([NSError errorWithDomain:kTokenErrorDomain
                                code:kTKErrorOauthAccessTokenNotFound
                            userInfo:@{ NSLocalizedDescriptionKey:
                                            @"Access token can't be retrieved from result page."}]);
    
    return NO;
}

- (void) browserWillCancel:(NSError *)error {
    onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                details:TKLocalizedString(@"User_Cancelled_Authentication",
                                                          @"User cancelled authentication")
                      encapsulatedError:error]);
}
@end

