//
//  SAAdLoader_Header_Tests.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 01/03/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SALoader.h"
#import "SASession.h"
#import "SAUtils.h"

@interface SAAdLoader_Header_Tests : XCTestCase

@end

@implementation SAAdLoader_Header_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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
    
    int expected_keys = 0;
    
    XCTAssertNotNil(header);
    XCTAssertEqual(expected_keys, [header count]);
}

@end
