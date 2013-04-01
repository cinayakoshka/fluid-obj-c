//
//  FiRequest.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 3/31/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FiRequest.h"


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

+ (NSURLRequest *) getName:(NSString *)name withPath:(NSString *)path
{
    return [FiRequest getPath:[NSString stringWithFormat:@"%@/%@", path, name]];
}
@end
