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
#import "SAVASTAd.h"
#import "SAVASTMedia.h"
#import "SAVASTEvent.h"

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
        BOOL expected_ad_isSafeAdApproved = false;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = -1;
        NSString *expected_creative_click_url = @"http://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Image;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
        NSString *expected_details_cdn = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_path = nil;
        NSString *expected_media_url = nil;
        BOOL expected_media_isDownloaded = false;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = nil;
        SAVASTAdType expected_vastad_type = SA_Invalid_VAST;
        NSMutableArray* expected_vastad_media = [@[] mutableCopy];
        NSMutableArray* expected_vastad_events = [@[] mutableCopy];
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_path, ad.creative.details.media.path);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], [expected_vastad_events count]);
        
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
        BOOL expected_ad_isSafeAdApproved = false;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = -1;
        NSString *expected_creative_click_url = @"http://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_cdn = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://ads.superawesome.tv/v2/video/vast/30479/-1/-1/?sdkVersion=0.0.0&rnd=";
        
        NSString *expected_media_path = @"mp4";
        NSString *expected_media_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isDownloaded = true;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        SAVASTAdType expected_vastad_type = SA_InLine_VAST;
        NSMutableArray<SAVASTMedia*> *expected_vastad_media = [@[] mutableCopy];
        SAVASTMedia *media = [[SAVASTMedia alloc] init];
        media.url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        media.type = @"video/mp4";
        media.bitrate = 720;
        media.width = 640;
        media.height = 480;
        [expected_vastad_media addObject:media];
        NSUInteger expected_vastad_events_size = 15;
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.path containsString:expected_media_path]);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], expected_vastad_events_size);
        
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
        BOOL expected_ad_isSafeAdApproved = false;
        BOOL expected_ad_show_padlock = false;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 0;
        NSString *expected_creative_click_url = nil;
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Invalid;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = nil;
        NSString *expected_details_url = nil;
        NSString *expected_details_video = nil;
        NSString *expected_details_cdn = nil;
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_path = nil;
        NSString *expected_media_url = nil;
        BOOL expected_media_isDownloaded = false;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = nil;
        SAVASTAdType expected_vastad_type = SA_Invalid_VAST;
        NSMutableArray* expected_vastad_media = [@[] mutableCopy];
        NSMutableArray* expected_vastad_events = [@[] mutableCopy];
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_path, ad.creative.details.media.path);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], [expected_vastad_events count]);
        
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
        BOOL expected_ad_isSafeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 5768;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_installUrl = nil;
        NSString *expected_creative_clickCounterUrl = @"https://superawesome.tv/click_counter";
        SACreativeFormat expected_creative_format = SA_Image;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/9Q4SVblKKIWDBJm537HFrqI6rBxjCdb9.jpg";
        NSString *expected_details_cdn = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_path = nil;
        NSString *expected_media_url = nil;
        BOOL expected_media_isDownloaded = false;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = nil;
        SAVASTAdType expected_vastad_type = SA_Invalid_VAST;
        NSMutableArray* expected_vastad_media = [@[] mutableCopy];
        NSMutableArray* expected_vastad_events = [@[] mutableCopy];
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_path, ad.creative.details.media.path);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], [expected_vastad_events count]);
        
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
        BOOL expected_ad_isSafeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 8902;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = @"https://superawesome.tv/v2/ad/ext_impression";
        NSString *expected_creative_clickCounterUrl = @"https://superawesome.tv/click_counter";
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Rich;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
        NSString *expected_details_cdn = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_path = nil;
        NSString *expected_media_url = nil;
        BOOL expected_media_isDownloaded = false;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = nil;
        SAVASTAdType expected_vastad_type = SA_Invalid_VAST;
        NSMutableArray* expected_vastad_media = [@[] mutableCopy];
        NSMutableArray* expected_vastad_events = [@[] mutableCopy];
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_path, ad.creative.details.media.path);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], [expected_vastad_events count]);
        
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
        BOOL expected_ad_isSafeAdApproved = true;
        BOOL expected_ad_show_padlock = false;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 21029;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = @"https://superawesome.tv/v2/ad/ext_impression";
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Tag;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = nil;
        NSString *expected_details_url = nil;
        NSString *expected_details_video = nil;
        NSString *expected_details_cdn = nil;
