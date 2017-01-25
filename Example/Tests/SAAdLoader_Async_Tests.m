//
//  SAAdLoader_Async_Tests.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 18/01/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SASession.h"
#import "SALoader.h"
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAMedia.h"
#import "SAResponse.h"

@interface SAAdLoader_Async_Tests : XCTestCase
@end

@implementation SAAdLoader_Async_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testLoad1 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:30471 withSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 30471;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Image;
        
        int expected_ad_placementId = 30471;
        int expected_ad_lineItemId = -1;
        int expected_ad_campaignId = 0;
        int expected_ad_advertiserId = 0;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = false;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = -1;
        NSString *expected_creative_click_url = @"http://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Image;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 10;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_cdnUrl = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_playableDiskUrl = nil;
        NSString *expected_media_playableMediaUrl = nil;
        BOOL expected_media_isOnDisk = false;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_playableDiskUrl, ad.creative.details.media.playableDiskUrl);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void) testLoad2 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:30479 withSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 30479;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Video;
        
        int expected_ad_placementId = 30479;
        int expected_ad_lineItemId = -1;
        int expected_ad_campaignId = 0;
        int expected_ad_advertiserId = 0;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = false;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = -1;
        NSString *expected_creative_click_url = @"http://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 25;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_cdnUrl = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://ads.superawesome.tv/v2/video/vast/30479/-1/-1/?sdkVersion=0.0.0&rnd=";
        
        NSString *expected_media_playableDiskUrl = @"mp4";
        NSString *expected_media_playableMediaUrl = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isOnDisk = true;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.playableDiskUrl containsString:expected_media_playableDiskUrl]);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad3 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:20 withSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 20;
        int expected_status = 404;
        SACreativeFormat expected_format = SA_Invalid;
        
        int expected_ad_placementId = 20;
        int expected_ad_lineItemId = 0;
        int expected_ad_campaignId = 0;
        int expected_ad_advertiserId = 0;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = false;
        BOOL expected_ad_show_padlock = false;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 0;
        NSString *expected_creative_click_url = nil;
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Invalid;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 10;
        
        NSString *expected_details_image = nil;
        NSString *expected_details_url = nil;
        NSString *expected_details_video = nil;
        NSString *expected_details_cdnUrl = nil;
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_playableDiskUrl = nil;
        NSString *expected_media_playableMediaUrl = nil;
        BOOL expected_media_isOnDisk = false;
        
        XCTAssertNotNil(response);
        XCTAssertFalse([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertFalse([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_playableDiskUrl, ad.creative.details.media.playableDiskUrl);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad4 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/imagead.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
       
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Image;
        
        int expected_ad_placementId = 100;
        int expected_ad_lineItemId = 1052;
        int expected_ad_campaignId = 1209;
        int expected_ad_advertiserId = 1;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 5768;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        NSString *expected_creative_clickCounterUrl = @"https://superawesome.tv/click_counter";
        SACreativeFormat expected_creative_format = SA_Image;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 10;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_cdnUrl = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_playableDiskUrl = nil;
        NSString *expected_media_playableMediaUrl = nil;
        BOOL expected_media_isOnDisk = false;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_playableDiskUrl, ad.creative.details.media.playableDiskUrl);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void) testLoad5 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/richmediaad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Rich;
        
        int expected_ad_placementId = 100;
        int expected_ad_lineItemId = 9021;
        int expected_ad_campaignId = 2921;
        int expected_ad_advertiserId = 23;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 8902;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = @"https://superawesome.tv/v2/ad/ext_impression";
        NSString *expected_creative_clickCounterUrl = @"https://superawesome.tv/click_counter";
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Rich;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 10;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_cdnUrl = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_playableDiskUrl = nil;
        NSString *expected_media_playableMediaUrl = nil;
        BOOL expected_media_isOnDisk = false;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_playableDiskUrl, ad.creative.details.media.playableDiskUrl);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad6 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/tagad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Tag;
        
        int expected_ad_placementId = 100;
        int expected_ad_lineItemId = 8929;
        int expected_ad_campaignId = 2213;
        int expected_ad_advertiserId = 22;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = true;
        BOOL expected_ad_show_padlock = false;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 21029;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = @"https://superawesome.tv/v2/ad/ext_impression";
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Tag;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 10;
        
        NSString *expected_details_image = nil;
        NSString *expected_details_url = nil;
        NSString *expected_details_video = nil;
        NSString *expected_details_cdnUrl = nil;
