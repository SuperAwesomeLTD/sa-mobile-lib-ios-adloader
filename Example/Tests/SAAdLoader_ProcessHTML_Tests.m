//
//  SASAAdLoader_ProcessHTML_Tests.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 18/01/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"
#import "SAMedia.h"
#import "SAProcessHTML.h"

@interface SAAdLoader_ProcessHTML_Tests : XCTestCase
@end

@implementation SAAdLoader_ProcessHTML_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testProcessImage {

    SAAd *ad = [[SAAd alloc] init];
    ad.creative.format = SA_Image;
    ad.creative.details.image = @"https://ads.superawesome.tv/v2/demo_images/320x50.jpg";
    ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoImageHTML:ad];
    
    XCTAssertNotNil(ad.creative.details.media.html);
    XCTAssertTrue([ad.creative.details.media.html containsString:@"<meta name='viewport' content='width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no' />"]);
    XCTAssertTrue([ad.creative.details.media.html containsString:@"<img id='image' src='https://ads.superawesome.tv/v2/demo_images/320x50.jpg'/>"]);
}

- (void) testProcessRichMedia {
    
    SAAd *ad = [[SAAd alloc] init];
    ad.placementId = 4091;
    ad.lineItemId = 2001;
    ad.creative._id = 2081;
    ad.creative.format = SA_Rich;
    ad.creative.details.url = @"https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html";
    ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoRichMediaHTML:ad];
    
    XCTAssertNotNil(ad.creative.details.media.html);
    XCTAssertTrue([ad.creative.details.media.html containsString:@"<meta name='viewport' content='width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no, target-densitydpi=device-dpi'/>"]);
    XCTAssertTrue([ad.creative.details.media.html containsString:@"<iframe src='https://s3-eu-west-1.amazonaws.com/sb-ads-uploads/rich-media/tNmFLJ7kGQWBbyORkIqTJ4oqykaGPU9w/rich-media/index.html?creative=2081&line_item=2001&placement=4091&rnd="]);
}

- (void) testProcessTag {
    
    SAAd *ad = [[SAAd alloc] init];
    ad.creative.format = SA_Tag;
    ad.creative.details.tag = @"<!-- Beginning PassBack for Ad unit FK:Site-Skyscraper-Passback ### size: [[120,600]] -->\\\\n\\\\t<script type='text/javascript' src='http://www.googletagservices.com/tag/js/gpt.js'>\\\\n\\\\t\\\\tgoogletag.pubads().definePassback('1002534/FK:Site-Skyscraper-Passback', [[120,600]]).display();\\\\n\\\\t</script>\\\\n<!-- End Passback -->";
    ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoTagHTML:ad];
    
    XCTAssertNotNil(ad.creative.details.media.html);
    XCTAssertTrue([ad.creative.details.media.html containsString:@"<meta charset='UTF-8'/><title>SuperAwesome 3rd Party Tag Template</title><meta name='viewport' content='width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no, target-densitydpi=device-dpi'/>"]);
    
}


@end
