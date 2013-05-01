//
//  ViewController.m
//  singleplatformsdk
//
//  Created by Jorge Astorga on 3/22/13.
//  Copyright (c) 2013 Jorge Astorga. All rights reserved.
//

#import "ViewController.h"
#import "SinglePlatform.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
       NSMutableString *api = [[NSMutableString alloc] initWithString:@"coad3k62n95pi9sbybjydroxy"];
    NSMutableString *client = [[NSMutableString alloc] initWithString:@"coad3k62n95pi9sbybjydroxy"];
    NSMutableString *sign = [[NSMutableString alloc] initWithString:@"Sw3j7scIBviRMWBtLQ5jYsE1JnmgxA41hbrxQeQwfcw"];
    SinglePlatform *spClient = [SinglePlatform clientWithApiKey:api withClientId:client withSecret:sign];
    
    [spClient restaurantSearch:@"boot"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
