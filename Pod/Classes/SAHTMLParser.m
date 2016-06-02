//
//  SAFormatter.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 12/10/2015.
//
//

// import header
#import "SAHTMLParser.h"

// import modelspace
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import juciy aux functions
#import "SAUtils.h"

// import SA class
// #import "SuperAwesome.h"

@implementation SAHTMLParser

+ (NSString*) formatCreativeDataIntoAdHTML:(SAAd*)ad {
    
    switch (ad.creative.creativeFormat) {
        case image:{
            return [self formatCreativeIntoImageHTML:ad];
            break;
        }
        case video:{
            return nil;
            break;
        }
        case rich:{
            return [self formatCreativeIntoRichMediaHTML:ad];
            break;
        }
        case tag:{
            return [self formatCreativeIntoTagHTML:ad];
            break;
        }
        case invalid:
        default:{
            return nil;
            break;
        }
    }
}

+ (NSString*) formatCreativeIntoImageHTML:(SAAd*)ad {
    
    NSMutableString *htmlString = [[NSMutableString alloc] init];
    [htmlString appendString:@"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"/>"];
    [htmlString appendString:@"<meta name='viewport' content='width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no' />"];
    [htmlString appendString:@"<title>SuperAwesome Image Template</title>"];
    [htmlString appendString:@"<style>html, body, div { margin: 0px; padding: 0px; width: 100%; height: 100%; overflow: hidden; background-color: #efefef; }</style>"];
    [htmlString appendString:@"</head><body><a href='hrefURL'><img id='image' src='imageURL'/></a></body></html>"];
    
    // return the parametrized template
    NSString *click = (ad.creative.clickUrl ? ad.creative.clickUrl : ad.creative.trackingUrl);
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"hrefURL" withString:click];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"imageURL" withString:ad.creative.details.image];
    return htmlString;
}

+ (NSString*) formatCreativeIntoRichMediaHTML:(SAAd*)ad {
    
    NSMutableString *htmlString = [[NSMutableString alloc] init];
    [htmlString appendString:@"<!DOCTYPE html><html><head>"];
    [htmlString appendString:@"<meta name='viewport' content='width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no, target-densitydpi=device-dpi'/>"];
    [htmlString appendString:@"<title>SuperAwesome Rich Media Template</title>"];
    [htmlString appendString:@"<style>html, body, iframe { width: 100%; height: 100%; padding: 0; margin: 0; border: 0; background-color: #efefef; overflow: hidden; }</style>"];
    [htmlString appendString:@"</head><body><iframe src='richMediaURL'></iframe></body></html>"];
    
    // format template parameters
    NSMutableString *richMediaString = [[NSMutableString alloc] init];
    [richMediaString appendString:ad.creative.details.url];
    
    NSDictionary *richMediaDict = @{
        @"placement":[NSNumber numberWithInteger:ad.placementId],
        @"line_item":[NSNumber numberWithInteger:ad.lineItemId],
        @"creative":[NSNumber numberWithInteger:ad.creative._id],
        @"rnd":[NSNumber numberWithInteger:[SAUtils getCachebuster]]
    };
    [richMediaString appendString:@"?"];
    [richMediaString appendString:[SAUtils formGetQueryFromDict:richMediaDict]];
    
    // return the parametrized template
    NSString *richString = [htmlString stringByReplacingOccurrencesOfString:@"richMediaURL" withString:richMediaString];
    
    richString = [richString stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    return richString;
}

+ (NSString*) formatCreativeIntoTagHTML:(SAAd*)ad {
    
    NSMutableString *htmlString = [[NSMutableString alloc] init];
    [htmlString appendString:@"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"/>"];
    [htmlString appendString:@"<title>SuperAwesome 3rd Party Tag Template</title>"];
    [htmlString appendString:@"<meta name=\"viewport\" content=\"width=device-width, initial-scale=_PARAM_SCALE_, maximum-scale=_PARAM_SCALE_, user-scalable=no, target-densitydpi=device-dpi\"/>"];
    [htmlString appendString:@"<style>"];
    [htmlString appendString:@"html, body { width: _WIDTH_px; height: _HEIGHT_px; padding: 0; margin: 0; border: 0; background-color: #efefef; }"];
    [htmlString appendString:@"* { width: 100%; height: 100%; }"];
    [htmlString appendString:@"</style>"];
    [htmlString appendString:@"</head><body>tagdata</body></html>"];
    
    // format template parameters
    NSString *tagString = ad.creative.details.tag;
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click]" withString:[NSString stringWithFormat:@"%@&redir=",ad.creative.trackingUrl]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[click_enc]" withString:[SAUtils encodeURI:ad.creative.trackingUrl]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[keywords]" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"[timestamp]" withString:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"target=\"_blank\"" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tagString = [tagString stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    
    NSString *html = [htmlString stringByReplacingOccurrencesOfString:@"tagdata" withString:tagString];
    html = [html stringByReplacingOccurrencesOfString:@"\/" withString:@"/"];
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    
    // return the parametrized template
    return html;
}

@end
