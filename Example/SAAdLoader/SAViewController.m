//
//  SAViewController.m
//  SAAdLoader
//
//  Created by Gabriel Coman on 06/02/2016.
//  Copyright (c) 2016 Gabriel Coman. All rights reserved.
//

#import "SAViewController.h"
#import "SALoader.h"
#import "SASession.h"
#import "SAResponse.h"
#import "SAAd.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    SALoader *loader = [[SALoader alloc] init];
//     [loader loadAd:251 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"Loaded Ad 251");
//    }];
    
//    [loader loadAd:470 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"Loaded Ad 470");
//    }];
    
//    [loader loadAd:480 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"Loaded Ad 480");
//    }];
    
//    [loader loadAd:481 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"Loaded Ad #1 481");
//    }];
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    [session disableTestMode];
    
//    [loader loadAd:28000 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"%@", [response jsonPreetyStringRepresentation]);
//    }];
    
    [session setConfigurationStaging];
    [session disableTestMode];
    
//    [loader loadAd:544 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"%@", [response jsonPreetyStringRepresentation]);
//    }];
    
    [loader loadAd:437 withSession:session andResult:^(SAResponse *response) {
        NSLog(@"%@", [response jsonPreetyStringRepresentation]);
    }];
    
//    [loader loadAd:250 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"%@", [response jsonPreetyStringRepresentation]);
//    }];
//    
//    [loader loadAd:252 withSession:session andResult:^(SAResponse *response) {
//        NSLog(@"%@", [response jsonPreetyStringRepresentation]);
//    }];
    
//    [[SASession getInstance] setConfigurationStaging];
//    [[SASession getInstance] setTest:false];
//    
//    SALoader *loader = [[SALoader alloc] init];
//    [loader loadAd:251 withResult:^(SAAd *ad) {
//        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
//    }];
//    [loader loadAd:250 withResult:^(SAAd *ad) {
//        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
//    }];
//    [loader loadAd:252 withResult:^(SAAd *ad) {
//        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
