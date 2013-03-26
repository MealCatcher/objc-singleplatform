//
//  SinglePlatform.m
//  singleplatformsdk
//
//  Created by Jorge Astorga on 3/22/13.
//  Copyright (c) 2013 Jorge Astorga. All rights reserved.
//

#import "SinglePlatform.h"

NSString * const kSinglePlatformBaseURL = @"http://api.singleplatform.co";

@implementation SinglePlatform

+(instancetype)client
{
    static dispatch_once_t onceToken;
    static SinglePlatform *client;
    dispatch_once(&onceToken, ^{
        client = [[SinglePlatform alloc] initWithBaseURL:[NSURL URLWithString:kSinglePlatformBaseURL]];
    });
    return client;
}


-(void)setAPIKey:(NSString *)apiKey
{
    NSParameterAssert(apiKey);
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:@"api" password:apiKey];
}



@end
