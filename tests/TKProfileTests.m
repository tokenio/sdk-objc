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
#import "TokenClient.h"
#import "TKMember.h"

@interface TKProfileTests : TKTestBase

@end

@implementation TKProfileTests {
    TKMember *member;
}

- (void)setUp {
    [super setUp];
    member = [self createMember:[self client]];
}

- (void)testProfile {
    Profile* profile = [[Profile alloc] init];
    profile.displayNameFirst = @"Meimei";
    profile.displayNameLast = @"Han";
    
    __weak TKMember *weakMember = member;
    TKTestExpectation *expactation = [[TKTestExpectation alloc] init];
    [weakMember setProfile:profile onSuccess:^(Profile *p) {
        [weakMember getProfile:weakMember.id onSuccess:^(Profile *result) {
            NSString* name = [NSString stringWithFormat:@"%@ %@", profile.displayNameFirst, profile.displayNameLast];
            XCTAssertEqualObjects(result.displayNameFirst, name);
            XCTAssertEqualObjects(result.displayNameLast, @"");
            [expactation fulfill];
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expactation] timeout:10];
}

- (void)testProfilePicture {
    //create picture
    UIGraphicsBeginImageContext(CGSizeMake(500, 500));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0x12/255.f green:0x34/255.f blue:0x56/255.f alpha:1].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 500, 500));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* data = UIImagePNGRepresentation(image);
    
    __weak TKMember *weakMember = member;
    TKTestExpectation *expactation = [[TKTestExpectation alloc] init];
    [weakMember setProfilePicture:member.id withType:@"image/png" withName:@"testImage" withData:data onSuccess:^ {
        [weakMember getProfilePicture:weakMember.id size:ProfilePictureSize_Original onSuccess:^(Blob *blob) {
            XCTAssertNotNil(blob);
            XCTAssertNotNil(blob.data);
            [expactation fulfill];
            
            UIImage* resultImage = [UIImage imageWithData:data];
            
            // get pixels
            uint32_t* rgbImageBuf = (uint32_t*)malloc(resultImage.size.width * resultImage.size.height * 4);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(rgbImageBuf,
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
            
        } onError:THROWERROR];
    } onError:THROWERROR];
    [self waitForExpectations:@[expactation] timeout:10];
}
@end
