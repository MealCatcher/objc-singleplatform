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

NSString * const kSinglePlatformBaseURL = @"http://api.singleplatform.co";

@implementation SinglePlatform

@synthesize clientID;
@synthesize secret;
@synthesize apiKey;

+(instancetype)client
{
    static dispatch_once_t onceToken;
    static SinglePlatform *client;
    dispatch_once(&onceToken, ^{
        client = [[SinglePlatform alloc] initWithBaseURL:[NSURL URLWithString:kSinglePlatformBaseURL]];
    });
    return client;
}

-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        self.parameterEncoding = AFFormURLParameterEncoding;
    }
    return self;
}

/*-(void)setClientID:(NSString *)clientID
{
    NSParameterAssert(clientID);
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:@"api" password:clientID];
}*/

/* This method signs the URL using HMAC-SHA1 and returns the signature */
-(NSString *)signURL:(NSMutableString *)url signingKey:(NSMutableString *)key
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

-(void)getLocations
{
    
}




@end
