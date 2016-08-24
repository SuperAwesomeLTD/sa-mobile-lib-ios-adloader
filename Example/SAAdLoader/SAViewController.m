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
#import "SAAd.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[SASession getInstance] setConfigurationStaging];
    [[SASession getInstance] setTest:false];
    
    SALoader *loader = [[SALoader alloc] init];
    [loader loadAd:251 withResult:^(SAAd *ad) {
        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
    }];
    [loader loadAd:250 withResult:^(SAAd *ad) {
        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
    }];
    [loader loadAd:252 withResult:^(SAAd *ad) {
        NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
