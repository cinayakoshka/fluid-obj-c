//
//  FiObject.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FiObject.h"
#import "URLDelegate.h"
#import "FiRequest.h"

#define _DOMAIN @"com.fluidinfo.api.NSCocoaErrorDomain"

@implementation FiObject
@synthesize waiting, error, processResponse;
- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate
{
    if (delegate.complete && processResponse) {
        NSError * err = [NSError errorWithDomain:_DOMAIN code:0 userInfo:NULL];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[delegate receivedData] options:normal error:&err];
        return dic;
    }
    return NULL;
}

- (void) callFluidinfo:(NSURLRequest *)request andWait:(BOOL)wait andProcess:(BOOL)process
{
    @synchronized(self) {
        error = NULL;
        waiting = wait;
        processResponse = process;
        URLDelegate * d = [URLDelegate initWithCompletionDelegate:self];
        [d doRequest:request];
    }
}

- (NSString *) fullPath
{
    return @"Fail: not yet implemented fullpath here.";
}

- (NSString *) fqpath
{
    return @"Fail: not yet implemented fullpath here";
}

- (NSData *) postJson
{
    return NULL;
}

- (NSData *) putJson
{
    return NULL;
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    if (delegate.error != NULL) {
        error = delegate.error;
        waiting = NO;
    } else {
        error = NULL;
    }
}

- (void) get
{
    NSURLRequest * request = [FiRequest getPath:[self fullPath]];
    [self callFluidinfo:request andWait:YES andProcess:YES];
}

- (void) update
{
    NSURLRequest * request = [FiRequest putBody:[self putJson] toPath:[self fullPath]];
    [self callFluidinfo:request andWait:YES andProcess:NO];
}

- (void) create
{
    NSURLRequest * request = [FiRequest postBody:[self postJson] toPath:[self fqpath]];
    [self callFluidinfo:request andWait:YES andProcess:YES];
}

- (void) delete
{
    NSURLRequest * req = [FiRequest deletePath:[self fullPath]];
    [self callFluidinfo:req andWait:YES andProcess:YES];
}
@end
