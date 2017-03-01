//
//  SAAdLoader_Query_Tests.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 01/03/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SALoader.h"
#import "SASession.h"
#import "SAUtils.h"

@interface SAAdLoader_Query_Tests : XCTestCase

@end

@implementation SAAdLoader_Query_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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
    
    int expected_keys = 0;
    
    NSDictionary *query = [loader getAwesomeAdsQuery:session];
    
    XCTAssertNotNil(query);
    XCTAssertEqual(expected_keys, [query count]);
}

@end
