//
//  FiRequest.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FiRequest.h"
// TODO: use
// NSString *fixedURL = [myURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


@implementation FiRequest
+ (void) prepareHeadersForRequest:(NSMutableURLRequest *)request
{
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Fluidinfo Obj-c client library"
    forHTTPHeaderField:@"User-Agent"];
}

+ (NSURLRequest *) getPath:(NSString *)path
{
    NSURL * url = [Session urlForPath:path];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:60];
    [FiRequest prepareHeadersForRequest:req];
    return req;
}

+ (NSURLRequest *) deletePath:(NSString *)path
{
    NSURL * url = [Session urlForPath:path];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:60];
    [FiRequest prepareHeadersForRequest:req];
    [req setHTTPMethod:@"DELETE"];
    return req;
}

+ (NSURLRequest *) postBody:(NSData *)data toPath:(NSString *)path
{
    NSURL * url = [Session urlForPath:path];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:60];
    [FiRequest prepareHeadersForRequest:req];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: data];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // not sure the following isn't done automatically:
    [req setValue:[NSString stringWithFormat:@"%i", [data length]]  forHTTPHeaderField:@"Content-Length"];
    return req;
}
@end
