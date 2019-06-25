//
//  TKOauthEngine.m
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
    OnSuccessWithString onSuccess;
    OnError onError;
    TKBrowser *browser;
    NSString *url;
    NSString *pattern;
    
    BOOL completionUrlIsFound;
}

- (id)initWithTokenCluster:(TokenCluster *)tokenCluster
            BrowserFactory:(TKBrowserFactory)browserFactory
                       url:(NSString *)url_ {
    self = [super init];
    
    if (self) {
        browser = browserFactory(self);
        completionUrlIsFound = NO;
        
        NSString *callbackUrl = [NSString stringWithFormat:@"https://%@/auth/callback",
                                 tokenCluster.webAppUrl];
        
        url = [NSString stringWithFormat:@"%@&redirect_uri=%@&resource=BALANCES&resource=TRANSACTIONS",
               url_,
               [callbackUrl stringByAddingPercentEncodingWithAllowedCharacters:
                [NSCharacterSet URLHostAllowedCharacterSet]]];
        
        pattern = [callbackUrl stringByAppendingString:@"([/?]?.*#).*access_token=.+"];
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
    
    NSString* urlStr = request.URL.absoluteString;
    
    NSError *error = nil;
    
    if (error != nil) {
        onError(error);
        return NO;
    }
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:0
                                  error:&error];
    
    NSArray *matches = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    
    if (matches.count == 0) {
        return YES;
    }
    
    completionUrlIsFound = YES;
    
    NSArray<NSString *> *urlParts = [urlStr componentsSeparatedByCharactersInSet:
                                     [NSCharacterSet characterSetWithCharactersInString:@"#|&"]];
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

