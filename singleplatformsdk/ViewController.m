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
    
    /*[[SinglePlatform client] getPath:@"restaurants/search?q=boot&client=coad3k62n95pi9sbybjydroxy&sig=3OgyqDjn0w9aySO_Z2zIrKHHi1o"
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 NSLog(@"Success");
                                 NSLog(@"Response: %@", responseObject);
                                 NSMutableArray *results = [NSMutableArray array];
                                 for(id resultsDictionary in responseObject)
                                 {
                                     
                                 }
                                
    }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Did not work");
    }];*/
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
