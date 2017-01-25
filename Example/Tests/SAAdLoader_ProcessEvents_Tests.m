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
    
    int expected_events = 10;
    
    int expected_sa_tracking = 1;
    int expected_viewable_impr = 1;
    int expected_pg_close = 1;
    int expected_pg_fail = 1;
    int expected_pg_open = 1;
    int expected_pg_success = 1;
    int expected_sa_impr = 1;
    int expected_impression = 1;
    int expected_install = 1;
    int expected_click_counter = 1;
    
    NSString *expected_sa_tracking_url = @"https://ads.superawesome.tv/v2/click?placement=4001&rnd=1026797&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&creative=1092&line_item=2731&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_viewable_impr_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22viewable_impression%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1115679&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_pg_close_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateClose%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1123630&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_pg_fail_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateFail%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1468009&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_pg_open_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateOpen%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1043005&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_pg_success_url = @"https://ads.superawesome.tv/v2/event?data=%7B%22type%22%3A%22parentalGateSuccess%22%2C%22creative%22%3A1092%2C%22line_item%22%3A2731%2C%22placement%22%3A4001%7D&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&rnd=1487496&ct=wifi&sdkVersion=0.0.0";
    NSString *expected_sa_impr_url = @"https://ads.superawesome.tv/v2/impression?placement=4001&rnd=1095998&sourceBundle=org.cocoapods.demo.SAAdLoader-Example&no_image=true&line_item=2731&creative=1092&sdkVersion=0.0.0";
    NSString *expected_impression_url = @"https://superawesome.tv/impression";
    NSString *expected_install_url = @"https://superawesome.tv/install";
    NSString *expected_click_counter_url = @"https://superawesome.tv/click_counter";
    
    XCTAssertNotNil(ad.creative.events);
    XCTAssertEqual(expected_events, [ad.creative.events count]);
    
    NSMutableArray<SATracking*> *sa_tracking = [@[] mutableCopy];
    NSMutableArray<SATracking*> *viewable_impr = [@[] mutableCopy];
    NSMutableArray<SATracking*> *pg_close = [@[] mutableCopy];
    NSMutableArray<SATracking*> *pg_fail = [@[] mutableCopy];
    NSMutableArray<SATracking*> *pg_open = [@[] mutableCopy];
    NSMutableArray<SATracking*> *pg_success = [@[] mutableCopy];
    NSMutableArray<SATracking*> *sa_impr = [@[] mutableCopy];
    NSMutableArray<SATracking*> *impression = [@[] mutableCopy];
    NSMutableArray<SATracking*> *install = [@[] mutableCopy];
    NSMutableArray<SATracking*> *click_counter = [@[] mutableCopy];
    
    for (SATracking *event in ad.creative.events) {
        if ([event.event containsString:@"sa_tracking"]) [sa_tracking addObject:event];
        if ([event.event containsString:@"viewable_impr"]) [viewable_impr addObject:event];
        if ([event.event containsString:@"pg_close"]) [pg_close addObject:event];
        if ([event.event containsString:@"pg_fail"]) [pg_fail addObject:event];
        if ([event.event containsString:@"pg_open"]) [pg_open addObject:event];
        if ([event.event containsString:@"pg_success"]) [pg_success addObject:event];
        if ([event.event containsString:@"sa_impr"]) [sa_impr addObject:event];
        if ([event.event containsString:@"impression"]) [impression addObject:event];
        if ([event.event containsString:@"install"]) [install addObject:event];
        if ([event.event containsString:@"clk_counter"]) [click_counter addObject:event];
    }
    
    XCTAssertEqual(expected_sa_tracking, [sa_tracking count]);
    XCTAssertEqual(expected_viewable_impr, [viewable_impr count]);
    XCTAssertEqual(expected_pg_close, [pg_close count]);
    XCTAssertEqual(expected_pg_fail, [pg_fail count]);
    XCTAssertEqual(expected_pg_open, [pg_open count]);
    XCTAssertEqual(expected_pg_success, [pg_success count]);
    XCTAssertEqual(expected_sa_impr, [sa_impr count]);
    XCTAssertEqual(expected_impression, [impression count]);
    XCTAssertEqual(expected_install, [install count]);
    XCTAssertEqual(expected_click_counter, [click_counter count]);
    
    NSString *sa_tracking_url = sa_tracking[0].URL;
    NSString *viewable_impr_url = viewable_impr[0].URL;
    NSString *pg_close_url = pg_close[0].URL;
    NSString *pg_fail_url = pg_fail[0].URL;
    NSString *pg_open_url = pg_open[0].URL;
    NSString *pg_success_url = pg_success[0].URL;
    NSString *sa_impr_url = sa_impr[0].URL;
    NSString *impression_url = impression[0].URL;
    NSString *install_url = install[0].URL;
    NSString *click_counter_url = click_counter[0].URL;
    
    XCTAssertNotNil(sa_tracking_url);
    XCTAssertNotNil(viewable_impr_url);
    XCTAssertNotNil(pg_close_url);
    XCTAssertNotNil(pg_fail_url);
    XCTAssertNotNil(pg_open_url);
    XCTAssertNotNil(pg_success_url);
    XCTAssertNotNil(sa_impr_url);
    XCTAssertNotNil(impression_url);
    XCTAssertNotNil(install_url);
    XCTAssertNotNil(click_counter_url);
    
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

