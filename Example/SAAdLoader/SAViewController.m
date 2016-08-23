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

@interface SAViewController () <SALoaderProtocol>

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[SASession getInstance] setConfigurationStaging];
    [[SASession getInstance] setTest:false];
    
    SALoader *loader = [[SALoader alloc] init];
    loader.delegate = self;
    [loader loadAdForPlacementId:251];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didLoadAd:(SAAd *)ad {
    NSLog(@"%@", [ad jsonPreetyStringRepresentation]);
}

- (void) didFailToLoadAdForPlacementId:(NSInteger)placementId {
    NSLog(@"Failed to load %ld", (long)placementId);
}

@end