//        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = nil;
        
        NSString *expected_media_path = nil;
        NSString *expected_media_url = nil;
        BOOL expected_media_isDownloaded = false;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = nil;
        SAVASTAdType expected_vastad_type = SA_Invalid_VAST;
        NSMutableArray* expected_vastad_media = [@[] mutableCopy];
        NSMutableArray* expected_vastad_events = [@[] mutableCopy];
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
//        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertEqualObjects(expected_details_vast, ad.creative.details.vast);
        
        XCTAssertNotNil(ad.creative.details.media.html);
        XCTAssertEqualObjects(expected_media_path, ad.creative.details.media.path);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], [expected_vastad_media count]);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], [expected_vastad_events count]);
        
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
        BOOL expected_ad_isSafeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 5770;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_video = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/yqbZXLY8b7p8dyIekHAnzySMwqOwA0HE.mp4";
        NSString *expected_details_cdn = @"https://s3-eu-west-1.amazonaws.com/sb-ads-video-transcoded/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-vastparser/master/samples/VAST2.0.xml";
        
        NSString *expected_media_path = @"mp4";
        NSString *expected_media_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isDownloaded = true;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        SAVASTAdType expected_vastad_type = SA_InLine_VAST;
        NSInteger expected_vastad_media_size = 3;
        NSInteger expected_vastad_events_size = 40;
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.path containsString:expected_media_path]);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], expected_vastad_media_size);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], expected_vastad_events_size);
        
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
        BOOL expected_ad_isSafeAdApproved[] = {true, true};
        BOOL expected_ad_show_padlock[] = {true, true};
        SACampaignType expected_ad_campaignType[] = {SA_CPI, SA_CPI};
        
        int expected_creative_id[] = {5792, 5793};
        NSString* expected_creative_click_url[] = {@"http://superawesome.tv", @"http://www.superawesome.tv/en/kws"};
        NSString* expected_creative_impression_url[] = {nil, nil};
        NSString* expected_creative_clickCounterUrl[] = {@"https://superawesome.tv/click_counter", @"https://superawesome.tv/click_counter_2"};
        NSString* expected_creative_installUrl[] = {@"https://ads.superawesome.tv/install_1", nil};
        SACreativeFormat expected_creative_format[] = {SA_Appwall, SA_Appwall};
        NSString* expected_creative_bundle[] = {@"tv.superawesome.demoapp", @"tv.superawesome.demoapp"};
        
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
        NSString* expected_details_cdn[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/"
        };
        NSString* expected_details_tag[] = {nil, nil};
        NSString* expected_details_vast[] = {nil, nil};
        
        NSString* expected_media_path[] = {@"png", @"png"};
        NSString* expected_media_url[] = {
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/2ODwlbp3NJxnsmgROrdzXrxIUcD87h5y.png",
            @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/images/TMRQ0iNyFEinXx2BQhkSONtEvCES7rsr.png"
        };
        BOOL expected_media_isDownloaded[] = {true, true};
        
        NSString *expected_vastad_redirect[] = {nil, nil};
        NSString *exprected_vastad_url[] = {nil, nil};
        SAVASTAdType expected_vastad_type[] = {SA_Invalid_VAST, SA_Invalid_VAST};
        
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
            XCTAssertEqual(expected_ad_isSafeAdApproved[i], ad.isSafeAdApproved);
            XCTAssertEqual(expected_ad_show_padlock[i], ad.isPadlockVisible);
            XCTAssertEqual(expected_ad_campaignType[i], ad.campaignType);
            
            XCTAssertEqual(expected_creative_id[i], ad.creative._id);
            XCTAssertEqualObjects(expected_creative_click_url[i], ad.creative.clickUrl);
            XCTAssertEqualObjects(expected_creative_impression_url[i], ad.creative.impressionUrl);
            XCTAssertEqualObjects(expected_creative_clickCounterUrl[i], ad.creative.clickCounterUrl);
            XCTAssertEqualObjects(expected_creative_installUrl[i], ad.creative.installUrl);
            XCTAssertEqual(expected_creative_format[i], ad.creative.format);
            XCTAssertEqualObjects(expected_creative_bundle[i], ad.creative.bundle);
            
            XCTAssertEqualObjects(expected_details_image[i], ad.creative.details.image);
            XCTAssertEqualObjects(expected_details_url[i], ad.creative.details.url);
            XCTAssertEqualObjects(expected_details_video[i], ad.creative.details.video);
            XCTAssertEqualObjects(expected_details_cdn[i], ad.creative.details.cdn);
            XCTAssertEqualObjects(expected_details_tag[i], ad.creative.details.tag);
            XCTAssertEqualObjects(expected_details_vast[i], ad.creative.details.vast);
            
            XCTAssertNil(ad.creative.details.media.html);
            XCTAssertTrue([ad.creative.details.media.path containsString:expected_media_path[i]]);
            XCTAssertEqualObjects(expected_media_url[i], ad.creative.details.media.url);
            XCTAssertEqual(expected_media_isDownloaded[i], ad.creative.details.media.isDownloaded);
            
            XCTAssertNotNil(ad.creative.details.media.vastAd);
            XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect[i]);
            XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url[i]);
            XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type[i]);
            XCTAssertNotNil(ad.creative.details.media.vastAd.media);
            XCTAssertNotNil(ad.creative.details.media.vastAd.events);
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
        BOOL expected_ad_isSafeAdApproved = true;
        BOOL expected_ad_show_padlock = true;
        SACampaignType expected_ad_campaignType = SA_CPM;
        
        int expected_creative_id = 3330;
        NSString *expected_creative_click_url = @"https://superawesome.tv";
        NSString *expected_creative_impression_url = nil;
        NSString *expected_creative_clickCounterUrl = nil;
        NSString *expected_creative_installUrl = nil;
        SACreativeFormat expected_creative_format = SA_Video;
        NSString *expected_creative_bundle = nil;
        
        NSString *expected_details_image = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_video = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        NSString *expected_details_cdn = @"https://ads.superawesome.tv/v2/demo_images/";
        NSString *expected_details_tag = nil;
        NSString *expected_details_vast = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-vastparser/master/samples/VAST5.0.xml";
        
        NSString *expected_media_path = @"mp4";
        NSString *expected_media_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        BOOL expected_media_isDownloaded = true;
        
        NSString *expected_vastad_redirect = nil;
        NSString *exprected_vastad_url = @"https://ads.superawesome.tv/v2/demo_images/video.mp4";
        SAVASTAdType expected_vastad_type = SA_InLine_VAST;
        NSInteger expected_vastad_media_size = 3;
        NSInteger expected_vastad_events_size = 30;
        
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
        XCTAssertEqual(expected_ad_isSafeAdApproved, ad.isSafeAdApproved);
        XCTAssertEqual(expected_ad_show_padlock, ad.isPadlockVisible);
        XCTAssertEqual(expected_ad_campaignType, ad.campaignType);
        
        XCTAssertEqual(expected_creative_id, ad.creative._id);
        XCTAssertEqualObjects(expected_creative_click_url, ad.creative.clickUrl);
        XCTAssertEqualObjects(expected_creative_impression_url, ad.creative.impressionUrl);
        XCTAssertEqualObjects(expected_creative_clickCounterUrl, ad.creative.clickCounterUrl);
        XCTAssertEqualObjects(expected_creative_installUrl, ad.creative.installUrl);
        XCTAssertEqual(expected_creative_format, ad.creative.format);
        XCTAssertEqualObjects(expected_creative_bundle, ad.creative.bundle);
        
        XCTAssertEqualObjects(expected_details_image, ad.creative.details.image);
        XCTAssertEqualObjects(expected_details_url, ad.creative.details.url);
        XCTAssertEqualObjects(expected_details_video, ad.creative.details.video);
        XCTAssertEqualObjects(expected_details_cdn, ad.creative.details.cdn);
        XCTAssertEqualObjects(expected_details_tag, ad.creative.details.tag);
        XCTAssertTrue([ad.creative.details.vast containsString:expected_details_vast]);
        
        XCTAssertNil(ad.creative.details.media.html);
        XCTAssertTrue([ad.creative.details.media.path containsString:expected_media_path]);
        XCTAssertEqualObjects(expected_media_url, ad.creative.details.media.url);
        XCTAssertEqual(expected_media_isDownloaded, ad.creative.details.media.isDownloaded);
        
        XCTAssertNotNil(ad.creative.details.media.vastAd);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.redirect, expected_vastad_redirect);
        XCTAssertEqualObjects(ad.creative.details.media.vastAd.url, exprected_vastad_url);
        XCTAssertEqual(ad.creative.details.media.vastAd.type, expected_vastad_type);
        XCTAssertNotNil(ad.creative.details.media.vastAd.media);
        XCTAssertNotNil(ad.creative.details.media.vastAd.events);
        XCTAssertEqual([ad.creative.details.media.vastAd.media count], expected_vastad_media_size);
        XCTAssertEqual([ad.creative.details.media.vastAd.events count], expected_vastad_events_size);

        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}


@end
