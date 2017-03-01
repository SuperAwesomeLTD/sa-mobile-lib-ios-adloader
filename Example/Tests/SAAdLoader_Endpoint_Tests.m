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

@end
