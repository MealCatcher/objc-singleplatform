//
//  SinglePlatform.h
//  singleplatformsdk
//
//  Created by Jorge Astorga on 3/22/13.
//  Copyright (c) 2013 Jorge Astorga. All rights reserved.
//


#if !__has_feature(objc_arc)
#error SinglePlatform must be built with ARC
// You can turn on ARC by adding -fobj-arc on the build phases tab for each of its files
#endif

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPClient.h>
#import <Foundation/Foundation.h>

@interface SinglePlatform : AFHTTPClient


@property (nonatomic, strong)NSString *apiKey;
@property (nonatomic, strong)NSString *clientId;
@property (nonatomic, strong)NSMutableString *signingKey;

+(id)client;
+(id)clientWithApiKey:(NSString *)apiKey withClientId:(NSString *)clientId withSecret:(NSMutableString *)signingKey;

//-(void)setAPIKey:(NSString *)apiKey;
-(void)restaurantSearch:(NSString *)searchTerm;


@end