//        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_playableDiskUrl = nil;
        NSString *expected_media_playableMediaUrl = nil;
        BOOL expected_media_isOnDisk = false;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
//        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_playableDiskUrl, ad.creative.details.media.playableDiskUrl);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad7 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/videoad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Video;
        
        int expected_ad_placementId = 100;
        int expected_ad_lineItemId = 1054;
        int expected_ad_campaignId = 1209;
        int expected_ad_advertiserId = 1;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 5770;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 50;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_cdnUrl = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-vastparser/master/samples/VAST2.0.xml";
        
        NSString *expected_media_playableDiskUrl = @"mp4";
        NSString *expected_media_playableMediaUrl = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isOnDisk = true;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.playableDiskUrl containsString:expected_media_playableDiskUrl]);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad8 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/appwallad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 2;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Appwall;
        
        int expected_ad_placementId[] = {100, 100};
        int expected_ad_lineItemId[] = {1075, 1076};
        int expected_ad_campaignId[] = {1227, 1227};
        int expected_ad_advertiserId[] = {1, 1};
        BOOL expected_ad_isFallback[] = {false, false};
        BOOL expected_ad_isHouse[] = {false, false};
        BOOL expected_ad_safeAdApproved[] = {true, true};
        BOOL expected_ad_show_padlock[] = {true, true};
        SACampaignType expected_ad_campaignType[] = {SA_CPI, SA_CPI};
        
        int expected_creative_id[] = {5792, 5793};
        NSString* expected_creative_click_url[] = {@"http://superawesome.tv", @"http://www.superawesome.tv/en/kws"};
        NSString* expected_creative_impression_url[] = {nil, nil};
        NSString* expected_creative_clickCounterUrl[] = {@"https://superawesome.tv/click_counter", @"https://superawesome.tv/click_counter_2"};
        NSString* expected_creative_installUrl[] = {@"https://ads.superawesome.tv/install_1", nil};
        SACreativeFormat expected_creative_format[] = {SA_Appwall, SA_Appwall};
        NSString* expected_creative_bundleId[] = {@"tv.superawesome.demoapp", @"tv.superawesome.demoapp"};
        int expected_creative_events[] = {10, 10};
        
        NSString* expected_details_image[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/2ODwlbp3NJxnsmgROrdzXrxIUcD87h5y.png",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/TMRQ0iNyFEinXx2BQhkSONtEvCES7rsr.png"
        };
        NSString* expected_details_url[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/2ODwlbp3NJxnsmgROrdzXrxIUcD87h5y.png",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/TMRQ0iNyFEinXx2BQhkSONtEvCES7rsr.png"
        };
        NSString* expected_details_video[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/2ODwlbp3NJxnsmgROrdzXrxIUcD87h5y.png",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/TMRQ0iNyFEinXx2BQhkSONtEvCES7rsr.png"
        };
        NSString* expected_details_cdnUrl[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/"
        };
        NSString* expected_details_tag[] = {nil, nil};
        NSString* expected_details_vast[] = {nil, nil};
        
        NSString* expected_media_playableDiskUrl[] = {@"png", @"png"};
        NSString* expected_media_playableMediaUrl[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/2ODwlbp3NJxnsmgROrdzXrxIUcD87h5y.png",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/TMRQ0iNyFEinXx2BQhkSONtEvCES7rsr.png"
        };
        BOOL expected_media_isOnDisk[] = {true, true};
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        for (int i = 0; i < [response.ads count]; i++) {
            SAAd *ad = response.ads[i];
            
            XCTAssertNotNil(ad);
            XCTAssertTrue([ad isValid]);
            XCTAssertNotNil(ad.creative);
            XCTAssertNotNil(ad.creative.details);
            XCTAssertNotNil(ad.creative.details.media);
            
            XCTAssertEqual(expected_placementId, response.placementId);
            XCTAssertEqual(expected_status, response.status);
            XCTAssertEqual(expected_format, response.format);
            
            XCTAssertEqual(expected_ad_placementId[i], ad.placementId);
            XCTAssertEqual(expected_ad_lineItemId[i], ad.lineItemId);
            XCTAssertEqual(expected_ad_campaignId[i], ad.campaignId);
            XCTAssertEqual(expected_ad_advertiserId[i], ad.advertiserId);
            XCTAssertEqual(expected_ad_isFallback[i], ad.isFallback);
            XCTAssertEqual(expected_ad_isHouse[i], ad.isHouse);
            XCTAssertEqual(expected_ad_safeAdApproved[i], ad.safeAdApproved);
            XCTAssertEqual(expected_ad_show_padlock[i], ad.showPadlock);
            XCTAssertEqual(expected_ad_campaignType[i], ad.campaignType);
            
            XCTAssertEqual(expected_creative_id[i], ad.creative._id);
            XCTAssertEqualObjects(expected_creative_click_url[i], ad.creative.clickUrl);
            XCTAssertEqualObjects(expected_creative_impression_url[i], ad.creative.impressionUrl);
            XCTAssertEqualObjects(expected_creative_clickCounterUrl[i], ad.creative.clickCounterUrl);
            XCTAssertEqualObjects(expected_creative_installUrl[i], ad.creative.installUrl);
            XCTAssertEqual(expected_creative_format[i], ad.creative.format);
            XCTAssertEqualObjects(expected_creative_bundleId[i], ad.creative.bundleId);
            XCTAssertEqual(expected_creative_events[i], [ad.creative.events count]);
            
            XCTAssertEqualObjects(expected_details_image[i], ad.creative.details.image);
            XCTAssertEqualObjects(expected_details_url[i], ad.creative.details.url);
            XCTAssertEqualObjects(expected_details_video[i], ad.creative.details.video);
            XCTAssertEqualObjects(expected_details_cdnUrl[i], ad.creative.details.cdnUrl);
            XCTAssertEqualObjects(expected_details_tag[i], ad.creative.details.tag);
            XCTAssertEqualObjects(expected_details_vast[i], ad.creative.details.vast);
            
            XCTAssertNil(ad.creative.details.media.html);
            XCTAssertTrue([ad.creative.details.media.playableDiskUrl containsString:expected_media_playableDiskUrl[i]]);
            XCTAssertEqualObjects(expected_media_playableMediaUrl[i], ad.creative.details.media.playableMediaUrl);
            XCTAssertEqual(expected_media_isOnDisk[i], ad.creative.details.media.isOnDisk);
        }
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void) testLoad9 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session enableTestMode];
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader/master/Example/Tests/Datasource/videoad2.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        // only test for relevant things
        int expected_ads = 1;
        
        int expected_placementId = 100;
        int expected_status = 200;
        SACreativeFormat expected_format = SA_Video;
        
        int expected_ad_placementId = 100;
        int expected_ad_lineItemId = 1110;
        int expected_ad_campaignId = 1420;
        int expected_ad_advertiserId = 1;
        BOOL expected_ad_isFallback = false;
        BOOL expected_ad_isHouse = false;
        BOOL expected_ad_safeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 3330;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundleId = nil;
        int expected_creative_events = 40;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_cdnUrl = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-vastparser/master/samples/VAST5.0.xml";
        
        NSString *expected_media_playableDiskUrl = @"mp4";
        NSString *expected_media_playableMediaUrl = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isOnDisk = true;
        
        XCTAssertNotNil(response);
        XCTAssertTrue([response isValid]);
        XCTAssertNotNil(response.ads);
        XCTAssertEqual(expected_ads, [response.ads count]);
        
        SAAd *ad = response.ads[0];
        XCTAssertNotNil(ad);
        XCTAssertTrue([ad isValid]);
        XCTAssertNotNil(ad.creative);
        XCTAssertNotNil(ad.creative.details);
        XCTAssertNotNil(ad.creative.details.media);
        
        XCTAssertEqual(expected_placementId, response.placementId);
        XCTAssertEqual(expected_status, response.status);
        XCTAssertEqual(expected_format, response.format);
        
        XCTAssertEqual(expected_ad_placementId, ad.placementId);
        XCTAssertEqual(expected_ad_lineItemId, ad.lineItemId);
        XCTAssertEqual(expected_ad_campaignId, ad.campaignId);
        XCTAssertEqual(expected_ad_advertiserId, ad.advertiserId);
        XCTAssertEqual(expected_ad_isFallback, ad.isFallback);
        XCTAssertEqual(expected_ad_isHouse, ad.isHouse);
        XCTAssertEqual(expected_ad_safeAdApproved, ad.safeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.showPadlock);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundleId, ad.creative.bundleId);
        XCTAssertEqual(expected_creative_events, [ad.creative.events count]);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdnUrl, ad.creative.details.cdnUrl);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.playableDiskUrl containsString:expected_media_playableDiskUrl]);
        XCTAssertEqualObjects(expected_media_playableMediaUrl, ad.creative.details.media.playableMediaUrl);
        XCTAssertEqual(expected_media_isOnDisk, ad.creative.details.media.isOnDisk);

        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}


@end