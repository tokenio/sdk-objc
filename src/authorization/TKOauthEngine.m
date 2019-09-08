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
    NSString *successPattern;
    NSString *errorPattern;
    
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

        successPattern = [callbackUrl stringByAppendingString:@"[/?]?.*#.*access_token=([^&]+)"];
        errorPattern = [callbackUrl stringByAppendingString:@"[/?]?error=([^&]+)"];
        // https://web-app.sandbox.token.io/auth/callback?error=access_denied
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

    NSString* successMatch = [self matchResult:urlStr WithPattern:successPattern];
    if (successMatch) {
        completionUrlIsFound = YES;
        onSuccess(successMatch);
        return NO;
    }


    NSString* errorMatch = [self matchResult:urlStr WithPattern:errorPattern];
    if (errorMatch) {
        completionUrlIsFound = YES;
        onError([NSError errorWithDomain:kTokenErrorDomain
                                    code:kTKErrorBankLinking
                                userInfo:@{ NSLocalizedDescriptionKey: errorMatch }]);
        return NO;
    }

    return YES;
}

- (void) browserWillCancel:(NSError *)error {
    onError([NSError errorFromErrorCode:kTKErrorUserCancelled
                                details:TKLocalizedString(@"User_Cancelled_Authentication",
                                                          @"User cancelled authentication")
                      encapsulatedError:error]);
}

- (NSString *) matchResult:(NSString *)string WithPattern:(NSString *)pattern {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:0
                                  error:nil];

    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];

    if (matches.count > 0) {
        return [string substringWithRange:[matches[0] rangeAtIndex:1]];
    }
    return nil;
}
@end

