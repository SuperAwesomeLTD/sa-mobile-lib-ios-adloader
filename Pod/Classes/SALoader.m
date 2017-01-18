/**
 * @Copyright:   SuperAwesome Trading Limited 2017
 * @Author:      Gabriel Coman (gabriel.coman@superawesome.tv)
 */

#import "SALoader.h"
#import "SAProcessHTML.h"
#import "SAProcessEvents.h"

#if defined(__has_include)
#if __has_include(<SAModelSpace/SAResponse.h>)
#import <SAModelSpace/SAResponse.h>
#else
#import "SAResponse.h"
#endif
#endif

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
#if __has_include(<SAModelSpace/SAVASTAd.h>)
#import <SAModelSpace/SAVASTAd.h>
#else
#import "SAVASTAd.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAModelSpace/SAVASTMedia.h>)
#import <SAModelSpace/SAVASTMedia.h>
#else
#import "SAVASTMedia.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SASession/SASession.h>)
#import <SASession/SASession.h>
#else
#import "SASession.h"
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
#if __has_include(<SANetworking/SANetwork.h>)
#import <SANetworking/SANetwork.h>
#else
#import "SANetwork.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SAVASTParser/SAVASTParser.h>)
#import <SAVASTParser/SAVASTParser.h>
#else
#import "SAVASTParser.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SANetworking/SAFileDownloader.h>)
#import <SANetworking/SAFileDownloader.h>
#else
#import "SAFileDownloader.h"
#endif
#endif

#if defined(__has_include)
#if __has_include(<SANetworking/SAFileListDownloader.h>)
#import <SANetworking/SAFileListDownloader.h>
#else
#import "SAFileListDownloader.h"
#endif
#endif

@interface SALoader ()
@end

@implementation SALoader

- (NSString*) getAwesomeAdsEndpoint: (SASession*) session
                forPlacementId:(NSInteger) placementId {
    
    if (session) {
        return [NSString stringWithFormat:@"%@/ad/%ld",
                [session getBaseUrl],
                (long) placementId];
    } else {
        return nil;
    }
}


- (NSDictionary*) getAwesomeAdsQuery: (SASession*) session {
    return @{@"test": @(session ? [session getTestMode] : false),
             @"sdkVersion":session ? [session getVersion] : @"0.0.0",
             @"rnd":@(session ? [session getCachebuster] : [SAUtils randomNumberBetween:1000000 maxNumber:1500000]),
             @"ct":@(session ? [session getConnectivityType] : unknown),
             @"bundle":session ? [session getBundleId] : @"unknown",
             @"name":session ? [session getAppName] : @"unknown",
             @"dauid":@(session ? [session getDauId] : 0),
             @"lang": session ? [session getLang] : @"unknown",
             @"device": session ? [session getDevice] : @"phone"
             // @"preload": @(true)
             };
}

- (NSDictionary*) getAwesomeAdsHeader: (SASession*) session {
    return @{@"Content-Type":@"application/json",
             @"User-Agent":session ? [session getUserAgent] : @""};
}

- (void) loadAd:(NSInteger) placementId
    withSession:(SASession *) session
      andResult:(saDidLoadAd) result  {
    
    NSDictionary *query = [self getAwesomeAdsQuery:session];
    NSDictionary *header = [self getAwesomeAdsHeader:session];
    NSString *endpoint = [self getAwesomeAdsEndpoint:session
                                      forPlacementId:placementId];
    
    [self loadAd:endpoint
       withQuery:query
       andHeader:header
  andPlacementId:placementId
      andSession:session
       andResult:result];
}

