//
//  TKProfileTests.m
//  TokenSdk
//
//  Created by Sibin Lu on 6/23/17.
//  Copyright © 2017 Token Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TKTestBase.h"
#import "TKUtil.h"
#import "TokenIOSync.h"
#import "TKMemberSync.h"

@interface TKProfileTests : TKTestBase

@end

@implementation TKProfileTests {
    TKMemberSync *member;
}

- (void)setUp {
    [super setUp];
    
    [self run: ^(TokenIOSync *tokenIO) {
        Alias *alias = [self generateAlias];
        member = [tokenIO createMember:alias];
    }];
}

- (void)testProfile {
    [self run: ^(TokenIOSync *tokenIO) {
        Profile* profile = [[Profile alloc] init];
        profile.displayNameFirst = @"Meimei";
        profile.displayNameLast = @"Han";
        
        Profile* result = [member setProfile:profile];
        result = [member getProfile:member.id];
        
        XCTAssertEqualObjects(profile.displayNameFirst, result.displayNameFirst);
        XCTAssertEqualObjects(profile.displayNameLast, result.displayNameLast);
    }];
}

- (void)testProfilePicture {
    [self run: ^(TokenIOSync *tokenIO) {
        //create picture
        UIGraphicsBeginImageContext(CGSizeMake(500, 500));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0x12/255.f green:0x34/255.f blue:0x56/255.f alpha:1].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, 500, 500));
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData* data = UIImagePNGRepresentation(image);
        [member setProfilePicture:member.id withType:@"image/png" withName:@"testImage" withData:data];
        
        Blob *blob = [member getProfilePicture:member.id size:ProfilePictureSize_Original];
        XCTAssertNotNil(blob);
        XCTAssertNotNil(blob.data);
        
        UIImage* resultImage = [UIImage imageWithData:data];
        
        // get pixels
        uint32_t* rgbImageBuf = (uint32_t*)malloc(resultImage.size.width * resultImage.size.height * 4);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        context = CGBitmapContextCreate(rgbImageBuf,
                                                     resultImage.size.width,
                                                     resultImage.size.height,
                                                     8,
                                                     resultImage.size.width * 4 ,
                                                     colorSpace,
                                                     kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
        CGContextDrawImage(context, CGRectMake(0, 0, resultImage.size.width, resultImage.size.height), resultImage.CGImage);
        
        XCTAssertTrue(rgbImageBuf[0] == 0x123456ff);
        
        
        if (rgbImageBuf) {
            free(rgbImageBuf);
        }
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
    }];
}


@end
