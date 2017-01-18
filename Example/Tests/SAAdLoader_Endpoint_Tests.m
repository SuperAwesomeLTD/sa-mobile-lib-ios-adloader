//
//  SAAdLoader_Endpoint_Tests.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 18/01/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SALoader.h"
#import "SASession.h"
#import "SAUtils.h"

@interface SAAdLoader_Endpoint_Tests : XCTestCase
@end

@implementation SAAdLoader_Endpoint_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testGetAwesomeAdsEndpoint1 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    
    NSString *expected_baseUrl = @"https://ads.superawesome.tv/v2/ad/4001";
    
    NSString *baseUrl = [loader getAwesomeAdsEndpoint:session forPlacementId:4001];
    
    XCTAssertNotNil(baseUrl);
    XCTAssertEqualObjects(expected_baseUrl, baseUrl);
    
}

- (void) testGetAwesomeAdsEndpoint2 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationStaging];
    
    NSString *expected_baseUrl = @"https://ads.staging.superawesome.tv/v2/ad/4001";
    
    NSString *baseUrl = [loader getAwesomeAdsEndpoint:session forPlacementId:4001];
    
    XCTAssertNotNil(baseUrl);
    XCTAssertEqualObjects(expected_baseUrl, baseUrl);
    
}

- (void) testGetAwesomeAdsEndpoint3 {
    
    SALoader *loader = [[SALoader alloc] init];
    SASession *session = nil;
    
    NSString *baseUrl = [loader getAwesomeAdsEndpoint:session forPlacementId:4001];
    
    XCTAssertNil(baseUrl);
    
}

- (void) testGetAwesomeAdsQuery1 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *sesstion = [[SASession alloc] init];
    [sesstion enableTestMode];
    
    int expected_keys = 9;
    BOOL expected_test = true;
    NSString *expected_sdkVersion = @"0.0.0";
    NSString *expected_bundle = @"org.cocoapods.demo.SAAdLoader-Example";
    NSString *expected_name = @"SAAdLoader_Example";
    int expected_ct = wifi;
    
    NSDictionary *query = [loader getAwesomeAdsQuery:sesstion];
    
    XCTAssertNotNil(query);
    XCTAssertEqual(expected_keys, [query count]);
    
    XCTAssertNotNil(query[@"test"]);
    XCTAssertEqual(expected_test, [query[@"test"] boolValue]);
    
    XCTAssertNotNil(query[@"sdkVersion"]);
    XCTAssertEqualObjects(expected_sdkVersion, query[@"sdkVersion"]);
    
    XCTAssertNotNil(query[@"rnd"]);
    
    XCTAssertNotNil(query[@"bundle"]);
    XCTAssertEqualObjects(expected_bundle, query[@"bundle"]);
    
    XCTAssertNotNil(query[@"name"]);
    XCTAssertEqualObjects(expected_name, query[@"name"]);
    
    XCTAssertNotNil(query[@"dauid"]);
    
    XCTAssertNotNil(query[@"ct"]);
    XCTAssertEqual(expected_ct, [query[@"ct"] intValue]);
    
    XCTAssertNotNil(query[@"lang"]);
    XCTAssertNotNil(query[@"device"]);
    
}