- (void) loadAd:(NSString*) endpoint
      withQuery:(NSDictionary*) query
      andHeader:(NSDictionary*) header
 andPlacementId:(NSInteger) placementId
     andSession:(SASession*) session
      andResult:(saDidLoadAd) result {
    
    // make sure the local result is never nil
    __block saDidLoadAd localResult = result ? result : ^(SAResponse* response){};
    
    // send a network request
    SANetwork *network = [[SANetwork alloc] init];
    [network sendGET:endpoint withQuery:query andHeader:header withResponse:^(NSInteger status, NSString *data, BOOL success) {
        
        // create a new object of type SAResponse
        __block SAResponse *response = [[SAResponse alloc] init];
        response.placementId = placementId;
        response.status = status;
        
        // error case, just bail out with a non-null invalid response
        if (!success || data == nil) {
            localResult (response);
        }
        // good case, continue trying to figure out what kind of ad this is
        else {
            
            NSDictionary *jsonDict = [[NSDictionary alloc] initWithJsonString:data];
            NSArray *jsonArray = [NSArray arrayWithJsonString:data andIterator:^id(id item) {
                return item;
            }];
            
            // Normal Ad case
            if (jsonDict != nil && [jsonDict count] > 0) {
                
                // parse the final ad
                __block SAAd *ad = [[SAAd alloc] initWithJsonDictionary:jsonDict];
                ad.placementId = placementId;
                // add events
                [SAProcessEvents addAdEvents:ad forSession:session];
                
                // update type in response as well
                response.format = ad.creative.format;
                [response.ads addObject:ad];
                
                switch (ad.creative.format) {
                    // in this case return whatever we have at this moment
                    case SA_Invalid: {
                        localResult (response);
                        break;
                    }
                    // in this case process the HTML and return the response
                    case SA_Image: {
                        ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoImageHTML:ad];
                        localResult (response);
                        break;
                    }
                    case SA_Rich:{
                        ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoRichMediaHTML:ad];
                        localResult (response);
                        break;
                    }
                    case SA_Tag:{
                        ad.creative.details.media.html = [SAProcessHTML formatCreativeIntoTagHTML:ad];
                        localResult (response);
                        break;
                    }
                    case SA_Video:{
                        SAVASTParser *parser = [[SAVASTParser alloc] init];
                        [parser parseVAST:ad.creative.details.vast withResponse:^(SAVASTAd *savastAd) {
                            
                            // copy the vast media
                            ad.creative.details.media.playableMediaUrl = savastAd.mediaUrl;
                            // copy the vast events
                            [ad.creative.events addObjectsFromArray:savastAd.vastEvents];
                            // download file
                            [[SAFileDownloader getInstance] downloadFileFrom:ad.creative.details.media.playableMediaUrl andResponse:^(BOOL success, NSString *diskPath) {
                                
                                // add final details
                                ad.creative.details.media.playableDiskUrl = diskPath;
                                ad.creative.details.media.isOnDisk = diskPath != nil;
                                
                                // finally respond 
                                localResult (response);
                                
                            }];
                            
                        }];
                        break;
                    }
                }
                
            }
            // ÅppWall case
            else if (jsonArray != nil && [jsonArray count] > 0) {
                
                // set response correct format
                response.format = SA_Appwall;
                
                // add ads to it
                for (int i = 0; i < [jsonArray count]; i++) {
                    
                    // get the object at index "i"
                    id dict = [jsonArray objectAtIndex:i];
                    
                    // only if it's a valid dictionary
                    if ([dict isKindOfClass:[NSDictionary class]]) {
                        
                        SAAd *ad = [[SAAd alloc] initWithJsonDictionary:dict];
                        ad.placementId = placementId;
                        [SAProcessEvents addAdEvents:ad forSession:session];
                        
                        // only add image type ads - no rich media or videos in the
                        // GameWall for now
                        if (ad.creative.format == SA_Image) {
                            [response.ads addObject:ad];
                            ad.creative.format = SA_Appwall;
                        }
                    }
                }
                
                // add all the images that'll need to be downloaded
                NSMutableArray<NSString*> *filesToDownload = [@[] mutableCopy];
                for (SAAd *ad in response.ads) {
                    [filesToDownload addObject:ad.creative.details.image];
                }
                
                // use the file list downloader to download them in the same
                // correct order
                SAFileListDownloader *fileListDownloader = [[SAFileListDownloader alloc] init];
                [fileListDownloader downloadListOfFiles:filesToDownload withResponse:^(NSArray<NSString *> *diskLocations) {
                   
                    for (int i = 0; i < [diskLocations count]; i++) {
                        
                        NSString *diskUrl = [diskLocations objectAtIndex:i];
                        SAAd *cAd = [response.ads objectAtIndex:i];
                        cAd.creative.details.media.playableMediaUrl = cAd.creative.details.image;
                        cAd.creative.details.media.playableDiskUrl = diskUrl;
                        cAd.creative.details.media.isOnDisk = diskUrl != nil;
                        
                    }
                    
                    // and finally send a response
                    localResult (response);
                    
                }];
                
            }
            // it's not a normal ad or an app wall, then return
            else {
                localResult (response);
            }
        }
    }];
}

@end
