//
//  SAAdLoaderTests.m
//  SAAdLoaderTests
//
//  Created by Gabriel Coman on 06/02/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

@import XCTest;
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAMedia.h"
#import "SAProcessEvents.h"
#import "SASession.h"
#import "SATracking.h"

@interface SAAdLoader_ProcessEvents_Tests : XCTestCase
@end

@implementation SAAdLoader_ProcessEvents_Tests

- (void)setUp {
    [super setUp];
}

- (void) tearDown {
    [super tearDown];
}

- (void) testEvents {
    
    SAAd *ad = [[SAAd alloc] init];
    ad.placementId = 4001;
    ad.lineItemId = 2731;
    ad.creative._id = 1092;
    ad.creative.impressionUrl = @"https://superawesome.tv/impression";
    ad.creative.installUrl = @"https://superawesome.tv/install";
    ad.creative.clickCounterUrl = @"https://superawesome.tv/click_counter";
    
    SASession *session = [[SASession alloc] init];
                           ;
    [session setConfigurationProduction];
    [session disableTestMode];
    
    [SAProcessEvents addAdEvents:ad forSession:session];
    
    int expected_events = 7;
    
    int expected_superawesome_click = 1;
    int expected_superawesome_impression = 1;
    int expected_superawesome_viewable_impression = 1;
    int expected_superawesome_pg_close = 1;
    int expected_superawesome_pg_fail = 1;
    int expected_superawesome_pg_open = 1;
    int expected_superawesome_pg_success = 1;
    
    NSString *expected_superawesome_click_url = @"https://ads.superawesome.tv/v2/click?placement=4001&rnd=1026797&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&creative=1092&line_item=2731&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_superawesome_impression_url = @"https://ads.superawesome.tv/v2/impression?placement=4001&rnd=1095998&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&no_image=true&line_item=2731&creative=1092&sdkVersion=0.0.0";
    NSString *expected_superawesome_viewable_impression_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22viewable_impression%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1115679&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_superawesome_pg_close_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateClose%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1123630&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_superawesome_pg_fail_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateFail%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1468009&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_superawesome_pg_open_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateOpen%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1043005&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_superawesome_pg_success_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateSuccess%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1487496&ct=wifi&sdkVersion=0.0.0";
    
    XCTAssertNotNil(ad.creative.events);
    XCTAssertEqual(expected_events, [ad.creative.events count]);
    
    NSMutableArray<SATracking*> *superawesome_click = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_impression = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_viewable_impression = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_pg_close = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_pg_fail = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_pg_open = [@[] mutableCopy];
    NSMutableArray<SATracking*> *superawesome_pg_success = [@[] mutableCopy];
    
    for (SATracking *event in ad.creative.events) {
        if ([event.event containsString:@"superawesome_click"]) [superawesome_click addObject:event];
        if ([event.event containsString:@"superawesome_impression"]) [superawesome_impression addObject:event];
        if ([event.event containsString:@"superawesome_viewable_impression"]) [superawesome_viewable_impression addObject:event];
        if ([event.event containsString:@"superawesome_pg_close"]) [superawesome_pg_close addObject:event];
        if ([event.event containsString:@"superawesome_pg_fail"]) [superawesome_pg_fail addObject:event];
        if ([event.event containsString:@"superawesome_pg_open"]) [superawesome_pg_open addObject:event];
        if ([event.event containsString:@"superawesome_pg_success"]) [superawesome_pg_success addObject:event];
    }
    
    XCTAssertEqual(expected_superawesome_click, [superawesome_click count]);
    XCTAssertEqual(expected_superawesome_impression, [superawesome_impression count]);
    XCTAssertEqual(expected_superawesome_viewable_impression, [superawesome_viewable_impression count]);
    XCTAssertEqual(expected_superawesome_pg_close, [superawesome_pg_close count]);
    XCTAssertEqual(expected_superawesome_pg_fail, [superawesome_pg_fail count]);
    XCTAssertEqual(expected_superawesome_pg_open, [superawesome_pg_open count]);
    XCTAssertEqual(expected_superawesome_pg_success, [superawesome_pg_success count]);
    
    NSString *superawesome_click_url = superawesome_click[0].URL;
    NSString *superawesome_impression_url = superawesome_impression[0].URL;
    NSString *superawesome_viewable_impression_url = superawesome_viewable_impression[0].URL;
    NSString *superawesome_pg_close_url = superawesome_pg_close[0].URL;
    NSString *superawesome_pg_fail_url = superawesome_pg_fail[0].URL;
    NSString *superawesome_pg_open_url = superawesome_pg_open[0].URL;
    NSString *superawesome_pg_success_url = superawesome_pg_success[0].URL;
    
    XCTAssertNotNil(superawesome_click_url);
    XCTAssertNotNil(superawesome_impression_url);
    XCTAssertNotNil(superawesome_viewable_impression_url);
    XCTAssertNotNil(superawesome_pg_close_url);
    XCTAssertNotNil(superawesome_pg_fail_url);
    XCTAssertNotNil(superawesome_pg_open_url);
    XCTAssertNotNil(superawesome_pg_success_url);
    
//    BOOL sa_tracking_ok =  getHammingDistance(expected_sa_tracking_url, sa_tracking_url, 7);
//    BOOL viewable_impr_ok = getHammingDistance(expected_viewable_impr_url, viewable_impr_url, 7);
//    BOOL pg_close_ok = getHammingDistance(expected_pg_close_url, pg_close_url, 7);
//    BOOL pg_fail_ok = getHammingDistance(expected_pg_fail_url, pg_fail_url, 7);
//    BOOL pg_open_ok = getHammingDistance(expected_pg_open_url, pg_open_url, 7);
//    BOOL pg_success_ok = getHammingDistance(expected_pg_success_url, pg_success_url, 7);
//    BOOL sa_impr_ok = getHammingDistance(expected_sa_impr_url, sa_impr_url, 7);
//    BOOL impression_ok = getHammingDistance(expected_impression_url, impression_url, 7);
//    BOOL install_ok = getHammingDistance(expected_install_url, install_url, 7);
//    
//    XCTAssertTrue(sa_tracking_ok);
//    XCTAssertTrue(viewable_impr_ok);
//    XCTAssertTrue(pg_close_ok);
//    XCTAssertTrue(pg_fail_ok);
//    XCTAssertTrue(pg_open_ok);
//    XCTAssertTrue(pg_success_ok);
//    XCTAssertTrue(sa_impr_ok);
//    XCTAssertTrue(impression_ok);
//    XCTAssertTrue(install_ok);
    
}

BOOL getHammingDistance(NSString *expected, NSString *existing, int maxDelta) {
    
    int cDelta = 0;
    if ([existing length] != [expected length]) return false;
    
    for (int i = 0; i < [expected length]; i++) {
        unichar expC = [expected characterAtIndex:i];
        unichar exiC = [existing characterAtIndex:i];
        if (expC != exiC) cDelta++;
    }
    
    return cDelta <= maxDelta;
    
}

@end

