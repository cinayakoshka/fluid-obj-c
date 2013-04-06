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
@synthesize waiting, error;
- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate
{
    if (delegate.complete) {
        NSError * err = [NSError errorWithDomain:_DOMAIN code:0 userInfo:NULL];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[delegate receivedData] options:normal error:&err];
        return dic;
    }
    return NULL;
}

- (void) callFluidinfo:(NSURLRequest *)request andWait:(BOOL) wait
{
    @synchronized(self) {
        waiting = wait;
        URLDelegate * d = [URLDelegate initWithCompletionDelegate:self];
        [d doRequest:request];
    }
}

- (NSString *) fullPath
{
    return @"";
}

- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    if (delegate.error != NULL) {
        error = delegate.error;
        waiting = NO;
    }
}

- (void) get
{
    
}

- (void) update
{
    
}

- (void) create
{
    
}

- (void) delete
{
    NSURLRequest * req = [FiRequest deletePath:[self fullPath]];
    [self callFluidinfo:req andWait:YES];    
}
@end
