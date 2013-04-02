//
//  FiObject.m
//  Fluidinfo
//
//  Created by Barbara Shirtcliff on 4/1/13.
//  Copyright (c) 2013 Barbara Shirtcliff. All rights reserved.
//

#import "FiObject.h"
#import "URLDelegate.h"

#define _DOMAIN @"com.fluidinfo.api.NSCocoaErrorDomain"

@implementation FiObject
@synthesize waiting;
- (void) handleCompletionOrCancelFrom:(URLDelegate *)delegate
{
    // no-op.
}

- (NSDictionary *)getDictionaryMaybeFrom:(URLDelegate *)delegate
{
    if (delegate.complete) {
        NSError * err = [NSError errorWithDomain:_DOMAIN code:0 userInfo:NULL];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[delegate receivedData] options:normal error:&err];
        return dic;
    }
    return NULL;
}
@end
