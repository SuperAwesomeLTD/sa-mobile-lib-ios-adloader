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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/imagead.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
       
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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/richmediaad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/tagad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/videoad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/appwallad.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
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
    
    NSString *adUrl = @"https://raw.githubusercontent.com/SuperAwesomeLTD/sa-mobile-lib-android-adloader/master/samples/videoad2.json";
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:adUrl withQuery:@{} andHeader:@{} andPlacementId:100 andSession:session andResult:^(SAResponse *response) {
        
        [expectation fulfill];
        
    }];
    
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}


@end