- (void) testGetAwesomeAdsQuery2 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = [[SASession alloc] init];
    [session disableTestMode];
    
    int expected_keys = 9;
    BOOL expected_test = false;
    NSString *expected_sdkVersion = @"0.0.0";
    NSString *expected_bundle = @"org.cocoapods.demo.SAAdLoader-Example";
    NSString *expected_name = @"SAAdLoader_Example";
    int expected_ct = wifi;
    
    NSDictionary *query = [loader getAwesomeAdsQuery:session];
    
    XCTAssertNotNil(query);
    XCTAssertEqual(expected_keys, [query count]);
    
    XCTAssertNotNil(query[@"test"]);
    XCTAssertEqual(expected_test, [query[@"test"] boolValue]);
    
    XCTAssertNotNil(query[@"sdkVersion"]);
    XCTAssertEqualObjects(expected_sdkVersion, query[@"sdkVersion"]);
    
    XCTAssertNotNil(query[@"rnd"]);
    
    XCTAssertNotNil(query[@"bundle"]);
    XCTAssertEqualObjects(expected_bundle, query[@"bundle"]);
    
    XCTAssertNotNil(query[@"name"]);
    XCTAssertEqualObjects(expected_name, query[@"name"]);
    
    XCTAssertNotNil(query[@"dauid"]);
    
    XCTAssertNotNil(query[@"ct"]);
    XCTAssertEqual(expected_ct, [query[@"ct"] intValue]);
    
    XCTAssertNotNil(query[@"lang"]);
    XCTAssertNotNil(query[@"device"]);
    
}

- (void) testGetAwesomeAdsQuery3 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = nil;
    
    int expected_keys = 9;
    BOOL expected_test = false;
    NSString *expected_sdkVersion = @"0.0.0";
    NSString *expected_bundle = @"unknown";
    NSString *expected_name = @"unknown";
    int expected_ct = unknown;
    
    NSDictionary *query = [loader getAwesomeAdsQuery:session];
    
    XCTAssertNotNil(query);
    XCTAssertEqual(expected_keys, [query count]);
    
    XCTAssertNotNil(query[@"test"]);
    XCTAssertEqual(expected_test, [query[@"test"] boolValue]);
    
    XCTAssertNotNil(query[@"sdkVersion"]);
    XCTAssertEqualObjects(expected_sdkVersion, query[@"sdkVersion"]);
    
    XCTAssertNotNil(query[@"rnd"]);
    
    XCTAssertNotNil(query[@"bundle"]);
    XCTAssertEqualObjects(expected_bundle, query[@"bundle"]);
    
    XCTAssertNotNil(query[@"name"]);
    XCTAssertEqualObjects(expected_name, query[@"name"]);
    
    XCTAssertNotNil(query[@"dauid"]);
    
    XCTAssertNotNil(query[@"ct"]);
    XCTAssertEqual(expected_ct, [query[@"ct"] intValue]);
    
    XCTAssertNotNil(query[@"lang"]);
    XCTAssertNotNil(query[@"device"]);
    
}

- (void) testGetAwesomeAdsHeader1 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = [[SASession alloc] init];
    
    NSDictionary *header = [loader getAwesomeAdsHeader:session];
    
    int expected_keys = 2;
    NSString *expected_Content_Type = @"application/json";
    NSString *expected_User_Agent = [session getUserAgent];
    
    XCTAssertNotNil(header);
    XCTAssertEqual(expected_keys, [header count]);
    
    XCTAssertNotNil(header[@"Content-Type"]);
    XCTAssertEqualObjects(expected_Content_Type, header[@"Content-Type"]);
    
    XCTAssertNotNil(header[@"User-Agent"]);
    XCTAssertEqualObjects(expected_User_Agent, header[@"User-Agent"]);
}

- (void) testGetAwesomeAdsHeader2 {
    
    SALoader *loader = [[SALoader alloc] init];
    
    SASession *session = nil;
    
    NSDictionary *header = [loader getAwesomeAdsHeader:session];
    
    int expected_keys = 2;
    NSString *expected_Content_Type = @"application/json";
    NSString *expected_User_Agent = @"";
    
    XCTAssertNotNil(header);
    XCTAssertEqual(expected_keys, [header count]);
    
    XCTAssertNotNil(header[@"Content-Type"]);
    XCTAssertEqualObjects(expected_Content_Type, header[@"Content-Type"]);
    
    XCTAssertNotNil(header[@"User-Agent"]);
    XCTAssertEqualObjects(expected_User_Agent, header[@"User-Agent"]);
    
}

@end
