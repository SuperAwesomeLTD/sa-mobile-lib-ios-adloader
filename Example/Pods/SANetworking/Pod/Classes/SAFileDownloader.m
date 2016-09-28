//
//  SAFileDownloader.m
//  Pods
//
//  Created by Gabriel Coman on 18/04/2016.
//
//

#import "SAFileDownloader.h"

// callback for iOS's own [NSURLConnection sendAsynchronousRequest:]
typedef void (^locationResponse)(NSURL * location, NSURLResponse * response, NSError * error);


static BOOL runOnce = false;

//
// private vars for SAFileDownloader
@interface SAFileDownloader ()
// dictionary that holds all the files currently saved on disk as part of the SDK
//@property (nonatomic, strong) NSMutableDictionary *fileStore;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSUserDefaults *defs;
@end

//
// actual implementation of SAFileDownloader
@implementation SAFileDownloader

#pragma mark Singleton & Constructor functions

- (id) init {
    if (self = [super init]) {
        // get user defaults and file manager
        _defs = [NSUserDefaults standardUserDefaults];
        _fileManager = [NSFileManager defaultManager];
        
        // do a preliminary cleanup
        if (!runOnce) {
            runOnce = true;
            [self cleanup];
        }
    }
    
    return self;
}

#pragma mark Main Public functions

+ (NSString*) getDiskLocation: (NSString*)extension {
    return [NSString stringWithFormat:@"samov_%d.%@", arc4random_uniform((uint32_t)(65536)), extension];
}

- (void) downloadFileFrom:(NSString*)url to:(NSString*)fpath withResponse:(downloadResponse)response {
    
    // form the URL & request
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:URL];
    [request setHTTPMethod:@"GET"];
    
    locationResponse resp2 = ^(NSURL * location, NSURLResponse * httpresponse, NSError * error) {
        NSInteger statusCode = ((NSHTTPURLResponse*)httpresponse).statusCode;
        
        // check for whatever error
        if (error != NULL || statusCode != 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"[false] | FILE GET | 0 | %@ ==> %@", url, fpath);
                if (response) {
                    response(false);
                }
            });
        }
        // goto success
        else {
            NSString *fullFilePath = [self filePathInDocuments:fpath];
            NSString *key = [NSString stringWithFormat:@"sasdkkey_%@", [self getKeyFromLocation:fpath]];
            NSError *fileError = NULL;
            NSURL *destURL = [NSURL fileURLWithPath:fullFilePath];
            [_fileManager moveItemAtURL:location toURL:destURL error:&fileError];
            
            if (fileError == NULL || key == NULL) {
                // save
                [_defs setObject:fpath forKey:key];
                [_defs synchronize];
                
                // call success
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"[true] | FILE GET | 200 | %@ ==> %@", url, fpath);
                    if (response) {
                        response(true);
                    }
                });
                
            }
            // failure to write file
            else {
                // call success
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"[false] | FILE GET | 0 | %@ ==> %@", url, fpath);
                    if (response) {
                        response(false);
                    }
                });
            }
        }
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:resp2];
    [task resume];
}

#pragma mark Private Functions

- (NSString*) getKeyFromLocation:(NSString*)location {
    if (!location) return NULL;
    NSArray *c1 = [location componentsSeparatedByString:@"_"];
    if ([c1 count] < 2) return NULL;
    NSString *key1 = [c1 objectAtIndex:1];
    NSArray *c2 = [key1 componentsSeparatedByString:@"."];
    if ([c2 count] < 1) return NULL;
    return [c2 firstObject];
}

- (void) cleanup {
    
    NSMutableArray<NSString*> *keysToDel = [@[] mutableCopy];
    
    for (NSString *key in [[_defs dictionaryRepresentation] allKeys]) {
        if ([key rangeOfString:@"sasdkkey_"].location != NSNotFound) {
            NSString *filePath = [_defs objectForKey:key];
            NSString *fullFilePath = [self filePathInDocuments:filePath];
            if ([_fileManager fileExistsAtPath:fullFilePath] && [_fileManager isDeletableFileAtPath:fullFilePath]) {
                [_fileManager removeItemAtPath:fullFilePath error:nil];
                NSLog(@"[true] | DEL | %@", filePath);
            } else {
                NSLog(@"[false] | DEL | %@", filePath);
            }
            
            [keysToDel addObject:key];
        }
    }
    
    for (NSString* key in keysToDel) {
        [_defs removeObjectForKey:key];
    }
    [_defs synchronize];
}

// MARK: Private

- (NSString *) getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    return basePath;
}

- (NSString*) filePathInDocuments:(NSString*)fpath {
    return [[self getDocumentsDirectory] stringByAppendingPathComponent:fpath];
}

@end
