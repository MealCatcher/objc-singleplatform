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
    
    NSLog(@"Base URL: %@", [sp baseURL]);
    NSURL *locationsURL = [NSURL URLWithString:@"/restaurants/search" relativeToURL:[sp baseURL]];
    NSLog(@"Locations URL: %@", [locationsURL absoluteString]);
    NSLog(@"Host: %@", [locationsURL host]);
    NSLog(@"Last Path Component: %@", [locationsURL lastPathComponent]);
    NSLog(@"Path: %@", [locationsURL path]);
    NSLog(@"Query: %@", [locationsURL query]);
    
    
    NSMutableString *testURL = [[NSMutableString alloc]initWithString:[[sp baseURL] description]];
    NSString *signedURL = [sp signURL:testURL signingKey:[[NSMutableString alloc] initWithString:[sp secret]]];
    NSLog(@"Signed URL: %@", signedURL);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"85390" forKey:@"q"];
    [parameters setValue:[sp clientID] forKey:@"client"];
   
    
    NSURLRequest *myRequest = [sp requestWithMethod:@"GET" path:[locationsURL absoluteString] parameters:parameters];
    NSLog(@"Aboslute String: %@", [[myRequest URL] absoluteString]);
    NSString *as = [[NSString alloc] initWithFormat:@"%@?%@", [[myRequest URL] path] ,[[myRequest URL] query]];//[[myRequest URL] query];
    NSLog(@"The new path: %@", as);
    NSMutableString *testing = [NSMutableString stringWithString:as];
    
    NSString *newSignature = [sp signURL:testing signingKey:[[NSMutableString alloc] initWithString:[sp secret]]];
    NSLog(@"New Signature: %@", newSignature);
    NSLog(@"Request URL: %@", [myRequest description]);
    
    
    [parameters setValue:newSignature forKey:@"sig"];
    
    NSURLRequest *newRequest = [sp requestWithMethod:@"GET" path:[locationsURL absoluteString] parameters:parameters];
    NSLog(@"Test URL: %@", [newRequest description]);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:newRequest
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSLog(@"Test Stream: %@", JSON);} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             NSLog(@"Something happened");
                                             NSLog(@"Error: %@", [error localizedDescription]);
                                         }];
    NSLog(@"Got here!");
    [operation start];
    NSLog(@"Got here!");
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
