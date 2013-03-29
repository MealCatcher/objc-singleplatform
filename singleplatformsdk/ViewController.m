//
//  ViewController.m
//  singleplatformsdk
//
//  Created by Jorge Astorga on 3/22/13.
//  Copyright (c) 2013 Jorge Astorga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SinglePlatform *sp = [SinglePlatform client];
    [sp setClientID:@"coad3k62n95pi9sbybjydroxy"];
    [sp setSecret:@"Sw3j7scIBviRMWBtLQ5jYsE1JnmgxA41hbrxQeQwfcw"];
    [sp setApiKey:@"kcz006fl85dbvocyf7m8i8n6f"];
    
    //[sp searchLocations:@"85390"];
    [sp searchLocations:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
