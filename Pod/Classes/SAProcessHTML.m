/**
 * @Copyright:   SuperAwesome Trading Limited 2017
 * @Author:      Gabriel Coman (gabriel.coman@superawesome.tv)
 */

#import "SAProcessHTML.h"

#if defined(__has_include)
#if __has_include(<SAModelSpace/SAAd.h>)
#import <SAModelSpace/SAAd.h>
#else
#import "SAAd.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAModelSpace/SACreative.h>)
#import <SAModelSpace/SACreative.h>
#else
#import "SACreative.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAModelSpace/SADetails.h>)
#import <SAModelSpace/SADetails.h>
#else
#import "SADetails.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAModelSpace/SAMedia.h>)
#import <SAModelSpace/SAMedia.h>
#else
#import "SAMedia.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAUtils/SAUtils.h>)
#import <SAUtils/SAUtils.h>
#else
#import "SAUtils.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAUtils/SAExtensions.h>)
#import <SAUtils/SAExtensions.h>
#else
#import "SAExtensions.h"
#endif
#endif

@implementation SAProcessHTML

+ (NSString*) formatCreativeIntoImageHTML:(SAAd*) ad {
    
    // the html string
    NSString *htmlString = @"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"/><html><header><style>html, body, div { margin: 0px; padding: 0px; width: 100%; height: 100%; overflow: hidden; background-color: #efefef; }</style></header><body>_CONTENT_</body></html>";
    // the img string
    NSString *imgString = @"<a href='hrefURL'><img src='imageURL'/></a>_MOAT_";
    
    // do the replacement
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"_CONTENT_" withString:imgString];
    
    // determine the Click URL
    NSString *click = ad.creative.clickUrl;
    
    if (!click) {
        NSArray *potentialClicks = [ad.creative.events filterBy:@"event" withValue:@"sa_tracking"];
        if ([potentialClicks count] > 1) {
            click = [potentialClicks objectAtIndex:0];
        }
    }
    
    // set click
    if (click != nil) {
        htmlString = [[htmlString stringByReplacingOccurrencesOfString:@"hrefURL" withString:click] mutableCopy];
    }
    // set image
    if (ad.creative.details.image) {
        htmlString = [[htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:ad.creative.details.image] mutableCopy];
    }
    return htmlString;
}

+ (NSString*) formatCreativeIntoRichMediaHTML:(SAAd*) ad {
    
    // the html string
    NSString *htmlString = @"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"/><html><header><style>html, body, div { margin: 0px; padding: 0px; width: 100%; height: 100%; overflow: hidden; background-color: #efefef; }</style></header><body>_CONTENT_</body></html>";
    // the img string
    NSString *rmString = @"<iframe src='richMediaURL'></iframe>_MOAT_";
    
    // do the replacement
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"_CONTENT_" withString:rmString];
    
    // format template parameters
    NSMutableString *richMediaString = [@"" mutableCopy];
    [richMediaString appendString:ad.creative.details.url];
    
    NSDictionary *richMediaDict = @{
        @"placement":@(ad.placementId),
        @"line_item":@(ad.lineItemId),
        @"creative":@(ad.creative._id),
        @"rnd":[NSNumber numberWithInteger:[SAUtils getCachebuster]]
    };
    [richMediaString appendString:@"?"];
    [richMediaString appendString:[SAUtils formGetQueryFromDict:richMediaDict]];
    
    // return the parametrized template
    NSString *richString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:richMediaString];
    
    richString = [richString stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    return richString;
}

+ (NSString*) formatCreativeIntoTagHTML:(SAAd*) ad {
    
    // the html string
    NSString *htmlString = @"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"/><html><header><style>html, body, div { margin: 0px; padding: 0px; width: 100%; height: 100%; overflow: hidden; background-color: #efefef; }</style></header><body>_CONTENT_</body></html>";
    // the img string
    NSString *rmString = @"tagdata_MOAT_";
    
    // do the replacement
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"_CONTENT_" withString:rmString];
    
    
    // format template parameters
    NSString *tagString = ad.creative.details.tag;
    
    NSString *click = ad.creative.clickUrl;
    
    if (!click) {
        NSArray *potentialClicks = [ad.creative.events filterBy:@"event" withValue:@"sa_tracking"];
        if ([potentialClicks count] > 1) {
            click = [potentialClicks objectAtIndex:0];
        }
    }
    
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click]" withString:[NSString stringWithFormat:@"%@&redir=", click]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click_enc]" withString:[SAUtils encodeURI:click]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[keywords]" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[timestamp]" withString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"target=\"_blank\"" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    
    NSString *html = [htmlString stringByReplacingOccurrencesOfString:@"tagdata" withString:tagString];
    // html = [html stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
    html = [html stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    
    // return the parametrized template
    return html;
}

@end
