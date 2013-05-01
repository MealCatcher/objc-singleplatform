//
//  SinglePlatform.m
//  singleplatformsdk
//
//  Created by Jorge Astorga on 3/22/13.
//  Copyright (c) 2013 Jorge Astorga. All rights reserved.
//

#import "SinglePlatform.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"
#import "GTMStringEncoding.h"

#import "AFJSONRequestOperation.h"

NSString * const kSinglePlatformBaseURL = @"http://api.singleplatform.co";

@implementation SinglePlatform

@synthesize apiKey;
@synthesize signingKey;
@synthesize clientId;

+(id)client
{
    static SinglePlatform *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SinglePlatform alloc] initWithBaseURL:[NSURL URLWithString:kSinglePlatformBaseURL]];
    });
    
    return _sharedClient;
}

+(id)clientWithApiKey:(NSString *)apiKey withClientId:(NSString *)clientId withSecret:(NSMutableString *)signingKey
{
    NSParameterAssert(apiKey);
    NSParameterAssert(clientId);
    NSParameterAssert(signingKey);
    
    SinglePlatform *client = [SinglePlatform client];
    client.apiKey = apiKey;
    client.clientId = clientId;
    client.signingKey = signingKey;
    
    return client;
}

-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
    {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];

    //Accept HTTP Header;
    [self setDefaultHeader:@"Accept" value:@"application/json"];

    return self;
}

-(void)restaurantSearch:(NSString *)searchTerm
{
    NSParameterAssert(searchTerm);
    
    //Sign the URL with the zip code (search term) and clientId in the URL
    //Append signature at the end
    
    NSMutableString *testURL = [[NSMutableString alloc]
                                initWithFormat:@"/restaurants/search?q=%@&client=%@",
                                searchTerm,
                                self.clientId];

    
    NSString *signature = [self signURL:testURL signingKey:self.signingKey];
    
    NSLog(@"Signature: %@", signature);

#warning This code still needs significant refactoring
    [self getPath:[[NSString alloc] initWithFormat:@"restaurants/search?q=%@&client=%@&sig=%@", searchTerm, clientId, signature]
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
                             }];


}

/* This method signs the a URL using HMAC-SHA1 and returns the signature */
-(NSString *)signURL:(NSMutableString *)url signingKey:(NSMutableString*)key
{
    [key replaceOccurrencesOfString:@"-" withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [key length])];
    
    [key replaceOccurrencesOfString:@"_" withString:@"/" options:NSLiteralSearch range:NSMakeRange(0, [key length])];
    
    // Create instance of Google's URL-safe Base64 coder/decoder.
    GTMStringEncoding *encoding = [GTMStringEncoding rfc4648Base64WebsafeStringEncoding];
    
    // Decodes the URL-safe Base64 key to binary.
    NSData *binaryKey = [encoding decode:key];
    
    //Put the URL path and query in a string
    NSString *urlpath = url;
    
    // Stores the url in a NSData.
    //Put the URL in an NSData object using ASCII String Encoding. Stores it in binary.
    NSData *urlData = [urlpath dataUsingEncoding: NSASCIIStringEncoding];
    
    // Sign the URL with Objective-C HMAC SHA1 algorithm and put it in character array
    // the size of a SHA1 digest
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1,
           [binaryKey bytes],
           [binaryKey length],
           [urlData bytes],
           [urlData length],
           &result);
    
    NSData *binarySignature = [NSData dataWithBytes:&result length:CC_SHA1_DIGEST_LENGTH];
    
    // Encodes the signature to URL-safe Base64 using Google's encoder/decoder (from binary to URL-safe)
    NSMutableString *signature = [[NSMutableString alloc] initWithString:[encoding encode:binarySignature]];
    
    [signature replaceOccurrencesOfString:@"+" withString:@"-" options:NSLiteralSearch range:NSMakeRange(0, [signature length])];
    [signature replaceOccurrencesOfString:@"/" withString:@"_" options:NSLiteralSearch range:NSMakeRange(0, [signature length])];
    
    //Remove the equal sign at the end of the signature
    [signature replaceOccurrencesOfString:@"=" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [signature length])];
    
    return signature;
}


@end
